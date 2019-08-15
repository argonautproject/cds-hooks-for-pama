```js
// Ahead of time

const accessTokenResponse = getAccessTokenResponse();

const targetWindow = window.parent || window.opener;
const targetOrigin = accessTokenResponse.smart_messaging_origin;

// Interact with user to gather relevant details
// collect evidence, and guide toward a decision.

// Once the decision is made, communicate it to the  EHR
targetWindow.postMessage({
    "messageId": generateGuid(),
    "messageType": "scratchpad.update",
    "payload": {
        "resource": {
            "resourceType": "ServiceRequest",
            "id": "example-MRI-59879846",
            "extension": [{
              "url": "http://fhir.org/argonaut/Extension/pama-rating",
              "valueCodeableConcept": {
                "coding": [{
                  "system": "http://fhir.org/argonaut/CodeSystem/pama-rating",
                  "code": "appropriate"
                }]
              }
            },
            {
              "url": "http://fhir.org/argonaut/Extension/pama-rating-qcdsm-consulted",
              "valueString": "example-gcode"
            },
            {
              "url": "http://fhir.org/argonaut/Extension/pama-rating-consult-id",
              "valueUri": "urn:uuid:55f3b7fc-9955-420e-a460-ff284b2956e6"
            }],
            "status": "draft",
            "intent": "plan",
            "code": {
                "coding": [{
                    "system": "http://www.ama-assn.org/go/cpt",
                    "code": "75561"
                }],
                "text": "Cardiac MRI"
            },
            "subject": {
                "reference": "Patient/MRI-59879846"
            },
            "reasonCode": [{
                "coding": [{
                    "system": "http://snomed.info/sct",
                    "code": "13213009",
                    "display": "Congenital heart disease"
                }]
            }]
        }
    }
}, targetOrigin)


// Finally, return control back to the EHR.
targetWindow.postMessage({
    "messageId": generateGuid(),
    "messageType": "ui.done",
}, targetOrigin);
```
