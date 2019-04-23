**Background**

To incentivize appropriate use of advanced medical diagnostic imaging services (e.g. computed tomography (CT) positron emission tomography (PET), etc.), Medicare put rules in place to require that providers consult with [Appropriate Use Criteria](https://www.cms.gov/medicare/quality-initiatives-patient-assessment-instruments/appropriate-use-criteria-program/index.html) (AUC) when ordering certain imaging procedures. The initial Education and Operations Testing Period for this CMS program is scheduled to begin January 1, 2020, with additional requirements in 2021. This implementation guide describes the use of [CDS Hooks](https://cds-hooks.org/#overview) to evaluate appropriate use criteria. It is designed to help EHR developers and Qualified Clinical decision support mechanism (qCDSM) developers to implement support for AUCs with a consistent, repeatable pattern.

**Overview**

When placing an order for advanced imaging services, the EHR invokes an [order-select](https://cds-hooks.org/hooks/order-select/) CDS Hook, passing the draft order(s) as FHIR ServiceRequest resources within the "draftOrders" context. The CDS Service can do one or more of the following:

- Respond with a card that attaches an appropriateness Rating directly to the draft order(s); this is typically a "best-effort" Rating that might be improved with the availability of additional information.
- Respond with suggestion cards that convey valid alternatives to the draft order (where each alternative includes a pre-calculated appropriateness Rating based on available information)
- (TODO, once SMART Web Messaging specification is ready) Respond with an "App Link" card to gather additional information and generate a more accurate Rating.

This implementation guide proposes a small spanning set of "appropriatenessRating" values in a CodeableConcept, but these can be extended with more specific value sets for each set of Appropriate Use Criteria.

## Context

### Hook

[Order-Select](https://cds-hooks.org/hooks/order-select/)

In support of the PAMA requirements, the [order-select](https://cds-hooks.org/hooks/order-select/) hook will fire prior to a clinician signing an order.

### CDS Service Response

The guidance below is a starting point prior to deployment of SMART Web Messaging.

Argonaut PAMA extensions at the top level of the response to communicate:

| Field | Optionality | Type | Description |
| --- | ---- |  ---- |  ---- | 
| `cdsSessionId` | REQUIRED |  *uri* | correlation handle that can be used for audit logging |
| `qcdsmConsulted` | REQUIRED | *url* |  canonical `url` representing the Qualified CDS Mechanism that was consulted |
| `aucNotApplicableReason` | REQUIRED | *string* | short description on why AUC didn't apply.|
| `aucNotApplicable` | REQUIRED | *CodeableConcept* |  list of identifiers conveying which AUCs were considered but deemed not to apply to this patient or scenario. For example, a qCDSM that implements the criteria from the American College of Radiology might return {"system": "https://acsearch.acr.org", "value": "1.0.0"} to indicate that these AUCs did not apply for the patient's diagnosis. |

Argonaut PAMA extensions within each **card** to communicate:

| Field | Optionality | Type | Description |
| ----- | -------- | ---- | ---- |
`aucApplied` | REQUIRED |  *identifier* | identifier for the AUC considered in this card
`appropriatenessRatingscore` | REQUIRED | *CodeableConcept* | 'Usually Appropriate'; 'May Be Appropriate'; 'Usually Not Appropriate'; may include concept of 'No Score Available'?
`description` | REQUIRED | *string* | Required if appropriatenessRatingscore = 'No Score Available'?) 

The CDS service response **MAY** provide:

- An _app link card_ if they need to capture additional data (e.g. prior diagnostic work completed, previous procedures performed, information from review of systems)

### CDS Client

The CDS client invoking the order-select hook **SHALL** include:

- The draftOrders field with a FHIR R4 bundle [ServiceRequest](http://hl7.org/fhir/servicerequest.html) and all supporting resources.

When the ServiceRequest is finalized it would lead to the performance of a study whose results would eventually be summarized in a DiagnosticReport, with imaging data conveyed as an ImagingStudy.

A CDS client, or EHR, **SHALL** support:

- Display of a response that no criteria were applicable, when this is the case
- Display of an _information_ card which will include a score, reason for no score
- Automatic incorporation of appropriatenessRating information from an _information card_, when such a rating is available
- Display _suggestion_ cards that convey valid alternative orders
- Display an _app link card_ with a link to an app (often a SMART App) that a clinician can interact with (but without a return-path for scoring information)
- TODO once SMART Web Messaging specification is stable
  - Display an _app link card_ to launch a SMART App with SMART Web Messaging support, allowing the CDS service to collect additional information through interacting with the clinician, and allowing the CDS service to pass back a fully-scored order to the EHR when the interaction is complete.



## End to end example CDS Scenario: (working on it!)
### CDS Client
Example request:

    {
      "hookInstance": "d1577c69-dfbe-44ad-ba6d-3e05e953b2ea",
      "fhirServer": "http://hooks.smarthealthit.org:9080",
      "context": {
          "userId": "Practitioner/123",
          "patientId": "MRI-59879846",
          "encounterId": "89284",
          "selections": ["ServiceRequest/example-MRI-59879846"],
          "draftOrders": {
              "resourceType": "Bundle",
              "entry": [
                  {
                      "resource": {
                          "resourceType": "ServiceRequest",
                          "id": "Example-MRI-Request",
                          "status": "draft",
                          "intent": "plan",
                          "code": {
                              "coding": [
                                  {
                                      "system": "http://loinc.org",
                                      "code": "36801-9"
                                  }
                              ],  
                              "text": "MRA Knee Vessels Right"
                          },
                          "subject": {"reference": "Patient/MRI-59879846"},
                          "reasonCode": [
                              {
                                  "coding": [
                                      {
                                          "system": "http://hl7.org/fhir/sid/icd-10",
                                          "code": "S83.511",
                                          "display": "Sprain of anterior cruciate ligament of right knee"
                                      }
                                    ]
                                }
                            ]
                        }
                    }
                ]
            }
        }
    } Need to add Prefetch!

### CDS Service Responses

Example response when "no criteria apply":

    {
        "extension": {
            "http://fhir.org/guides/argonaut/pama-v1.0.0/context": {
                "cdsSessionId": "urn:uuid:53fefa32-fcbb-4ff8-8a92-55ee120877b7",
                "qcdsmConsulted": "http://example-cds-service.fhir.org/qualified-cds/provider",
                "aucNotApplicableReason": "No criteria apply for a diagnosis of jaw pain",
                "aucNotApplicable": [
                    {
                        "system": "https://acsearch.acr.org",
                        "code": "1.0.0"
                    }
                ]
            }
        },
        "cards": []
    }

Example response when criteria do apply:

    {
        "extension": {
            "http://fhir.org/guides/argonaut/pama-v1.0.0/context": {
                "cdsSessionId": "urn:uuid:53fefa32-fcbb-4ff8-8a92-55ee120877b7",
                "qcdsmConsulted": "http://example-cds-service.fhir.org/qualified-cds/provider"
            }
        },
        "cards": [
            {
                "summary": "Example Card",
                "indicator": "info",
                "detail": "This is an example card.",
                "source": {
                    "label": "Static CDS Service Example",
                    "url": "https://example.com",
                    "icon": "https://example.com/img/icon-100px.png"
                },
                "extension": {
                    "http://fhir.org/guides/argonaut/pama-v1.0.0/score-detail": {
                        "aucApplied": [
                            {
                                "system": "https://acsearch.acr.or",
                                "value": "70910548971"
                            }
                        ],
                        "appropriatenessRatingscore": {
                            "coding": [
                                {
                                    "system": "http://fhir.org/guides/argonaut/appropriatenessRatingscore",
                                    "code": "May-Be-Appropriate"
                                }
                            ],
                            "text": "May Be Appropriatee"
                        }
                    }
                },
                "links": [
                    {
                        "label": "ACR Guidelines to review",
                        "url": "https://acsearch.acr.org/docs/70910/Narrative/",
                        "type": "absolute"
                    }
                ]
            },
            {
                "summary": "Another card",
                "indicator": "warning"
            }
        ]
    }



### Steps to add once Web Messaging spec is ready

- Additional Client (EHR) expectations
- Ability to work in the CDS service, provide additional information, and have that flow back to EHR scratchpad
- Process for &#39;re-triggering&#39; the order-select hook after changes have been made in both the CDS service and EHR. Is this a brand-new request? Is some sort of context retained to help CDS service?
- Error conditions
- Storage/tracking of information provided by the CDS service. Is this any different than non SMART Messaging case?

Extra notes

- Which AUCs do we need to support? Do they define different scoring systems? Do we need common roll-up codes like "Yes, Appropriate", "No, inappropriate" or "Indeterminate" ? Can we provide extensibility for AUCs to express their own scores too, directly? Do we capture which qualified QCDM who provided the score?
- Which qualified PLEs? CMS [list here](https://www.cms.gov/Medicare/Quality-Initiatives-Patient-Assessment-Instruments/Appropriate-Use-Criteria-Program/PLE.html) e.g. [ACR](https://www.acr.org/Clinical-Resources/Clinical-Decision-Support) is qualified; [https://acsearch.acr.org/list](httpsf://acsearch.acr.org/list); like [this one](https://acsearch.acr.org/docs/70910/Narrative/)

