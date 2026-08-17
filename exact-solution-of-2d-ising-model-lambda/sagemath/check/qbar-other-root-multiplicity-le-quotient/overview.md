# SageMath Check: 相異なる点の重複度は、一次因子を割り出した商へ引き継がれる

**対象ラベル**: `claim_qbar_other_root_multiplicity_le_quotient`

本文の証明どおり、$w\ne w'$、$f=(t-w')g$ のとき、
$(t-w)^{\mathrm{mult}_w(f)}\mid f$ から互いに素な一次因子 $t-w'$ を落として
$(t-w)^{\mathrm{mult}_w(f)}\mid g$ を得る各段と、
$\mathrm{mult}_w(f)\le\mathrm{mult}_w(g)$ を `QQbar` の厳密計算で確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-other-root-multiplicity-le-quotient/check.sage
```

**2026-08-17 実行: すべて通過。**
