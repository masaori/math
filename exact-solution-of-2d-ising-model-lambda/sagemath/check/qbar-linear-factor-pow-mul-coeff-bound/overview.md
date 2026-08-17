# SageMath Check: 一次因子の冪との積の係数は、上界と指数の和より上の番号で零である

**対象ラベル**: `claim_qbar_linear_factor_pow_mul_coeff_bound`

本文の帰納法の各段を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- 出発点 $j=0$（$(t-\widehat{w})^{0}C=1\cdot C=C$ の係数。3 段）。
- 一歩（冪の等式 $(t-\widehat{w})^{j+1}C=(t-\widehat{w})(t-\widehat{w})^{j}C$ と、
  帰納法の仮定のもとで $k>m+(j+1)$ の係数が零になること）。$j$ は $0$ から $5$ まで。

$w$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$、$C$ は零多項式・定数・3 次・4 次（$\zeta_5$ 係数）・
2 つの一次因子の積で、$k$ は上界の次から 4 つ走らせた。

```sh
sage sagemath/check/qbar-linear-factor-pow-mul-coeff-bound/check.sage
```

**2026-08-17 実行: すべて通過。**
