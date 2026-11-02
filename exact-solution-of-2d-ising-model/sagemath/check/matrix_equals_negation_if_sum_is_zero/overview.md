# SageMath Check: matrix_equals_negation_if_sum_is_zero

## 対象

**対象ラベル**: `matrix_equals_negation_if_sum_is_zero`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_equals_negation_if_sum_is_zero`（和が零行列なら一方は他方の符号反転）
- 範囲: 証明の全ての鎖の行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の 3 等号と結論 | `check_chain.sage` | 第 1・2 等号は任意の不定元の X, Y で、第 3 等号と結論は Y := -X のときだけ成り立つ | **PASS** | 成り立つ |

各行は、その行の括弧の形どおりに本文の定め方（`mat_mult` の成分の式の積、`def_matrix_sum`・`def_matrix_scalar_multiple`・`def_matrix_negation`・`def_matrix_difference` の成分の式、`def_finite_sum_of_matrices` の左からの和、`def_kronecker` の成分の式）で組み、隣の行と比べる。両辺を同じ式から作らないため、ε・σ_k^a・Z_m・Y_m は本文の経路と Sage の `tensor_product`・`*` の経路の二通りで作って一致を確かめてから使う（共通の準備 `sagemath/_shared/pauli_sites_exact.sage`）。対照（仮定を外すとどの行が崩れるか、可換でない行列では成り立たないこと）を置いた検算は、表の検査内容にそのことを書いた。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ`・`QQ(i)` かその上の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。
- 範囲外: 表に書いた大きさより大きい `M_col`・`n`・`r`。帰納法と極限の推論そのものは計算を含まないので、確かめるのはその中の各段の鎖の行である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_equals_negation_if_sum_is_zero
```

実行ログは `logs/` に保存する。
