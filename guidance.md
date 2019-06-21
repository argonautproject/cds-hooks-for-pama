**Background**

To incentivize appropriate use of advanced medical diagnostic imaging services (e.g. computed tomography (CT) positron emission tomography (PET), etc.), Medicare put rules in place to require that providers consult with [Appropriate Use Criteria](https://www.cms.gov/medicare/quality-initiatives-patient-assessment-instruments/appropriate-use-criteria-program/index.html) (AUC) when ordering certain imaging procedures. The initial Education and Operations Testing Period for this CMS program is scheduled to begin January 1, 2020, with additional requirements in 2021. This implementation guide describes the use of [CDS Hooks](https://cds-hooks.org/#overview) to evaluate appropriate use criteria. It is designed to help EHR developers and Qualified Clinical decision support mechanism (qCDSM) developers to implement support for AUCs with a consistent, repeatable pattern.

**Overview**

When placing an order for advanced imaging services, the EHR invokes an [order-select](https://cds-hooks.org/hooks/order-select/) or [order-sign](https://cds-hooks.org/hooks/order-sign/) CDS Hook, passing the draft order(s) as FHIR ServiceRequest resources within the "draftOrders" context. The CDS Service can do one or more of the following:

- Respond with a top-level `extension.systemActions` (defined below) that attaches an appropriateness Rating directly to the draft order(s); this is typically a "best-effort" Rating that might be improved with the availability of additional information.
- Respond with suggestion cards that convey valid alternatives to the draft order (where each alternative includes a pre-calculated appropriateness Rating based on available information)
- (TODO, once SMART Web Messaging specification is ready) Respond with an "App Link" card to gather additional information and generate a more accurate Rating.

This implementation guide proposes a small spanning set of appropriateness rating Codings, but these can be extended with translations from more specific values for each set of Appropriate Use Criteria.

## CDS Client Prepares a PAMA Request

A PAMA Request uses the [`order-select`](https://cds-hooks.org/hooks/order-select/) hook
 or the [`order-sign`](https://cds-hooks.org/hooks/order-sign/) hook. In general, CDS Clients should attempt to provide advice as early in the workflow as is feasible, to prevent repeated data entry or surprising evaluations. This means that clients should prefer the [`order-select`](https://cds-hooks.org/hooks/order-select/) hook, since it fires before a clinician gets to the point of signing an order. The [`order-sign`](https://cds-hooks.org/hooks/order-sign/) hook fires after all the order details are complete and the clinician is ready to sign the order. 

The request context **SHALL** include:

- The `draftOrders` field with a FHIR R4 bundle of [ServiceRequest](http://hl7.org/fhir/servicerequest.html) resources (and any supporting resources)
- TODO: other requirements on the supplies ServiceRequest (e.g., codes)

### DRAFT of ServiceRequest Profile
- status - FHIR value set [RequestStatus](http://build.fhir.org/valueset-request-status.html)
- intent - FHIR value set [RequestIntent](http://build.fhir.org/valueset-request-intent.html)
- code - CPT (extensible). Recommend SNOMED/LOINC if CPT is unavailable. Systems should also include Codings with more detail (e.g. via proprietary or local codes as a last resort)
- subject - Patient
- reasonCode - ICD-10 or SNOMED CT (preferred)  

## CDS Service returns a PAMA Response

Since a CDS Services might offer multi-purpose advice, accepting PAMA Requests as well as unrelated requests, the CDS Service must first determine
whether each incoming draft ServiceRequest is "PAMA-relevant". At a minimum, the CDS Service SHALL recognize ServiceRequests that pertain to priority clinical areas defined
by CMS, and MAY recognize additional clinical areas.

For each PAMA-relevant ServiceRequest, the CDS Service SHALL evaluate its PAMA AUCs and attempt to assign one of three PAMA Rating values (`appropriate` if there is an AUC consistent with the proposed imaging order, `not-appropriate` if there is an AUC that contra-indicates the proposed imaging order, or `not-applicable` if no AUC pertains to the proposed imaging order). In the event that not enough information is available to reach one of these ratings (e.g., if key data have not been captured in a structured form), the CDS Service SHALL NOT produce a PAMA Response for the ServiceRequest, and SHOULD instead offer Cards with app links or suggestions that would lead to a computable rating (e.g., a link to an app that would collect additional information necessary to evaluate an AUC).

For each PAMA-relevant ServiceRequest where a rating has been determined, the CDS Service SHALL provide a PAMA Response by including the required PAMA extensions described below.

The CDS Service produces a PAMA Response for each PAMA-relevant ServiceRequest by:

1. Creating an `systemActions` list as a root-level extension (see extension details below).
2. Optionally creating a set of proposed alternatively orders, as _suggestion_ cards
3. Optionally creating a set of _app link_ cards to launch external apps to capture additional data (e.g. prior diagnostic work completed, previous procedures performed, information from review of systems) or provide advice

Argonaut CDS Hooks extension for PAMA, to be used at the top level of a CDS Hooks Response:

| Field | Optionality | Type | Description |
| --- | ---- |  ---- |  ---- | 
| `systemActions` | OPTIONAL | *array* |  An array of `action` elements, following the same schema as the actions of a _suggestion card_. Each action must use `type: "update"` to update a single ServiceRequest; the update MUST NOT make any semantic change to the ServiceRequest, but may attach appropriateness rating extensions.|


Argonaut FHIR extensions for PAMA, within each **ServiceRequest** resource to communicate:

| Field | Optionality | Type | Description |
| ----- | -------- | ---- | ---- |
| `http://fhir.org/argonaut/pama-rating` | REQUIRED | *CodeableConcept* | MUST include a Coding with system `http://fhir.org/argonaut/CodeSystem/pama-rating` and code `appropriate` or `not-appropriate` or `no-criteria-apply`. If a CDS Service cannot assign one of these three codes to a given ServiceRequest, then it SHALL NOT provide aCDSMs MAY include additional translation Codings with more specific, finer-grained scores. For example, an AUC score with a numeric value or alternative code such as 'May be appropriate' |
| `http://fhir.org/argonaut/pama-rating-qcdsm-consulted` | REQUIRED | *string* | CMS-assigned identifier for ths Qualified CDS Mechanism consulted (also known as a "GCODE").|
| `http://fhir.org/argonaut/pama-rating-consult-id` | REQUIRED | *uri* | Unique correlation handle that can be used for audit logging and, if needed, reporting to CMS as the Unique Consultation Identifier (UCI). |
| `http://fhir.org/argonaut/pama-rating-auc-applied	` | OPTIONAL | *uri* | URL indicating the AUC applied. This value can be helpful, for example, to assess which specific AUCs are most often over-riddden. |
 
### CDS Client Processes PAMA Response

A CDS client, or EHR, **SHOULD** support the following behaviors to process a PAMA Response:

- Automatically incorporate appropriateness ratings from any actions in the top-level `extension.systemActions` array
- Communicate any automatically-incorporated appropriateness ratings to the user
- Store any automatically-incorporated appropriatness ratings and make them available for subsequent reporting
- Correlate the CDS Service's client id with the CMS-issued G-code for subsequent reporting
- Display any _suggestion_ cards that convey valid alternative orders
- Display _app link_ cards that can launch an app (often a SMART App) that a clinician can interact with (but without a return-path for scoring information)
- TODO once SMART Web Messaging specification is stable
  - Display a _app link_ cards to launch a SMART App with SMART Web Messaging support, allowing the CDS service to collect additional information through interacting with the clinician, and allowing the CDS service to pass back a fully-scored order to the EHR when the interaction is complete.


## End to end example CDS Scenario: (working on it!)
### CDS Client
Example request:

```
{
    "hookInstance": "d1577c69-dfbe-44ad-ba6d-3e05e953b2ea",
    "fhirServer": "http://hooks.smarthealthit.org:9080",
    "context": {
        "userId": "Practitioner/123",
        "patientId": "MRI-59879846",
        "encounterId": "89284",
        "selections": [
            "ServiceRequest/example-MRI-59879846"
        ],
        "draftOrders": {
            "resourceType": "Bundle",
            "entry": [{
                "resource": {
                    "resourceType": "ServiceRequest",
                    "id": "Example-MRI-Request",
                    "status": "draft",
                    "intent": "plan",
                    "code": {
                        "coding": [{
                            "system": "http://loinc.org",
                            "code": "36801-9"
                        }],
                        "text": "MRA Knee Vessels Right"
                    },
                    "subject": {
                        "reference": "Patient/MRI-59879846"
                    },
                    "reasonCode": [{
                        "coding": [{
                            "system": "http://hl7.org/fhir/sid/icd-10",
                            "code": "S83.511",
                            "display": "Sprain of anterior cruciate ligament of right knee"
                        }]
                    }]
                }
            }]
        }
    }
}
```

Need to add Prefetch!

### CDS Service Responses

Example response when AUC "Not Applicable":

```json
{
    "cards": [],
    "extension": {
        "systemActions": [{
            "type": "update",
            "resource": {
                "resourceType": "ServiceRequest",
                "id": "Example-MRI-Request",
                "extension": [{
                        "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating",
                        "valueCodeableConcept": {
                            "coding": [{
                                "system": "http://fhir.org/argonaut/CodeSystem/pama-rating",
                                "code": "no-criteria-apply"
                            }]
                        }
                    },
                    {
                        "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating-consult-id",
                        "valueUri": "urn:uuid:55f3b7fc-9955-420e-a460-ff284b2956e6"
                    }
                ],
                "status": "draft",
                "intent": "plan",
                "code": {
                    "coding": [{
                        "system": "http://loinc.org",
                        "code": "36801-9"
                    }],
                    "text": "MRA Knee Vessels Right"
                },
                "subject": {
                    "reference": "Patient/MRI-59879846"
                },
                "reasonCode": [{
                    "coding": [{
                        "system": "http://hl7.org/fhir/sid/icd-10",
                        "code": "S83.511",
                        "display": "Sprain of anterior cruciate ligament of right knee"
                    }]
                }]
            }
        }]
    }
}
```

Example response when criteria do apply:

```json
{
    "cards": [],
    "extension": {
        "systemActions": [{
            "type": "update",
            "resource": {
                "resourceType": "ServiceRequest",
                "id": "Example-MRI-Request",
                "extension": [{
                        "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating",
                        "valueCodeableConcept": {
                            "coding": [{
                                "system": "http://fhir.org/argonaut/CodeSystem/pama-rating",
                                "code": "appropriate"
                            }]
                        }
                    },
                    {
                        "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating-consult-id",
                        "valueUri": "urn:uuid:55f3b7fc-9955-420e-a460-ff284b2956e6"
                    }
                ],
                "status": "draft",
                "intent": "plan",
                "code": {
                    "coding": [{
                        "system": "http://loinc.org",
                        "code": "36801-9"
                    }],
                    "text": "MRA Knee Vessels Right"
                },
                "subject": {
                    "reference": "Patient/MRI-59879846"
                },
                "reasonCode": [{
                    "coding": [{
                        "system": "http://hl7.org/fhir/sid/icd-10",
                        "code": "S83.511",
                        "display": "Sprain of anterior cruciate ligament of right knee"
                    }]
                }]
            }
        }]
    }
}
```


### References and Links
- [AUC program backgrround](https://www.cms.gov/medicare/quality-initiatives-patient-assessment-instruments/appropriate-use-criteria-program/index.html) (official [PDF document](https://www.cms.gov/Regulations-and-Guidance/Guidance/Transmittals/2018Downloads/R2040OTN.pdf))
- [Information on CMS requirements, QQ modifier, and list of CPT codes for relevant orders](https://www.cms.gov/Outreach-and-Education/Medicare-Learning-Network-MLN/MLNMattersArticles/Downloads/MM10481.pdf)
- [Offical provider led entities](https://www.cms.gov/Medicare/Quality-Initiatives-Patient-Assessment-Instruments/Appropriate-Use-Criteria-Program/PLE.html)
- [Intermountain Proven Imaging](https://intermountainhealthcare.org/services/imaging-services/proven-imaging/step-1/)
- [American College of Radiology (ACR) criteria](https://www.acr.org/Clinical-Resources/ACR-Appropriateness-Criteria)


### Steps to add once Web Messaging spec is ready

- Additional Client (EHR) expectations
- Ability to work in the CDS service, provide additional information, and have that flow back to EHR scratchpad
- Process for &#39;re-triggering&#39; the order-select hook after changes have been made in both the CDS service and EHR. Is this a brand-new request? Is some sort of context retained to help CDS service?
- Error conditions
- Storage/tracking of information provided by the CDS service. Is this any different than non SMART Messaging case?
