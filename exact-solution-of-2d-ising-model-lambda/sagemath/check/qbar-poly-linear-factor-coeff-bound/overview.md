# SageMath Check: 一次因子との積の係数は、上の番号で零である

**対象ラベル**: `claim_qbar_poly_linear_factor_coeff_bound`

本文の証明の各段を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- 準備の鎖（$i\ge2$ で $\mathrm{ac}_i(t-\widehat{w})=0$。3 段）。
- 本体の鎖（$k>m+1$ で $\mathrm{ac}_k((t-\widehat{w})C)=0$。積の係数 → 番号 $0,1$ の
  取り出し → 係数の仮定 → 準備の係数 → 零元との積 → 零元の有限和、の 6 段）。

$w$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$、$C$ は零多項式・定数・3 次・4 次（$\zeta_5$ 係数）・
2 つの一次因子の積で、$k$ は $m+2$ から $m+5$ まで走らせた。

```sh
sage sagemath/check/qbar-poly-linear-factor-coeff-bound/check.sage
```

**2026-08-12 実行: すべて通過。**

2026-09-05 のレビューで再実行し、全段のプログラミングによる検証が通過した。
LLM による検証では本文と Lean 二版の計算順を突き合わせ、Lean を準備三段・本体六段へ揃えた。
