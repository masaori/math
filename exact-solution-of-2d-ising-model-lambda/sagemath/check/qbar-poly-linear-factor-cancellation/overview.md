# SageMath Check: 一次因子は消去できる

**対象ラベル**: `claim_qbar_poly_linear_factor_cancellation`

本文の証明の各段を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- 一次式 $t-\widehat{w}$ の係数（$\mathrm{ac}_0=-w$、$\mathrm{ac}_1=1$、$i\ge2$ で $0$）。
- 積の係数 $\mathrm{ac}_{m+1}((t-\widehat{w})C)=\mathrm{ac}_m(C)+(-w)\,\mathrm{ac}_{m+1}(C)$。
- 帰納法の一歩に対応する取り戻しの鎖（係数を上の番号から順に決めると一意に戻ること）。
- 消去そのもの（$(t-\widehat{w})A=(t-\widehat{w})B$ ならば $A=B$）。

```sh
sage sagemath/check/qbar-poly-linear-factor-cancellation/check.sage
```

**2026-08-12 実行: すべて通過。**
