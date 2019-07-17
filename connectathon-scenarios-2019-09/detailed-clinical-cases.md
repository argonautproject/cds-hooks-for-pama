# Scenarios for PAMA Connectathon Testing
*Authored by: Gay Dolin, Intelligent Medical Objects*

## Locked-down, single-code scenarios


These scenarios describe a full-specified interaction between a CDS Client and a CDS Service. Each scenario locks down a specific CPT code for the imaging study, and a single ICD or SNOMED CT code for the reason/indication. (To make testing as easy as possible, at the connectathon, we'll aim to have our Sandbox pre-configured to be able to launch these scenarios directly, via deep links.)

### Example leading to "appropriate" rating


71 year old male, Neville Nuclear, MRI-98675842, was admitted to Good Health Hospital, encounter
ID#IP-344356 in poor condition on 2019-Sept-12 for evaluation and treatment for suspected acute
pancreatitis. Dr. Peter Primary, his primary ambulatory doctor, is also concerned he may also be
showing symptoms possible bowel obstruction or ischemia. Dr. Aaron Attend, NPI# 2232567593,
examines him discovers Mr. Nuclear presented with moderate epigastric abdominal pain that lasted for
approximately 12 hours, then the pain became severe. The pain was sudden in onset, radiating to the
back, and associated with nausea and vomiting. This was coupled with lower abdominal cramping,
frequent feelings of having to move his bowels, with small amount of diarrhea, followed by feelings of
constipation. Mr. Nuclear also has stage 2 chronic kidney disease and Type 2 diabetes. Dr. Attend orders
an *MRI abdomen without and with IV contrast with MRCP* and selects *Acute inflammation of pancreas
and Stage 2 chronic kidney disease due to type 2 diabetes mellitus* as indications. (See codes below)

<table>
  <tr>
   <td><b>Advanced Imaging Procedure</b>
   </td>
   <td><b>CPT&nbsp;Code</b>
   </td>
  </tr>
  <tr>
   <td>Magnetic resonance (eg, proton) imaging, abdomen; without contrast
material(s), followed by with contrast material(s) and further sequences
   </td>
   <td>74183
   </td>
  </tr>
</table>

See also CPT codes for similar studies

* 74182 (Magnetic resonance (eg, proton) imaging, abdomen; with contrast material(s))
* 74181 (Magnetic resonance (eg, proton) imaging, abdomen; without contrast material(s))
* 74183 (Magnetic resonance (eg, proton) imaging, abdomen; without contrast material(s), followed by with contrast material(s) and further sequences)
* 74185 (Magnetic resonance angiography, abdomen, with or without contrast material(s))


<table>
  <tr>
   <td colspan="3" ><b>Indication (reasonCode)</b>
   </td>
  </tr>
  <tr>
   <td>User Selected (IMO)
   </td>
   <td>ICD10
   </td>
   <td>SNOMED CT 
   </td>
  </tr>
  <tr>
   <td>360790
   </td>
   <td>K85.90
   </td>
   <td>197456007
   </td>
  </tr>
  <tr>
   <td>Acute inflammation of the pancreas
   </td>
   <td>Acute pancreatitis without necrosis or infection, unspecified
   </td>
   <td>Acute pancreatitis
   </td>
  </tr>
</table>

<table>
  <tr>
   <td colspan="3" ><b>Indication #2 (reasonCode)</b>
   </td>
  </tr>
  <tr>
   <td>User Selected (IMO)
   </td>
   <td>ICD10
   </td>
   <td>SNOMED CT 
   </td>
  </tr>
  <tr>
   <td>52863174
   </td>
   <td>E11.22
   </td>
   <td>741000119101
   </td>
  </tr>
  <tr>
   <td>Stage 2 chronic kidney disease due to type 2 diabetes mellitus
   </td>
   <td>Type 2 diabetes mellitus with diabetic chronic kidney disease
   </td>
   <td>Chronic kidney disease stage 2 due to type 2 diabetes mellitus
   </td>
  </tr>
</table>


<table>
  <tr>
   <td colspan="2" ><b>ACR Appropriateness Criteria (pama-rating)</b>
   </td>
  </tr>
  <tr>
   <td>Numerical Value
   </td>
   <td>Text Rating
   </td>
  </tr>
  <tr>
   <td>9
   </td>
   <td>Usually Appropriate (https://acsearch.acr.org/docs/69468/Narrative/)
   </td>
  </tr>
</table>

### Example leading to "not appropriate" rating


49 year old female, Eve Everywoman, MRI-87612343, is seen at the Good Health Clinic, encounter ID#908798, on 2019-Sept-13, by Nancy Nightingale, Advanced Nurse Practitioner NPI #2234567894, for persistent low back pain, that started 4 months prior to the visit and varies in intensity from mild to severe. Ms. Everywoman has never been treated for low back pain before and has no other symptoms. Ms. Everywoman takes ibuprofen and acetaminophen regularly for it and states she has tried weight loss, yoga and other exercises, but won’t accept a referral to Physical Therapy until “you really find out what’s going on”. Ms. Everywoman is also demanding a prescription for Tramadol. Ms. Nightingale reluctantly proceeds to begin the ordering process for a *Computed tomography, lumbar spine; without contrast material, followed by contrast material(s) and further sections*. Ms. Nightingale selects, *Low back pain potentially associated with radiculopathy* for an indication in the EHR. (See codes below).


<table>
  <tr>
   <td><b>Advanced Imaging Procedure</b>
   </td>
   <td>CPT&nbsp;Code
   </td>
  </tr>
  <tr>
   <td>Computed tomography, lumbar spine; without contrast material, followed by contrast material(s) and further sections
   </td>
   <td>72133
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" ><b>Indication (reasonCode)</b>
   </td>
  </tr>
  <tr>
   <td>User Selected (IMO)
   </td>
   <td>ICD10
   </td>
   <td>SNOMED CT 
   </td>
  </tr>
  <tr>
   <td>38677432
   </td>
   <td>M54.5
   </td>
   <td>279039007
   </td>
  </tr>
  <tr>
   <td>Low back pain potentially associated with radiculopathy
   </td>
   <td>Low back pain
   </td>
   <td>Low back pain
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="2" ><b>ACR Appropriateness Criteria (pama-rating)</b>
   </td>
  </tr>
  <tr>
   <td>Numerical Value
   </td>
   <td>Text Rating
   </td>
  </tr>
  <tr>
   <td>1 
   </td>
   <td>"Usually not appropriate”  (https://acsearch.acr.org/docs/69483/Narrative/)
   </td>
  </tr>
</table>


### 2nd Example leading to "not appropriate" rating

*(Variant 4: New headache. Classic migraine or tension-type primary headache. Normal neurologic
examination. Initial imaging. Followed by Variant 6: Chronic headache. No new features. No neurologic
deficit. Initial imaging.)*

46 year old male, Ralph Relative, MRI# 4857603, was seen at Good Health Clinic by Dr. Peter Primary, NPI# 2232511193 on 2019 August 15 th , complaining of a headache on both sides of his head that would get worse with activity and light exposure and loud noise – he has been feeling especially irritable at both work and home and in fact has taken several days off. It tends to get better after a few days but only if he rests in a dark room and takes “lots” of ibuprofen and acetaminophen. He is concerned about his work and that livelihood begin affected. Dr Primary performed a neurological exam and found the exam to be WNL. Dr Primary orders *MRI of brain including brain stem, without contrast* and selects *Migraine without aura, not intractable, without status migrainosus*. (See codes below)

<table>
  <tr>
   <td><b>Advanced Imaging Procedure</b>
   </td>
   <td>CPT&nbsp;Code
   </td>
  </tr>
  <tr>
   <td>Magnetic resonance (eg, proton) imaging, brain (including brain stem); without contrast material(s)
   </td>
   <td>70551
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" ><b>Indication (reasonCode)</b>
   </td>
  </tr>
  <tr>
   <td>User Selected (IMO)
   </td>
   <td>ICD10
   </td>
   <td>SNOMED CT 
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>G43.009
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>Migraine without aura, not intractable, without status migrainosus
   </td>
   <td>
   </td>
  </tr>
</table>

<table>
  <tr>
   <td colspan="2" ><b>ACR Appropriateness Criteria (pama-rating)</b>
   </td>
  </tr>
  <tr>
   <td>Numerical Value
   </td>
   <td>Text Rating
   </td>
  </tr>
  <tr>
   <td>1 
   </td>
   <td>"Usually not appropriate”  (https://acsearch.acr.org/docs/69483/Narrative/)
   </td>
  </tr>
</table>




### Example leading to "unknown" (need more information) rating


78 year old male, Dick Dyspnea, MRI-132457469, is seen at his primary care office by provider Dr. DoGood, NPI#9786754311 on 06/22/2019 complaining of new and significant shortness of breath that began a few days earlier. Dick is healthy, with only a prior history of dyslipidemia. He is a non-smoker, and quite active for his age. His pulse oximetry and vital signs are normal, but there is slight swelling of his left lower leg. His PCP is concerned about pulmonary embolism and orders a *Computed tomography angiography, chest (noncoronary), with contrast material(s), including noncontrast images, if performed*, and *image postprocessing and selects Shortness of breath* for the indication. (see codes below)


<table>
  <tr>
   <td><b>Advanced Imaging Procedure</b>
   </td>
   <td>CPT&nbsp;Code
   </td>
  </tr>
  <tr>
   <td>Computed tomography angiography, chest (noncoronary), with contrast material(s), including noncontrast images, if performed, and image postprocessing
   </td>
   <td>71275
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" ><b>Indication (reasonCode)</b>
   </td>
  </tr>
  <tr>
   <td>User Selected (IMO)
   </td>
   <td>ICD10
   </td>
   <td>SNOMED CT 
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>R06.02
   </td>
   <td>267036007
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>Shortness of breath
   </td>
   <td>Dyspnea
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="2" ><b>ACR Appropriateness Criteria (pama-rating)</b>
   </td>
  </tr>
  <tr>
   <td>Numerical Value
   </td>
   <td>Text Rating
   </td>
  </tr>
  <tr>
   <td>—
   </td>
   <td> No rating -- need more information (https://acsearch.acr.org/docs/69404/Narrative/ indicates d-dimer results are needed)
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>A Suggested Procedure as per ACR Appropriateness Criteria
   </td>
   <td>CPT Code
   </td>
  </tr>
  <tr>
   <td>Magnetic resonance (eg, proton) imaging, spinal canal and contents, thoracic; without contrast material
   </td>
   <td>72146
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="2" ><b>Suggested Procedure as per ACR Appropriateness Criteria (pama-rating)</b>
   </td>
  </tr>
  <tr>
   <td>Numerical Value
   </td>
   <td>Text Rating
   </td>
  </tr>
  <tr>
   <td>—
   </td>
   <td>“Usually appropriate” (https://acsearch.acr.org/docs/3101564/Narrative/)
   </td>
  </tr>
</table>




## Open-ended Simulation Scenarios

These scenarios will test/simulate a more “open-ended” implementation of where the CDS Client might provide various codes with similar/consistent meanings. For example, a clinician might choose one of several procedure codes that are members of CPT "value sets" defined by CMS as requiring justification.

Correspondingly, there may be various codes used to convey the reason for a procedure, taking into account "is-a" relationships, synonyms, etc.  For example, an indication like “brain aneurysm” may be associated with many ICD, SNOMED CT and/or local/interface codes through an "is-a" relationship. **For Connectathon testing, these open-ended scenarios allow the CDS Client to choose any values within the sets described here. This allow for more realistic testing where an end-user can choose one of several values at an ordering screen, and receive meaningful feedback from the CDS Service.**

For these scenarios, a CDS Service should be able to recognize any of the codes specified, whether it's supplied as a `reasonCode` on the `ServiceRequest` oro discoverd via a FHIR query against existing resources (e.g., something present on the patient's active problem list). To support CDS Service developers, we will provide access to small subsets of 1) CMS CPT value sets, 2) indication/condition value sets.


### Example leading to "appropriate" rating

71 year old male, Neville Nuclear, MRI-98675842, was admitted to Good Health Hospital, encounter ID#IP-344356 in poor condition on 2019-Sept-12 for evaluation and treatment for suspected acute pancreatitis. Dr. Peter Primary, his primary ambulatory doctor, is also concerned he may also be showing symptoms possible bowel obstruction or ischemia. Dr. Aaron Attend, NPI# 2232567593, examines him discovers Mr. Nuclear presented with moderate epigastric abdominal pain that lasted for approximately 12 hours, then the pain became severe. The pain was sudden in onset, radiating to the back, and associated with nausea and vomiting. This was coupled with lower abdominal cramping, frequent feelings of having to move his bowels, with small amount of diarrhea, followed by feelings of constipation. Mr. Nuclear also has stage 2 chronic kidney disease and Type 2 diabetes. Dr. Attend orders an *MRI abdomen without and with IV contrast with MRCP* and selects *Acute inflammation of pancreas* and *Stage 2 chronic kidney disease due to type 2 diabetes mellitus* as indications. (See codes below)


<table>
  <tr>
   <td>Advanced Imaging Procedure (ordered)
   </td>
   <td>CPT Code
   </td>
  </tr>
  <tr>
   <td>Magnetic resonance (eg, proton) imaging, abdomen; without contrast material(s), followed by with contrast material(s) and further sequences
   </td>
   <td>74183
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>Set of CMS Valid Advanced Imaging CPT Codes for similar MRIs
   </td>
   <td>CPT Code
   </td>
  </tr>
  <tr>
   <td>Magnetic resonance (eg, proton) imaging, abdomen; with contrast material(s)
   </td>
   <td>74182
   </td>
  </tr>
  <tr>
   <td>Magnetic resonance (eg, proton) imaging, abdomen; without contrast material(s)
   </td>
   <td>74181
   </td>
  </tr>
  <tr>
   <td>Magnetic resonance (eg, proton) imaging, abdomen; without contrast material(s), followed by with contrast material(s) and further sequences
   </td>
   <td>74183
   </td>
  </tr>
  <tr>
   <td>Magnetic resonance angiography, abdomen, with or without contrast material(s)
   </td>
   <td>74185
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" ><b>Indication #1 (reasonCode) </b>
   </td>
  </tr>
  <tr>
   <td>User Selected (IMO)
   </td>
   <td>ICD10
   </td>
   <td>SNOMED CT 
   </td>
  </tr>
  <tr>
   <td>360790
   </td>
   <td>K85.90
   </td>
   <td>197456007
   </td>
  </tr>
  <tr>
   <td>Acute inflammation of the pancreas
   </td>
   <td>Acute pancreatitis without necrosis or infection, unspecified
   </td>
   <td>Acute pancreatitis
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>Acute Pancreatitis – IMO Lexicals, SNOMED CT, ICD-10
   </td>
  </tr>
  <tr>
   <td>
      <a href="https://docs.google.com/spreadsheets/d/0BzDLBlJ9IyUCSW5HemEtWllGZ3E2SmtwN0ZkYTVPTTRfQ0VZ/edit#gid=140256322">See full valueset</a>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="3" ><b>Indication #2 (reasonCode) </b>
   </td>
  </tr>
  <tr>
   <td>User Selected (IMO)
   </td>
   <td>ICD10
   </td>
   <td>SNOMED CT 
   </td>
  </tr>
  <tr>
   <td>52863174
   </td>
   <td>E11.22
   </td>
   <td>741000119101
   </td>
  </tr>
  <tr>
   <td>Stage 2 chronic kidney disease due to type 2 diabetes mellitus
   </td>
   <td>Type 2 diabetes mellitus with diabetic chronic kidney disease
   </td>
   <td>Chronic kidney disease stage 2 due to type 2 diabetes mellitus
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>Chronic Kidney Disease Stage 2 - IMO Lexicals, SNOMED CT, ICD-10
   </td>
  </tr>
  <tr>
   <td>
   <a href="https://docs.google.com/spreadsheets/d/0BzDLBlJ9IyUCaVR5WkFtVnJ3U1FNaC1zaFpJbDlJOXV4VUlv/edit#gid=587309550">See full valueset</a>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td colspan="2" ><b>ACR Appropriateness Criteria (pama-rating)</b>
   </td>
  </tr>
  <tr>
   <td>Numerical Value
   </td>
   <td>Text Rating
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>Usually Appropriate (https://acsearch.acr.org/docs/69468/Narrative/)
   </td>
  </tr>
</table>

