# TL / Loop Finitized-Character Candidates (cycle 0, thin)

Source gap map: `outputs/maps/003_tl_loop_finitized_character_seed_map.md`。
cycle 0 thin の粗い候補。`resolved_risk` / `novelty_risk` は `unchecked`、`paper_potential` は粗い当て推量。06_verify・sagemath はこの周では行わない。
記法: logarithmic minimal model \(LM(p,p')\)、strip サイズ（列数）\(N\)、形式変数 \(q\)、loop fugacity \(\beta=-(q+q^{-1})\)、境界 fugacity \(\{\xi_i\}\)。finitized character を \(\chi^{(N)}(q)\) と書く。

```yaml
id: U1-two-boundary-general-param-finitized-character
title: 一般2境界パラメータをもつ blob/2-boundary TL loop 模型の finitized character
status: candidate
model_family: loop_tl
model: 2-boundary Temperley-Lieb (blob) dense loop model / LM(p,p')
operation_type: character_identity
statement_type: finite_size_identity
parameters: [generic_loop_fugacity, finite_size, q_series]
boundary_condition: two integrable boundaries with general boundary fugacities ξ_1, ξ_2
known_result_anchor: >
  Pearce-Rasmussen 2007（critical dense polymers, 1境界/特殊点の finitized character）と
  de Gier-Nichols 2009（1-boundary TL = blob 代数の表現論）。
missing_generalization: >
  1境界・特殊境界点の finitized character は既知（gap map K2/K3）。一般の2境界パラメータ
  \(\xi_1,\xi_2\) に依存する finitized Kac character（有限 q-多項式）は gap map U1 が unknown。
candidate_statement: >
  幅 \(N\) の strip 上の 2-boundary TL（blob）dense loop 模型において、各 link-state sector の
  double-row transfer matrix の固有値生成関数は、境界 fugacity \(\xi_1,\xi_2\) と loop fugacity \(\beta\) に
  依存する有限 q-多項式 \(\chi^{(N)}_{\text{sector}}(q;\xi_1,\xi_2)\) として閉じ、
  bosonic（交代和）と fermionic（patterns-of-zeros / quasi-particle 和）の2表示をもつ。
  特殊点で K2/K3 の既知 finitized character に帰着し、\(N\to\infty\) で対応する境界 LCFT 指標に収束する。
finite_symbol_process: >
  character_identity / q_series_identity。double-row transfer matrix の固有値を
  patterns-of-zeros で分類し、sector ごとの生成関数を有限 q-多項式として両側表示で一致させる。
expected_proof_strategy: >
  Pearce-Rasmussen の functional-equation / patterns-of-zeros 法を 2-boundary（blob）表現へ拡張。
  境界 fugacity 依存の固有値分類が有限 N で閉じることを示す。
small_case_experiment: >
  小 N（2-6）で 2-boundary TL double-row transfer matrix を記号構築し、固有値生成関数と
  予想多項式の一致を SageMath で検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: medium
references: [pearce-rasmussen-2007-critical-dense-polymers, degier-nichols-2009-one-boundary-tl, pearce-villani-2014-critical-dense-polymers-robin]
notes: gap map U1。最有力。de Gier 系の後続に既出の可能性 → resolved 確認要。
```

```yaml
id: U2-fused-tl-finitized-character
title: fused Temperley-Lieb loop 模型（一般 fusion level）の finitized character
status: candidate
model_family: loop_tl
model: fused TL dense loop model (fusion level n), LM(p,p')
operation_type: character_identity
statement_type: finite_size_identity
parameters: [critical, finite_size, q_series]
boundary_condition: strip
known_result_anchor: >
  Pearce-Rasmussen-Zuber 2006（fusion level 1 の LM(p,p') finitized Kac character）、
  Pearce-Tartaglia 2014（超共形 = 部分的に fused-TL の finitized character）。
missing_generalization: >
  fusion level 1（と超共形の一部）の finitized character は既知/needs_review。一般 fusion level \(n\) の
  fused-TL finitized character は gap map U2 が unknown。
candidate_statement: >
  fusion level \(n\) の fused-TL dense loop 模型（strip）の各 sector の transfer matrix 固有値生成関数は、
  level \(n\) に依存する有限 q-多項式 \(\chi^{(N),n}(q)\) として閉じ、fermionic / bosonic 2表示をもつ。
  \(n=1\) で Pearce-Rasmussen-Zuber に帰着し、\(N\to\infty\) で対応する（高 spin / fused）LCFT 指標に収束する。
finite_symbol_process: >
  character_identity / fusion_relation。fusion hierarchy（T-system 型関係）で fused transfer matrix を
  構成し、固有値生成関数を有限 q-多項式に落とす。
expected_proof_strategy: >
  fusion の functional relation（T-system）を用いて level \(n\) の固有値を level 1 から構成し、
  finitized character の閉形を帰納的に示す。
small_case_experiment: >
  n=2 の小 N で fused double-row transfer matrix を構築し、固有値生成関数を数値・記号で確認。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: low
references: [pearce-rasmussen-zuber-2006-logarithmic-minimal, pearce-tartaglia-2014-logarithmic-superconformal]
notes: gap map U2（fusion 軸）。Pearce-Tartaglia 系の続きで一部既出の可能性 → resolved 確認要。slice 2 の高ランク(U2)と類似構造。
```

```yaml
id: U3-loop-boundary-correlation-finite-formula
title: dense loop 模型の境界相関の有限記号閉形式（六頂点境界相関 det の loop 版）
status: candidate
model_family: loop_tl
model: dense loop model (blob / 1-boundary TL), LM(p,p')
operation_type: character_identity
statement_type: exact_formula
parameters: [critical, finite_size]
boundary_condition: integrable boundary, boundary observable
known_result_anchor: >
  Morin-Duchesne-Saleur 2018（dense loop の2点境界相関）と Pearce-Rasmussen 2007（finite strip 厳密解）。
  vertex-face/loop 対応の背景に Pasquier-Saleur 1990。
missing_generalization: >
  2点境界相関は既知（gap map NR2, near-known）だが、これを一般サイズで閉じた有限記号公式
  （行列式 / 有限和 / 生成関数）として与え、六頂点の境界相関 det（slice 1 K5/U1）の loop 版にするセルは
  gap map U3 が unknown。
candidate_statement: >
  幅 \(N\) の strip 上の dense loop 模型（1-boundary TL）において、境界辺の link 配置に関する
  境界相関は、double-row transfer matrix から構成される有限行列式（または有限和）で表せ、
  vertex-face/loop 対応のもとで六頂点境界相関の行列式公式（Bogoliubov-Pronko-Zvonarev 型）に対応する。
finite_symbol_process: >
  determinant_formula / character_identity。loop link-state 基底で境界 observable を行列要素として表し、
  transfer matrix の有限積から閉形を得る。
expected_proof_strategy: >
  Morin-Duchesne-Saleur の境界相関構成を出発点に、vertex-face/loop 対応で六頂点の境界挿入法（BPZ）を移植し、
  有限行列式表示が閉じることを示す。
small_case_experiment: >
  小 N で loop link-state 基底の境界相関を直接計算し、予想行列式と一致を記号検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: medium
references: [morin-duchesne-saleur-2018-two-point-boundary-loop, pearce-rasmussen-2007-critical-dense-polymers, pasquier-saleur-1990-quantum-groups]
notes: gap map U3。slice 1（六頂点境界相関 det）の loop 版で、横断テーマ「境界軸×有限公式」の結節点。vertex-face/loop 対応が鍵。
```
