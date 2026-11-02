# SageMath Check: epsilon_commutes_with_H1_plus

## 対象

**対象ラベル**: `epsilon_commutes_with_H1_plus`

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- ブロック: `projection_claim_epsilon_commutes_with_H1_plus`（ε は H_1^{(+)} と可換）
- 範囲: 証明の全ての鎖の行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 全ての a, b の ε(Y_aZ_b) = (Y_aZ_b)ε、和の可換性、主の 3 等号 | `check_chain.sage` | M_col = 2..5 | **PASS** | 成り立つ |

各行は、その行の括弧の形どおりに本文の定め方（`mat_mult` の成分の式の積、`def_matrix_sum`・`def_matrix_scalar_multiple`・`def_matrix_negation`・`def_matrix_difference` の成分の式、`def_finite_sum_of_matrices` の左からの和、`def_kronecker` の成分の式）で組み、隣の行と比べる。両辺を同じ式から作らないため、ε・σ_k^a・Z_m・Y_m は本文の経路と Sage の `tensor_product`・`*` の経路の二通りで作って一致を確かめてから使う（共通の準備 `sagemath/_shared/pauli_sites_exact.sage`）。対照（仮定を外すとどの行が崩れるか、可換でない行列では成り立たないこと）を置いた検算は、表の検査内容にそのことを書いた。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ`・`QQ(i)` かその上の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。
- 範囲外: 表に書いた大きさより大きい `M_col`・`n`・`r`。帰納法と極限の推論そのものは計算を含まないので、確かめるのはその中の各段の鎖の行である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_commutes_with_H1_plus
```

実行ログは `logs/` に保存する。
