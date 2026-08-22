# 固定剰余類格子の Fisher 分解体次数の素数百六十七における有限体分解型による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_167_modular_cycle_constraint`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_167_modular_cycle_constraint`）
- 範囲: 次数四十四の既約因子の `167` 進非分岐分解型と、既存の `101`・`103`・`107`・`131`・`149`・`163` 進分解型を併用した分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_163_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_modular_factorization_cycle_order.sage` | `Q_Q` の先頭係数と判別式が `167` で非零であり、`GF(167)[x]` 上の既約因子次数が `1,2,4,4,6,8,19`、その最小公倍数が `456` であること | PASS | `ZZ[x]`、`GF(167)[x]`、`NN` による厳密照合 |
| `check_combined_degree_divisor_cancellation.sage` | 位数 `456` と既存の次数因子 `1574522667900` から `787261333950 | d` を得て、次数を `34639498693800k` に書き換える有限整数計算 | PASS | `ZZ` と `NN` による厳密照合 |

## 備考

- Dedekind の有限体分解型定理、有限置換の巡回分解による位数公式、Lagrange の定理、最小公倍数の性質、Euclid の補題は構造化本文で適用する。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-167-modular-cycle-constraint/check_*.sage; do sage "$file"; done
```
