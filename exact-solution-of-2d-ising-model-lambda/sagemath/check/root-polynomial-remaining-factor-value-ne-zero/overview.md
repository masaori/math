# SageMath Check: 一次因子との分解の残りの因子の、その一次因子の根における値

**対象ラベル**: `claim_root_polynomial_remaining_factor_value_ne_zero`

本文の証明の準備 2 つと本体の鎖を `QQbar` の厳密計算で確かめる。浮動小数点は使わない。

- 準備の第 1（$n<k$ で $\mathrm{ac}_k(f)=0$）と第 2（$w\in\mu_n$ で $\mathrm{aev}_w(f)=0$）。
- 本体の鎖 $(t-\widehat{w})B=f=(t-\widehat{w})g$、商の係数の上界、消去による $B=g$、
  値の一致 $\mathrm{aev}_w(B)=\mathrm{aev}_w(g)$。
- 主張 $\mathrm{aev}_w(B)\ne0$。

$n=1,\dots,8$、$w$ は $\mu_n$ の全元（$\zeta_n$ の冪）、$B$ は仮定を満たす多項式
（$f$ を一次因子で割った商）で確かめる。

```sh
sage sagemath/check/root-polynomial-remaining-factor-value-ne-zero/check.sage
```

**2026-08-12 実行: すべて通過。**

**2026-09-06 プログラミングによる検証: 通過。** 準備の係数計算四段と評価計算五段、
最後の商の非零性を本文の各行へ対応させた。以前の終点の assertion も保持した。
Lean 具体版と必要十分版への特殊化の係数計算も同じ四段に揃えた。
