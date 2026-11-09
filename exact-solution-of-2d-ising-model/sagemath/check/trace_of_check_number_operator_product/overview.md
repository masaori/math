# SageMath Check: trace_of_check_number_operator_product

## 対象

**対象ラベル**: `trace_of_check_number_operator_product`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_004_claim_trace_of_check_number_operator_product`（相異なる μ_1, …, μ_k ∈ M̌ と e_1, …, e_k ∈ {0,1} について
  tr(R_{μ_1}^{(e_1)} ⋯ R_{μ_k}^{(e_k)}) = 2^{M_col−k}。R_μ^{(1)} := ň_μ、R_μ^{(0)} := I − ň_μ）
- 範囲: 証明の全ての鎖（基底段階の 9 個の等号、帰納段階の準備 1・準備 2・準備 3、tr(Pň_{μ_k}) の鎖、準備 4、tr(Pň_{μ_k}) = 2_ℂ^{-1} tr(P) の鎖、二場合の鎖、最後の鎖）、
  帰納法の仮定 tr(P) = 2^{M_col−(k−1)}、鎖が引く二つの主張、主張そのもの。
- 記号: σ(μ) := M_col + 1 − μ、D_μ := ψ̌_μ^†、A_μ := ψ̌_{σ(μ)}、n_μ := D_μA_μ（`def_check_number_operator` の ň_μ）。

## 証明の行との対応

鎖の組み立ては `_chains.sage` の関数で、二つの検算が同じ関数を使う。各行は証明の括弧どおりに組み、隣の行と比べる。

| 証明の行 | `_chains.sage` の関数 | 等号の数（1 列あたり） |
|---|---|---|
| 基底段階の 9 行 tr(I) = Σ_{l=1}^{2_ℤ^{M_col}} 1_ℂ = Σ (1_ℝ)_ℂ = (Σ 1_ℝ)_ℂ = (ι(2_ℤ^{M_col})1_ℝ)_ℂ = (ι(2_ℤ^{M_col}))_ℂ = (2_ℝ^{M_col})_ℂ = ((2_ℝ)_ℂ)^{M_col} = 2^{M_col} = 2^{M_col−0}（ℂ は実数の対、ℤ・ℝ・ℂ の冪と ι と有限和は定義の再帰で作り、8 行目の後に組み込みの冪と比べる）と、前置きの 2_ℤ^{M_col} ∈ ℤ_{≥1}、tr(I) が実数の包含であること、否定の対照（ℝ の冪の底を 3 に取り違えると合わない） | `base_case` | 12（M_col ごとに 1 回） |
| 帰納法の仮定 tr(P) = 2^{M_col−(k−1)}（k = 1 では P := I） | `induction_step` の最初の行 | 1 |
| 準備 1（k = 1: ∏_{j=1}^{1} R = R_{μ_1} = I R_{μ_1} = P R_{μ_k}。k ≥ 2: ∏ = (∏_{j<k} R) R_{μ_k} = P R_{μ_k}） | `induction_step` | 3 または 2 |
| 準備 2 の単位行列との積の鎖 ψ̌I = ψ̌ = Iψ̌（ψ̌ := ψ̌_{σ(μ_k)}） | `induction_step` | 2 |
| 準備 2 の各 j < k の鎖（e_j = 1 と e_j = 0。`check_number_operators_commute` (1) の第 2 式・`commuting_with_difference`） | `induction_step` | 3 × (k − 1) |
| 準備 2 の ψ̌P = Pψ̌ の鎖（k = 1 と k ≥ 2。`matrix_commuting_with_each_factor_commutes_with_finite_product`） | `induction_step` | 3 |
| 準備 3 の 10 行（差の書き換え・分配・単位行列・符号の外出し・1 倍・−1 倍・`trace_basic_properties` (1)・ℂ の計算） | `induction_step` | 10 |
| tr(Pň_{μ_k}) の 8 行（`def_check_number_operator`・`mat_mult_associative`・巡回性・準備 2・`check_number_operator_idempotent` (2)・準備 3） | `induction_step` | 8 |
| 準備 4（2_ℂ = 1_ℂ + 1_ℂ の 4 行、2_ℂ^{-1}2_ℂ = 1_ℂ の 2 行。w = tr(Pň)、tr(P) のそれぞれで 2_ℂw = w + w・w = 2_ℂ^{-1}(2_ℂw)・w = 2_ℂ^{-1}w + 2_ℂ^{-1}w の各 3 行） | `induction_step` | 24 |
| tr(Pň) = 2_ℂ^{-1} tr(P) の 9 行 | `induction_step` | 9 |
| 二場合（e_k = 1 の 2 行、e_k = 0 の 8 行） | `induction_step` | 10 |
| 最後の 9 行 | `induction_step` | 9 |
| 否定の対照: 2_ℂ^{-1} を落とした tr(Pň) = tr(P) は成り立たない | `induction_step` | 1 |
| 鎖が引く主張 `check_number_operator_idempotent` (2) A_μD_μ = I − ň_μ と `check_number_operators_commute` (1) の第 2 式 A_μň_ν = ň_νA_μ（μ ≠ ν） | `assumption_lines` | M_col ごとに M_col^2 件 |
| 否定コントロール: 添字が重なる列（μ_1 = μ_2 = μ、e_1 = e_2 = 1）では準備 2 の可換性 ψ̌_{σ(μ)}ň_μ = ň_μψ̌_{σ(μ)} も tr(ň_μň_μ) = 2^{M_col−2} も外れる | `negative_controls` | M_col ごとに 2 × M_col 件 |

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_induction_chains_jordan_wigner_model.sage` | 上の全ての鎖を、鎖が使う仮定を満たす模型（Jordan–Wigner のフェルミ演算子 c_μ。D_μ := c_μ^T、A_μ := c_μ）で、M_col = 2, 3, 4 の相異なる添字の全ての列（k = 1..M_col）と全ての e について `QQ` の行列で確かめる | **PASS** | 鎖の等号 61506 段、帰納法の仮定 722 列、仮定の主張 29 件、否定コントロール 18 件 |
| `check_with_check_psi.sage` | 本文の ψ̌（`def_check_fermi` の式どおり）で、同じ関数で全ての鎖と、仮定の主張と、主張そのものを確かめる。ň_μ が O でも I でもないこと（等号が自明でないこと）も見る | **PASS** | 結合定数 3 組 × M_col = 2, 3 で 22938/22938 件（1 件が 1 個の等号か 1 つの主張か 1 つの否定コントロール） |

