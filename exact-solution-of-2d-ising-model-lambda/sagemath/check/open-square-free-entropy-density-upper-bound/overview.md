# SageMath Check: 開境界正方形の自由エントロピー密度の上からの評価

## 対象

**対象ラベル**: `claim_open_square_free_entropy_density_upper_bound`

- 実行日: 2026-08-16
- 状態: PASS（$L\in\{1,2,3\}$、正の有理点 9 点。準備の第二 6 件、各 $(L,q)$ で準備の第一 1 件・第三 2 件・$\Lambda$ の鎖 1 件・$\Lambda_{\mathbb Q}$ の鎖 1 件、合計 141 件）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書の厳密計算。浮動小数点は使わない（主張は $\Lambda_{\mathbb Q}$ で閉じている）。

## 検査内容

$L\in\{1,2,3\}$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備の第一: $Z^{\mathrm{op}}_{L,L}(q)\in\mathbb Q_{>0}$（$\mathbb Z[x]$ の開境界分配多項式への代入が配位ごとの和と一致すること）、
  $Z^{\mathrm{op}}_{L,L}(q)\le2^{L^2}(1+q)^{2L^2}$。
- 準備の第二: $\log2=\ell_2$（各素数での四段の鎖を素数 $2,3,5,7,11,353$ で）。
- 準備の第三: $n\cdot\iota(\nu)=\iota(n\nu)$（$n=L^2,2L^2$、$\nu=\ell_2,\log(1+q)$）。
- $\Lambda$ の鎖: $\log Z^{\mathrm{op}}_{L,L}(q)\le_\Lambda\log(2^{L^2}(1+q)^{2L^2})=\log2^{L^2}+\log(1+q)^{2L^2}=L^2\log2+2L^2\log(1+q)=L^2\ell_2+2L^2\log(1+q)$
  （$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ を通した $\mathbb Q$ の比較）。
- $\Lambda_{\mathbb Q}$ の鎖: $\Psi^{\mathrm{op}}_L(q)=\frac{1}{L^2}\cdot\iota(\log Z^{\mathrm{op}}_{L,L}(q))\le_{\Lambda_{\mathbb Q}}\frac{1}{L^2}\cdot\iota(L^2\ell_2+2L^2\log(1+q))$、
  以下 $\iota$ の加法性・分配則・準備の第三・結合則・約分・$1\cdot\lambda=\lambda$ の各段、そして主張
  $\Psi^{\mathrm{op}}_L(q)\le_{\Lambda_{\mathbb Q}}\iota(\ell_2)+2\cdot\iota(\log(1+q))$
  （$\le_{\Lambda_{\mathbb Q}}$ は決定手続きで判定。$N=L^2$ が共通分母で証人が $\log Z^{\mathrm{op}}_{L,L}(q)$ と $L^2\ell_2+2L^2\log(1+q)$ であること、
  証人の比較と一致すること（順序の移送）も見る）。

周期境界の `finite-free-entropy-density-upper-bound` と同じ検査を、$Z_L(q)$ の代わりに $Z^{\mathrm{op}}_{L,L}(q)$ で行う。
有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## Lean

具体版 `logOrderLE_logRat_openPartitionValueRat_upperBound`・`rationalLogOrderLE_openScaledFreeEntropy_upperBound`
（`lean/Ising2DLambda/ThermodynamicLimit/OpenSquareFreeEntropyDensityUpperBound.lean`。周期境界の
`logRat_upperBound_eq`・`scaled_toRational_upperBound_eq` を共有）、
必要十分版は周期境界の `upperBound_transport_through_two_monotone_maps_necSuf` を共有、導出版
`rationalLogOrderLE_openScaledFreeEntropy_upperBound_from_necSuf`（`OpenSquareFreeEntropyDensityUpperBoundFromNecSuf.lean`）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-free-entropy-density-upper-bound/check.sage
```
