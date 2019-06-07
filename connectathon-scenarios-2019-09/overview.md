# Scenarios for PAMA Connectathon Testing
*Authored by: Gay Dolin, Intelligent Medical Objects*

## Locked-down, single-code scenarios


These scenarios describe a full-specified interaction between a CDS Client and a CDS Service. Each scenario locks down a specific CPT code for the imaging study, and a single ICD or SNOMED CT code for the reason/indication. (To make testing as easy as possible, at the connectathon, we'll aim to have our Sandbox pre-configured to be able to launch these scenarios directly, via deep links.)

### Example leading to "appropriate" rating


63 year old male, Adam Everyman, MRI-59879846, is seen at the Good Health Clinic, encounter ID#654321, on 2019-Sept-12 by Dr Peter Primary NPI #1234567893. Mr. Everyman is complaining of increasing shortness of breath and “getting winded” he is fit for his age and has no other complaints. A month ago, he was seen in the clinic for the same symptoms, but milder and a Chest X-ray was performed that was determined to be unremarkable. During this visit, Mr. Everyman reports he remembers being told he was a little that the doctors thought he might have been a “blue baby” but changed their minds. He recalls getting a bit more winded than his friends as a teenager. Dr. Peter Primary suspects a mild congenital heart defect undiagnosed in childhood that is now worsening. He orders *Cardiac magnetic resonance imaging for morphology and function without contrast material(s), followed by contrast material(s) and further sequences*. Dr. Peter Primary, selects *Congenital Heart Disease, Adult* as an indication in the EHR. (See codes below)

It will be found after the MRI that Mr. Everyman was documented to have *Ebstein's anomaly of left atrioventricular valve*  (IMO® 29242281, ICD-10-CM Q22.5 - *Ebstein's anomaly*, SNOMED CT® 253496001 - *Ebstein's anomaly of left atrioventricular valve).*


<table>
  <tr>
   <td><b>Advanced Imaging Procedure</b>
   </td>
   <td><b>CPT&nbsp;Code</b>
   </td>
  </tr>
  <tr>
   <td>Cardiac magnetic resonance imaging for morphology and function without contrast material(s), followed by contrast material(s) and further sequences
   </td>
   <td>75561
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
   <td>961842
   </td>
   <td>Q24.9
   </td>
   <td>13213009
   </td>
  </tr>
  <tr>
   <td>Congenital Heart Disease, Adult
   </td>
   <td>Congenital malformation of heart, unspecified
   </td>
   <td>Congenital heart disease
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
   <td>Usually Appropriate (https://acsearch.acr.org/docs/69355/Narrative/)
   </td>
  </tr>
</table>

*TODO*: which ACR 


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



### Example leading to "unknown" (need more information) rating


5 year old female, Kari Kidd, MRI, 85739473, is seen at the Good Health Hospital Pediatric Orthopedic Clinic, encounter ID#746940, 0n 2018-Sept-14, by Dr. Jeffrey Joint NPI #1234533893. Kari’s mother has brought her in because she recently noticed her daughter’s head had an odd tilt to it, from there she noticed that one hip was higher than another. On examination, Dr. Joint discovered multiple asymmetries along the median plane of her body. He also noticed decreased breath sounds in her left lung. Because she is less than 8 years old, Dr. Joint strongly suspects congenital scoliosis as opposed to idiopathic and orders a *Computed tomography, thoracic spine; without contrast material* because he feels the child will need surgical growth rod placement ASAP, and in his opinion the CT provides better presurgical information. He selects *Congenital Scoliosis* from the EHR as the indication for the procedure. The system knows that this procedure *may be* appropriate, but that a preferred first line advanced imaging procedure is *Magnetic resonance (eg, proton) imaging, spinal canal and contents, thoracic; without contrast material*, and so, will suggest the alternative and/or ask for more justification. (see codes below)


<table>
  <tr>
   <td><b>Advanced Imaging Procedure</b>
   </td>
   <td>CPT&nbsp;Code
   </td>
  </tr>
  <tr>
   <td>Computed tomography, thoracic spine; without contrast material
   </td>
   <td>72128
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
   <td>5682
   </td>
   <td>Q67.5
   </td>
   <td>20944008
   </td>
  </tr>
  <tr>
   <td>Congenital scoliosis
   </td>
   <td>Congenital deformity of spine
   </td>
   <td>Congenital postural scoliosis
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
   <td>“May be appropriate” (https://acsearch.acr.org/docs/3101564/Narrative/)
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
   <td>
   </td>
   <td>“Usually appropriate” (https://acsearch.acr.org/docs/3101564/Narrative/)
   </td>
  </tr>
</table>



## Real World Simulation Scenarios

These scenarios will test/simulate a more “real world” implementation of the CDS Hooks solution where there is more than one code that a clinician might choose when ordering a particular advanced imaging procedure (e.g. procedure X “is-a” MRI, procedure Y “is-a” CT Scan etc.) which are members of CPT “value sets” defined by CMS that will require justification. The selected code will participate in the order-select/order sign CDS Hook.  

Correspondingly, there are “permitted” indications (diagnoses/symptoms/findings) for those procedures (What is appropriate is defined by the PLEs). Each indication type, e.g “brain aneurysm” has many ICD, SNOMED CT and/or local/interface codes that “is-a” brain aneurysm - represented in value sets. **For Connectathon testing purposes we will likely use subsets of the value sets. **The CDS Hook will find the 1..* (? Or would it stop at the 1<sup>st</sup> qualifying condition?), not find, or find other conditions/indications that would qualify.to respond. (Is there an order for the query? E.g. first look on Problem list, next look in encounter note, other notes).

These clinical scenarios are similar to the “single code value” scenarios – but small subsets of the CMS CPT value sets and the indication/condition value sets are/will be made available for the Connectathon track to simulate the vocabulary support needed/provided for the logic in the qCDSM and EHR.


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

