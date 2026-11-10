# SageMath Check: anticommutator_of_check_Z_Y

## 対象

**対象ラベル**: `anticommutator_of_check_Z_Y`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `evensector_005_claim_anticommutator_check_Z_Y`（Ž・Y̌ の反交換関係）
- 範囲: 準備 1 と 2 等号の鎖、準備 2 の実数の鎖（20 等号）と複素数の鎖（5 等号）、第 1 式（16 等号）、第 2 式（6 等号）、第 3 式（16 等号）、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 1（`j, k ∈ {1..N}` で δ^{(M)}_{(j,k)} の対角）と `(e e)δ = (e e)0_C = 0_C`、主鎖の def_delta_M の行 `δ^{(M)}_{(κ,0)} = δ^{(M)}_{(μ+ν,1)}` と def_check_index_set (5) の行 | `check_index_and_delta.sage` | M = 2..12、全ての j, k、μ, ν ∈ M̌ で、δ^{(M)} を合同式の場合分け、δ_{ν,M+1-μ} を等号の場合分けで別々に組んで比べる（整数と `QQ` 上の多項式環）。対照: M̌ の外の添字では二つのデルタが食い違う | **PASS** | 成り立つ |
| 準備 2 の実数の鎖 `j_Rθ̃_μ + j_Rθ̃_ν = … = -(2πj_Rκ_R/(M)_R)` と複素数の鎖 `(-i)(j_Rθ̃_μ)_C + (-i)(j_Rθ̃_ν)_C = … = i(y_j)_C` | `check_exponent_chains.sage` | π・μ・ν・M・j を不定元にした `QQ` 上の有理関数体で実数の行を、ℂ を本文どおり実数の対にして複素数の行を組み、隣と比べる。対照: 整数運動量の角度では実数の鎖の右辺と一致しない、符号を落とした (-i)(y_j)_C は i(y_j)_C と違う | **PASS** | 成り立つ |
| 第 1 式・第 3 式の 16 等号（定義、`anticommutator_of_finite_sums_of_scalar_multiples`、`anticommutator_of_Z_and_Y`、`scalar_multiple_is_associative`、`finite_sum_of_scalar_multiples_of_one_matrix` 二回、`finite_sum_with_single_nonzero_term`、準備 1、1_C、`scalar_exp_product`、準備 2、`exp_sum`、`def_delta_M`、`def_check_index_set` (5)、`scalar_multiple_is_associative`、積の結合・交換）と第 2 式の 6 等号 | `check_three_chains.sage` | M = 2..5、全ての μ, ν ∈ M̌ で、Z_j・Y_j をクロネッカー積と積の成分の式で組み、位相を円分体 `QQ(ζ_{4M})` の 1 の冪根に持って、各行の行列を本文の成分の式で組んで隣と厳密に比べる。`anticommutator_of_Z_and_Y` の右辺を δ(2_C I)・O と読めることも確かめる。主張を Sage の行列演算とも比べる。対照: 整数運動量の位相では対 ν = M+1-μ で第 1 式の右辺が崩れる | **PASS** | 成り立つ |
| 位相の 1 の冪根による表し方、`scalar_exp_product` の行、準備 2 の行、`exp_sum` の行、第 1 式の係数 | `check_exp_balls.sage` | M = 2..8、全ての μ, ν、j で、本文の exp の部分和に尾の上界を半径として足したボール（512 bit）が、1 の冪根の値と重なり、積と和の exp が重なり、和が (M)δ を含むことを見る。対照: 整数運動量では和が M にならない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 準備 1 とデルタの行（整数）、準備 2（有理関数体と実数の対）、三つの主鎖（円分体の行列）。
- **ℝ への脱出**: `check_exp_balls.sage` の本文の exp のボールと π（`RB.pi()`）。重なりは等号の必要条件であって証明ではない。`check_three_chains.sage` の第 10・11 行は、exp の値を指数の有理数から 1 の冪根で作り直したもので、1 の冪根の表し方（Euler の公式を前提にする）と `scalar_exp_product`・`exp_sum` の中身はこのボールが担う。
- **作り方で自明な比較**: 定義を当てはめる行（第 1 等号の定義、準備 2 の `-i := (-1_C)i` の行）と、1_C を掛ける行は、両辺を同じ定義の式から作るので比較は値が通ることを見るだけである。準備 2 の実数の鎖の κ_R を置く行（`-(-(μ_R+ν_R-1_R)) = -κ_R`）は κ_R を同じ式で作るので中身を持たず、結合律・交換律だけで並べ替える行も、有理関数体が同じ元にするので中身を持たない（複素数の鎖の 5 等号のうち 2 等号は主張 `negative_i_times_complex_is_negation_of_i_times`・`negation_of_i_times_negated_real_is_i_times` の当てはめで、各主張の検算はそれぞれの対象ラベルのフォルダにある）。
- 範囲外: 主鎖で M_col ≥ 6（2^M 次の行列の成分の式の計算量のため）、ボールで M_col ≥ 9。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh anticommutator_of_check_Z_Y
```

実行ログは `logs/` に保存する。
