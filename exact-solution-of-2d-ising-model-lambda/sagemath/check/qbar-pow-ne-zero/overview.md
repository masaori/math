# SageMath Check: 零でない代数的数の冪は零でない

**対象ラベル**: `claim_qbar_pow_ne_zero`

帰納法の出発点 $w^0=1\ne0$ と、一歩で使う
$w^k w=w^{k+1}$ および零でない左因子の消去を、複数の厳密な代数的数と
$k=0,\dots,8$ について確かめる。主張を $n=0,\dots,9$ でも確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-pow-ne-zero/check.sage
```

**2026-08-11 実行: すべて通過。**
