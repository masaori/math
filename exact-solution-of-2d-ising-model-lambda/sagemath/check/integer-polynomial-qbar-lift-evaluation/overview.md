# SageMath Check: 持ち上げの値は整係数多項式の代数的数における値に一致する

## 対象

**対象ラベル**: `claim_integer_polynomial_qbar_lift_evaluation`（structured-latex 側の安定識別子）

- 本文: 章「熱力学極限」の主張「持ち上げの値は整係数多項式の代数的数における値に一致する」
- 併せて引く定義・主張: `def_integer_polynomial_qbar_lift`、`def_qbar_poly_evaluation`、
  `def_qbar_polynomial_evaluation`、`claim_qbar_evaluation_coefficient_sum`

### 何を確定させるための検証か

$\mathcal F_L$ の有限性を $\overline{\mathbb Q}[t]$ の根の個数の上界から出すために、
$\mathbb Z[x]$ の多項式 $f$ の持ち上げ $\widehat f^{\,F}$ の $\xi$ における値が
$\mathrm{Ev}^F_\xi(f)$ に一致すること（$\mathrm{aev}_\xi(\widehat f^{\,F})=\mathrm{Ev}^F_\xi(f)$）を確かめる。

確かめるのは次の三つである。

1. 準備（$n<k$ で $\mathrm{ac}_k(\widehat f^{\,F})=0$、$k\le n$ で $\mathrm{ac}_k(\widehat f^{\,F})=a_k$）。
2. 鎖の 3 段（係数の有限和への展開・係数の読み替え・$\mathrm{Ev}^F$ の定義式）と主張そのもの。
3. 帰結: $Z_L$（$L\le3$）の Fisher 零点で両辺とも $0$。

対象は $Z_L$（$L\le3$）と小さな整係数多項式 5 個、標本 $\xi$ は代数的数 8 個。
計算はすべて `ZZ[x]`・`PolynomialRing(QQbar)`・`QQbar` の厳密計算であり、浮動小数点は使わない。

## 実行

```sh
sage sagemath/check/integer-polynomial-qbar-lift-evaluation/check.sage
```

## 結果

**2026-08-17 実行: すべて通過。**

```
claim_integer_polynomial_qbar_lift_evaluation: 多項式 8 個 × 標本 8 個 = 64 検査、Fisher 零点 20 個で両辺 0。すべて通過
```
