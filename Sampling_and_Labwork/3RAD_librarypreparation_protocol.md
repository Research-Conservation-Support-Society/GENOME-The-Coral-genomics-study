# 3RAD Library Preparation Protocol

**Project:** *GENOME-wide Exploration for Novel Organismal Markers to Enhance Coral Taxonomy and Conservation in Kenya*  
**Version:** 1.0  
**Last Updated:** 2025-11-20  
**Author:** Nabwire Asatsa  
**Institution:** Pwani University Bioscience Research Centre (PUBReC)

---

## 1. Purpose

This protocol describes the preparation of 3RAD sequencing libraries following the workflow of Bayona-Vásquez et al. (2019), including digestion, adapter ligation, pooling, purification, PCR amplification, size selection, and library quality verification.

---

## 2. Required Equipment and Reagents

### **Enzymes & Buffers**
- BamHI-HF (20 U/µL; NEB)  
- ClaI (20 U/µL; NEB)  
- MspI (20 U/µL; NEB)  
- 10× rCutSmart™ Buffer (NEB)  
- BSA (Sigma Aldrich)  
- T4 DNA Ligase (600 U/µL; Tinzyme)  
- 10× T4 DNA Ligase Buffer (Tinzyme)  
- ATP (100 mM)

### **Adapters & Primers**
- Double-stranded iTru Read 1 Adapter (5 µM)  
- Double-stranded iTru Read 2 Adapter (5 µM)  
- iTru5 PCR Primer (5 µM)  
- iTru7 PCR Primer (5 µM)

### **PCR & Cleanup Reagents**
- Q5 High-Fidelity 2× Master Mix (NEB)  
- Select-a-Size MagBeads (Zymo Research)  
- Nuclease-free water (dH₂O or ddH₂O)

### **Consumables**
- 2.0 mL and 1.5 mL microcentrifuge tubes  
- 96-well PCR plate (optional for batching)  
- Loading dye  
- 100 bp DNA ladder  
- Agarose gel (2%)  
- Ethanol (fresh, for gel cleaning if needed)

### **Equipment**
- Thermocycler  
- Magnetic rack  
- Microcentrifuge  
- Pipettes and filtered tips  
- Agarose gel electrophoresis unit  
- Qubit Fluorometer (High Sensitivity Assay)  

---

## 3. DNA Normalization

1. Normalize genomic DNA to **≤ 20 ng/µL**.  
2. Use **10 µL gDNA** per digestion reaction.

---

## 4. Restriction Digest and Adapter Ligation

### 4.1 Restriction Digest

Prepare a **15.5 µL** digestion reaction:

- 10 µL genomic DNA  
- 1.5 µL 10× rCutSmart Buffer  
- 0.5 µL BSA  
- 0.5 µL BamHI-HF (20 U/µL)  
- 0.5 µL ClaI (20 U/µL)  
- 0.5 µL MspI (20 U/µL)  
- 1 µL 5 µM iTru Read 1 Adapter  
- 1 µL 5 µM iTru Read 2 Adapter  

**Incubate at 37°C for 1 hour** in a thermocycler.

---

### 4.2 Adapter Ligation

Add **5 µL ligation master mix** to each digestion:

- 1.0 µL T4 DNA Ligase (600 U/µL)  
- 3.35 µL dH₂O  
- 0.15 µL ATP (100 mM)  
- 0.5 µL 10× T4 Ligase Buffer  

Run the ligation program on a thermocycler:

- 22°C — 20 min  
- 37°C — 10 min  
- 22°C — 20 min  
- 37°C — 10 min  
- 80°C — 20 min  
- Hold at 10°C  

---

## 5. Pooling of Ligated Products

1. From each row of 12 wells, transfer **10 µL per well** into a single 2.0 mL tube  
   - → 120 µL pooled per row.  
2. From each of the six pooled tubes, transfer **60 µL** into a final combined pool:  
   - → 60 µL × 6 = **360 µL total**.  
3. Retain the remaining 60 µL per strip at −20°C for backup use.

---

## 6. Purification of Ligated Products

1. Split the **360 µL** pooled product into two tubes (180 µL each).  
2. Add **1.25× volume Select-a-Size MagBeads** to each tube.  
3. Perform magnetic cleanup according to the manufacturer’s instructions.  
4. Elute each tube in **25 µL dH₂O**.  
5. Pool eluates to obtain **50 µL purified ligated product**.

---

## 7. PCR Amplification of 3RAD Libraries

Prepare a **50 µL PCR reaction**:

- 25 µL Q5 2× Master Mix  
- 4 µL dH₂O  
- 1 µL BSA  
- 2.5 µL iTru5 primer (5 µM)  
- 2.5 µL iTru7 primer (5 µM)  
- 15 µL purified ligated DNA  

### **Cycling Conditions**

- 98°C — 1 min  
- 12 cycles of:  
  - 98°C — 20 sec  
  - 60°C — 15 sec  
  - 72°C — 30 sec  
- 72°C — 5 min  
- Hold at 15°C  

Set up **three PCR reactions**, each using 15 µL of the ligated product.

---

## 8. PCR Verification & Size Selection

### **8.1 Gel Verification of PCR Products**

- Run **5 µL** of PCR product + 1 µL loading dye on a **2% agarose gel**.  
- Electrophorese for 45 minutes at **110 V**.  
- Expect a bright smear between **200–800 bp**.

### **8.2 Pooling & Double Size Selection**

1. Pool all three PCR reactions.  
2. Perform **double size selection** using Select-a-Size MagBeads:  
   - **0.6× ratio** → removes fragments **> 600 bp**  
   - **1.2× ratio** → removes fragments **< 200 bp**  
3. Elute the final pool in **30 µL ddH₂O**.

---

## 9. Final Library QC

### **9.1 Gel Verification**

- Run **4 µL** final library + 1 µL loading dye on a **2% agarose gel**.  
- Electrophorese for 45 minutes at 110 V.  
- Expect a smear centered around **300–450 bp**.

### **9.2 Quantification**

- Measure concentration using a **Qubit Fluorometer (High Sensitivity Assay)**.

### **9.3 Sequencing**

- Sequence libraries as **150 bp paired-end** reads on an **Illumina NovaSeq X** platform.

---

## 10. Notes & Quality Assurance

- DNA must be normalized to ≤ 20 ng/µL prior to digestion.  
- Avoid adapter contamination by using low-adhesion tubes and filtered tips.  
- Bead ratios must be precise to ensure consistent fragment size distribution.  
- PCR overcycling may introduce bias—cycle number should not exceed 12.  
- Retain backup ligation aliquots in case of library failure.

---

## 11. Version Control

| Version | Date       | Description                       | Author |
|---------|------------|-----------------------------------|--------|
| 1.0     | 2025-11-20 | Initial 3RAD protocol extraction  | C.N. Asatsa |
