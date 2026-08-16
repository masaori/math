# SageMath Check: 対数順序群から有理係数の対数順序群への写像は整数倍と交換する

## 対象

**対象ラベル**: `claim_rational_embedding_commutes_with_integer_multiple`

- 実行日: 2026-08-16
- 状態: PASS（247 件）
- 帰属: `ZZ`・`QQ` と有限台辞書による厳密計算。浮動小数点は使わない。

## 検査内容

整数 $n\in\{-6,\dots,6\}$ と有限台指数ベクトル 5 組について、$n\cdot\iota(\nu)=\iota(n\nu)$
（左辺は $\Lambda_{\mathbb Q}$ の有理数倍、右辺は $\Lambda$ の整数倍を $\iota$ で移したもの）を全件検査し、
各素数での値の五段の鎖（有理数倍の定義・$\iota$ の定義・分母 1 の積・整数倍の定義・$\iota$ の定義）を段ごとに確かめる。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-embedding-commutes-with-integer-multiple/check.sage
```
