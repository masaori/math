# SageMath Check: 相異なる代数的数に対応する一次因子は互いに素である（明示的な Bezout 恒等式）

**対象ラベル**: `claim_qbar_distinct_linear_factors_bezout`

本文の準備の鎖を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- $u_{w,w'}:=(w'-w)^{-1}$ が well-defined（$w\ne w'\Rightarrow w'-w\ne0$）。
- 恒等式 $u_{w,w'}(t-\widehat w)-u_{w,w'}(t-\widehat{w'})=1$。
- 準備段の各行（分配則・$t$ の相殺・定数埋め込みの和・積・体の逆元）を個別に確認。

$w,w'$ は $0,\pm1,\tfrac23,\zeta_3,\zeta_5,\sqrt2$ から取った相異なる組すべて（42 組）。

```sh
sage sagemath/check/qbar-distinct-linear-factors-bezout/check.sage
```

**2026-08-17 実行: すべて通過。**
