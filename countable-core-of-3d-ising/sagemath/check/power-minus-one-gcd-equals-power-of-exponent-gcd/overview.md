# SageMath Check: 到達した形を指数の最大公約数の冪から一を引いた数へ書き換える

## 対象

**対象ラベル**: `claim_power_minus_one_gcd_equals_power_of_exponent_gcd`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 同じ自然数どうしの最大公約数、直前の到達形の書き換え、最終等式
- 併せて検証: `claim_power_minus_one_gcd_reaches_exponent_gcd`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_same_number_gcd.sage` | 同じ自然数どうしの最大公約数が相互整除により元の自然数と一致する | PASS | `ZZ` 上の有限標本で成立 |
| `check_terminal_gcd_rewrite.sage` | 指数の最大公約数で定まる到達形を同じ数どうしの最大公約数として書き換える | PASS | `ZZ` 上の有限標本で成立 |
| `check_final_equality.sage` | 直前の到達形から最終等式までの三段が一致する | PASS | `ZZ` 上の有限標本で成立 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-26。三検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/power-minus-one-gcd-equals-power-of-exponent-gcd/check_*.sage; do sage "$f"; done
```
