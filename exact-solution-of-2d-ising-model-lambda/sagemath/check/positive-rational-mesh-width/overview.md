# SageMath Check: 正の有理数より平方が小さい有理網幅

**対象ラベル**: `claim_positive_rational_mesh_width`

正の有理数 $\delta$ の標本 6 個について、$\varepsilon:=\min(\delta,1)$ と
$N:=\lfloor1/\varepsilon\rfloor+1$ を取り、$N\ge1$、$h:=1/N>0$、
$h<\varepsilon\le\delta$、$h^2<h<\delta$ を一段ずつ検査する。
すべて `QQ` の厳密計算であり、浮動小数点は使わない。

```sh
sage sagemath/check/positive-rational-mesh-width/check.sage
```

**2026-08-18 実行: 6 個すべて通過。**
