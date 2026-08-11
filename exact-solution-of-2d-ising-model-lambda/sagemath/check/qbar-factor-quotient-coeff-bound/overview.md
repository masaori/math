# SageMath Check: 因数定理の商の係数は、上界の番号以上で零である

**対象ラベル**: `claim_qbar_factor_quotient_coeff_bound`

本文の鎖（11 段）を `PolynomialRing(QQbar)` の厳密計算で一段ずつ確かめる。
$f$ は 6 つ（上界 $n$ が実際の次数より大きい取り方を含む）、$w$ は $1,\sqrt2,i,\sqrt{-3}$ の
4 つ、$j$ は $n$ から $n+3$ まで。あわせて鎖が使う前提（定数多項式の正次数の係数が零・
$\mathrm{ac}_0$ が元に戻る・$k\le j$ で $K_k(w)$ の係数が零）も確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/qbar-factor-quotient-coeff-bound/check.sage
```

**2026-08-11 実行: すべて通過。**
