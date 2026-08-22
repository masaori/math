# 固定剰余類格子の Fisher 分解体次数の既約因子次数による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`）
- 範囲: 次数四十四の既約因子の一根が生成する部分体と、階乗整除性を合わせた分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_finite_degree`、`theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_irreducible_root_degree.sage` | 次数四十四の既約因子の一根が `QQ` 上次数四十四であること | PASS | `QQ[x]`、`QQbar`、`NN` による厳密照合 |
| `check_factorial_cancellation.sage` | `44! = 44 * 43!` と素因数指数ごとの四十四の消去 | PASS | `ZZ` と `NN` による厳密照合 |

## 備考

- 体の塔の次数公式と整除関係の正整数での消去は構造化本文で証明する。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-irreducible-factor-multiple/check_*.sage; do sage "$file"; done
```
