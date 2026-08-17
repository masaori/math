# SageMath Check: 有理円板内の格子点数あたりの Fisher 零点数は 2 を超えない

**対象ラベル**: `claim_fisher_zero_density_in_rational_disc_le_two`

$L=1,2$ について $\mathcal F_L$ を $Z_L$ の `QQbar` における相異なる根として厳密に列挙し、
中心 3 点・半径 3 通りの有理円板 9 組で $N_L(c,r)$ を数え（`AA` の厳密比較）、
本文の一続きの鎖の各段 $\nu_L=N_L/L^2\le\lvert\mathcal F_L\rvert/L^2\le2L^2/L^2=2$ と
$0\le\nu_L$ を `QQ` の厳密計算で確かめる（18 検査）。浮動小数点は使わない。
$L=3$ は根 12 個の `AA` 厳密比較が 100 秒で終わらないので対象に入れていない。

```sh
sage sagemath/check/fisher-zero-density-in-rational-disc-le-two/check.sage
```

**2026-08-17 実行: すべて通過。**
