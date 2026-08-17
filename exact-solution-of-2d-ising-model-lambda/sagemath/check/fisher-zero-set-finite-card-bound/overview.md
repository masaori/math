# SageMath Check: 有限格子の Fisher 零点の全体は有限集合であり元の個数は 2L^2 を超えない

**対象ラベル**: `claim_fisher_zero_set_finite_card_bound`

$L=1,2,3$ について $\mathcal F_L$ を $Z_L$ の `QQbar` における相異なる根として厳密に列挙し、
有限のリストとして得られること・各元で $\mathrm{Ev}^F$ が 0 になること・個数が $2L^2$ 以下であること
（$\lvert\mathcal F_L\rvert=0,8,12$）、および本文の背理法の終点である $\lvert S\rvert=2L^2+1$ と
$\lvert S\rvert\le2L^2$ が両立しないことを整数の厳密計算で確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/fisher-zero-set-finite-card-bound/check.sage
```

**2026-08-17 実行: すべて通過。**
