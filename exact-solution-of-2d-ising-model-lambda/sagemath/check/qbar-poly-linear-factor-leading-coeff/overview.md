# SageMath Check: 一次因子との積の先頭の係数

**対象ラベル**: `claim_qbar_poly_linear_factor_leading_coeff`

本文の証明の 4 段を `QQbar` の厳密計算で確かめる。浮動小数点は使わない。

- 一次因子との積の番号 $m+1$ の係数を開く。
- $m+1>m$ と係数の仮定により $mathrm{ac}_{m+1}(C)=0$ とする。
- 零元との積、零元との和を順に適用する。

$w$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$、$C$ は零多項式・定数・3 次・4 次・
2 つの一次因子の積で確かめる。

```sh
sage sagemath/check/qbar-poly-linear-factor-leading-coeff/check.sage
```

**2026-08-12 実行: すべて通過。**
