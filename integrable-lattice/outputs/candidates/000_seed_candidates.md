# Seed Candidates

未解決ステートメント候補をここに蓄積する。

## テンプレート

```yaml
id:
title:
model_family:
model:
operation_type:
statement_type:
boundary_condition:
known_result_anchor:
missing_generalization:
candidate_statement:
finite_symbol_process:
expected_proof_strategy:
small_case_experiment:
resolved_risk:
novelty_risk:
paper_potential:
references:
notes:
```

## Candidates

Source gap map: `outputs/maps/001_six_vertex_dwbc_determinant_seed_map.md`。
記法: 六頂点の Boltzmann 重み \(a,b,c\)（trigonometric, 非斉次パラメータ \(\{\lambda_i\},\{\nu_j\}\)）。
標準 DWBC は \(N\times N\) 格子、partial DWBC は \(n\times N\)（\(n\le N\)）格子。

```yaml
id: U1-corr-partial-dwbc-boundary-onepoint
title: partial DWBC 六頂点模型の境界1点相関の有限行列式公式
status: candidate
model_family: vertex_spin_chain
model: six-vertex
operation_type: determinant_formula
statement_type: exact_formula
parameters: [trigonometric, inhomogeneous, finite_size]
boundary_condition: partial domain wall
known_result_anchor: >
  Foda-Wheeler 2012 が partial DWBC 分配関数 \(Z_{n,N}\) の有限行列式（\(N\times N\) と \(n\times n\) の等価二形）を与える。
  Bogoliubov-Pronko-Zvonarev 2002 が標準 DWBC（\(n=N\)）の境界1点相関を行列式で与える。
missing_generalization: >
  境界1点相関の有限行列式は標準 DWBC（\(n=N\)）でのみ知られ、partial DWBC（\(n<N\)）では gap map U1 が unknown。
candidate_statement: >
  \(n\times N\)（\(n\le N\)）格子の partial DWBC 六頂点模型（trigonometric, 非斉次）において、
  指定行の境界辺が固定タイプを取る境界1点相関 \(h^{(r)}_{n,N}\) は、
  Foda-Wheeler の partial DWPF 行列式を1つの非斉次パラメータ（または spectral parameter）で
  変形（境界微分）した修正行列式と \(Z_{n,N}\) の比として、閉じた有限サイズ行列式で表せる。
  \(n=N\) で Bogoliubov-Pronko-Zvonarev 2002 の標準 DWBC 公式に帰着する。
finite_symbol_process: >
  determinant_formula。分配関数行列式の境界パラメータに関する有限差分／微分で相関を生成し、
  QISM/Korepin 型 recursion が \(N\) について閉じることを用いる。
expected_proof_strategy: >
  BPZ 法（境界演算子挿入 → 相関を修正行列式と分配関数行列式の比で表現）を
  Foda-Wheeler partial DWPF 行列式へ適用。recursion の閉性と \(n=N\) 還元を確認。
small_case_experiment: >
  \(n\in\{1,2\}\), \(N\in\{2,3\}\) で square ice 配置を直接列挙し、
  分配関数と境界1点相関を SageMath で総和計算、予想行列式と一致を検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: medium
references: [foda-wheeler-2012-partial-dwpf, bogoliubov-pronko-zvonarev-2002-boundary-correlations]
notes: gap map U1。最有力候補。partial→相関の「ずれ」が明確で小サイズ検証が容易。
```

