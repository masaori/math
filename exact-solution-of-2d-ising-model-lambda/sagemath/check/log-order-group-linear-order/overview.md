# SageMath Check: 対数順序群の順序は線形順序である

## 対象

**対象ラベル**: `claim_log_order_group_linear_order`（定義 `def_log_order_group_order` の判定手続きも含む）

- 実行日: 2026-08-15
- 状態: PASS（125 ベクトル、15625 対、333375 推移三つ組）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-2,-1,0,1,2$ から選ぶ有限台指数ベクトル $125$ 件について、
$\lambda\le_\Lambda\mu:\iff\operatorname{rat}_\Lambda(\lambda)\le\operatorname{rat}_\Lambda(\mu)$
を `QQ` の比較で判定し、反射律・全順序性を各対で、反対称律を両向きの対について
（`QQ` の等号から $\log$ で $\Lambda$ の等号へ戻す一段を含めて）、推移律を各三つ組で検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/log-order-group-linear-order/check.sage
```
