# SageMath Check: 単位元の有限和は、自然数の与える有理数に等しい

**対象ラベル**: `claim_qbar_unit_sum_eq_rational`

帰納法の出発点（空の有限和が $\overline{\mathbb{Q}}$ の加法の単位元 $0$ であり、
自然数 $0$ に一致すること）と、一歩の鎖の各行（項を分ける・帰納法の仮定・
部分体の加法の一致と自然数の和の一致）を $n=0,\dots,8$ について確かめる。
主張 $\sum_{i<n}1=n$ 自体も $n=0,\dots,12$ で確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/qbar-unit-sum-rational-value/check.sage
```

**2026-08-12 実行: すべて通過。**
