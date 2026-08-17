# SageMath Check: 一次因子の冪どうしが互いに素であること（Bezout 恒等式の伝播の二度適用）

**対象ラベル**: `claim_qbar_linear_factor_powers_bezout`

本文の二度適用（`claim_qbar_bezout_power_propagation` を `n:=m` で一度、
続けて `a':=b^{m+1}`、`b':=a` と入れ替えて `n:=k` でもう一度）を厳密計算（`QQbar`）で確かめる。
浮動小数点は使わない。

- 一度目の適用で $P_1 a+Q_1 b^{m+1}=1$。
- 入れ替えた組 $(a',b',p',q'):=(b^{m+1},a,Q_1,P_1)$ が $p'a'+q'b'=1$ を満たすこと。
- 二度目の適用で $P_2 b^{m+1}+Q_2 a^{k+1}=1$、すなわち $Q_2 a^{k+1}+P_2 b^{m+1}=1$。

$w,w'$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$ から取った相異なる組すべて、$k,m=0,\dots,3$。

```sh
sage sagemath/check/qbar-linear-factor-powers-bezout/check.sage
```

**2026-08-17 実行: すべて通過。**
