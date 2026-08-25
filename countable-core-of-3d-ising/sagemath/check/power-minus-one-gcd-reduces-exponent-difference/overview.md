# SageMath Check: 冪差の最大公約数の指数差への還元

## 対象

**対象ラベル**: `claim_power_minus_one_gcd_exponent_difference_step`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 冪差の分解、二つの最大公約数の相互整除、最大公約数の等式

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_power_decomposition.sage` | `c^m-1=c^(m-n)(c^n-1)+(c^(m-n)-1)` | PASS | `ZZ` 上の有限標本で一致 |
| `check_gcd_divisibility_both_directions.sage` | 還元前後の最大公約数が互いに割り合う | PASS | `ZZ` 上の有限標本で両方向とも成立 |
| `check_gcd_equality.sage` | 還元前後の最大公約数が等しい | PASS | `ZZ` 上の有限標本で一致 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 初回は相互整除を剰余が零であることとして検査したため、`c=1` で現れる `0 | 0` に対して零除算となった。主張を変えず、`ZZ` の `divides` による整除判定へ直して再実行した。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-26。三検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/power-minus-one-gcd-reduces-exponent-difference/check_*.sage; do sage "$f"; done
```
