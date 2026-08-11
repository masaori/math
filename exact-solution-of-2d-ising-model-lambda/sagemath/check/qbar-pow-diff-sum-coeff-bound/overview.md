# SageMath Check: 冪の差の因数分解の商の係数は、その番号以上で零である

**対象ラベル**: `claim_qbar_pow_diff_sum_coeff_bound`

本文の帰納法（出発点と一歩）の鎖を `PolynomialRing(QQbar)` の厳密計算で一段ずつ確かめる。
$w$ は $1,\sqrt2,i,\sqrt{-3}$ の 4 つ、$n\le5$、$j$ は $n$ から $n+3$ まで。浮動小数点は使わない。

```sh
sage sagemath/check/qbar-pow-diff-sum-coeff-bound/check.sage
```

**2026-08-11 実行: すべて通過。**
