# SageMath Check: 冪の差の因数分解の商の、もとの根における値

**対象ラベル**: `claim_qbar_pow_diff_quotient_root_value`

`PolynomialRing(QQbar)` で商 $K_n(w)$ を本文の漸化式（$K_0=0$、$K_{n+1}=K_n\widehat{w}+t^n$）の
とおりに構成し、有理数・無理数・1 の冪根・零を含む代数的数のサンプルについて、
出発点 $\mathrm{aev}_w(K_1(w))=w^0$、一歩の鎖の中心
$\mathrm{aev}_w(K_{n+1}(w))=\mathrm{aev}_w(K_n(w))\cdot w+w^n$、および主張
$\mathrm{aev}_w(K_n(w))=\sum_{i<n}w^{n-1}$（$n=1,\dots,7$）を厳密に確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-pow-diff-quotient-root-value/check.sage
```

**2026-08-11 実行: すべて通過。**
