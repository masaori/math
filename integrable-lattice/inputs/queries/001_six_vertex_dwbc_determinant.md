# Query Log: six_vertex_dwbc_determinant

## Scope

First-pass harvest for six-vertex / XXZ determinant-formula cells around:

- domain wall boundary conditions
- reflecting / partially reflecting boundary conditions
- partial domain wall boundary conditions
- ASM symmetry classes and half-turn variants
- determinant / Pfaffian / correlation-function extensions derived from Izergin-Korepin or Tsuchiya-type formulas

Elliptic and higher-spin variants are intentionally excluded from this first pass because the current canonical anchors do not directly support them.

## Seed Queries Used

```text
"six-vertex model" "domain wall boundary" "determinant formula" arXiv
"six-vertex" "reflecting end" determinant Tsuchiya arXiv
"partial domain wall partition functions" "six-vertex" arXiv
"six-vertex" "triangular" "domain wall" determinant partition function
"A refined enumeration of alternating sign matrices" six vertex model domain wall DOI Zeilberger Kuperberg
"Another proof of the alternating-sign matrix conjecture" Kuperberg six vertex arXiv DOI
"Boundary correlation functions of the six-vertex model" arXiv math-ph/0203025 DOI
"Emptiness formation probability" "six-vertex" "domain wall boundary" Colomo Pronko arXiv
"On the partition function of the six-vertex model with domain wall boundary conditions" Colomo Pronko arXiv math-ph/0309064 DOI
"Six-vertex model with partial domain wall boundary conditions: ferroelectric phase" DOI
"Exact results for the six-vertex model with domain wall boundary conditions and a partially reflecting end" arXiv Hietala DOI
"Boundary correlations for the six-vertex model with reflecting end boundary condition" arXiv DOI
"Domain wall six-vertex model with half-turn symmetry" Bleher Liechty arXiv DOI
"Construction of determinants for the six-vertex model with domain wall boundary conditions" DOI
```

## Noisy / Deferred Queries

```text
"eight-vertex" "domain wall boundary" determinant
"higher-spin" "domain wall boundary" "six-vertex" determinant
"elliptic" "domain wall boundary" "six-vertex" determinant
```

These are deferred because they shift the first pass away from directly anchored six-vertex DWBC determinant cells.

## Harvest Decision

Save a small curated metadata file rather than a bulk corpus. The next step is a seed gap map, not full-text extraction.

