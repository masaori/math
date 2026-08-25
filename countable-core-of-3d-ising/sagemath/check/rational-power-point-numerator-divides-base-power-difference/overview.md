# SageMath Check: 点数乗表示の分子が隣接箱の底の点数乗の差を割る

## 対象

**対象ラベル**: `claim_rational_power_point_numerator_divides_base_power_difference`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 正の自然数である底の既約分母、隣接する二つの箱での合同式、その差から得る整除
- 併せて検証: `claim_rational_power_point_denominator_divides_two`、`claim_rational_power_base_congruences`、`claim_zero_breakage_multiplicity_is_two`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_integral_base_reduced_denominator.sage` | 正の自然数の既約分数表示の分母は一 | PASS | 正の自然数 256 件で一致 |
| `check_adjacent_box_congruences.sage` | 二つの点数乗がともに二に合同なら差は零に合同 | PASS | 条件を満たす 15442 件で一致 |
| `check_divisibility_from_congruence.sage` | 零合同と整除の同値 | PASS | 法と差の有限標本で一致 |

## 備考

- `ZZ` と `QQ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-25。三検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/rational-power-point-numerator-divides-base-power-difference/check_*.sage; do sage "$f"; done
```
