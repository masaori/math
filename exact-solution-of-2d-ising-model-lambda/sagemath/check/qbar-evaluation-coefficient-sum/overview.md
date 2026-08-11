# SageMath Check: 多項式の値は係数の有限和で書ける

## 対象

**対象ラベル**: `claim_qbar_evaluation_coefficient_sum`（structured-latex 側の安定識別子）

- 本文: 章「固有値の代数性」の主張「多項式の値は係数の有限和で書ける」
- 併せて引く定義・主張: `def_qbar_poly_evaluation`、`claim_qbar_poly_monomial_decomposition`、
  `claim_qbar_evaluation_indeterminate_pow`

### 何を確定させるための検証か

因数定理へ向けた組み立ての段である。$\mathrm{aev}_{w}$ の定義の和は係数が零でない項だけを
走るが、この主張の右辺は $0$ から $n$ までのすべての $k$ を走る。この 2 つが等しいこと
（$\mathrm{aev}_{w}(f)=\sum_{k=0}^{n}\mathrm{ac}_k(f)\,w^{\,k}$）を確かめる。

確かめるのは次の二つである。

1. 鎖の 5 段（単項式の有限和への分解・和を保つこと・積を保つこと・
   $\mathrm{aev}_{w}(\widehat{a})=a$・$\mathrm{aev}_{w}(t^{\,k})=w^{\,k}$）。
2. 主張そのもの。$n$ を最小の取り方より大きく取っても成り立つこと（余分な項は零元）。

計算はすべて `PolynomialRing(QQbar)` の厳密計算であり、浮動小数点は使わない。

## 実行

```sh
sage sagemath/check/qbar-evaluation-coefficient-sum/check.sage
```

## 結果

**2026-08-11 実行: すべて通過。**

```
1. 鎖の各段
   通過（多項式 8 個 × 標本 9 個）
2. 主張そのもの（aev_w(f) = sum_{k=0}^{n} ac_k(f) w^k。n を最小より大きく取っても同じ）
   通過（多項式 8 個 × 標本 9 個 × n は最小・+1・+2）
すべて通過
```