```yaml
id: U1-efp-partial-dwbc-emptiness
title: partial DWBC 六頂点模型の emptiness formation probability の行列式/多重積分表示
status: candidate
model_family: vertex_spin_chain
model: six-vertex
operation_type: determinant_formula
statement_type: exact_formula
parameters: [trigonometric, inhomogeneous, finite_size]
boundary_condition: partial domain wall
known_result_anchor: >
  Colomo-Pronko 2007 が標準 DWBC の emptiness formation probability (EFP) を行列式/多重積分で与える。
  Foda-Wheeler 2012 が partial DWBC 分配関数の行列式を与える。
missing_generalization: >
  EFP の有限表示は標準 DWBC のみ。partial DWBC（gap map U1）では unknown。
candidate_statement: >
  \(n\times N\) partial DWBC 六頂点模型において、サイズ \(r\) の強誘電的フローズン角の
  emptiness formation probability \(F^{(r)}_{n,N}\) は、Foda-Wheeler 分配関数行列式から
  構成される有限行列式（または多重積分）で表せ、\(n=N\) で Colomo-Pronko 2007 に帰着する。
finite_symbol_process: >
  determinant_formula / multiple_integral。複数境界辺の同時固定を分配関数行列式の
  多重変形で生成する。
expected_proof_strategy: >
  Colomo-Pronko の EFP 構成（多重 boundary insertion → 直交多項式/積分核）を
  partial DWPF 行列式へ移植。直交多項式系が partial 設定で閉じるかを確認。
small_case_experiment: >
  \(n\in\{1,2\}\), \(N\in\{2,3\}\), \(r\in\{1,2\}\) で直接列挙し EFP を数値検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: medium
references: [colomo-pronko-2007-efp-dwbc, foda-wheeler-2012-partial-dwpf]
notes: gap map U1。U1-corr の発展。Bleher-Liechty 2014 の partial 漸近と整合チェック可能。
```

```yaml
id: U3-corr-halfturn-boundary-onepoint
title: half-turn 対称 DWBC 六頂点模型の一般パラメータ境界相関の有限行列式公式
status: candidate
model_family: vertex_spin_chain
model: six-vertex
operation_type: determinant_formula
statement_type: exact_formula
parameters: [trigonometric, inhomogeneous, finite_size]
boundary_condition: domain wall + half-turn symmetry
known_result_anchor: >
  Kuperberg 2002 が ASM 対称類（half-turn 含む）を行列式/Pfaffian で与える（主に ice point の数え上げ）。
  Bogoliubov-Pronko-Zvonarev 2002 が標準 DWBC の境界1点相関行列式を与える。
missing_generalization: >
  対称類の有限公式は ice point の数え上げに偏在。一般 trigonometric パラメータでの
  境界相関行列式は gap map U3 が unknown。
candidate_statement: >
  half-turn 対称 DWBC 六頂点模型（一般 trigonometric, 非斉次）において、境界1点相関は
  対称性で実効サイズを半減させた有限行列式/Pfaffian で表せ、ice point で
  Kuperberg 2002 の half-turn 数え上げと整合し、対称性を外すと
  Bogoliubov-Pronko-Zvonarev 2002 の標準公式に帰着する。
finite_symbol_process: >
  determinant_formula / pfaffian_formula。half-turn 対称による格子折り畳みで
  実効自由度を半減し、BPZ 型境界挿入を適用。
expected_proof_strategy: >
  half-turn 分配関数の有限行列式（Kuperberg / Bleher-Liechty 2017 の reduction）を出発点に、
  BPZ 法で境界相関を生成。対称折り畳みが相関でも閉じることを確認。
small_case_experiment: >
  小サイズ（\(N\in\{2,4\}\)）の half-turn 対称配置を直接列挙し、境界相関を数値検証。
resolved_risk: >
  unchecked。half-turn 分配関数の有限行列式は Kuperberg 2002 / Bleher-Liechty 2017 で
  既に得られている可能性があり、新規性は「相関」部分に限定される。要検証。
novelty_risk: >
  unchecked。BPZ + 対称折り畳みから自明に従うリスクを精査する必要がある。
paper_potential: medium
references: [kuperberg-2002-asm-symmetry-classes, bogoliubov-pronko-zvonarev-2002-boundary-correlations, bleher-liechty-2017-half-turn]
notes: gap map U3。分配関数側は resolved リスクあり。新規性の核は一般パラメータ相関。
```

