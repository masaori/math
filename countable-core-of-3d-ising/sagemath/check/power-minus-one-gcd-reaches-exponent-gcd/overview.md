# SageMath Check: 還元を繰り返して指数の最大公約数へ到達する

## 対象

**対象ラベル**: `claim_power_minus_one_gcd_reaches_exponent_gcd`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 指数差による最大公約数の不変性、強い帰納法の三場合、指数の最大公約数への到達

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_exponent_gcd_difference_invariance.sage` | 差を取った指数対と元の指数対の最大公約数が互いに割り合い、一致する | PASS | `ZZ` 上の有限標本で成立 |
| `check_three_reduction_cases.sage` | 指数の大小の三場合で、冪差の最大公約数が和の小さい指数対へ移る | PASS | `ZZ` 上の有限標本で成立 |
| `check_reaches_exponent_gcd.sage` | 還元前の冪差の最大公約数が指数の最大公約数で定まる到達形に一致する | PASS | `ZZ` 上の有限標本で成立 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 強い帰納法そのものは有限検査の対象ではないため、本文の帰納段が使う減少量と三場合、および結論の等式を別々に確認した。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-26。三検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/power-minus-one-gcd-reaches-exponent-gcd/check_*.sage; do sage "$f"; done
```
