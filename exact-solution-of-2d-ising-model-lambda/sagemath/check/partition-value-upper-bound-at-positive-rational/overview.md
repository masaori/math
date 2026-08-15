# SageMath Check: 正の有理点での分配多項式の値の上からの評価

## 対象

**対象ラベル**: `claim_partition_value_upper_bound_at_positive_rational`

- 実行日: 2026-08-16
- 状態: PASS（$L\in\{1,2,3,4\}$、正の有理点 9 点。準備 1251 件（冪の正値性 162・底の単調性 486・指数の単調性 567・定数の有限和 36）、式変形の各行と主張 332 件、合計 1583 件）
- 帰属: `ZZ`/`QQ` の厳密計算。浮動小数点・ball 算術は使わない（主張は $\mathbb Q$ で閉じている）。

## 検査内容

$L\in\{1,2,3,4\}$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備の第一: $0<w$ なら $0<w^k$（$w\in\{q,1+q\}$、$k\le8$）。
- 準備の第二: $0<u\le v$ なら $u^k\le v^k$（$u=q$、$v=1+q$ と標本どうしの順序対、$k\le8$）。
- 準備の第三: $1\le w$ なら $1\le w^k$、$m\le n$ なら $w^m\cdot w^{n-m}=w^n$ と $w^m\le w^n$（$w=1+q$、$m,n\le6$）。
- 準備の第四: $\sum_{s\in\Sigma_L}c=|\Sigma_L|\cdot c$（$c=(1+q)^{2L^2}$）。
- 式変形の各行: $|\Sigma_L|=2^{L^2}$、各 $\sigma$ で $b(\sigma)\le2L^2$、$q\le1+q$、$1\le1+q$、
  $Z_L(q)=\sum_\sigma q^{b(\sigma)}$（全配位から組んだ分配多項式への代入）、$\le\sum_\sigma(1+q)^{b(\sigma)}$、
  $\le\sum_\sigma(1+q)^{2L^2}$、$=|\Sigma_L|\cdot(1+q)^{2L^2}$、$=2^{L^2}\cdot(1+q)^{2L^2}$、そして主張 $Z_L(q)\le2^{L^2}(1+q)^{2L^2}$。

有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/partition-value-upper-bound-at-positive-rational/check.sage
```
