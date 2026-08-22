# 固定剰余類格子の Fisher 分解体次数の二つの有限体分解型による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_two_modular_cycle_constraints`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_two_modular_cycle_constraints`）
- 範囲: 次数四十四の既約因子の `101` 進非分岐分解型と、既存の `107` 進分解型を併用した分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| 構造化本文ディレクトリからのリポジトリ相対 glob による実行 | `countable-ising-on-hyperbolic-surfaces/.../check_*.sage` の解決 | ERROR | 実行場所がリポジトリ直下でなかったため glob が展開されず、SageMath 起動前に入力ファイル不在で停止。検算内容は実行されていない |
| `check_combined_degree_divisor_cancellation.sage` 初版 | `43!/596505` の全正約数列挙 | ERROR | 主張に不要な全列挙が停滞したため終了。素因数指数と整除等式の直接照合へ修正した |
| `check_modular_factorization_cycle_order.sage` | `Q_Q` の先頭係数と判別式が `101` で非零であり、`GF(101)[x]` 上の既約因子次数が `4,19,21`、その最小公倍数が `1596` であること | PASS | `ZZ[x]`、`GF(101)[x]`、`NN` による厳密照合 |
| `check_combined_degree_divisor_cancellation.sage` | 位数 `1596` と `2990` の制約から `596505 | d` を得て、次数を `26246220f` に書き換える有限整数計算 | PASS | `ZZ` と `NN` による厳密照合 |

## 備考

- Dedekind の有限体分解型定理、有限置換の巡回分解による位数公式、Lagrange の定理、最小公倍数の性質、Euclid の補題は構造化本文で適用する。
- 二つの ERROR 後はリポジトリ直下から、全約数列挙を行わない同じ二検算を再実行して PASS を確認した。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-two-modular-cycle-constraints/check_*.sage; do sage "$file"; done
```
