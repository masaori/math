# SageMath Check: 有理係数の対数順序群の逆元は順序を反転する

## 対象

**対象ラベル**: `claim_rational_log_order_group_neg_reverses_order`

- 実行日: 2026-08-17
- 状態: PASS（125 ベクトル、$\lambda\le\mu$ を満たす二元の組 7875 件、満たさない組 7750 件。10 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-1,-\tfrac12,0,\tfrac13,\tfrac34$ から選ぶ有限台の有理係数ベクトル
$\lambda,\mu\in\Lambda_{\mathbb Q}$（零写像を含む）について、`def_rational_log_order_group_order` の決定手続き
$N_\mu\lambda_{N_\lambda}\le_\Lambda N_\lambda\mu_{N_\mu}$ で $\le_{\Lambda_{\mathbb Q}}$ を計算し、
$\lambda\le_{\Lambda_{\mathbb Q}}\mu$ を満たすすべての組で $-\mu\le_{\Lambda_{\mathbb Q}}-\lambda$ を検査する
（満たさない組では $-\mu\not\le_{\Lambda_{\mathbb Q}}-\lambda$ も検査する。線形順序なので同値）。
さらに証明の中身を段ごとに検査する: $\nu:=(-\lambda)+(-\mu)$ を両辺に足した
$\lambda+\nu\le_{\Lambda_{\mathbb Q}}\mu+\nu$（`claim_rational_log_order_group_add_monotone`）、
左辺の三段 $\lambda+((-\lambda)+(-\mu))=(\lambda+(-\lambda))+(-\mu)=0+(-\mu)=-\mu$、
右辺の四段 $\mu+((-\lambda)+(-\mu))=\mu+((-\mu)+(-\lambda))=(\mu+(-\mu))+(-\lambda)=0+(-\lambda)=-\lambda$、
そして整えた両辺の比較が主張そのものであること。
逆元・加法は `def_rational_log_order_group` のとおり素数ごとに計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-neg-reverses-order/check.sage
```
