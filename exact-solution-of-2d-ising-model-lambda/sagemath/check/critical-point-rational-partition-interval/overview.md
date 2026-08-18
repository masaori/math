# SageMath Check: 臨界点を挟む有理等分区間

**対象ラベル**: `claim_critical_point_rational_partition_interval`

$x_c=\sqrt2-1\in\texttt{AA}$ と $N=1,2,3,4,5,7,10,16,31,64,127$ について、
$S_N=\{j\le N\mid j/N\le x_c\}$ を `QQ` から `AA` へ厳密に埋め込んで構成する。
$0\in S_N$、$N\notin S_N$、最大元 $k$ の上界、
$k/N\le x_c<(k+1)/N$、および最大性を検査する。浮動小数点は使わない。

```sh
sage sagemath/check/critical-point-rational-partition-interval/check.sage
```

**2026-08-18 実行: すべて通過。**
