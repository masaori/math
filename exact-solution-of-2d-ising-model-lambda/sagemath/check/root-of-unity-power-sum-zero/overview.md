# SageMath Check: 冪が 1 でない 1 の冪根があるとき、冪の和は零元である

**対象ラベル**: `claim_root_of_unity_power_sum_zero`

$n=1,\dots,8$・$m=0,\dots,17$ について、$\mu_n$ を `QQbar.zeta(n)` の冪として厳密に列挙し、
$w^m\ne1$ を満たす $w\in\mu_n$ ごとに、準備（$w^m-1\ne0$）と 4 段の鎖
$(w^m-1)S_{n,m}=w^mS-1\cdot S=w^mS-S=S-S=0$ を一段ずつ確かめ、結論 $S_{n,m}=0$ を検算する。
仮定が外せないこと（$w^m\ne1$ なる $w$ が無い組では $m$ が $n$ の倍数であり $S_{n,m}=n\ne0$）も
確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-power-sum-zero/check.sage
```

**2026-08-12 実行: すべて通過。**

2026-09-06 のプログラミングによる検証: 準備と四段の鎖は各 372 組、零和の結論は 93 組、仮定が無い対照は 51 組で全て通過。
LLM による検証: 本文の結論の根拠を式の行末へ移す表記統一であり、仮定・論法・式・参照は保存した。
