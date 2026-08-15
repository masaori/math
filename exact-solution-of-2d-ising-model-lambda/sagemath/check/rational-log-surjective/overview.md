# SageMath Check: 正の有理数の対数は全射である

## 対象

**対象ラベル**: `claim_rational_log_surjective`

- 実行日: 2026-08-15
- 状態: PASS（625 件）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5,7$ の各係数を $-3,-1,0,1,2$ から選ぶ有限台指数ベクトル $625$ 件について、
$\operatorname{rat}_{\Lambda}(\lambda)$ の有限積、正負の指数を分子・分母へ分けた表示、
素数一個の整数冪、有限積への加法性の反復、最終等式
$\log(\operatorname{rat}_{\Lambda}(\lambda))=\lambda$ を `ZZ`/`QQ` で一段ずつ検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-surjective/check.sage
```
