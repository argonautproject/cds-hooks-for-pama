## Argonaut PAMA Project: September 2019 Connectathon

We'll be participating in the CDS Hooks track of the September 2019
Connectathon, testing our draft CDS Hooks for PAMA IG.  The track is designed
for clients and servers that want to try out a full spectrum of integration
from:

1. Automated rating of orders in-workflow
2. Suggestions for alternative orders presented in-workflow
3. App-mediated order selection through SMART Web Messaging

We'll use clinical histories and detailed codes documented in these [Scenarios for PAMA Connectathon Testing](detailed-clinical-cases.md)

## Scenario 1. Automated rating of orders in-workflow

* EHR provides an order-entry form that triggers the `order-select` hook as
orders are entered (and optionally triggers `order-sign` when full order
details are present). Order entry must be able to populate at least: patient,
provider, and a `draftOrders` bundle containing a `ServiceRequest` with a
`code` and a `reasonCode`. [See example request](./examples/scenario-01-outbound-request.json).

For this connectathon scenario, we recommend that the order
entry screen provides a way to easily enter any of the following three orders:

|`ServiceRequest.code`|`ServiceRequest.reasonCode`|Expected PAMA rating|
|---|---|---|
|CPT 72133 (Lumbar spine CT...)|SNOMED 279039007 (Low back pain)|`not-appropriate`|
|CPT 75561 (Cardiac MRI...)|SNOMED 13213009 (Congenital heart disease)|`appropriate`|
|CPT 75561 (Cardiac MRI...)|(omitted)|No rating (insufficient information)|

(TODO: add an example where `no-criteria-apply`.)

* CDS Service returns a response with a `.extension.systemActions` array that
includes an `update` action with an automated PAMA rating for the
`ServiceRequest`, including extensions for the PAMA rating, qCDSM GCODE,
consult ID, and optionally AUC consulted. [See example
response](./examples/scenario-01-rating-response.json).

* EHR updates the ordering screen to show that a PAMA rating has been returned
(if indeed this is the case) alongside the order (e.g. with a badge or other
inline indicator to show an icon or symbol for "appropriate" vs "not
appropriate").

## Scenario 2. Suggestions for alternative orders presented in-workflow

* EHR provides an order-entry form that triggers the `order-select` hook as
orders are entered (and optionally triggers `order-sign` when full order
details are present). Order entry must be able to populate at least: patient,
provider, and a `draftOrders` bundle containing a `ServiceRequest` with a
`code` and a `reasonCode`. [See example request](./examples/scenario-02-outbound-request.json).

* CDS Service returns a suggestion card that performs an `update` on the
proposed order, changing the `code` and presmuably preserving the `reasonCode`.
The updated `ServiceRequest` includes extensions for its PAMA rating
(presumably `appropriate` if the CDS Service is suggesting this study), qCDSM
GCODE, consult ID, and optionally AUC consulted. [See example
response](./examples/scenario-02-suggestion-response.json).

* EHR displays the suggestion card alongside the ordering screen. When a user
accepts the suggestion, EHR incorporates details from the suggested
`ServiceRequest` into the ordering screen, including at least an updated `code`
and PAMA rating extensions.


## Scenario 3. App-mediated order selection through SMART Web Messaging

* EHR provides an order-entry form that triggers the `order-select` hook as
orders are entered (and optionally triggers `order-sign` when full order
details are present). Order entry must be able to populate at least: patient,
provider, and a `draftOrders` bundle containing a `ServiceRequest` with a
`code` and a `reasonCode`. [See example request](./examples/scenario-02-outbound-request.json).

* CDS Service returns a SMART App Link card including `appContext` to launch
its CDS companion app. [See example request](./examples/scenario-03-app-launch-response.json).

* When a user follows the link, EHR launches the CDS companion app, including
launch context parameters for `patient`, `smart_messaging_origin`, and
`appContext`.

* CDS Companion app interacts as needed with a user and with the EHR's FHIR API
endpoint. When a user has decided on an alternate order, the app issues a SMART
Web Messaging call to `scratchpad.update` to alter the draft order, changing
the `code` and presumably preserving the `reasonCode`.  The updated
`ServiceRequest` includes extensions for its PAMA rating (presumably
`appropriate` if the app is suggesting this study), qCDSM GCODE, consult ID,
and optionally AUC consulted.  Finally, the app issues a SMART Web Messaging
call to `ui.done` to return control back to the EHR. [See example
calls](./examples/scenario-03-web-messages.md).

* In response to SMART Web Messaging requests from the CDS companion, the EHR
incorporates details from the updated `ServiceRequest` into the ordering
screen, including at least an updated `code` and PAMA rating extensions; and
the EHR closes the app.
