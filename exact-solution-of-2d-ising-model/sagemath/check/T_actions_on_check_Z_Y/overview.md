# SageMath Check: T_actions_on_check_Z_Y

## 対象

**対象ラベル**: `T_actions_on_check_Z_Y`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_005_claim_T_actions`（T_{(V_1^{(+)})^{1/2}}・T_{V_2} の Ž・Y̌ への作用）
- 範囲: 証明の準備の二つの鎖（X = G_1、Y = G_2）、四本の鎖（T_S(Ž)・T_S(Y̌)・T_{V_2}(Ž)・T_{V_2}(Y̌)）の全ての行、主張そのもの

## 証明の行との対応

`S := (V_1^{(+)})^{1/2}`、`X`・`G_1`・`G_2` は証明の記号、`a`・`Y` は `V2_invertible` の主張の記号。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `X = ((i/2)(K_1)_C)H_1^(+) = (i/2)((K_1)_C H_1^(+)) = G_1`、`Y = (i(K_2^*)_C)H_2 = i((K_2^*)_C H_2) = G_2` | `check_preparation_and_scalar_lines.sage` | `(K_1)_C`・`(K_2^*)_C` を `QQ(i)` 上の不定元に置き、本文の H_1^(+)・H_2 と成分が不定元の行列 H でスカラー倍の成分の式から作って一致。対照: `(K_1)_C` を落とすと一致しない | **PASS** | `M_col = 2..4`、`d = 2, 4` で厳密 |
| T_S の鎖の第 1〜5 行（`def_T_g`、`def_V1_plus_square_root`、X の置き方、`matrix_exp_conjugation` (3)、準備の X = G_1） | `check_chains_exact.sage` | `K_1 = 2 log y` で `exp(±X)` を固有値の射影に `y^{±λ}` を掛けて厳密に作り、各行を本文の積の成分の式で組んで隣り合う行が等しい。中身のある比較は第 3 行と第 4 行の `exp(X)^{-1}`（Sage の inverse）`= exp(-X)` だけで、ほかの隣り合う行は同じ行列から作るので作り方から通る（下の「確かめられない行と理由」） | **PASS** | `M_col = 2, 3, 4`、全 μ、`(x, y) = (2, 2), (3, 3/2)` で厳密等号 |
| T_{V_2} の鎖の第 1〜5 行（`def_T_g`、`V2_invertible` の逆元、`V2_exponential_representation`、a・Y の読み替え） | 同上 | `K_2 = log x` で V_2 を成分 `x^n` で、`exp(±Y)` を射影に `(√t)^{∓λ}` を掛けて、`a = (√(2s_2))^{M_col}` を数体 F に作る。V_2（成分）`= a exp(Y)`、`V_2^{-1}`（Sage の inverse）`= (a^{-1}) exp(-Y)`、各行が等しい。対照: `exp(-Y)` だけでは V_2 の逆元でない | **PASS** | 同上 |
| T_{V_2} の鎖の係数を左・右の因子から出す 3 行、係数をまとめる行、`1_C` を外す行 | `check_preparation_and_scalar_lines.sage`・`check_chains_exact.sage` | exp(Y)・W・exp(-Y) を成分が独立な不定元の行列、`a_C`・`(a^{-1})_C` を不定元 p・q に置いて隣り合う行が多項式として等しい。`pq = 1` を課さないと崩れ、`q = p^{-1}` で `1((EW)F) = (EW)F`。F の中の具体値でも各行が等しい | **PASS** | `d = 2, 4` で厳密、具体値は上と同じ範囲 |
| 包含の三行 `a_C(a^{-1})_C = (aa^{-1})_C = (1)_C = 1_C` | `check_preparation_and_scalar_lines.sage` | ℂ を実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、a を `QQ(a)` の元に置いて対の積と包含で作る。対照: `a_C a_C ≠ 1_C` | **PASS** | 厳密 |
| 四本の鎖の `(exp(G)W)exp(-G) = Σ_{n≥0} (1/n!) ad^n_G(W)`（`exp_X_Y_exp_-X` の当てはめ）と、係数を `(1/n!)_C` と書き直す行 | `check_series_lines_by_partial_sums.sage` | `G_1 = (log y)(iH_1^(+))`、`G_2 = K_2^*(iH_2)` と書き換え、`ad^n_{ℓ·iH}(W) = ℓ^n ad^n_{iH}(W)` を使って（この書き換えと斉次性は準備の検算が W = Ž_μ・Y̌_μ と不定元 ℓ で n = 0..4 に確かめる。全ての n への一般化は確かめていない）、`ad^n_{iH}(W)` を F で厳密に作って部分和 S_90 を 512 bit の複素数のボールで足し、左辺の厳密な値との差のノルムが 10^{-40} 未満、N = 10 から 30 で差が減る。対照: 共役の向きを逆にした `(exp(-G)W)exp(G)` とは 10^{-3} 以上離れる | **PASS** | `M_col = 2, 3, 4`、全 μ、`(x, y) = (2, 2), (3, 3/2)` |
| 四本の鎖の `extract_taylor_coefficient_of_check_Z_Y` の行と主張の右辺 | `check_chains_exact.sage` | `(exp(G)W)exp(-G)` の厳密な値が、`cosh K_1 = (y^2+y^{-2})/2`・`sinh K_1 = (y^2-y^{-2})/2`・`cosh 2K_2^* = (t^{-1}+t)/2`・`sinh 2K_2^* = (t^{-1}-t)/2` と位相 `ζ_{4M}^{∓2(2μ-1)}` で組んだ主張の右辺に等しい。独立の経路として、Sage の積と inverse で作った `gWg^{-1}` も右辺に等しい。対照: sinh の側の係数の符号を逆にした式とは一致しない | **PASS** | `M_col = 2, 3, 4`、全 μ、2 組の (x, y) で厳密等号 |
| 四本の鎖の最終行（`def_pair_of_matrices_times_column_of_numbers`） | `check_chains_exact.sage`・`check_preparation_and_scalar_lines.sage` | `(Ž, Y̌)(a; b)` を定義の成分の式で作って前の行に等しい。定義の式は Sage の `aA + bB` とも一致し、係数を入れ替えると異なる | **PASS** | 同上、`d = 2, 4` |

## 計算の帰属と範囲

- 共通の準備は `_prelude.sage`（`_shared/half_integer_check_operators.sage`・`_shared/transfer_matrix_factor_inverses.sage` を使う）。`K_1 = 2 log y`、`K_2 = log x`（`x, y ∈ QQ`、`x, y > 1`）と選ぶと、`exp(±X)`・V_2・cosh・sinh が `QQ` に、`a`・`exp(±Y)` が `QQ(√(2s_2), √t)` に、位相が円分体に入るので、それらを一つの数体 `F = QQ(ζ_{4M}, √(2s_2), √t)` に置いて全ての等号を厳密に判定する。ℝ への脱出は K_1・K_2 の選び方と、位相を 1 の冪根で表すこと（本文の exp との照合は `nesting_of_commutator_of_H_and_check_Z` の検算）だけである。
- 級数の行だけは無限和なので ℝ へ脱出する。部分和の係数 `ℓ^n/n!` の `ℓ = log y`・`-(1/2) log t` は標本の選び方から来る実対数で、Arb の log のボール（512 bit）で持つ。F の元は、ζ ↦ exp(2πi/(4M))・平方根 ↦ 正の平方根 の埋め込みで複素数のボールへ移す。閾値 10^{-40} は、観測した差の上端（全ての場合で 4.8e-127 以下。ログ）より十分大きく、対照の差（10^{-3} 以上）より十分小さい値として置いた。
- 範囲外: `M_col ≥ 5`、log の形でない K_1・K_2。

## 確かめられない行と理由

- 係数 `1/n!` を `inclusion_rr_to_cc` の像 `(1/n!)_C` と書き直す行は記法の行で、部分和では同じ有理数を掛けるので一致は作り方から通る。
- T_S の鎖の第 1→2 行（`def_V1_plus_square_root` の代入）と第 2→3 行（X の置き方）は、検算では S を exp(X) そのものとして作るので、一致は作り方から必ず通る。
- `V2_exponential_representation` の係数と K を包含の像に読み替える行（X の置き方、a・Y の読み替え）、`(1)_C = 1_C` の行、`準備の X = G_1`・`Y = G_2` を代入する行は記法の行で、具体値では同じ行列なので一致は作り方から必ず通る。読み替えの中身（スカラー倍の結合律）は準備の検算が不定元で確かめる。
- `def_T_g` の当てはめで S・V_2 が可逆であること（`V1_plus_half_invertible`・`V2_invertible`）は推論で、検算は逆元の値（Sage の inverse と一致すること）を確かめるにとどまる。
- 級数の極限そのものと、主張の全ての μ・M_col・K_1・K_2^* への一般化は確かめられない。範囲は表の「結果」のとおり。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh T_actions_on_check_Z_Y
```

各ファイルは引数で `M_col` を絞れる。実行ログは `logs/` に保存する。
