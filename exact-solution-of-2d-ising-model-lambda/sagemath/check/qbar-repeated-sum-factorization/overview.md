# SageMath Check: 同じ元の有限和は、単位元の有限和との積である

**対象ラベル**: `claim_qbar_repeated_sum_factorization`

帰納法の出発点（空の有限和が $0$ であり $0=0\cdot a$）と、一歩の鎖の各行
（項を分ける・帰納法の仮定・$1$ が積の単位元・分配則・項を合わせる）を、
複数の厳密な代数的数と $n=0,\dots,8$ について確かめる。
主張 $\sum_{i<n}a=(\sum_{i<n}1)\cdot a$ 自体も $n=0,\dots,9$ で確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-repeated-sum-factorization/check.sage
```

**2026-08-11 実行: すべて通過。**
