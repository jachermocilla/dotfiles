---
name: research-proposal-review
description: Review a research proposal submitted as a PDF (e.g., CMSC 190/200/300 or a conference/journal proposal) against the SRG ICS-UPLB "Research Proposal" guide series, and produce a structured, actionable review.
---

# Research Proposal Review

Reviews a research proposal PDF using the criteria from the six-part SRG ICS-UPLB guide series ( ["Lost Packets" blog](https://srg-ics-uplb.github.io/blog/), J.A.C. Hermocilla ):



1. Finding and identifying research gaps
2. Writing the problem statement
3. Writing the aim, objectives, and methods
4. Writing the review of related literature (RRL)
5. Writing the title
6. Evaluation and validation

The guides are written for computer systems research but apply to other CS areas. When the proposal is outside systems, keep the principles and swap the systems-specific expectations (e.g., throughput/latency) for the field's equivalents (e.g., accuracy/F1 for ML, usability measures for HCI).

## Inputs

- **Required:** the proposal PDF.
- **Optional (ask only if it changes the review; otherwise assume and state the assumption):**
  - Level: undergraduate (CMSC 190), MS (CMSC 200), PhD (CMSC 300), or venue submission. Default: undergraduate thesis proposal.
  - Target venue or department template, if any.
  - Reviewer focus (e.g., "just the methods", "be strict").

## Workflow

### Step 1 — Extract the text

1. Try `pdftotext -layout proposal.pdf proposal.txt`. If unavailable, use Python `pdfplumber` (or `pypdf`).
2. If the text is empty or garbled, the PDF is likely scanned: rasterize pages (`pdftoppm -r 150 -png`) and read the images, or OCR with `pytesseract`.
3. Keep page numbers. Every finding in the review must cite the page (e.g., "p. 4").
4. Look at pages with figures, tables, Gantt charts, or architecture diagrams as images if they matter to the methods or evaluation.

### Step 2 — Map the proposal's structure

Locate each component, whatever the proposal calls it. Record its page range, or mark it **MISSING**.

| Component | Common headings |
|---|---|
| Title | title page |
| Background / research gap | Introduction, Background of the Study |
| Problem statement | Statement of the Problem, Problem Definition |
| Aim | General Objective, Aim of the Study |
| Objectives | Specific Objectives |
| Methods | Methodology, Methods, Research Design |
| Evaluation & validation plan | Evaluation, Experimental Setup, Testing (often inside Methods) |
| Review of related literature | RRL, Related Work, Literature Review |
| Scope & limitations | Scope and Limitations |
| References | References, Bibliography |

A missing component is itself a major finding.

### Step 3 — Evaluate each component against the rubric

For every criterion below, assign one rating and back it with evidence:

- **Met** — clearly satisfied
- **Partial** — present but weak, vague, or inconsistent
- **Not met** — absent or wrong
- **N/A** — genuinely does not apply (say why)

For each Partial / Not met, give (a) the evidence: a short quote under ~25 words or a paraphrase, with page; and (b) a concrete fix. Don't just say "be more specific"; say *what* to make specific and, where helpful, show a rewritten example.

---

#### A. Research gap (Guide 1)

- **A1 Gap is explicit.** The proposal names a specific unanswered question, unaddressed concept, or missing approach—not just a topic area.
- **A2 Gap is grounded.** It is traced to evidence: limitations or "future work" in prior papers, unrealistic assumptions in existing systems (e.g., homogeneous hardware, ideal networks), failing evaluation scenarios, real-world issue trackers/outages/industry reports, taxonomies or benchmarks the author ran, or emerging technologies/application domains.
- **A3 Novelty.** There is evidence the author checked that recent work (roughly the last 3–5 years) has not already closed the gap. If you have web search, run a quick check for recent work on the gap and report anything that may overlap—phrase it as "the author should check X," never as a verdict that the work is not novel.
- **A4 Impact.** It is clear why closing the gap matters, academically or practically.
- **A5 Feasibility.** The gap is solvable with the tools, data, hardware, skills, and time the author plausibly has at this level. Flag gaps that require hardware/data the author is unlikely to access.
- **A6 Balance.** The problem is both new and tractable—not a trivial reimplementation, not an unbounded grand challenge.

#### B. Problem statement (Guide 2)

- **B1 Clear issue.** States the core limitation or deficiency of existing systems/approaches.
- **B2 Context.** Gives enough background for both experts and non-experts.
- **B3 Scoped.** Narrowed to a specific domain, platform, or workload—not overly broad.
- **B4 Impact & stakeholders.** States consequences (e.g., poor performance, wasted resources, limited scalability) and who is affected.
- **B5 Why unsolved.** References concrete shortcomings of existing work.
- **B6 Why now.** Ties the problem to a current trend that makes it timely.
- **B7 Concise and formal.** The core statement fits in about 1–2 sentences; avoids unqualified words like "better," "improved," "efficient" without saying in what respect.
- **B8 Doesn't prescribe the solution.** It frames the need without turning into a description of the proposed system.
- **B9 Aligned.** Directly reflects the gap and sets up the aim and objectives.
- **B10 Actionable.** Implies a clear research direction.

#### C. Aim / general objective (Guide 3)

- **C1 Single high-level statement** of 1–2 sentences.
- **C2 Targets the gap** and names the problem specifically.
- **C3 States the intended outcome** (e.g., improved performance, utilization, fairness, accuracy).
- **C4 Clear wording**, minimal jargon.

#### D. Specific objectives (Guide 3)

- **D1 Count.** About 3–5 objectives; flag far more (scope creep) or fewer (under-specified).
- **D2 Action verbs.** Each begins with an actionable verb (design, implement, evaluate, assess, compare). Flag weak verbs like "understand," "learn," "study," "explore" when used as the whole objective.
- **D3 SMART.** Specific, Measurable, Achievable, Relevant, Time-bound (time-bound may be satisfied by a timeline elsewhere).
- **D4 Coverage.** Includes both building (design/implement) and evaluating (performance/scalability/robustness) objectives.
- **D5 Decomposes the aim.** Achieving all objectives would achieve the aim; nothing in the aim is left uncovered, and no objective is off-aim.
- **D6 Measurable criteria named.** Evaluation objectives name metrics and comparison points (e.g., "compared to the default scheduler in terms of throughput and latency").

#### E. Methods (Guide 3)

- **E1 Covers the pipeline:** design → implementation → experimental setup → evaluation → validation.
- **E2 Concrete tools.** Names languages, frameworks, platforms, datasets, benchmarks.
- **E3 Experimental setup described:** hardware/testbed, software stack, workloads/datasets.
- **E4 Addresses the gap.** It is clear how the method's design attacks the stated limitation.
- **E5 Feasible.** Leverages existing tools and datasets where possible; resources are realistically obtainable.
- **E6 Baselines.** Plans a comparison against existing/state-of-the-art solutions.
- **E7 Traceability.** Each objective maps to at least one method step. Build a mapping table (see Step 4).

#### F. Evaluation & validation plan (Guide 6)

- **F1 Metrics defined** and tied to objectives—covering, as relevant, performance, efficiency/resource use, scalability, and robustness (or the field's equivalents). Each metric has a definition and unit.
- **F2 Baselines** include both the widely used default and at least one state-of-the-art or domain-specific alternative, with a reason for each.
- **F3 Realistic scenarios.** Standard benchmarks or realistic datasets/workloads; a realistic environment.
- **F4 Variations.** Tests across conditions (e.g., small vs. large scale, low vs. high load, failure or adversarial conditions).
- **F5 Controlled setup.** Fixed hardware and software versions; control variables stated so the effect of the proposed system is isolated.
- **F6 Correctness validation.** States how the author will confirm the system behaves as designed (logs, tracing, test cases, ground truth).
- **F7 Robustness validation.** Stress or failure testing with an acceptable-degradation criterion.
- **F8 Analysis plan.** Multiple runs; mean/median and standard deviation; significance testing where claims compare systems.
- **F9 Presentation plan.** Intended charts/tables for comparing against baselines.
- **F10 Reproducibility.** Plans to share code, configurations, and datasets/traces, and to document the setup.
- **F11 Limitations acknowledged.** States what the evaluation will not cover (workloads, scale, hardware) and how that bounds the conclusions.

#### G. Review of related literature (Guide 4)

- **G1 Organized by themes**, not a chronological or paper-by-paper list.
- **G2 Relevant** works, mixing seminal papers with recent ones (roughly last 3–5 years relative to the proposal date).
- **G3 Critical, not descriptive.** For each key work: contribution, strength, *and* limitation—with the limitation explicitly linked to the proposal's gap. Flag "X did Y. Z did W." summaries with no critique.
- **G4 Authoritative sources.** Peer-reviewed venues and journals, plus relevant official documentation or industry reports. Flag heavy reliance on blogs, Wikipedia, or undated web pages.
- **G5 Focused size.** About 1–2 paragraphs per theme and a targeted core set of works (the guide suggests ~6–10 key papers for a proposal; more is fine for MS/PhD if still focused).
- **G6 Transitions** connect themes and build the argument toward the gap.
- **G7 Synthesis.** Ends with a paragraph that summarizes the shortcomings and positions the proposed work as addressing them.
- **G8 Citations.** Consistent style (IEEE, ACM, etc.); complete entries; DOIs/URLs where possible; every in-text citation appears in the references and vice versa. Spot-check: list any citations that look incomplete, inconsistent, or unverifiable.
- **G9 Terms defined** or clear from context.

#### H. Title (Guide 5)

- **H1 Clear and specific.** Names the system/component, the problem, and the context (e.g., platform, workload, environment); precise terms instead of generic ones.
- **H2 Contribution visible** (e.g., "optimizing," "a scheduler for," "detecting").
- **H3 Keywords** a researcher would search for.
- **H4 Length** roughly 8–15 words.
- **H5 No filler** such as "A Study on," "Towards," "An Analysis of" unless a template requires it.
- **H6 No overpromising** ("revolutionizing," "solving") and no catchy-but-vague phrasing.
- **H7 Aligned** with the problem statement and the scope of aim/objectives.
- **H8 Conventional style** for the field (e.g., "Optimizing X for Y," "X: A System for Z"). If the title is weak, propose 2–3 alternatives with different emphasis.

---

### Step 4 — Check alignment across sections (the "golden thread")

This is often the most valuable part of the review. Check that one consistent story runs through:

**Gap → Problem statement → Aim → Objectives → Methods → Evaluation metrics → Title**

Produce a traceability table:

| Objective | Method step(s) | Metric(s) / validation | Baseline(s) | Gap |
|---|---|---|---|---|
| Obj 1: … | … | … | … | … |

Flag:
- objectives with no method or no evaluation;
- methods or metrics not tied to any objective;
- RRL limitations that don't match the stated gap, or a gap that the RRL never establishes;
- a title or aim broader or narrower than the objectives;
- scope/limitations that contradict the objectives.

### Step 5 — Calibrate for level

- **Undergraduate (CMSC 190):** prioritize clarity, feasibility within ~1–2 semesters, and a sound evaluation. A modest, well-scoped contribution is fine. Be explicit and educational in the fixes.
- **MS (CMSC 200):** expect a genuine gap supported by recent literature, credible baselines, and statistical analysis.
- **PhD (CMSC 300) / venue:** expect clear novelty against the current state of the art, top-venue-level evaluation rigor, and reproducibility.

### Step 6 — Write the review

Use the template below. Tone: collegial, direct, and specific—like a good adviser. Lead with what works. Prioritize: a reader should know the top three things to fix after reading the summary. Do not rewrite the whole proposal; give targeted rewrites only for the title, problem statement, and aim when they are weak.

Deliver the review as a document (Markdown by default; another format if the user asks). Name it `<proposal-short-name>_review.md`.

## Review template

```markdown
# Proposal Review: <Proposal title>

**Author(s):** <if stated> · **Level assumed:** <CMSC 190/200/300/venue> · **Reviewed:** <date>
**Basis:** SRG ICS-UPLB Research Proposal guide series, Parts 1–6

## Summary

<3–5 sentences: what the proposal aims to do, the gap it targets, and an overall assessment.>

**Overall recommendation:** <Ready to proceed · Minor revisions · Major revisions · Rework the core problem>

**Top priorities**
1. <most important fix, with page>
2. <…>
3. <…>

**Strengths**
- <specific strength, with page>
- <…>

## Section-by-section assessment

| Section | Rating | Key issue |
|---|---|---|
| Research gap | ●●●○○ | … |
| Problem statement | … | … |
| Aim | … | … |
| Objectives | … | … |
| Methods | … | … |
| Evaluation & validation | … | … |
| Review of related literature | … | … |
| Title | … | … |

<Rating scale: ●●●●● excellent · ●●●●○ good · ●●●○○ adequate · ●●○○○ weak · ●○○○○ missing or seriously flawed>

### 1. Research gap
<Findings against A1–A6. For each Partial/Not met: evidence (page) → suggested fix.>

### 2. Problem statement
<Findings against B1–B10.>
<If weak: "Suggested rewrite:" a 1–2 sentence version.>

### 3. Aim
<C1–C4, plus a suggested rewrite if needed.>

### 4. Specific objectives
<D1–D6. Comment on each objective by number.>

### 5. Methods
<E1–E7.>

### 6. Evaluation and validation
<F1–F11.>

### 7. Review of related literature
<G1–G9, including a list of citation problems found.>

### 8. Title
<H1–H8, plus 2–3 alternative titles if needed.>

## Alignment check

<Traceability table from Step 4, followed by a bullet list of breaks in the thread.>

## Minor issues
<Grammar, formatting, figure labels, inconsistent terms—grouped briefly, with pages.>

## Questions for the author
<3–6 questions a panel would likely ask at the defense.>

## Detailed checklist

<Compact table of every criterion ID (A1…H8) with Met / Partial / Not met / N/A.>
```

## Reviewer rules

- Base every judgment on what is actually in the PDF; cite pages. If something might be in an appendix you couldn't read, say so rather than marking it missing.
- Keep quotes from the proposal short; paraphrase otherwise.
- Never fabricate references, papers, or "existing work." If you suggest literature the author should look at, only name works you have verified (e.g., via web search), and include a link.
- Novelty concerns are suggestions to check, not verdicts.
- Don't penalize a proposal for using different section names than the guides, as long as the content is there.
- If the PDF isn't a research proposal (e.g., a finished thesis or a paper), say so and adapt: review the same components but note which criteria apply differently.
