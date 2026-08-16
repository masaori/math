# SageMath Check: 開境界正方形の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義

## 対象

**対象ラベル**: `def_open_square_free_entropy_density`

- 実行日: 2026-08-16
- 状態: PASS（178 検査）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （定義は $\Lambda_{\mathbb Q}$ で閉じており、実数体は現れない）。

## 検査内容

$L\in\{1,2,3\}$ と正の有理数 $q$ 9 点（$1$ 未満・$1$・$1$ 超え）について、
$L^2\ne0$ と $1/L^2\in\mathbb Q$ の確定、$Z^{\mathrm{op}}_{L,L}(q)$ が $\mathbb Z[x]$ の開境界分配多項式への
代入で配位ごとの和と一致し $\mathbb Q_{>0}$ に入ること、$\log Z^{\mathrm{op}}_{L,L}(q)\in\Lambda$
（素因数分解の指数ベクトル）が定まること、$\Psi^{\mathrm{op}}_L(q):=\frac{1}{L^2}\cdot\iota(\log Z^{\mathrm{op}}_{L,L}(q))$
の各素数での値が本文の三段の鎖（有理数倍の定義・$\iota$ の定義・$\mathbb Q$ の積）どおり
$(\log Z^{\mathrm{op}}_{L,L}(q))(p)/L^2$ に等しいこと、台が $\log Z^{\mathrm{op}}_{L,L}(q)$ の台と一致することを検査する。
さらに具体例 $L=2$、$q=1/2$ で $Z^{\mathrm{op}}_{2,2}=2+12x^2+2x^4$、$Z^{\mathrm{op}}_{2,2}(1/2)=41/8$、
$\log Z^{\mathrm{op}}_{2,2}(1/2)=\ell_{41}-3\ell_2$、$\Psi^{\mathrm{op}}_2(1/2)(41)=1/4$、$\Psi^{\mathrm{op}}_2(1/2)(2)=-3/4$ を確かめる。

## 検査できないこと（黙って広げない）

有限標本検査は任意の $L$・$q$ についての定義の性質の証明ではない。一般の各素数での値の鎖は Lean
（`openScaledFreeEntropy_apply`）で検証済み（2026-08-16）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-free-entropy-density/check.sage
```
