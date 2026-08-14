# SageMath Check: 二つの混合符号条件の積

**対象ラベル**: `claim_quadratic_positive_mul_mixed_signs`

**結果**: PASS（2026-08-14。67308 組）

- 負の第二係数条件を満たす有理数係数の表示 $(a,b)=(a,-u)$ と、負の第一係数条件を満たす表示
  $(a',b')=(-c',b')$ を列挙し、積の表示 $(A,B)=(a\cdot a'+2\cdot(b\cdot b'),\ a\cdot b'+b\cdot a')$
  が正錐の負の第一係数条件（$A<0$、$0<B$、$A\cdot A<2\cdot(B\cdot B)$）を満たすことを `QQ` で検査する。
- 本文の各段を検査する: 代入形 $A=-(a\cdot c'+2\cdot(u\cdot b'))$、$B=a\cdot b'+u\cdot c'$、
  正どうしの積の和による $0<C:=a\cdot c'+2\cdot(u\cdot b')$（したがって $A<0$）と $0<B$、
  $D:=a\cdot a-2\cdot(u\cdot u)$ を使う中間比較の鎖
  （$D\cdot(c'\cdot c')<D\cdot(2\cdot(b'\cdot b'))$ と両側の分配則・移項）、
  および $A\cdot A=C\cdot C$ から $2\cdot(B\cdot B)$ へ至る最終鎖の各行。
- 浮動小数点は使わない。
