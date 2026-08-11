# SageMath Check: 代入は不定元の冪を代数的数の冪へ写す

## 対象

**対象ラベル**: `claim_qbar_evaluation_indeterminate_pow`（structured-latex 側の安定識別子）

- 本文: 章「固有値の代数性」の主張「代入は不定元の冪を代数的数の冪へ写す」
- 併せて引く定義: `def_qbar_polynomial_ring`、`def_qbar_poly_evaluation`、`def_root_of_unity_set`

### 何を確定させるための検証か

因数定理へ向けて、多項式の値を係数の有限和へ開くときに
$\mathrm{aev}_{w}(t^{\,k})$ を $w^{\,k}$ へ書き換える。本検証は、その書き換えだけを見る。
値の有限和表示と因数定理そのものは扱わない。

確かめるのは次の三つである。

1. 出発点 $\mathrm{aev}_{w}(t^0)=\mathrm{aev}_{w}(1)=1=w^0$ の三段。
2. 一歩 $\mathrm{aev}_{w}(t^{n+1})=\mathrm{aev}_{w}(t^nt)=\mathrm{aev}_{w}(t^n)\mathrm{aev}_{w}(t)=w^nw=w^{n+1}$ の五段。
3. 主張 $\mathrm{aev}_{w}(t^n)=w^n$。

二つの冪は定義どおりの反復で作る。計算はすべて `PolynomialRing(QQbar)` の厳密計算であり、
浮動小数点は使わない。

## 実行

```sh
sage sagemath/check/qbar-evaluation-indeterminate-pow/check.sage
```

## 結果

**2026-08-11 実行: すべて通過。**

```
1. 出発点（aev_w(t^0) = aev_w(1) = 1 = w^0）
   通過（標本 9 個）
2. 一歩（aev_w(t^{n+1}) = aev_w(t^n t) = aev_w(t^n)aev_w(t) = w^n w = w^{n+1}）
   通過（標本 9 個、n = 0,...,6）
3. 主張そのもの（aev_w(t^n) = w^n）
   通過（標本 9 個、n = 0,...,6）
すべて通過
```
