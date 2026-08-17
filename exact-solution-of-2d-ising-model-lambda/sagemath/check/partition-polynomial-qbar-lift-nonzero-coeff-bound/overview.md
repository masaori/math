# SageMath Check: 持ち上げた分配多項式は零でなく、係数は $2L^2$ より上の番号で零である

**対象ラベル**: `claim_partition_polynomial_qbar_lift_nonzero_coeff_bound`

本文の 3 つの言明（係数の場合分け／持ち上げが零でないこと／$2L^2$ より上の番号の係数が零であること）を
厳密計算（`ZZ[x]` と `QQbar[t]`）で確かめる。浮動小数点は使わない。

- $\mathrm{ac}_k(\widehat{Z_L}^{\,F})=\Omega_L(k)$（$k\le2L^2$）、$=0$（$2L^2<k$）。
- 係数の総和が $2^{L^2}$ であること（背理法で「零元なら総和が 0」と矛盾させる箇所の材料）と、
  持ち上げが零元でないこと。
- $2L^2<k$ の範囲で係数が零であること。

$L=1,2,3$。分配多項式は配位ごとに単項式を足し上げて作り（多重度から作らない）、
多重度の列は独立に数える。

```sh
sage sagemath/check/partition-polynomial-qbar-lift-nonzero-coeff-bound/check.sage
```

**2026-08-17 実行: すべて通過。**
