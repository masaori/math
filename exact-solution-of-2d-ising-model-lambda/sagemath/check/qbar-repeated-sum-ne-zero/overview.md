# SageMath Check: 零でない代数的数を正の個数だけ足した有限和は零でない

**対象ラベル**: `claim_qbar_repeated_sum_ne_zero`

零でない代数的数 $a$（有理数・無理数・虚数・1 の冪根・混合を含む 7 例）と $n=1,\dots,8$ について、
証明の鎖（$\sum_{i<n}a=(\sum_{i<n}1)\cdot a$・$\sum_{i<n}1\ne0$・積の非零性）を厳密計算で確かめる。
仮定 $a\ne0$ を外すと $a=0$ で、仮定 $n\geq1$ を外すと $n=0$ で結論が破れることも確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-repeated-sum-ne-zero/check.sage
```

**2026-08-12 実行: すべて通過。**
