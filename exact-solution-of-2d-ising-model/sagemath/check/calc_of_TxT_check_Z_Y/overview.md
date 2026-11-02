# SageMath Check: calc_of_TxT_check_Z_Y

## 対象

**対象ラベル**: `calc_of_TxT_check_Z_Y`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_008_claim_product_action`（T_{(V_1^{(+)})^{1/2}}・T_{V_2} の (Ž, Y̌) への直積作用）
- 範囲: 証明の二本の鎖（V_1 の側・V_2 の側）の全ての行と主張そのもの、鎖の第 2 行 → 第 3 行が使う定義 `def_pair_of_matrices_times_two_by_two_matrix`

## 証明の行との対応

`S := (V_1^{(+)})^{1/2}`。各鎖は 4 行（始点、`T_actions_on_check_Z_Y` の当てはめ、`def_pair_of_matrices_times_two_by_two_matrix`、`def_B1_theta_B2`）。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 両鎖の第 1 行 → 第 2 行（`T_actions_on_check_Z_Y` の T_S(Ž_μ)・T_S(Y̌_μ) の式、T_{V_2}(Ž_μ)・T_{V_2}(Y̌_μ) の式を 2 成分へ同時適用） | `check_chains_exact.sage` | 始点 `(T_g(Ž_μ), T_g(Y̌_μ))` を `T_actions_on_check_Z_Y` の主張を使わずに `def_T_g` の `(gW)g^{-1}`（本文の積の成分の式、g^{-1} は Sage の inverse）で作り、第 2 行の組 `((Ž, Y̌)(列), (Ž, Y̌)(列))` を `def_pair_of_matrices_times_column_of_numbers` の成分の式で作って等しい | **PASS** | `M_col = 2, 3, 4`、全 μ、`(x, y) = (2, 2), (3, 3/2)` で厳密等号 |
| 両鎖の第 2 行 → 第 3 行（`def_pair_of_matrices_times_two_by_two_matrix`） | `check_chains_exact.sage`・`check_definition_of_pair_times_matrix.sage` | 証明に書かれた 2×2 行列を成分どおりに組み、定義の「列ごとに (A, B)(列) を並べた組」で積を作って第 2 行に等しい。定義そのものは、鎖と同じ関数で、成分が独立な不定元の A, B と不定元 p, q, r, s について、二つの定義を続けて展開した値が Sage で作った `(pA + rB, qA + sB)`（下流が引く形）に等しく、行で読んだ組 `(pA + qB, rA + sB)` とは異なる | **PASS** | 上と同じ範囲で厳密。定義は `d = 1, 2, 4` で多項式として厳密 |
| 両鎖の第 3 行 → 第 4 行（`def_B1_theta_B2`） | `check_chains_exact.sage` | 証明の第 3 行の 2×2 行列が、`def_B1_theta_B2` の成分の式に θ := θ̃_μ（`exp(±i(θ̃)_C)` は位相）を入れた B_1(θ̃)、および B_2 と行列として等しく、積も等しい | **PASS** | 上と同じ範囲で厳密 |
| 主張 | `check_chains_exact.sage` | 左辺を Sage の積と inverse の `gWg^{-1}` で、右辺を Sage のスカラー倍と和の `(B_11 Ž + B_21 Y̌, B_12 Ž + B_22 Y̌)` で作り、鎖の終点とも等しい。対照: 非対角成分の符号を逆にした B_1、B_1 の転置（B_1(θ̃) が対称でないとき）、B_1(-θ̃)（exp(iθ̃) ≠ exp(-iθ̃) のとき）、B_2 の転置では一致しない | **PASS** | 上と同じ範囲で厳密。対照が意味を持たない場合（M_col = 2 では B_1(θ̃) が対称、M_col = 3・μ = 2 では θ̃ = π）はログに SKIP と書いた |

## 計算の帰属と範囲

- 共通の準備は `_prelude.sage` と `_shared/transfer_factor_actions_on_check_Z_Y.sage`（`T_actions_on_check_Z_Y` の検算と共有）。
  `K_1 = 2 log y`、`K_2 = log x`（`x, y ∈ QQ`、`x, y > 1`）と選ぶと、S = exp(X)（`def_V1_plus_square_root`）・V_2・cosh・sinh・位相が一つの数体
  `F = QQ(ζ_{4M}, √(2s_2), √t)` に入るので、全ての等号を厳密に判定する（浮動小数点なし）。
- ℝ への脱出は K_1・K_2 の選び方と、位相 `exp(∓i(θ̃_μ)_C)` を 1 の冪根で表すこと（本文の exp との照合は
  `nesting_of_commutator_of_H_and_check_Z` の検算）だけである。
- 範囲外: `M_col ≥ 5`、log の形でない K_1・K_2。

## 確かめられない行と理由

- 両鎖の第 2 行 → 第 3 行と第 3 行 → 第 4 行は定義の展開で、検算は第 2 行の係数・第 3 行の 2×2 行列・定義の成分を同じ式で組むので、一致は作り方から通る。確かめているのは成分の配置（列の向き、どの成分がどこに入るか）の写しだけである。値として独立に確かめているのは、第 1 行 → 第 2 行（始点を共役で作る）と主張の行（Sage の積・inverse・スカラー倍と和で作る）である。

- 鎖の第 1 行 → 第 2 行は `T_actions_on_check_Z_Y` の主張の当てはめで、検算は具体値で両辺の一致を見るにとどまる。その主張の証明そのものは `T_actions_on_check_Z_Y` の検算が確かめる。
- 主張の全ての μ・M_col・K_1・K_2^* への一般化は確かめられない。範囲は表の「結果」のとおり。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh calc_of_TxT_check_Z_Y
```

`check_chains_exact.sage` は引数で `M_col` を絞れる。実行ログは `logs/` に保存する。
