# SageMath Check: 判別式だけでは多項式を決めない

**対象ラベル**: `claim_discriminant_does_not_determine_polynomial`

本文の反例（$A(X)=X^2-X$ と $B(X)=X^2+X$）の証明の各段を、$\mathbb Z$・$\mathbb Z[X]$ の
厳密計算で確認する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| 一次係数が $-1$ と $1$ なので $A(X)\ne B(X)$ | `ZZ[X]` の係数比較 | PASS |
| 分配法則による因数分解 $A(X)=X(X-1)$、$B(X)=X(X+1)$ と、各積の一次因子が相異なること | `ZZ[X]` の等式比較 | PASS |
| どちらも重複因子を持たず、square-free 部分が多項式自身であること | `is_squarefree()` と `radical()` | PASS |
| 判別式 $b^2-4ac$ の計算で $\operatorname{disc}(A)=\operatorname{disc}(B)=1$ | 整数の四則演算。Sage の `discriminant()`（終結式由来）とも一致することを独立な校正として確認 | PASS |
| 相異なる二つの多項式が同じ判別式を持つこと | 上の段の合成 | PASS |

すべて `ZZ`・`ZZ[X]` の厳密計算であり、浮動小数点、実対数、指数関数、無限和は使わない。

```sh
sage sagemath/check/discriminant-counterexample/check.sage
```

**2026-08-15 実行: すべて通過。**
