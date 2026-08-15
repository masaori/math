# SageMath Check: 有限系の自由エントロピー密度の上からの評価

## 対象

**対象ラベル**: `claim_finite_free_entropy_density_upper_bound`

- 実行日: 2026-08-16
- 状態: PASS（$L\in\{1,2,3\}$、正の有理点 9 点。準備の第二 6 件、各 $(L,q)$ で準備の第一 1 件・準備の第三 2 件・$\Lambda$ の鎖 1 件・$\Lambda_{\mathbb Q}$ の鎖と主張 1 件、合計 141 件）
- 帰属: `ZZ`/`QQ` の厳密計算と素因数分解。浮動小数点は使わない（主張は $\Lambda_{\mathbb Q}$ で閉じている）。

## 検査内容

$L\in\{1,2,3\}$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備の第一: $Z_L(q)\in\mathbb Q_{>0}$、$Z_L(q)\le2^{L^2}(1+q)^{2L^2}$。
- 準備の第二: $\log2=\ell_2$（各素数での四段の鎖 $(\log2)(p)=w_p(2)=v_p(2)-v_p(1)=v_p(2)=\ell_2(p)$）。
- 準備の第三: $n\cdot\iota(\nu)=\iota(n\nu)$（$n=L^2,2L^2$、$\nu=\ell_2,\log(1+q)$）。
- $\Lambda$ の鎖: $\Phi_L(q)=\log Z_L(q)\le_\Lambda\log(2^{L^2}(1+q)^{2L^2})=\log2^{L^2}+\log(1+q)^{2L^2}=L^2\log2+2L^2\log(1+q)=L^2\ell_2+2L^2\log(1+q)$（$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ を通した $\mathbb Q$ の比較）。
- $\Lambda_{\mathbb Q}$ の鎖: $\Psi_L(q)=\frac{1}{L^2}\cdot\iota(\Phi_L(q))\le_{\Lambda_{\mathbb Q}}\frac{1}{L^2}\cdot\iota(L^2\ell_2+2L^2\log(1+q))$（決定手続きで判定し、共通分母 $N=L^2$ での証人の比較 $\Phi_L(q)\le_\Lambda L^2\ell_2+2L^2\log(1+q)$ と一致することも見る）、以下 $\iota$ の加法性・分配則・準備の第三・結合則・約分・$1\cdot\lambda=\lambda$ の各段の等号、そして主張 $\Psi_L(q)\le_{\Lambda_{\mathbb Q}}\iota(\ell_2)+2\cdot\iota(\log(1+q))$。

有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/finite-free-entropy-density-upper-bound/check.sage
```
