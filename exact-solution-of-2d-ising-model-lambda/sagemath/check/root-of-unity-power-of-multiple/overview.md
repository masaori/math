# SageMath Check: 指数が根の次数の倍数ならば 1 の冪根の冪は 1 である

**対象ラベル**: `claim_root_of_unity_power_of_multiple`

$n=1,\dots,8$、$k=0,\dots,12$、$m=nk$ とし、$w\in\mu_n$ の全てについて、
$w^m=w^{nk}=(w^n)^k=1^k=1$ の各段を `QQbar` の厳密計算で確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-power-of-multiple/check.sage
```

**2026-08-12 実行: すべて通過。**
