# 固定剰余類格子の Fisher 分解体次数の階乗整除性

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial`）
- 範囲: 分解体の Galois 群による四十四根の忠実な置換、Lagrange の定理による拡大次数の階乗整除性
- 依存: `theorem_fixed_quotient_fisher_splitting_field_finite_degree`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_root_permutation_group.sage` | 次数四十四の既約因子が相異なる四十四根をもち、その根集合の全置換群の位数が `44!` であること | PASS | `QQ[x]`、`QQbar`、`NN` による厳密照合 |
| `check_factorial_divisor_set.sage` | `44!` の素因数指数データから元の階乗と正の約数候補数を復元すること | PASS | `ZZ` と `NN` による厳密照合 |

## 備考

- 分解体が有限 Galois 拡大であること、根集合への作用の単射性、Lagrange の定理、有限 Galois 拡大の次数公式は構造化本文で証明する。
- SageMath は固定多項式の分離性、相異なる根の個数、全置換群の位数、および整除候補集合を厳密検算する。
- 初回は `44!` の全ての正の約数を列挙しようとして停滞したため ERROR とし、失敗を消さずここに記録する。全約数を実体化せず、各素数の Legendre 指数から `44!` と約数候補数を復元する有限計算へ修正した。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-divides-factorial/check_*.sage; do sage "$file"; done
```
