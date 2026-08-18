# SageMath Check: 臨界点は正である

**対象ラベル**: `claim_critical_point_positive`

固定した $s=\sqrt2$ とモデル $R=\texttt{AA}$ について、第 5 条件の証人
$w=2^{1/4}$、二平方和の証人 $v=\sqrt{s+1}$ を厳密に構成する。
$v\ne0$、$x_c=s-1=(v^{-1})^2$へ至る本文の全等式、および
$0<x_c$ を `AA` の厳密計算で検査する。浮動小数点は使わない。

```sh
sage sagemath/check/critical-point-positive/check.sage
```

**2026-08-18 実行: すべて通過。**
