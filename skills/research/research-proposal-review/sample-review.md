# Paper Review: OSv-MPI: A Prototype MPI Implementation for the OSv Cloud Operating System

**Author(s):** Joseph Anthony C. Hermocilla, Eliezer A. Albacea · **Level assumed:** Venue paper (NCITE 2016, published). Assessed as if preparing an extended or journal version. · **Reviewed:** 2026-11-08
**Basis:** SRG ICS-UPLB Research Proposal guide series, Parts 1–6
*This is a published conference paper, not a proposal. "Aim/objectives" are read as the stated contribution. "Methods" are read as design and implementation. Page numbers are the proceedings page numbers (pp. 203–208).*

## Summary

The paper presents OSv-MPI, a from-scratch, TCP-based MPI subset that lets MPI applications run on OSv. OSv is a single-address-space cloud OS that runs one application per VM. The work has three parts:
- a daemon (`osvmpd`, master/slave);
- a library (`osvmpi`) implementing six calls: `Init`, `Comm_size`, `Comm_rank`, `Send`, `Recv`, `Finalize`;
- curl-based bootstrap scripts that drive OSv's REST API.

Correctness is shown with three small programs (hello world, send-receive, ping-pong) on a three-node OSv cluster in the P2C private cloud.

The motivation is well framed: general-purpose guest OSes add overhead to HPC in the cloud. The design is clearly explained, and the code is released. The main weakness is a broken thread. The paper is **motivated by performance**, but it **evaluates only functional correctness**. It reports no latency, bandwidth, or scalability numbers, and no comparison with MPICH or Open MPI on a Linux guest. The one resource measurement (96.9% CPU from a listener thread) suggests a busy-wait that would *hurt* performance. As an NCITE prototype paper this is acceptable. An extended version would need a performance evaluation.

**Overall recommendation:** As published (NCITE prototype paper): acceptable. For an extended or journal version: **Major revisions**. Add a comparative performance evaluation and an expanded related-work section.

