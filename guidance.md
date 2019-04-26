**Background**

To incentivize appropriate use of advanced medical diagnostic imaging services (e.g. computed tomography (CT) positron emission tomography (PET), etc.), Medicare put rules in place to require that providers consult with [Appropriate Use Criteria](https://www.cms.gov/medicare/quality-initiatives-patient-assessment-instruments/appropriate-use-criteria-program/index.html) (AUC) when ordering certain imaging procedures. The initial Education and Operations Testing Period for this CMS program is scheduled to begin January 1, 2020, with additional requirements in 2021. This implementation guide describes the use of [CDS Hooks](https://cds-hooks.org/#overview) to evaluate appropriate use criteria. It is designed to help EHR developers and Qualified Clinical decision support mechanism (qCDSM) developers to implement support for AUCs with a consistent, repeatable pattern.

**Overview**

When placing an order for advanced imaging services, the EHR invokes an [order-select](https://cds-hooks.org/hooks/order-select/) or [order-sign](https://cds-hooks.org/hooks/order-sign/) CDS Hook, passing the draft order(s) as FHIR ServiceRequest resources within the "draftOrders" context. The CDS Service can do one or more of the following:

- Respond with a card that attaches an appropriateness Rating directly to the draft order(s); this is typically a "best-effort" Rating that might be improved with the availability of additional information.
- Respond with suggestion cards that convey valid alternatives to the draft order (where each alternative includes a pre-calculated appropriateness Rating based on available information)
- (TODO, once SMART Web Messaging specification is ready) Respond with an "App Link" card to gather additional information and generate a more accurate Rating.

This implementation guide proposes a small spanning set of appropriateness rating Codings, but these can be extended with translations from more specific values for each set of Appropriate Use Criteria.

## CDS Client Prepares a PAMA Request

A PAMA Request uses the [`order-select` hook](https://cds-hooks.org/hooks/order-select/),
firing the hook before a clinician gets to the point of signing an order, or the [`order-sign` hook](https://cds-hooks.org/hooks/order-sign/),
firing the hook once all the order details are complete and the clinician is ready to sign the order.

The request context **SHALL** include:

- The `draftOrders` field with a FHIR R4 bundle of [ServiceRequest](http://hl7.org/fhir/servicerequest.html) resources (and any supporting resources)
- TODO: other requirements on the supplies ServiceRequest (e.g., codes)


## CDS Service returns a PAMA Response

Since a CDS Services might offer multi-purpose advice, accepting PAMA Requests as well as unrelated requests, the CDS Service must first determine
whether each incoming draft ServiceRequest is "PAMA-relevant". At a minimum, the CDS Service MUST recognize ServiceRequests that pertain to priority clinical areas defined
by CMS, and MAY recognize additional clinical areas.

For each PAMA-relevant ServiceRequest, the CDS Service MUST provide a PAMA Response by including the required PAMA extensions described below.

The CDS Service produces a PAMA Response for each PAMA-relevant ServiceRequest by:

1. Creating a _suggestion_ card with the `pama-rating-auto-apply` extension set to `true`, which indicate that this
   card does not make any semantic change to the ServiceRequest, but only attaches a set of appropriateness rating extensions.
2. Optionally creating a set of proposed alternatively orders, as _suggestion_ cards that do *not*
   include an auto-apply value of `true`.
3. Optionally creating a set of _app link_ cards to launch external apps to capture additional data (e.g. prior diagnostic work completed, previous procedures performed, information from review of systems) or provide advice

Argonaut CDS Hooks extension for PAMA, to be used at the top level of a `suggestions` entry:

| Field | Optionality | Type | Description |
| --- | ---- |  ---- |  ---- | 
| `pama-rating-auto-apply` | OPTIONAL | *boolean* |  indicator to the requesting client to auto apply the score, rather than presenting it for a user to manually accept. This MUST NOT be set to true if the suggestion makes any changes beyond applying a PAMA response.|


Argonaut FHIR extensions for PAMA, within each **ServiceRequest** resource to communicate:

| Field | Optionality | Type | Description |
| ----- | -------- | ---- | ---- |
| `http://fhir.org/argonaut/pama-rating` | REQUIRED | *CodeableConcept* | MUST include a Coding with system `http://fhir.org/argonaut/CodeSystem/pama-rating` and code `apropriate` or `inappropriate` or `not-applicable` and MAY include additional translation Codings with more specific details|
| `http://fhir.org/argonaut/pama-rating-qcdsm-consulted` | REQUIRED |  *uri* | canonical `url` representing the Qualified CDS Mechanism that was consulted. (Note: In future this may be a CMS assigned GCODE to identify service)correlation handle that can be used for audit logging |
| `http://fhir.org/argonaut/pama-rating-consult-id` | REQUIRED | *uri* | correlation handle that can be used for audit logging |
| `http://fhir.org/argonaut/pama-rating-auc-applied` | OPTIONAL |  *uri* | URL indicating the AUC applied |

 
### CDS Client Processes PAMA Response

A CDS client, or EHR, **SHALL** support the following behaviors to process a PAMA Response:

- Automatically incorporate appropriateness ratings from any _suggestion cards_ where the auto-apply flag is set to `true`
- Communicate any automatically-incorporated appropriateness ratings to the user
- Store any automatically-incorporated appropriatness ratings and make them available for subsequent reporting
- Display any _suggestion_ cards that convey valid alternative orders
- Display _app link_ cards that can launch an app (often a SMART App) that a clinician can interact with (but without a return-path for scoring information)
- TODO once SMART Web Messaging specification is stable
  - Display a _app link_ cards to launch a SMART App with SMART Web Messaging support, allowing the CDS service to collect additional information through interacting with the clinician, and allowing the CDS service to pass back a fully-scored order to the EHR when the interaction is complete.


## End to end example CDS Scenario: (working on it!)
### CDS Client
Example request:

```
{
  "hookInstance":"d1577c69-dfbe-44ad-ba6d-3e05e953b2ea",
  "fhirServer":"http://hooks.smarthealthit.org:9080",
  "context":{
    "userId":"Practitioner/123",
    "patientId":"MRI-59879846",
    "encounterId":"89284",
    "selections":[
      "ServiceRequest/example-MRI-59879846"
    ],
    "draftOrders":{
      "resourceType":"Bundle",
      "entry":[
        {
          "resource":{
            "resourceType":"ServiceRequest",
            "id":"Example-MRI-Request",
            "status":"draft",
            "intent":"plan",
            "code":{
              "coding":[
                {
                  "system":"http://loinc.org",
                  "code":"36801-9"
                }
              ],
              "text":"MRA Knee Vessels Right"
            },
            "subject":{
              "reference":"Patient/MRI-59879846"
            },
            "reasonCode":[
              {
                "coding":[
                  {
                    "system":"http://hl7.org/fhir/sid/icd-10",
                    "code":"S83.511",
                    "display":"Sprain of anterior cruciate ligament of right knee"
                  }
                ]
              }
            ]
          }
        }
      ]
    }
  }
}
```

Need to add Prefetch!

### CDS Service Responses

Example response when AUC "Not Applicable":

```json
{
  "cards":[
    {
      "suggestions":[
        {
          "extension":{
            "http://fhir.org/argonaut/pama-rating-auto-apply":true
          },
          "actions":[
            {
              "type":"update",
              "resource":{
                "resourceType":"ServiceRequest",
                "id":"Example-MRI-Request",
                "extension":[
                  {
                    "url":"http://fhir.org/argonaut/StructureDefinition/pama-rating",
                    "valueCodeableConcept":{
                      "coding":[
                        {
                          "system":"http://fhir.org/argonaut/CodeSystem/pama-rating",
                          "code":"not-applicable"
                        }
                      ]
                    }
                  },
                  {
                    "url":"http://fhir.org/argonaut/StructureDefinition/pama-rating-qcdsm-consulted",
                    "valueUri":"http://example-cds-service.fhir.org/qualified-cds/provider"
                  },
                  {
                    "url":"http://fhir.org/argonaut/StructureDefinition/pama-rating-auc-applied",
                    "valueUri":"https://acsearch.acr.org/70910548971"
                  },
                  {
                    "url":"http://fhir.org/argonaut/StructureDefinition/pama-rating-consult-id",
                    "valueUri":"urn:uuid:55f3b7fc-9955-420e-a460-ff284b2956e6"
                  }
                ],
                "status":"draft",
                "intent":"plan",
                "code":{
                  "coding":[
                    {
                      "system":"http://loinc.org",
                      "code":"36801-9"
                    }
                  ],
                  "text":"MRA Knee Vessels Right"
                },
                "subject":{
                  "reference":"Patient/MRI-59879846"
                },
                "reasonCode":[
                  {
                    "coding":[
                      {
                        "system":"http://hl7.org/fhir/sid/icd-10",
                        "code":"S83.511",
                        "display":"Sprain of anterior cruciate ligament of right knee"
                      }
                    ]
                  }
                ]
              }
            }
          ]
        }
      ]
    }
  ]
}
```

Example response when criteria do apply:

```json
{
  "cards":[
    {
      "suggestions":[
        {
          "extension":{
            "http://fhir.org/argonaut/pama-rating-auto-apply":true
          },
          "actions":[
            {
              "type":"update",
              "resource":{
                "resourceType":"ServiceRequest",
                "id":"Example-MRI-Request",
                "extension":[
                  {
                    "url":"http://fhir.org/argonaut/StructureDefinition/pama-rating",
                    "valueCodeableConcept":{
                      "coding":[
                        {
                          "system":"http://fhir.org/argonaut/CodeSystem/pama-rating",
                          "code":"appropriate"
                        }
                      ]
                    }
                  },
                  {
                    "url":"http://fhir.org/argonaut/StructureDefinition/pama-rating-qcdsm-consulted",
                    "valueUri":"http://example-cds-service.fhir.org/qualified-cds/provider"
                  },
                  {
                    "url":"http://fhir.org/argonaut/StructureDefinition/pama-rating-auc-applied",
                    "valueUri":"https://acsearch.acr.org/70910548971"
                  },
                  {
                    "url":"http://fhir.org/argonaut/StructureDefinition/pama-rating-consult-id",
                    "valueUri":"urn:uuid:55f3b7fc-9955-420e-a460-ff284b2956e6"
                  }
                ],
                "status":"draft",
                "intent":"plan",
                "code":{
                  "coding":[
                    {
                      "system":"http://loinc.org",
                      "code":"36801-9"
                    }
                  ],
                  "text":"MRA Knee Vessels Right"
                },
                "subject":{
                  "reference":"Patient/MRI-59879846"
                },
                "reasonCode":[
                  {
                    "coding":[
                      {
                        "system":"http://hl7.org/fhir/sid/icd-10",
                        "code":"S83.511",
                        "display":"Sprain of anterior cruciate ligament of right knee"
                      }
                    ]
                  }
                ]
              }
            }
          ]
        }
      ]
    }
  ]
}
```


### Steps to add once Web Messaging spec is ready

- Additional Client (EHR) expectations
- Ability to work in the CDS service, provide additional information, and have that flow back to EHR scratchpad
- Process for &#39;re-triggering&#39; the order-select hook after changes have been made in both the CDS service and EHR. Is this a brand-new request? Is some sort of context retained to help CDS service?
- Error conditions
- Storage/tracking of information provided by the CDS service. Is this any different than non SMART Messaging case?

Extra notes

- Which AUCs do we need to support? Do they define different scoring systems? Do we need common roll-up codes like "Yes, Appropriate", "No, inappropriate" or "Indeterminate" ? Can we provide extensibility for AUCs to express their own scores too, directly? Do we capture which qualified QCDM who provided the score?
- Which qualified PLEs? CMS [list here](https://www.cms.gov/Medicare/Quality-Initiatives-Patient-Assessment-Instruments/Appropriate-Use-Criteria-Program/PLE.html) e.g. [ACR](https://www.acr.org/Clinical-Resources/Clinical-Decision-Support) is qualified; [https://acsearch.acr.org/list](httpsf://acsearch.acr.org/list); like [this one](https://acsearch.acr.org/docs/70910/Narrative/)

