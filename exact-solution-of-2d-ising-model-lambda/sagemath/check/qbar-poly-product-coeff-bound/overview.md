# SageMath Check: 係数上界つき多項式の積の係数は、上界の和より上の番号で零である

**対象ラベル**: `claim_qbar_poly_product_coeff_bound`

本文の証明の各段を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- 本体の鎖（$k>p+q$ で $\mathrm{ac}_k(PQ)=0$。積の係数 → 有限和を番号 $p$ で分ける →
  $Q$ の係数の仮定 → $P$ の係数の仮定 → 零元との積 → 零元の有限和 → 零元との和、の 7 段）。
- 各段の途中で、分けた前半の全項について $k-i>q$ と $\mathrm{ac}_{k-i}(Q)=0$、
  後半の全項について $\mathrm{ac}_i(P)=0$ を個別に確かめている。

$P$ は零多項式・定数・1 次・3 次・2 次（$\zeta_3,\sqrt2$ 係数）、$Q$ は零多項式・定数・
一次因子・2 つの一次因子の積・4 次で、$k$ は $p+q+1$ から $p+q+4$ まで走らせた。

```sh
sage sagemath/check/qbar-poly-product-coeff-bound/check.sage
```

**2026-08-12 実行: すべて通過。**
