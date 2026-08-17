# SageMath Check: 根の重複度が 1 以上であることと、その点で値が零であることは同じである

**対象ラベル**: `claim_qbar_root_multiplicity_ge_one_iff_root`

本文の準備と二つの含意の各段を厳密計算（`QQbar`）で確かめる。浮動小数点は使わない。

- 準備: $\mathrm{aev}_w(t-\widehat{w})=\mathrm{aev}_w(t)-\mathrm{aev}_w(\widehat{w})=w-w=0$。
- $\mathrm{mult}_w(f)\ge1\Rightarrow\mathrm{aev}_w(f)=0$: 重複度 $k$ の整除の商 $g$ を取り、
  $(t-\widehat w)^{k}=(t-\widehat w)^{m}(t-\widehat w)$（$m=k-1$）と代入が積を保つことによる鎖
  $\mathrm{aev}_w(f)=\mathrm{aev}_w((t-\widehat w)^m)\cdot0\cdot\mathrm{aev}_w(g)=0$。
- $\mathrm{aev}_w(f)=0\Rightarrow\mathrm{mult}_w(f)\ge1$: 非零係数の番号の最大元 $n_f$ を上界にして
  $(t-\widehat w)^{1}\mid f$、よって $1\le\mathrm{mult}_w(f)$。
- 同値そのもの: $\mathrm{mult}_w(f)\ge1\Leftrightarrow\mathrm{aev}_w(f)=0$。

$w$ は $0,\pm1,\tfrac23,\zeta_3,\sqrt2$、$f$ は定数・3 次・4 次（$\zeta_5$ 係数）・2 つの一次因子の積・
$3t$・重複度 3 の因子を持つもの・重複度 2 の因子を持つものの 7 個。
重複度は $\{k\mid(t-\widehat w)^k\mid f\}$（$k\le n_f$）の最大元として計算する。

```sh
sage sagemath/check/qbar-root-multiplicity-ge-one-iff-root/check.sage
```

**2026-08-17 実行: すべて通過。**
