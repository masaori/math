# SageMath Check: 正錐の元の自然数倍は零元または正錐の元である

**対象ラベル**: `claim_quadratic_positive_cone_nat_mul`

本文の場合分けを厳密計算で確認する。$s^2=2$ の二つの根と、正錐の三条件を
覆う四つの表示、零を含む自然数の代表 $c\in\{0,1,2,3,5,7\}$ について、
積 $c\cdot\xi$ の表示が $\overline{\mathbb Q}$ の通常の積に一致し（$Q_s$ への
所属の証人）、$c=0$ では値が零元・表示が $(0,0)$、$1\le c$ では $c$ 自身と積の
表示がともに正錐の条件を満たすことを確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/positive-cone-nat-mul/check.sage
```

**2026-08-18 実行: すべて通過。**
