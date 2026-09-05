# SageMath Check: 1 の冪根の全体にわたる冪の和の値

**対象ラベル**: `claim_root_of_unity_power_sum_value`

$n=1,\dots,8$、$m=0,\dots,17$ の全 144 組について、
$S_{n,m}=\sum_{z\in\mu_n}z^m$ を `QQbar` で厳密に計算する。
$n\mid m$ の場合は各項が $1$ で和が $n$ であること、$n\nmid m$ の場合は
$w^m\ne1$ を満たす $w\in\mu_n$ が存在して和が $0$ であることを確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-power-sum-value/check.sage
```

**2026-08-12 実行: すべて通過。**

2026-09-06 のプログラミングによる検証: 相異性・根への所属・独立に求めた全根との集合一致を追加し、全 144 組が通過した。LLM による検証では本文と Lean 二版の三主張の合成を照合した。冪和公式は射影からの復元に使うため、空の四則主張には該当しない。
