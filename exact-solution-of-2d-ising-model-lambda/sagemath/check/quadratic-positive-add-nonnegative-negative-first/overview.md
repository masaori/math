# SageMath Check: 非負係数条件と負の第一係数条件の和

**対象ラベル**: `claim_quadratic_positive_add_nonnegative_negative_first`

## 検証内容

- 非負係数条件と負の第一係数条件を満たす有理係数対について、和の第一係数が非負なら第一条件、負なら第三条件を満たすことを検査する。
- 負の場合は $a'\le a+a'<0$ から平方が増えないこと（中間段 $A\cdot A\le a'\cdot A$、$a'\cdot A\le a'\cdot a'$ を含む）と、$0<b'\le b+b'$ から平方が減らないことを検査する。
- 浮動小数点と実数体は使わない。

## 実行結果

- 2026-08-14: `sage check.sage` 成功。
