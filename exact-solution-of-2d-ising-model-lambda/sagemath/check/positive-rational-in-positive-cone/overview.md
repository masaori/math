# SageMath Check: 正の有理数は正錐の元である

**対象ラベル**: `claim_positive_rational_in_positive_cone`

本文の証明の各段を厳密計算で確認する。浮動小数点は使わない。

- 所属の鎖 $q=q+0=q+0\cdot s$（加法単位元と零元の乗法）。
- 表示の証人 $(q,0)$ が実際に $q$ を表し、別の組は表さないこと。
- 正錐の第一条件（$0\le q$、$0\le0$、$(q,0)\ne(0,0)$）が $\mathbb{Q}$ の順序で成り立つこと。
- 非空虚性: $q=0$ と負の有理数は三条件のどれも満たさないこと。

$s\cdot s=2$ の解 2 つの両方で検査する（主張は「任意の $s$」について）。

```sh
sage sagemath/check/positive-rational-in-positive-cone/check.sage
```

**2026-08-18 実行: すべて通過。**