## 計算の帰属と範囲

- **厳密**: すべて。模型の検算は `QQ`、本物の ψ̌ の検算は数体 K := E_1 の中の等号と不等号。浮動小数点は使わない。
- **本物の ψ̌ を一つの体に置く方法**: ψ̌ は `def_check_number_operator` の検算の準備が作り、D_μ・A_μ は E_μ := F(r_μ)（r_μ := |γ_2(θ̃_μ)|、
  Ž・Y̌・位相の数体 F）の成分の行列である。主張は全ての μ の積を扱うので、全てを K := E_1 に移す。M_col = 2, 3 では、E_μ = F の μ（M_col = 3 の μ = 2）は
  F ⊂ K で移し、それ以外の μ ≠ 1 は μ = σ(1) で r_μ^2 = r_1^2（F の同じ元）かつ r_μ = r_1（AA で確かめる）なので R ↦ R で移す
  （Sage が E_{σ(1)} と E_1 を同じ体として持つ場合も、μ = σ(1) は必ずこの確かめを通す）。
  K は体で、K → QQbar の埋め込みで本物の値に移るので、K の中の不等号（否定コントロールと ň_μ ≠ O, I）も本物の値の不等号である。
- **模型と本物の ψ̌ の役割**: 模型の検算は「鎖が使う二つの仮定さえ満たせば鎖が通る」ことを、本文の ψ̌ より大きい M_col = 4 まで示す。
  本物の ψ̌ の検算は、本文の ψ̌ が仮定を満たし、同じ鎖と主張が本文の行列で通ることを示す。
