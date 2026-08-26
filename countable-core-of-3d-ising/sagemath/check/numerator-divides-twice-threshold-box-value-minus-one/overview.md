# SageMath Check: 分子と閾値の箱の値を結ぶ整除

## 対象

**対象ラベル**: `claim_numerator_divides_twice_threshold_box_value_minus_one`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 有限等比和、整除の二倍への移送と推移、閾値の箱の値の代入

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_geometric_sum.sage` | 有限等比和の四段と `(c - 1) | (c^n - 1)` | PASS | `ZZ` 上の有限標本で成立 |
| `check_scaled_divisibility_chain.sage` | 整除の二倍への移送と推移 | PASS | `ZZ` 上の有限標本で成立 |
| `check_threshold_box_substitution.sage` | `Z_{L_0}(q)=c^n` の代入による最終整除 | PASS | `ZZ` 上の有限標本で成立 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-26。三検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/numerator-divides-twice-threshold-box-value-minus-one/check_*.sage; do sage "$f"; done
```
