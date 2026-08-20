# 二段 Fisher 零点形式的因子の消滅条件の検算

**対象ラベル**: `theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_vanishing_criterion`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_two_stage_fisher_zero_formal_divisor_vanishing_criterion`）
- 範囲: 二段零点形式的因子が零であることと、二つの分配多項式が非零定数倍だけ異なることの同値性

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_formal_divisor_coefficients.sage` | 形式的因子の零性、整数差の零性、整数へ移した重複度の一致、自然数重複度の一致 | PASS | 重複度差の定義、整数加法の消去、標準単射の単射性を分けた三つの同値性が三例で成立した |
| `check_unique_monic_factorization.sage` | 重複度一致とモニック一次因子積の一致 | PASS | 三つの有限例で同値性が成立した |
| `check_leading_coefficient_cross_product.sage` | モニック化の一致と最高次係数の交差乗算による多項式等式 | PASS | 三つの有限例で同値性が成立した |

## 備考

- 互いに素な二段零点台、共有零点をもつ二段零点台、同じ零点と重複度をもち非零定数倍だけ異なる二段多項式を `QQbar[x]` と `ZZ` で厳密検算する。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、数値描画、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-fisher-zero-formal-divisor-vanishing-criterion/check_*.sage; do sage "$f"; done
```