- **ℝ への脱出**: r_μ = |γ_2(θ̃_μ)| と (√M_col)_ℂ（ℝ_{≥0} の平方根）。どちらも代数的数として厳密に持つ（`def_check_number_operator` の検算の準備と同じ）。
- **作り方で自明な比較**（両辺を同じ Sage の式から作るので、本文の写し間違いだけを検出する）:
  準備 1 の第 1 等号（k = 1 では左から掛ける積の 1 因子の場合がその因子そのもの、k ≥ 2 では同じ順序の同じ積）、
  準備 1 の k ≥ 2 の第 2 等号と、準備 2 の k ≥ 2 の第 1・第 3 等号（P を ∏_{j<k} R と置いたので同じ式）、準備 1 の k = 1 の第 3 等号と準備 2 の k = 1 の第 1・第 3 等号（P := I）、
  準備 2 の各 j の第 1・第 3 等号（R の定義の代入）、tr(Pň) の鎖の第 1 等号（ň := DA と置いた）、二場合の両方の第 1 等号、
  最後の鎖の第 1 等号の k ≥ 2（準備 1 の第 1 等号と同じ積。k = 1 は R と IR を比べるので自明でない）。
  帰納法の仮定の行は、P を直接計算して値を比べる（帰納法を回すのではない）。
- 範囲外: 本物の ψ̌ の検算の M_col ≥ 4。M_col = 4 では σ の対が (1,4) と (2,3) の二組になり、r_1 と r_2 の平方根を両方含む体が要るうえ、
  `check_number_operator_idempotent` の overview が記すとおり ψ̌ を作るだけで重い。M_col = 4 の鎖は模型の検算が受け持つ。模型の検算の M_col ≥ 5 も範囲外。
  鎖が使う仮定（本物の ψ̌ の反交換関係）そのものは、M_col = 2..5 で `anticommutator_of_check_psi` の検算の「主張」の行が厳密に確かめている。

- 2026-11-09: 帰納段階の「ℂ の四則」4 か所を準備 4 と体の公理 1 つずつの鎖に書き直したので、移項の 2 行・二場合・最後の鎖を新しい行に合わせ、準備 4 と否定の対照を足した（段数 33321 → 61479、本物の ψ̌ の件数 12354 → 22884）。
- 2026-11-09: 基底段階の「1_ℂ を 2^{M_col} 個足した和。ℂ の四則」を 9 行の鎖（実数の有限和・定数の有限和・ℤ の冪の包含・新しい主張 real_inclusion_preserves_power）に書き直したので、`base_case` を 9 行と前置き・否定の対照に合わせた（段数 61479 → 61506、本物の ψ̌ の件数 22884 → 22938）。

## 由来

2026-11-04 まで、この主張の検算は `050_claim_even_sector_eigenvalues/` の番号付きの検算にあった（そのディレクトリの対象ラベルは
`eigenvalues_of_V_plus` だけなので、この主張は未検算に数えられていた）。

| いまの名前 | 旧い名前 |
|---|---|
| `check_induction_chains_jordan_wigner_model.sage` と `_chains.sage` | `check_47_trace_of_check_number_operator_product_induction_chains.sage`（鎖の組み立てを `_chains.sage` の関数へ出した。鎖の各行の式は不変で、等号の段数 33321 は元と一致する。元は assert だけで数えていなかった帰納法の仮定と仮定の主張も数えるようにした） |
| `check_with_check_psi.sage` | 新しく足した |

ň のみの積のトレースを浮動小数点で確かめた `050_claim_even_sector_eigenvalues/check_01_number_operator.sage` は、他の主張と共有しているのでそこに残した。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh trace_of_check_number_operator_product
# 個別（本物の ψ̌ の検算は M_col を引数で絞れる）
cd sagemath/check/trace_of_check_number_operator_product && sage check_with_check_psi.sage 2 3
```
