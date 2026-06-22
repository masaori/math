# Cycle 0 観察レポート（Λ-statement 版, 07_rank）

cycle 0（探索方向 A–F を絞らず広く浅く）を1周した観察。目的は件数でなく **cycle 1 で深掘りする Λ-statement の筋を根拠付きで選ぶこと**。
入力: maps/candidates A–F（`outputs/maps/{A,B,C,D,E,F}_*`, `outputs/candidates/{A,B,C,D,E,F}_*`）。06_verify・sagemath は未実施（`resolved_risk: unchecked`）。

## 横断の主観察（最重要）

A–F すべてが一つのテーマに収束した:

> **有限・離散・可積分 ⇒ 全量（零点・臨界点・スペクトル・Massieu Φ）が Λ/ℚ̄ で無条件に決定可能・形式検証可能（witness 付き、強度 RCA₀）。相転移＝非解析性は ℝ脱出 (b) $N\to\infty$ の一点だけに隔離される。**

各方向はこのテーマの異なる面:
- **A** 零点 ∈ ℚ̄（QQbar 決定可能）。
- **B** 臨界点 ∈ ℚ̄（自己双対多項式の根, witness）。
- **C** ℝ脱出隔離 ⟺ 自由フェルミ（決定可能判定）、さらに Bethe 可解系で有限 N スペクトル ∈ ℚ̄。
- **D** Massieu Φ_N ∈ Λ（素因数分解）、β ∈ Λ（整数比較）。ℝ を本体に含まない。
- **E** これは 07 テーブルの **(poly, closed) セル＝2D Ising 型** に対応。#P 側（3D・スピングラス）は可算でも計算困難で射程外。
- **F** A–D に「decide 可能・witness・RCA₀」の形式検証保証を与える。

文献との差分（旧 cycle 0 の文献分類とは異なる軸）: 文献は零点・臨界点を数値/極限（ℝ/ℂ）で扱う。**有限 N を Λ/ℚ̄ の厳密・決定可能・形式検証可能な対象として述べ、ℝ脱出を一点に隔離する**可算再定式化が共通の差分（06「未踏＝差分」と整合）。

## ランキング（暫定。resolved 未確認のため literature_risk は暫定）

```yaml
- id: A-U1-finite-N-fisher-zeros-qqbar
  bucket: high
  reason: ℝ 不使用・完全 decide・witness(最小多項式)・QQbar で即実演可能。Λ プログラム適合度最大。
- id: C-U3-bethe-solvable-finite-N-in-qqbar
  bucket: high
  reason: 射程最大（自由フェルミの外, XXZ/XYZ/RSOS まで）。Bethe 方程式=代数的⇒有限 N∈ℚ̄。
- id: D-U1-phi-recurrence-as-lambda-relation
  bucket: high
  reason: ℝ 不使用の有限 N Λ 命題。転送行列の整数性→Φ の Λ 漸化。形式検証(F)に最も乗る。
- id: F-U2-qqbar-certificate-zeros-critical-point
  bucket: high
  reason: A×B を QQbar 証明書化（数値→記号検証の格上げ）。SageMath で即実演。
- id: F-U1-lean-decide-lambda-lemma
  bucket: high
  reason: D 命題の Lean decide 最小実装。可算性の効用§5 の次手、最も具体的。
- id: B-U2-self-dual-polynomial-root-witness
  bucket: medium
  reason: 臨界点=自己双対多項式の根 witness。A-U1 と同型だが個別例は古典的。
- id: D-U3-inverse-temperature-monotonicity-integer-comparison
  bucket: medium
  reason: β 単調性・凹凸を Λ 整数比較で decide。README 未解決スレッド直結。
- id: C-U1-R-escape-isolation-iff-free-fermion-decidable
  bucket: medium
  reason: 可解性軸を決定可能判定へ。総合化だが核は確立済み。
- id: F-U4-meta-decidability-of-finite-N-integrable
  bucket: medium
  reason: A-D 統一テーマのメタ定理。束ねの軸だが単体は総括。
- id: A-U4 / B-U4 / D-U4
  bucket: medium
  reason: A↔B↔D の可算命題群を相互接続する結節（零点=臨界点集積, Φ=Σlog|q−root|）。
- id: A-U2 / C-U2
  bucket: medium
  reason: 自由フェルミ類の積分解・構造保存（A×C 交差）。
- id: B-U1 / A-U3 / C-U4 / D-U2 / E-U1 / E-U2 / E-U3 / F-U3
  bucket: low
  reason: 分類・総合・周辺。射程か新規性が中位以下。E は整理枠。F-U3 は calibration 宿題。
```

## paper bundle

- **finite_N_decidable（最有力・統合束）**: 「可積分格子模型の有限 N 量（零点 A・臨界点 B・スペクトル C・Massieu Φ D）を Λ/ℚ̄ の決定可能・形式検証可能・witness 付き対象として確立し、ℝ脱出を N→∞ の一点に隔離する」。A-U1 + C-U3 + D-U1 を核に、F-U1/F-U2 で形式検証、B-U2 で臨界点、F-U4 でメタ総括。
- **structure_preservation（C 中心）**: 自由フェルミ/Bethe 構造が可算性を保つ範囲の決定可能判定（C-U1, A-U2/C-U2）。finite_N_decidable の「なぜ閉じるか」側。
- **classification（E 中心）**: 07 テーブル配置。上記束の整理枠。

## cycle 1 への方向提案（decide:cycle1 で確定）

1. 方向を **`finite_N_decidable` 束** に絞る（A–F 横断で最も筋が揃い、ℝ脱出隔離・決定可能・形式検証可能を全て満たす）。
2. cycle 1 は**深掘りサイクル**（方向確定後なので 06_verify・sagemath・Lean を投下してよい）。最初の具体作:
   - **A-U1 + F-U2**: 小 L Ising の Z_L(x)∈ℤ[x] を構築 → QQbar で Fisher 零点を厳密計算・witness 化（SageMath）。
   - **C-U3**: 小 N XXZ の Bethe 根を QQbar で厳密に解き ℚ̄ 帰属を確認。
   - **D-U1 + F-U1**: Φ_N=log Z_N(q) の素因数分解と Λ 漸化を小 N で確認 → Lean decide 最小例。
3. resolved-risk 確認（A は 06「未踏」だが、各論文の零点厳密計算がどこまで既出かを cycle 1 冒頭で確認）。
4. vertex-face/自由フェルミ対応で A/B/C/D を1本に束ねられるか paper-plan 化。

→ cycle 0 成功条件（次に深掘る Λ-statement の筋を根拠付きで選べる状態）を満たす。
