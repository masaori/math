# SageMath Check: 1 の冪根は零でない

**対象ラベル**: `claim_root_of_unity_element_ne_zero`

背理法の鎖の各段（$0^{\,n}=0^{\,(n-1)+1}=0^{\,n-1}\cdot0=0$、$n=1,\dots,8$）と
矛盾の核（`QQbar` で $1\ne0$）を厳密に確かめたうえで、主張そのもの
（$\mu_n$ の元は零でない）を $t^{\,n}-1$ の `QQbar` における根の総当たり
（$n=1,\dots,8$）で確かめる。仮定 $n\ge1$ が外せないこと（$0^{\,0}=1$ より
$0\in\mu_0$）も確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-element-ne-zero/check.sage
```

**2026-08-11 実行: すべて通過。**