**Top priorities (for an extended version)**
1. **Evaluate performance against the motivation** (pp. 203–204 vs. pp. 206–207). Run point-to-point latency and bandwidth tests across message sizes, e.g., the OSU micro-benchmarks' `osu_latency` and `osu_bw`, using the implemented subset. Compare OSv-MPI on OSv with MPICH/Open MPI on Linux guests on the same P2C hardware and VM sizes. Without this, the claim that OSv is "an alternative guest operating system to use when running HPC applications" (p. 208) is unsupported.
2. **Fix or explain the 96.9% CPU listener** (p. 207). "pingpong.exe is the thread that listens for connections and keeps the CPU busy" points to polling. Use blocking `accept()`/`select()` or a condition variable, then re-measure. Otherwise the CPU figure argues *against* the approach.
3. **Position against related work beyond Open MPI** (p. 208). Related work is one paragraph. Add unikernels and lightweight kernels for HPC, in particular **HermitCore**, which ran MPI applications on a unikernel or multi-kernel in the same year ([Lankes et al., ROSS 2016 slides](https://events.cels.anl.gov/ross/2016/slides/ross2016-lankes.pdf)). Also cover inter-VM MPI communication (Diakhate et al., already cited in the intro) and the cloud-HPC performance literature.

**Strengths**
- The motivation is clear and cited: virtualization and general-purpose OS layers degrade HPC performance in IaaS (Ostermann et al.; Kivity et al.) (pp. 203–204).
- The architecture is explained concisely (Fig. 6). It has separate ports for MPI data, daemon peers, and console output. Peers communicate directly after the rank table is distributed, without relaying through `osvmpd` (p. 206).
- The setup is reproducible: OSv version (0.17), host machine, image size, instance sizes (1 vCPU, 512 MB, 21 GB), and build commands (Listing 3) are all given. Source code is linked (p. 203 footnote).
- The scope is honest. It is called a "prototype", and the limitations (one application per `osvmpd`, TCP only) and future work are stated (pp. 205, 208).
- It describes practical engineering details for OSv, which has no SSH and no on-instance toolchain: a logging library, REST-based upload, and cross-built binaries relying on Linux ABI compatibility (p. 206).

## Section-by-section assessment

| Section | Rating | Key issue |
|---|---|---|
| Research gap | ●●●○○ | Motivated, but "no MPI exists for OSv" is implicit, not stated or verified |
| Problem statement | ●●○○○ | No explicit problem statement; the problem is spread over the intro |
| Aim (contribution) | ●●●●○ | Clear contribution statement (p. 204) |
| Objectives | N/A | Paper format, but expected outcomes are not enumerated |
| Methods (design/impl.) | ●●●●○ | Clear and reproducible; busy-wait listener; one process per node |
| Evaluation & validation | ●●○○○ | Correctness demos only; no performance, scalability, or baseline |
| Related work | ●●○○○ | One paragraph on Open MPI only |
| Title | ●●●●● | Clear, specific, conventional |

### 1. Research gap

- **A1 Partial.** The gap that MPI applications can't run on OSv is implied by the contribution statement (p. 204) but never stated as a gap. Say so explicitly, and say why OSv's Linux ABI compatibility isn't enough to run stock MPICH/Open MPI. The paper hints at the reasons only in Related Work ("complexity (many abstraction layers)", p. 208): `fork()`/`exec()`-based process managers and SSH-based launchers that OSv lacks.
- **A2 Met.** It is grounded in the cloud-HPC performance literature and OSv's design paper.
- **A3 Partial.** There is no evidence of a search for prior MPI-on-OSv or MPI-on-unikernel work. HermitCore (ROSS 2016) is concurrent and relevant (see Top priority 3). I found no prior MPI port for OSv specifically.
- **A4 Met.** **A5 Met.** **A6 Met** for a prototype paper.

### 2. Problem statement

- **B1 Partial.** **B2 Met.** **B3 Met** (OSv, IaaS, MPI). **B4 Partial.** **B5 Partial.** **B6 Met** (OSv was new in 2014–2016).
- **B7 Not met.** There is no 1–2 sentence statement.
- **B8 Met.** **B9 Partial** (see Alignment). **B10 Met.**

**Suggested statement:** "Library operating systems such as OSv promise lower virtualization overhead for cloud workloads, but existing MPI implementations depend on process-management and remote-execution facilities (fork/exec, SSH) that OSv does not provide. As a result, MPI-based HPC applications cannot use OSv as a guest operating system."

### 3. Aim (contribution)

- **C1 Met.** "OSv-MPI, a prototype MPI implementation to enable HPC applications that use the MPI standard to run on virtual machines with OSv as the guest operating system" (p. 204).
- **C2 Met.**
- **C3 Partial.** The outcome is "run", meaning functional. The motivation implies "run with less overhead". Either claim only functionality, or measure overhead.
- **C4 Met.**

### 4. Objectives

- **D1–D6 N/A.** Conference papers don't enumerate objectives. Still, the expected results (correctness, compatibility, performance) should be stated up front so the evaluation can be checked against them.

### 5. Methods (design and implementation)

- **E1 Partial.** Design and implementation are described. The experimental setup is minimal.
- **E2 Met.** OSv 0.17, gcc flags, json-c (`-ljson-c`), curl, TCP and `select()`.
- **E3 Met.** Host and instance specifications are given (p. 206).
- **E4 Partial.** The design is suited to OSv's model: no processes, REST control. The paper doesn't argue how the design reduces overhead.
- **E5 Met.**
- **E6 Not met.** No baseline (see F2).
- **E7 N/A** (no objectives list).
- **Design observations:**
  - *Busy listener* (p. 207): see Top priority 2.
  - *Completion detection:* the output file is polled manually until it appears ("On the fourth try", p. 206). A completion signal or exit status from `mpirun-osv.sh` would make runs scriptable and timeable.
  - *Datatypes and tags:* say which `MPI_Datatype`s and whether `tag`/`MPI_ANY_SOURCE` matching are supported. This determines which real applications can run.
  - *Scale:* the "one MPI application connects to an osvmpd process" constraint (p. 205) means one rank per VM. State the implication: multi-core VMs are unused.
  - *Security:* the REST API (port 8000) accepts binary uploads, and messages are unauthenticated. This is acknowledged as future work (p. 208). Mention it as a deployment caveat for shared private clouds.

### 6. Evaluation and validation

- **F1 Not met.** No performance metrics are defined. The CPU % comes from the admin UI screenshot (Fig. 12).
- **F2 Not met.** No comparison with MPICH/Open MPI on Linux VMs.
- **F3 Partial.** The test programs are toy examples. Add at least one small kernel, e.g., the NAS Parallel Benchmarks' EP, which needs only point-to-point calls if implemented carefully, or a simple stencil written to the implemented subset.
- **F4 Not met.** There are no variations in message size, number of nodes, or iterations.
- **F5 Met.** Fixed versions and instance sizes.
- **F6 Met.** Correctness is shown by expected outputs (Figs. 8–11).
- **F7 Not met.** No failure or stress tests, e.g., large messages or node loss.
- **F8 Not met.** Single runs. *Fix:* Run ≥ 30 iterations per message size and report the median and spread.
- **F9 Partial.** The screenshots show correctness. Plan latency and bandwidth plots versus message size for the extended version.
- **F10 Met.** Code is released. *Check:* confirm the 2016 download link (p. 203 footnote) still resolves. If not, archive it, e.g., on GitHub or Zenodo, with a DOI.
- **F11 Partial.** The limitations are listed in future work rather than bounding the conclusions.

### 7. Related work

- **G1 Not met.** One paragraph, about Open MPI only.
- **G2 Partial.** It lacks unikernels and lightweight kernels for HPC.
- **G3 Partial.** Open MPI's features are contrasted, which is good. The reason for not porting it is given only briefly.
- **G4 Met.** **G5 Not met** (too thin). **G6 N/A.** **G7 Partial** (the porting rationale, p. 208).
- **G8 Partial.** Problems found:
  - [1] "50âĂŞ58" and [5] "UsersâĂŹ": encoding mojibake for an en dash and an apostrophe in the BibTeX.
  - [4] Author is rendered "C. T. M. Forum". The intended author is "The MPI Forum". Brace the name in BibTeX: `{The MPI Forum}`.
  - [8] The NIST definition of cloud computing is cited as "(draft)". SP 800-145 was finalized in 2011.
  - [7] "usenix annual technical conference (usenix atc 14)": lowercase. Brace the venue to keep its capitalization.
- **G9 Met.**

### 8. Title

- **H1 Met.** **H2 Met** ("A prototype MPI implementation for"). **H3 Met** (MPI, OSv, cloud operating system).
- **H4 Met** (11 words). **H5 Met.** **H6 Met** ("prototype" is appropriately modest). **H7 Met.** **H8 Met** ("X: A Y for Z").

## Alignment check

| Contribution / claim | Method | Validation | Baseline | Gap |
|---|---|---|---|---|
| MPI apps can run on OSv | osvmpd + osvmpi + bootstrap (pp. 205–206) | Hello, send-receive, ping-pong outputs (Figs. 8–11) | — | No MPI for OSv (implicit) |
| OSv is an HPC guest-OS alternative (p. 208) | — | CPU % on one run (Fig. 12) | — | General-purpose OS overhead (p. 203) |

**Breaks in the thread**
- **The motivation is performance, but the evaluation is correctness.** The conclusion's "alternative guest operating system to use when running HPC applications" needs performance evidence.
- The only resource measurement (CPU busy-wait) cuts against the performance motivation.
- Figures 1–2 and 4–5 (P2C and OSv dashboards and CLI) take substantial space but support no claim. In an extended version, replace them with performance plots.

## Minor issues

- "ACKOWLEDGMENTS" → ACKNOWLEDGMENTS (p. 208).
- "lets the hypervisor performs" → perform (p. 204). "All work in the kernel are also done" → is (p. 204). "Open source implementations of MPI exists" → exist (p. 203). "the output are then consolidated" → is (p. 206).
- "minimal, if no modifications unless …" (p. 204) is unclear. Consider "few or no modifications, provided their dependencies are supported in OSv".
- The code listings use a letter-spaced font. Use `\lstset{columns=fullflexible}` or a monospace font for copy-pasteable code.
- "Google CE" (p. 203) → Google Compute Engine.

## Questions a reviewer would ask

1. What are the point-to-point latency and bandwidth of OSv-MPI on OSv versus MPICH on Linux on the same VMs?
2. Why does the listener thread consume ~97% CPU, and what happens to performance once that is fixed?
3. Which real MPI applications can run with only the six implemented calls?
4. Why couldn't MPICH run on OSv given OSv's Linux ABI compatibility? What specifically breaks?
5. How does OSv-MPI compare with HermitCore's approach to MPI on a unikernel?

## Detailed checklist

| ID | Rating | ID | Rating | ID | Rating | ID | Rating |
|---|---|---|---|---|---|---|---|
| A1 | Partial | B7 | Not met | E2 | Met | F8 | Not met |
| A2 | Met | B8 | Met | E3 | Met | F9 | Partial |
| A3 | Partial | B9 | Partial | E4 | Partial | F10 | Met |
| A4 | Met | B10 | Met | E5 | Met | F11 | Partial |
| A5 | Met | C1 | Met | E6 | Not met | G1 | Not met |
| A6 | Met | C2 | Met | E7 | N/A | G2 | Partial |
| B1 | Partial | C3 | Partial | F1 | Not met | G3 | Partial |
| B2 | Met | C4 | Met | F2 | Not met | G4 | Met |
| B3 | Met | D1–D6 | N/A | F3 | Partial | G5 | Not met |
| B4 | Partial | E1 | Partial | F4 | Not met | G6 | N/A |
| B5 | Partial | | | F5 | Met | G7 | Partial |
| B6 | Met | | | F6 | Met | G8 | Partial |
| | | | | F7 | Not met | G9 | Met |
| H1 | Met | H2 | Met | H3 | Met | H4 | Met |
| H5 | Met | H6 | Met | H7 | Met | H8 | Met |
