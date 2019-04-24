### AUCs Not Applicable

```json
{
    "cards": [{
      "suggestions": [{
        "extension": {
          "http://fhir.org/argonaut/pama-rating-auto-apply": true
        },
        "actions": [{
          "type": "update",
          "resource": {
              "resourceType": "ServiceRequest",
              "id": "Example-MRI-Request",
              "extension": [{
                "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating",
                "valueCodeableConcept": {
                  "coding": [{
                    "system": "http://fhir.org/argonaut/CodeSystem/pama-rating",
                    "code": "not-applicable"
                  }]
                }
              }, {
                "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating-qcdsm-consulted",
                "valueUri": "http://example-cds-service.fhir.org/qualified-cds/provider",
              }, {
                "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating-auc-applied",
                "valueUri": "https://acsearch.acr.org/70910548971",
              }, {
                "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating-consult-id",
                "valueUri": "urn:uuid:55f3b7fc-9955-420e-a460-ff284b2956e6",
              }],
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
        ]
      }]
    }]
}
```


```json
{
    "cards": [{
      "suggestions": [{
        "extension": {
          "http://fhir.org/argonaut/pama-rating-auto-apply": true
        },
        "actions": [{
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
              }, {
                "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating-qcdsm-consulted",
                "valueUri": "http://example-cds-service.fhir.org/qualified-cds/provider",
              }, {
                "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating-auc-applied",
                "valueUri": "https://acsearch.acr.org/70910548971",
              }, {
                "url": "http://fhir.org/argonaut/StructureDefinition/pama-rating-consult-id",
                "valueUri": "urn:uuid:55f3b7fc-9955-420e-a460-ff284b2956e6",
              }],
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
        ]
      }]
    }]
}
```

