# 固定剰余類格子の Fisher 分解体次数の有限体分解型による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint`）
- 範囲: 次数四十四の既約因子の `107` 進非分岐分解型と、それが強制する分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`、`theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| 構造化本文ディレクトリからのリポジトリ相対 glob による再実行 | `countable-ising-on-hyperbolic-surfaces/.../check_*.sage` の解決 | ERROR | 実行場所がリポジトリ直下でなかったため glob が展開されず、SageMath 起動前に入力ファイル不在で停止。検算内容は実行されていない |
| `check_modular_factorization_cycle_order.sage` | `Q_Q` の先頭係数と判別式が `107` で非零であり、`GF(107)[x]` 上の既約因子次数が `1,2,5,13,23`、その最小公倍数が `2990` であること | PASS | `ZZ[x]`、`GF(107)[x]`、`NN` による厳密照合 |
| `check_degree_divisor_cancellation.sage` | `2990 | 44d` と互いに素な因子の消去から `1495 | d` を得て、次数を `65780e` に書き換える有限整数計算 | PASS | `ZZ` と `NN` による厳密照合 |

## 備考

- Dedekind の有限体分解型定理、有限置換の巡回分解による位数公式、Lagrange の定理、Euclid の補題は構造化本文で適用する。
- ERROR 後はリポジトリ直下へ戻し、同じ二ファイルを再実行して PASS を確認した。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-modular-cycle-constraint/check_*.sage; do sage "$file"; done
```
