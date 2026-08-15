# SageMath Check: 対数順序群の順序は正整数倍で変わらない

## 対象

**対象ラベル**: `claim_log_order_group_positive_multiple_invariant`

- 実行日: 2026-08-15
- 状態: PASS（125 ベクトル、625 冪等式、62500 同値）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-2,-1,0,1,2$ から選ぶ有限台指数ベクトル $\lambda$ と
$N\in\{0,1,2,3,4\}$ について、補助等式
$\operatorname{rat}_{\Lambda}(N\lambda)=(\operatorname{rat}_{\Lambda}(\lambda))^{N}$ を検査する。
さらにすべての対 $\lambda,\mu$ と $N\in\{1,2,3,4\}$ について
$\lambda\le_{\Lambda}\mu\iff N\lambda\le_{\Lambda}N\mu$ を `QQ` の厳密比較で検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/log-order-group-positive-multiple-invariant/check.sage
```
