# SageMath Check: 二以上の有限格子の Fisher 零点集合は空でない

**対象ラベル**: `claim_fisher_zero_set_nonempty`

本文の証明の各段を厳密計算で確認する。浮動小数点は使わない。

- $L=1$ では $Z_1=2$ で根が無く、仮定 $L\ge2$ が必要であること。
- $L=2,3$ では $(0,0)$ のスピンだけを反転した配位の破れボンド数 $m$ が正で、
  $\Omega_L(m)\ge1$、したがって $Z_L$ の正次数の係数が非零であること。
- $Z_L$ が `QQbar` に少なくとも一つの根を持ち、各根での値が厳密に零であること。

```sh
sage sagemath/check/fisher-zero-set-nonempty/check.sage
```

**2026-08-18 実行: すべて通過。**
