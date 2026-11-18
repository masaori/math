# SageMath Check: 140_frobenius_inner_product_axioms

## 対象

**対象ラベル**: `frobenius_inner_product_axioms` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`

- 範囲: (0) 成分表示、(1) 共役対称性、(2) 第2変数線型・第1変数共役線型、(3) 正定値性、Cauchy–Schwarz、三角不等式

⟨A,B⟩ = tr(A*B) をトレースで計算した側と、成分の和で計算した側の 2 経路。Cauchy–Schwarz の等号（B = cA）も踏む。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_axioms.sage` | (0)〜(3)、Cauchy–Schwarz、三角不等式、等号条件 | 728 | 1.008e-15 | **PASS** |
| 02 | `check_02_linearity_chains.sage` | (2) の 4 本の鎖（`⟨A,B+C⟩`・`⟨A,λB⟩`・`⟨A+B,C⟩`・`⟨λA,B⟩`）を 1 行ずつ。(0) の段と、`def_matrix_sum`・`def_matrix_scalar_multiple` の段を別の行として確かめ、定義の成分の式が Sage の和・スカラー倍と一致することも確かめる。否定コントロール: 第 1 変数で共役を落とした等式は偽。`n = 1, 2, 3`、`QQ[i]` の厳密計算 | 252 | 厳密 | **PASS** |
| 03 | `check_03_cauchy_schwarz_case2_chain.sage` | Step 5 場合 2（`‖B‖ > 0`）を 1 行ずつ。前置きの `β_ℂ ∈ ℂ^×`・`(β^{-1})_ℂ = (β_ℂ)^{-1}`（`real_inclusion_preserves_inverse`）・`t = ū(β_ℂ)^{-1}`（`def_complex_quotient`）、準備 `t̄ = u(β_ℂ)^{-1}`（5 等号）・`(ūu)(β_ℂ)^{-1} = q_ℂ`（6 等号）、三つの積の項 `t⟨A,B⟩`（6 等号）・`t̄⟨B,A⟩`（8 等号）・`t̄t⟨B,B⟩`（13 等号）、展開式と合わせる鎖（12 等号）。逆元は `definition_of_cc` の積の式から `β_ℂ w = 1_ℂ` を解いて作る。否定コントロール: `t` を `u(β_ℂ)^{-1}` にすると `t⟨A,B⟩ ≠ q_ℂ`。`n = 1, 2, 3`、`QQ[i]` の厳密計算 | 648 | 厳密 | **PASS** |
| 04 | `check_04_positive_definiteness_chain.sage` | Step 4（(3) の `⟨A,A⟩ = (‖A‖²)_ℂ`）の 6 等号の鎖を 1 行ずつ。(0)、Step 0 の `z̄z = (|z|²)_ℂ`、`real_inclusion_preserves_finite_sum` を各 `i` の内側の和へ当てた段と外側の和へ当てた段、`definition_of_sqrt_r_positive` の `y² = x` の段、`def_matrix_norm` の段を別の行として確かめる。`‖A‖` は `|a_ij|` を `QQbar` の絶対値（`x² + y²` とは別の経路）で取り、代数的実数体 `AA` の平方根で作って `y ≥ 0`・`y² = x` も確かめる。`ι_{ℝ→ℂ}(r) = (r, 0)` も各回確かめる。否定コントロール: 共役を落とした `Σ a_ij a_ij` は `(‖A‖²)_ℂ` と異なる。`n = 1, 2, 3`、`QQ[i]`・`QQ`・`AA` の厳密計算 | 108 | 厳密 | **PASS** |
| – | `check_inner_product_zero_iff_zero_matrix_chain.sage` | Step 4 の後の同値の鎖 `⟨A,A⟩ = 0_ℂ ⟺ (‖A‖²)_ℂ = 0_ℂ ⟺ (‖A‖²)_ℂ = (0)_ℂ ⟺ ‖A‖² = 0 ⟺ ‖A‖‖A‖ = 0 ⟺ ‖A‖ = 0 ⟺ A = O` を 1 段ずつ（各段の両辺の真偽の一致）。段ごとの根拠 `0_ℂ = ι_{ℝ→ℂ}(0) = (0)_ℂ`（`inclusion_rr_to_cc` の略記、`r → 0`。値 `(0,0)` も確かめる）、`inclusion_rr_to_cc_is_injective`、`square_of_real_number_is_product`、`real_product_of_nonzero_is_nonzero`、`real_times_zero_is_zero`、`matrix_norm_triangle_inequality` (1) もその段の値で確かめる。標本は `A = O`・乱数の行列・成分が 1 つだけ 0 でない行列で、真偽の両方を踏む。否定コントロール 2 件: 共役を落とした `Σ a_ij a_ij = 0` は `B = [[1, i], [0, 0]]` で成り立つが `B ≠ O`。もう 1 件は、鎖の `‖A‖‖A‖ = 0 ⟺ ‖A‖ = 0` の段と同じ判定を零因子のある `ℤ/4ℤ` の `2` に当てると偽になること（`2·2 = 0`・`2 ≠ 0`）。`n = 1, 2, 3`、`QQ[i]`・`AA` の厳密計算 | 138 | 厳密 | **PASS** |
| – | `check_cauchy_schwarz_case1_zero_inner_product_chain.sage` | Step 5 場合 1（`‖B‖ = 0` で `B = O`）の `u` の鎖 `u = Σ_{i=1}^{n}Σ_{j=1}^{n} ā_ij b_ij = Σ_{i=1}^{n}Σ_{j=1}^{n} ā_ij·0_ℂ = Σ_{i=1}^{n}Σ_{j=1}^{n} 0_ℂ = Σ_{i=1}^{n} 0_ℂ = 0_ℂ` を 1 行ずつ（5 等号）。和は `def_finite_sum_of_complex_numbers` のとおり添字の順に左から足す。行ごとの根拠（`B = O` の各成分が `0_ℂ`、`complex_times_zero_is_zero`（`z → ā_ij`）を各項へ、`finite_sum_of_complex_zeros`（`m → n`）を各 `i` の内側の和へ、外側の和へ）もその行の値で確かめる。鎖の判定は `n = 1, 2, 3, 4`（1 行目は `B = O` では両辺が `0_ℂ` になるので、乱数の `B` でも 20 件確かめる）。否定コントロール 6 件（`n = 1, 2, 3`、(n,1) 成分だけが 1 の `B`）: `B = O` を使って各成分を `0_ℂ` に替える段の両辺が異なる（`B = O` を使うのはこの段だけなので、鎖の結論 `u = 0_ℂ` が `B = O` を要ることを表す）、`complex_times_zero_is_zero` の主張の形（右の因子が `0_ℂ`）から外れると結論が偽（`ā_{n1}·b_{n1} ≠ 0_ℂ`）。`QQ[i]` の厳密計算 | 200 | 厳密 | **PASS** |

check_02・check_03・check_04・check_inner_product_zero_iff_zero_matrix_chain・check_cauchy_schwarz_case1_zero_inner_product_chain は浮動小数点を使わない（ガウス有理数体 `QQ[i]` の厳密計算。check_04 の平方根は代数的実数体 `AA`）。check_01 の許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<def_frobenius_inner_product> の内容もこの check に含まれる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 140
```

実行ログは `sagemath/check/140_frobenius_inner_product_axioms/logs/` に保存してある（この表の数値はそのログから取った）。
