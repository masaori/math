# SageMath Check: linearity_of_T_V2

## 対象

**対象ラベル**: `linearity_of_T_V2`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_006a_claim_linearity_of_T_V2`（V_2 による共役写像の ℂ 線型性）
- 範囲: 証明の一行（`linearity_of_T` の当てはめ）、当てはめた `linearity_of_T` の鎖の各行、前提 `V_2 ∈ R^×`・`Ž_μ, Y̌_μ ∈ R`、主張そのもの

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の `g := V_2 ∈ R^×`（`V2_invertible`） | `check_linearity_exact.sage` | K_2 := log x と選び、`V_2` を `def_transfer_matrix` の成分 `exp(K_2 n) = x^n` で QQ に作る（`_shared/row_configurations.sage` の `V2_by_components`）。g^{-1} は Sage の inverse で作る（逆元は一意なので `V2_invertible` の `(a^{-1})_C exp(-Y)` と同じ行列。その一致は `T_actions_on_check_Z_Y` の検算が確かめる）。g と g^{-1} が 2^M 次の正方行列で、本文の成分の式の積で `gg^{-1} = g^{-1}g = I`、g^{-1} が Sage の inverse と一致（V_2 では g^{-1} 自体を Sage の inverse で作るので、この一致は作り方から通る。中身があるのは成分の式の積で `gg^{-1} = g^{-1}g = I` を確かめる方である） | **PASS** | `M_col = 2, 3, 4`、`x = 2, 3` で厳密 |
| 準備の `X := Ž_μ ∈ R`、`W := Y̌_μ ∈ R` | 同上 | 本文の定め方で作った Ž_μ・Y̌_μ（`_shared/half_integer_check_operators.sage`）が 2^M 次の正方行列 | **PASS** | 同上、全 μ |
| 証明の一行 `T_g(aŽ_μ+bY̌_μ) = aT_g(Ž_μ)+bT_g(Y̌_μ)`（`linearity_of_T`） | 同上 | a, b を `L[a, b]`（L = QQ(ζ_{4M})）の不定元に置き、`def_T_g` の `(gh)g^{-1}` を本文の成分の式の積・スカラー倍・和で組んで両辺が多項式の行列として等しい。独立の経路として、Sage の `*`・`+`・inverse で組んだ両辺も一致し、成分の式の値に等しい。対照: a と b を入れ替えた右辺とは一致せず、`T_g(Ž_μ) ≠ Ž_μ`・`T_g(Y̌_μ) ≠ Y̌_μ` | **PASS** | 同上 |
| 当てはめた `linearity_of_T` の鎖の 6 つの等号（`def_T_g`、積の分配の二つ、スカラー倍を積の外へ出す二つ、`def_T_g`） | 同上 | 鎖の各行を `X := Ž_μ`・`W := Y̌_μ`・この g で成分の式から組み、隣り合う行が等しい | **PASS** | 同上 |

## 計算の帰属と範囲

- 全ての等号を `L[a, b]` の中で厳密に判定する（浮動小数点なし）。両辺の成分は a, b について L 係数の一次式なので、多項式としての一致は、L を ℂ へ埋め込んで a, b に任意の複素数を入れた一致を含む。
- ℝ への脱出は二つある。一つは Ž_μ・Y̌_μ の位相 `exp(-i(j_R θ̃_μ)_C)` を円分体の 1 の冪根 `ζ_{4M}^{-2(2μ-1)j}` で表すこと（Euler の公式を前提にした表し方。本文の exp との照合は `nesting_of_commutator_of_H_and_check_Z` の検算）。もう一つは K_2 = log x の選び方である（V_2 の成分を有理数にするため）。
- 範囲外: `M_col ≥ 5`、ほかの K の値。

## 確かめられない行と理由

- `V_2 ∈ R^×` は `V2_invertible` からの推論で、検算は選んだ標本で逆元が在ることを確かめるにとどまる。
- 鎖の第 1 の等号 `T_g(aŽ+bY̌) = (g(aŽ+bY̌))g^{-1}` と最終の等号（どちらも `def_T_g` の当てはめ）は、両側を同じ式 `(gh)g^{-1}` から作るので、一致は作り方から通る。比べる行として中身があるのは第 2〜5 の等号である。
- 主張の全ての M_col・K への一般化は確かめられない。範囲は表の「結果」のとおり。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh linearity_of_T_V2
```

引数で `M_col` を絞れる（`sage check_linearity_exact.sage 2`）。実行ログは `logs/` に保存する。
