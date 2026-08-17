# SageMath Check: 有限集合上の根の重複度の和は係数の上界を超えない

**対象ラベル**: `claim_qbar_finite_root_multiplicity_sum_le_coeff_bound`

有限集合の各部分集合について重複度の和が多項式の次数以下であることと、本文の帰納法の一歩
（一次因子を一つ割り出すと、その点の重複度は高々 1 だけ減り、他の点の重複度は失われない）を
`QQbar` の厳密計算で確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/qbar-finite-root-multiplicity-sum-le-coeff-bound/check.sage
```

**2026-08-17 実行: すべて通過。**
