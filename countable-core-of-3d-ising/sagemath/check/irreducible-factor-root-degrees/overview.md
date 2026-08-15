# SageMath Check: 既約分解から決まる零点の次数

**対象ラベル**: `claim_factorization_type_determines_root_minimal_degrees`

本文の証明の各段を、具体例
$F(X)=6(X^2+1)^2(X^3-2)$ について厳密計算で確認する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $X^2+1$ と $X^3-2$ が原始的で最高次係数が正の相異なる既約因子であること | `ZZ[X]` の content・最高次係数・既約性・等号比較 | PASS |
| 標数 $0$ 上で各因子が重根を持たず、次数個の相異なる零点を持つこと | `is_squarefree()` と `QQbar` 上の厳密な零点 | PASS |
| 各零点の最小多項式次数が所属する既約因子の次数に等しいこと | `QQbar` の零点の `minpoly()` | PASS |
| 因子の指数 $2,1$ が $F$ の零点の代数的重複度になること | `F.roots(QQbar)` の厳密な重複度 | PASS |
| 最小多項式次数の多重集合が $[2,2,2,2,3,3,3]$ になること | 各零点を代数的重複度だけ反復した有限リストの比較 | PASS |

すべて `ZZ`・`ZZ[X]`・`QQbar` の厳密計算であり、浮動小数点、実対数、指数関数、無限和は使わない。

```sh
sage sagemath/check/irreducible-factor-root-degrees/check.sage
```

**2026-08-15 実行: すべて通過。**
