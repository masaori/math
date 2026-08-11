# SageMath Check: 因数定理の商と冪の差の商の一致

**対象ラベル**: `claim_root_polynomial_factor_quotient`

$n=1,\dots,8$ と $w\in\mu_n$ について、$f=t^n-1$ から因数定理が構成する商
$g=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}K_k(w)$ が $K_n(w)$ に等しく、
$f=(t-\widehat w)g$ であることを厳密計算で確かめる。
有限和の番号 $n$ の項が $K_n(w)$ で、そのほかの項がすべて零であることも個別に確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/root-polynomial-factor-quotient/check.sage
```

**2026-08-12 実行: すべて通過。**
