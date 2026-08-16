# SageMath Check: 実現写像は有理数倍と可換である

## 対象

**対象ラベル**: `claim_rational_log_order_group_realization_smul`

- 実行日: 2026-08-17
- 状態: PASS（344 標本 × 7 有理数倍、18235 検査。1 秒未満）
- 帰属: `QQ` 上の多項式環による厳密計算。不定元 $\ell_p$ は素数 $p$ の実対数 $\log_{\mathbb R}(\iota_{\mathbb Q\to\mathbb R}(p))$ を
  表す**記号**であり、実対数の値は計算しない（主張の証明も実対数の性質を一切使わないので、記号のままで
  等式が確かめられる）。浮動小数点は使わない。

## 検査内容

`claim_rational_log_order_group_realization_smul` の一続き六段
$\rho_{\mathbb R}(r\cdot\mu)=\sum_{p\in\operatorname{supp}(r\mu)}\cdots=\sum_{p\in\operatorname{supp}\mu}\cdots=\cdots=\iota(r)\rho_{\mathbb R}(\mu)$
のうち、記号 $\ell_p$ のままで確かめられる部分を検査する。

- 二段目の前提 $\operatorname{supp}(r\cdot\mu)\subset\operatorname{supp}(\mu)$。
- 一段目と二段目の値の一致（台に渡る和と $\operatorname{supp}(\mu)$ に渡る和）。
- 三段目 $(r\cdot\mu)(p)=r\,\mu(p)$ を各 $p\in\operatorname{supp}(\mu)$ で。
- 三段目から六段目の値の一致（$\mathbb Q[\ell_2,\dots]$ の中で $\sum r\mu(p)\ell_p=r\sum\mu(p)\ell_p$）。
- 結論 $\rho_{\mathbb R}(r\cdot\mu)=r\cdot\rho_{\mathbb R}(\mu)$。

標本は、台が $\{2,3,5\}$ の部分集合で係数が $\{0,\pm1,2,\tfrac12,-\tfrac34,\tfrac73\}$ の 343 個と、
台 $\{2,7,11\}$ の 1 個。有理数倍 $r\in\{0,\pm1,3,\tfrac12,-\tfrac25,\tfrac97\}$（$r=0$ で台が空になる場合を含む）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-realization-smul/check.sage
```
