# SageMath Check: 有限系の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義

## 対象

**対象ラベル**: `def_finite_free_entropy_density`

- 実行日: 2026-08-16
- 状態: PASS（72 検査）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない。

## 検査内容

$L\in\{1,2,3\}$ と正の有理数 $q$ 7 点（$1$ 未満・$1$・$1$ 超え）について、
$L^2\ne0$ と $1/L^2\in\mathbb Q$ の確定、$Z_L(q)\in\mathbb Q_{>0}$ から $\Phi_L(q)=\log Z_L(q)\in\Lambda$
（素因数分解の指数ベクトル）が定まること、$\Psi_L(q):=\frac{1}{L^2}\cdot\iota(\Phi_L(q))$ の各素数での値が
本文の三段の鎖（有理数倍の定義・$\iota$ の定義・$\mathbb Q$ の積）どおり $\Phi_L(q)(p)/L^2$ に等しいこと、
台が $\Phi_L(q)$ の台と一致することを検査する。さらに具体例 $L=2$、$q=1/2$ で
$Z_2(1/2)=353/2^7$、$\Phi_2(1/2)=\ell_{353}-7\ell_2$、$\Psi_2(1/2)(353)=1/4$、$\Psi_2(1/2)(2)=-7/4$ を確かめる。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/finite-free-entropy-density/check.sage
```
