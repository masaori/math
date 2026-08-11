# SageMath Check: 1 の冪根の全体の有限部分集合の元の個数は指数を超えない

**対象ラベル**: `claim_root_of_unity_subset_card_bound`

`PolynomialRing(QQbar)` で、準備の多項式 $f=t^{n}+\widehat{-1}$ が主張の適用に要る
3 条件（零でない・係数が $n$ で尽きる・$\mu_n$ の元が根である）を満たすことを
$n=1,\dots,6$ で厳密計算する。主張そのものは、$\mu_n$ の全部分集合を列挙して
元の個数が $n$ 以下であることを確かめる。また $n=0$ では $z^{0}=1$ により任意の
代数的数が $\mu_0$ の元になるので、1 元の部分集合が反例となり、仮定 $n\ge1$ が
外せないことを確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-subset-card-bound/check.sage
```

**2026-08-11 実行: すべて通過。**
