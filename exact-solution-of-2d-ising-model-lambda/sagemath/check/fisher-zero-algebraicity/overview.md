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

2026-09-06 のレビューで、本文の係数和による評価を直接計算し、形式微分で各根の重複度を確定し、その和が次数と一致することを加えた。根の相異性・重複度の正値・次数との和の一致も判定する。一般の格子サイズの証明は Lean が担い、この SageMath は一辺一から三の有限例を担当する。

プログラミングによる検証は一辺一から三の全 20 零点、本文一括検査・PDF・529 検算の対応、Lean 全体ビルドと登録 1,635 定理の未証明依存で全て通過した。
