# SageMath Check: 正の有理数の対数は順序を保ちかつ反映する

## 対象

**対象ラベル**: `claim_rational_log_order_iff`

- 実行日: 2026-08-16
- 状態: PASS（625 個の正の有理数、625 恒等式、390625 同値）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5,7$ の指数を $-2,-1,0,1,2$ から選んで作る正の有理数 $q$（625 個。$1$ を含む）について、
補助等式の手前の $\log(\operatorname{rat}_{\Lambda}(\log q))=\log q$ と補助等式
$\operatorname{rat}_{\Lambda}(\log q)=q$ を検査する。さらにすべての対 $q,q'$ について、同値の鎖の各段
（$\log q\le_{\Lambda}\log q'\iff\operatorname{rat}_{\Lambda}(\log q)\le\operatorname{rat}_{\Lambda}(\log q')$、
$\iff q\le q'$）と主張 $q\le q'\iff\log q\le_{\Lambda}\log q'$ を `QQ` の厳密比較で検査する。
$\log$ は `QQ` の素因数分解の指数ベクトル、$\operatorname{rat}_{\Lambda}$ はその素数冪の積である。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-iff/check.sage
```
