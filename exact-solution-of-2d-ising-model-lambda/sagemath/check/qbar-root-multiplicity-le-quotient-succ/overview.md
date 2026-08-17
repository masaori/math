# SageMath Check: 一次因子を 1 つ割り出すと、その点の重複度は 1 しか下がらない

**対象ラベル**: `claim_qbar_root_multiplicity_le_quotient_succ`

本文の証明（$M:=\mathrm{mult}_w(f)\ge1$ のとき $f=(t-\widehat w)^{M'+1}h$ の証人を取り、
$(t-\widehat w)\left((t-\widehat w)^{M'}h\right)=(t-\widehat w)g$ から一次因子を消去して
$(t-\widehat w)^{M'}\mid g$、よって $M'\le\mathrm{mult}_w(g)$）を厳密計算（`QQbar`）で確かめる。
浮動小数点は使わない。

- $g\ne0$ から $f=(t-\widehat w)g\ne0$。
- 結論 $\mathrm{mult}_w(f)\le\mathrm{mult}_w(g)+1$。
- 消去の段（$(t-\widehat w)^{M'}h=g$ と、そこから読める $(t-\widehat w)^{M'}\mid g$、$M'\le\mathrm{mult}_w(g)$）。
- この上界が最良であること（実際には等号が成り立つ。本文では上界だけを主張する）。

$w$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$、$g$ は重複度 2・3 の因子を持つものを含む 7 個。
重複度は $(t-\widehat w)^k$ が割り切る $k$ の最大元として、非零係数の番号の最大元を上界に取って計算する。

```sh
sage sagemath/check/qbar-root-multiplicity-le-quotient-succ/check.sage
```

**2026-08-17 実行: すべて通過。**
