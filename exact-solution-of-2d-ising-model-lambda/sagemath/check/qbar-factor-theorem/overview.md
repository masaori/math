# SageMath Check: 根を持つ多項式は一次式を因子に持つ

**対象ラベル**: `claim_qbar_factor_theorem`

本文の鎖を `PolynomialRing(QQbar)` の厳密計算で一段ずつ確かめる。根を持つ多項式について、
本文で構成した商 $g=\sum_k\widehat{\mathrm{ac}_k(f)}K_k(w)$ が
$f=(t-\widehat w)g$ を満たすことも確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/qbar-factor-theorem/check.sage
```

**2026-08-11 実行: すべて通過。**
