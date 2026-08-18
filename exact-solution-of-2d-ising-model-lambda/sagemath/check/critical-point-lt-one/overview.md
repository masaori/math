# SageMath Check: 臨界点は一より小さい

**対象ラベル**: `claim_critical_point_lt_one`

固定した $s=\sqrt2$ とモデル $R=\texttt{AA}$ について、第 5 条件の証人
$w=2^{1/4}$、二平方和の証人 $v=\sqrt{s+1}$、および $u=w\cdot v^{-1}$ を厳密に構成する。
$u\ne0$、$1-x_c=u\cdot u$ へ至る本文の全等式、および
$x_c<1$ を `AA` の厳密計算で検査する。浮動小数点は使わない。

```sh
sage sagemath/check/critical-point-lt-one/check.sage
```

**2026-08-18 実行: すべて通過。**
