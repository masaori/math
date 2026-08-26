# SageMath Check: 点数乗表示の底は閾値の箱の値から一意に決まる

## 対象

**対象ラベル**: `claim_power_form_base_is_determined_by_threshold_box`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_power_form_base_is_determined_by_threshold_box`）
- 範囲: 閾値の箱での冪等式から、正の有理数の有限乗の狭義単調性を使って底の一意性を得る証明全体
- 併せて検証: `def_box`、`claim_power_identity_iff_rational_power_form`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_threshold_box_power_equality.sage` | 閾値の箱の点の数が正で、底の点数乗が閾値の値に等しい段 | PASS | 箱サイズ 1 から 6、正の有理数 4 個で成立 |
| `check_strict_power_order.sage` | 底の狭義大小が正の自然数乗で保たれる二方向 | PASS | 正の有理数 5 個と指数 1 から 8 で成立 |
| `check_equal_positive_powers_force_equal_bases.sage` | 同じ正の自然数乗が等しい底の一意性 | PASS | 正の有理数 5 個と指数 1 から 8 で成立 |

## 備考

- `QQ` と `ZZ` だけを使い、本文の可算側の各段を厳密計算で検査する。
- 全称的な単射性は Lean 具体版で形式化する対象とし、ここでは複数の正の有理数と指数について各段を検査する。
- 浮動小数点、乗根、無限和、級数、箱の大きさの極限は使わない。
- 2026-08-26 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/power-form-base-determined-by-threshold-box/check_*.sage; do sage "$f"; done
```
