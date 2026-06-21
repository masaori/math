# RSOS Character-Identity Candidates (cycle 0, thin)

Source gap map: `outputs/maps/002_rsos_character_identity_seed_map.md`。
cycle 0 thin の粗い候補。`resolved_risk` / `novelty_risk` は `unchecked`、`paper_potential` は粗い当て推量。06_verify・sagemath はこの周では行わない。
記法: minimal model \(M(p,p')\)、有限化サイズ \(L\)、形式変数 \(q\)。finitized character（有限 q-多項式）を \(\chi^{(L)}_{r,s}(q)\) と書く。

```yaml
id: U1-boundary-rsos-finitized-character
title: 可積分境界つき RSOS 模型の finitized character の boson=fermion 多項式恒等式
status: candidate
model_family: rsos_face
model: ABF / Forrester-Baxter RSOS（regime III/IV, 臨界 trigonometric）
operation_type: character_identity
statement_type: finite_size_identity
parameters: [trigonometric_critical, finite_size, q_series]
boundary_condition: open / integrable boundary（境界 height 固定 + 可積分境界重み）
known_result_anchor: >
  Melzer 1994 / Warnaar 1996 / Berkovich 1994 が bulk（CTM）の finitized Virasoro character
  \(\chi^{(L)}_{r,s}(q)\) の boson=fermion 多項式恒等式を与える。
missing_generalization: >
  bulk の finitized character 恒等式は確立しているが、可積分境界/欠陥を1つ入れた RSOS の
  1次元 configuration sum に対する finitized character（有限 q-多項式の boson=fermion 表示）は
  gap map U1 が unknown。slice 1 の「分配関数 → 境界相関」gap の RSOS 版。
candidate_statement: >
  臨界 ABF / Forrester-Baxter RSOS 模型に対し、片側に可積分境界（固定境界 height \(c\) と
  対応する境界重み）を課した長さ \(L\) の path に対する重み付き configuration sum は、
  bulk finitized character を境界 height でずらした有限 q-多項式 \(\chi^{(L),\,\partial c}_{r,s}(q)\) に等しく、
  これは fermionic（quasi-particle）和と bosonic（交代）和の2表示をもつ多項式恒等式として閉じる。
  \(L\to\infty\) で対応する境界 CFT の指標に収束する。
finite_symbol_process: >
  character_identity / q_series_identity。境界つき path の数え上げを transfer/recurrence で
  有限 q-多項式に落とし、bosonic 側（交代和）と fermionic 側（quasi-particle 和）の一致を
  有限 L で示す。
expected_proof_strategy: >
  Warnaar の1次元 configuration-sum recurrence を境界 height を固定した path 集合へ適用し、
  境界項込みで recurrence が L について閉じることを示す。bulk 還元と L→∞ 境界指標を確認。
small_case_experiment: >
  小さい \(p,p'\)（例 M(3,4) Ising, M(2,5)）と小 L で、境界 height 固定 path を直接列挙し、
  configuration sum と予想 fermionic/bosonic 多項式の一致を記号計算で検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: medium
references: [melzer-1994-fermionic-character-sums, warnaar-1995-abf-melzer-polynomial-identities, berkovich-1994-fermionic-counting-rsos]
notes: gap map U1。最有力。境界 RSOS（Behrend-Pearce 系）が既出の可能性 → 後続サイクルで harvest 補強・resolved 確認。
```

```yaml
id: U2-higher-rank-finitized-character
title: A_{n-1}^{(1)} (n>2) face 模型の finitized character の有限多項式恒等式
status: candidate
model_family: rsos_face
model: A_{n-1}^{(1)} face family（JMO, n>2）
operation_type: character_identity
statement_type: finite_size_identity
parameters: [trigonometric_critical, finite_size, q_series]
boundary_condition: bulk（1次元 configuration sum）
known_result_anchor: >
  Melzer 1994 / Warnaar 1996 が n=2（su(2)）の finitized boson=fermion 多項式恒等式を、
  DJKMO 1989 / JMO 1988 が高ランク configuration sum = affine Lie 代数 character の同定を与える。
missing_generalization: >
  「有限化（finitization）」は su(2) でのみ多項式恒等式として証明され、高ランク character は
  config sum との同定（極限）として既知。両者を繋ぐ高ランク(n>2) の finitized boson=fermion
  多項式恒等式は gap map U2 が unknown。
candidate_statement: >
  A_{n-1}^{(1)}（n>2）face 模型の長さ \(L\) 1次元 configuration sum は、
  branching/string 関数の有限化 \(\,b^{(L)}(q)\) として閉じた有限 q-多項式で表され、
  bosonic（Weyl 型交代和）と fermionic（Kirillov-Reshetikhin 型 quasi-particle 和）の
  2表示が有限 L で一致する。\(L\to\infty\) で DJKMO の affine character に収束する。
finite_symbol_process: >
  character_identity / q_series_identity。高ランク path の energy 統計付き数え上げを
  有限 q-多項式に落とし、両側表示の一致を示す。
expected_proof_strategy: >
  su(2) の Warnaar recurrence を A_{n-1}^{(1)} の path（admissibility 条件付き）へ持ち上げ、
  fermionic 側は Kirillov-Reshetikhin 型 quasi-particle 構成を使う。recurrence の閉性を確認。
small_case_experiment: >
  n=3 の最小 level・小 L で path を直接列挙し、config sum と予想多項式の一致を記号計算で検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: medium
references: [date-jimbo-kuniba-miwa-okado-1989-config-sums, jimbo-miwa-okado-1988-local-state-probabilities, melzer-1994-fermionic-character-sums]
notes: gap map U2（K1×K4 交差）。高ランク fermionic form（Kirillov-Reshetikhin/HKOTY 系）が一部既知の可能性大 → harvest 補強・resolved 確認が後続で必須。novelty_risk は高そう。
```

```yaml
id: U3-coset-beyond-su2-finitized-branching
title: su(2)_M×su(2)_N 以外の coset 分岐関数の finitized 多項式恒等式
status: candidate
model_family: rsos_face_coset
model: su(2) 外 coset（例 su(n)_M×su(n)_N/su(n)_{M+N}, parafermion 系）
operation_type: character_identity
statement_type: finite_size_identity
parameters: [finite_size, q_series]
boundary_condition: bulk
known_result_anchor: >
  Berkovich-McCoy-Schilling 1996 / Schilling-Warnaar 1997 が su(2)_M×su(2)_N/su(2)_{M+N}
  coset 分岐関数の有限 fermionic 形と bosonic（supernomial）形を与える。
missing_generalization: >
  su(2) coset の分岐関数 finitization は確立。su(2) 以外の coset（高ランク coset / parafermion 系）の
  分岐関数の有限 boson=fermion 多項式恒等式は gap map U3 が unknown。
candidate_statement: >
  su(n)_M×su(n)_N/su(n)_{M+N}（n>2）coset の分岐関数は、有限サイズ \(L\) の supernomial（bosonic）和と
  Kirillov-Reshetikhin 型 fermionic 和の双方で表される有限 q-多項式に finitize でき、
  両表示は有限 L で一致し \(L\to\infty\) で coset 分岐関数に収束する。
finite_symbol_process: >
  character_identity / q_series_identity。supernomial 係数の高ランク化と fermionic quasi-particle
  和の一致を有限 L で示す。
expected_proof_strategy: >
  Schilling-Warnaar の supernomial 漸化式を高ランクに拡張し、fermionic 側を
  Kirillov-Reshetikhin 型構成で対応させる。
small_case_experiment: >
  最小の su(3) coset・小 M,N,L で両表示を記号計算し一致を検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: low
references: [berkovich-mccoy-schilling-1998-branching-fermionic-forms, schilling-warnaar-1998-supernomial-branching]
notes: gap map U3（U2 と関連）。parafermion 系は一部既知の可能性。cycle 0 では粗い形に留める。
```
