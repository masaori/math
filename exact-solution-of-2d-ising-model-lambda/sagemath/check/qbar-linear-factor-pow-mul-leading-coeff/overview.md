# SageMath Check: 一次因子の冪との積の先頭の係数は、もとの先頭の係数である

**対象ラベル**: `claim_qbar_linear_factor_pow_mul_leading_coeff`

本文の帰納法の各段を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- 出発点 $j=0$（$\mathrm{ac}_{m+0}((t-\widehat{w})^{0}C)=\mathrm{ac}_{m+0}(1\cdot C)=\mathrm{ac}_{m+0}(C)=\mathrm{ac}_m(C)$ の 3 段）。
- 一歩（$(t-\widehat{w})^{j}C$ が上界 $m+j$ を持つこと、冪の等式
  $(t-\widehat{w})^{j+1}C=(t-\widehat{w})(t-\widehat{w})^{j}C$、
  $\mathrm{ac}_{m+(j+1)}((t-\widehat{w})^{j+1}C)=\dots=\mathrm{ac}_m(C)$ の 4 段）。$j$ は $0$ から $5$ まで。

$w$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$、$C$ は零多項式・定数・3 次・4 次（$\zeta_5$ 係数）・
2 つの一次因子の積、上界 $m$ は次数と次数 $+2$ の 2 通り（上界は次数ちょうどでなくてよい）。

```sh
sage sagemath/check/qbar-linear-factor-pow-mul-leading-coeff/check.sage
```

**2026-08-17 実行: すべて通過。**
