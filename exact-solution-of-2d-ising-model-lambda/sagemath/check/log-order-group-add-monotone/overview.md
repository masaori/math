# SageMath Check: 対数順序群の順序の加法単調性

## 対象

**対象ラベル**: `claim_rational_of_log_additive`, `claim_log_order_group_add_monotone`

- 実行日: 2026-08-15
- 状態: PASS（125 ベクトル、15625 加法対、984375 単調性三つ組）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-2,-1,0,1,2$ から選ぶ有限台指数ベクトルについて、
$\operatorname{rat}_{\Lambda}(\lambda+\nu)=
\operatorname{rat}_{\Lambda}(\lambda)\operatorname{rat}_{\Lambda}(\nu)$ を全ての対で検査する。
さらに $\lambda\le_{\Lambda}\mu$ を満たすすべての組と任意の $\nu$ について、
$\lambda+\nu\le_{\Lambda}\mu+\nu$ を `QQ` の厳密比較で検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/log-order-group-add-monotone/check.sage
```
