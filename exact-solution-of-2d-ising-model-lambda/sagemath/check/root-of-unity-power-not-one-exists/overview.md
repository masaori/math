# SageMath Check: 指数が根の次数の倍数でないとき、冪が 1 でない 1 の冪根が存在する

**対象ラベル**: `claim_root_of_unity_power_not_one_exists`

$n=1,\dots,8$、$m=0,\dots,17$ のうち $n$ が $m$ を割り切らない全 93 組について、
人手証明の準備（除法 $m=nq+r$、$1\le r<n$）、鎖のうち背理法の仮定を使わない各段
（$w^{r}=1\cdot w^{r}=1^{q}\cdot w^{r}=(w^{n})^{q}\cdot w^{r}=w^{nq}\cdot w^{r}=w^{nq+r}=w^{m}$）、
大小（$\lvert\mu_n\rvert=n$、$r<n$）、および結論（$w^{m}\ne1$ を満たす $w\in\mu_n$ の存在）を
`QQbar` の厳密計算で確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-power-not-one-exists/check.sage
```

**2026-08-12 実行: すべて通過。**
