# SageMath Check: 有限格子の Fisher 零点は代数的である

**対象ラベル**: `def_qbar_polynomial_evaluation`・`def_finite_lattice_fisher_zeros`・
`claim_fisher_zero_algebraicity`

$L=1,2,3$ について、本文の定義どおり配位ごとの単項式の和から
$Z_L\in\mathbb{Z}[x]$ を作る。$Z_L(1)=2^{L^2}\ne0$ を確かめたうえで、すべての根を
`QQbar` で厳密に取り、各根での値が零元であることを確かめる。浮動小数点は使わない。
$L=1$ では $Z_1=2$ なので根は無く、存在しない根を仮定しない。

```sh
sage sagemath/check/fisher-zero-algebraicity/check.sage
```

**2026-08-12 実行: すべて通過。**
