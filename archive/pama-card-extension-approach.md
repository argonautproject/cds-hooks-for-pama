## Orignal Proposal - since superseded!
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


