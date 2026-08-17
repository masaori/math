# SageMath Check: 臨界点への距離の二乗の零性は一致と同値である

**対象ラベル**: `claim_critical_distance_squared_zero_iff_equal`

$s^2=2$ の二根について $x_c=-1+s\in\texttt{AA}$ とし、代数的数 $\xi$ の一意表示
$\xi=a+b\omega$ から作る
$\mathrm{dsq}_c(\xi)=(a-x_c)^2+b^2$ が零であることと $\xi=x_c$ の真偽が一致することを、
各根 9 点の計 18 組で厳密に確認する。あわせて表示の復元、$R=\texttt{AA}$ への所属、
$b\ne0$ の場合に本文で使う逆元による平方の等式を検査する。浮動小数点は使わない。

```sh
sage sagemath/check/critical-distance-squared-zero-iff-equal/check.sage
```

**2026-08-18 実行: 18 組すべて通過。**
