# SageMath Check: 有理数の Bernoulli 不等式

## 対象

**対象ラベル**: `claim_rational_bernoulli_inequality`

- 実行日: 2026-08-16
- 状態: PASS（1845 件）
- 帰属: `QQ`・`ZZ` による厳密計算。浮動小数点は使わない。

## 検査内容

$h\in\{0,\tfrac1{10},\tfrac13,\tfrac12,1,\tfrac32,2,\tfrac73,5\}$ と $n\in\{0,\dots,40\}$ について、
主張 $1+nh\le(1+h)^n$ を全件検査し、帰納法の段（$n\to n+1$）の四段
（$0\le nh^2$ を足す・分配則・帰納法の仮定に $0\le1+h$ を掛ける・冪の定義）を段ごとに確かめる。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-bernoulli-inequality/check.sage
```
