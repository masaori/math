# SageMath Check: 開境界正方形の自由エントロピー密度は非負である

## 対象

**対象ラベル**: `claim_open_square_free_entropy_density_nonnegative`

- 実行日: 2026-08-16
- 状態: PASS（$L\in\{1,2,3\}$、正の有理点 9 点。準備 16 件、鎖の各行と主張 81 件、合計 97 件）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書の厳密計算。浮動小数点は使わない（主張は $\Lambda_{\mathbb Q}$ で閉じている）。

## 検査内容

$L\in\{1,2,3\}$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備の第一: $Z^{\mathrm{op}}_{L,L}(q)\in\mathbb Q_{>0}$（$\mathbb Z[x]$ の開境界分配多項式への代入が配位ごとの和と一致すること）、$1\le Z^{\mathrm{op}}_{L,L}(q)$。
- 準備の第二: $\log1=0$（$\Lambda$ の零写像。素因数分解が空）。
- 準備の第三: $\frac{1}{L^2}\cdot\iota(0)=0$（$\Lambda_{\mathbb Q}$ の零写像）。各素数での鎖の各段を素数 $2,3,5,7,353$ で。
- $\Lambda$ の鎖: $0=\log1\le_\Lambda\log Z^{\mathrm{op}}_{L,L}(q)$（$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ を通した $\mathbb Q$ の比較）。
- $\Lambda_{\mathbb Q}$ の鎖: $0=\frac{1}{L^2}\cdot\iota(0)\le_{\Lambda_{\mathbb Q}}\frac{1}{L^2}\cdot\iota(\log Z^{\mathrm{op}}_{L,L}(q))=\Psi^{\mathrm{op}}_L(q)$
  （$\le_{\Lambda_{\mathbb Q}}$ は決定手続きで判定。$N=L^2$ が両方の共通分母で証人が $0,\log Z^{\mathrm{op}}_{L,L}(q)$ であること、
  証人の比較と一致すること（順序の移送）も見る）。

周期境界の `finite-free-entropy-density-nonnegative` と同じ検査を、$Z_L(q)$ の代わりに $Z^{\mathrm{op}}_{L,L}(q)$ で行う。
有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## Lean

具体版 `logOrderLE_zero_logRat_openPartitionValueRat`・`rationalLogOrderLE_zero_openScaledFreeEntropy`
（`lean/Ising2DLambda/ThermodynamicLimit/OpenSquareFreeEntropyDensityNonnegative.lean`）、
必要十分版は周期境界の `le_base_transport_of_monotone_necSuf` を共有、導出版
`OpenSquareFreeEntropyDensityNonnegativeFromNecSuf.lean`（2026-08-16）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-free-entropy-density-nonnegative/check.sage
```
