# SageMath Check: Bezout 恒等式は、もう一方の元の冪についても構成できる（帰納法）

**対象ラベル**: `claim_qbar_bezout_power_propagation`

本文の帰納法（出発点・一歩）を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- 出発点 $n=0$: $P:=p$、$Q:=q$ で $P a+Q b^{1}=1$。
- 一歩の再帰式 $P_{n+1}:=P_n p a+Q_n p b^{n+1}+P_n q b$、$Q_{n+1}:=Q_n q$ で構成した
  $P_n,Q_n$ が任意の $n=0,\dots,5$ で $P_n a+Q_n b^{n+1}=1$ を満たすこと。
- 一歩の証明の鎖（本文の 7 個の等式）を $n=1$ の一例で個別に確認。

$a:=t-w$、$b:=t-w'$、$p:=u_{w,w'}$、$q:=-u_{w,w'}$（`claim_qbar_distinct_linear_factors_bezout`
の具体例）とし、$w,w'$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$ から取った相異なる組すべて。

```sh
sage sagemath/check/qbar-bezout-power-propagation/check.sage
```

**2026-08-17 実行: すべて通過。**
