# SageMath Check: 互いに素な一次因子の冪による整除は、もう一方の冪を落とした因子へ遺伝する

**対象ラベル**: `claim_qbar_coprime_divides_cofactor`

本文の証明（Bezout 恒等式 $Pa^{k+1}+Qb^{m+1}=1$ に $g$ を掛け、仮定 $a^{k+1}g=b^{m+1}h$ を代入して
$g=b^{m+1}(Ph+Qg)$ とする一続き五段）を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- Bezout 恒等式が立つこと（`claim_qbar_linear_factor_powers_bezout` の二度適用で $P,Q$ を構成）。
- 鎖の各段が等式として成り立つこと（段ごとに個別に検証する）。
- 結論 $b^{m+1}\mid g$（商と余りで判定）。
- 仮定を満たさない $g$ では結論も成り立たない場合があること（含意が空虚でないことの確認）。

$w,w'$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$ から取った相異なる組すべて、$k,m=0,1,2$、
$g$ は $b^{m+1}$ に $1,t,t^2+1,3t-2,t^3-2$ を掛けたもの。

```sh
sage sagemath/check/qbar-coprime-divides-cofactor/check.sage
```

**2026-08-17 実行: すべて通過。**
