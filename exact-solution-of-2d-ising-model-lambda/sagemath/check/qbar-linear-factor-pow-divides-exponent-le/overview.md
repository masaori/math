# SageMath Check: 零でない多項式を割る一次因子の冪の指数は、係数の上界を超えない

**対象ラベル**: `claim_qbar_linear_factor_pow_divides_exponent_le`

本文の準備と鎖の各段を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- 準備: $g\ne0$ の非零係数の番号の集合 $S(g)$ が空でなく有限で、最大元 $m$ について
  $\mathrm{ac}_m(g)\ne0$、$i>m\Rightarrow\mathrm{ac}_i(g)=0$。
- $g=0$ なら $(t-\widehat{w})^{k}\cdot0=0$（$f\ne0$ に反する側）。
- 鎖 $\mathrm{ac}_{m+k}(f)=\mathrm{ac}_{m+k}((t-\widehat{w})^{k}g)=\mathrm{ac}_m(g)\ne0$ と、
  係数の上界 $n$ に対する $m+k\le n$、$k\le m+k\le n$。$k$ は $0$ から $5$ まで。

$w$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$、$g$ は定数・3 次・4 次（$\zeta_5$ 係数）・2 つの一次因子の積・
$3t$ の 5 個、$f:=(t-\widehat{w})^{k}g$ の上界 $n$ は次数と次数 $+2$ の 2 通り。

```sh
sage sagemath/check/qbar-linear-factor-pow-divides-exponent-le/check.sage
```

**2026-08-17 実行: すべて通過。**
