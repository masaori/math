# SageMath Check: 因数定理の商のもとの根における値の非零性

**対象ラベル**: `claim_root_factor_quotient_value_ne_zero`

$n=1,\dots,8$ と $w\in\mu_n$ について、準備の 3 つの非零性
（$w\ne0$・$w^{n-1}\ne0$・同じ元 $w^{n-1}$ を $n$ 個足す有限和の非零性）、
鎖の各行（$\mathrm{aev}_{w}(g)=\mathrm{aev}_{w}(K_n(w))=\sum_{i<n}w^{n-1}$）、
および主張 $\mathrm{aev}_{w}(g)\ne0$ を厳密計算で確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/root-factor-quotient-value-ne-zero/check.sage
```

**2026-08-12 実行: すべて通過。**
