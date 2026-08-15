# SageMath Check: 有理係数の対数順序群の元は共通分母を持つ

## 対象

**対象ラベル**: `claim_common_denominator_exists`

- 実行日: 2026-08-16
- 状態: PASS（10000 ベクトル。素数 $2,3,5,7$、係数 10 種）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5,7$ の各係数を $-\tfrac56,-1,-\tfrac12,0,\tfrac13,\tfrac12,1,\tfrac32,\tfrac74,5$ から選ぶ
有限台の有理係数ベクトル $\lambda\in\Lambda_{\mathbb Q}$（零写像を含む）について、非零値の既約分母の積
$N_\lambda$ が $1$ 以上であること、各 $p\in S_\lambda$ で $\operatorname{den}(\lambda(p))$ が $N_\lambda$ を
割ること、主張の場合分けで定めた $\nu$ が有限台の整数値で台が $S_\lambda$ に含まれること、証明の鎖の各段
$N_\lambda\lambda(p)=(N_\lambda/d)(d\,\lambda(p))=(N_\lambda/d)\,a=\nu(p)$ と、
$N_\lambda\cdot\lambda=\iota(\nu)$（各素数での値の等号）を検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/common-denominator-exists/check.sage
```
