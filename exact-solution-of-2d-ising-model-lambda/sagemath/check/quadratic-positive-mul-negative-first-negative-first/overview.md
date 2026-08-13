# SageMath Check: 負の第一係数条件どうしの積

**対象ラベル**: `claim_quadratic_positive_mul_negative_first_negative_first`

**結果**: PASS（2026-08-14。99856 組）

- 負の第一係数条件を満たす有理数係数の表示 $(a,b)=(-c,b)$ と $(a',b')=(-c',b')$ を列挙し、
  積の表示 $(A,B)=(a\cdot a'+2\cdot(b\cdot b'),\ a\cdot b'+b\cdot a')$ が正錐の
  負の第二係数条件（$0<A$、$B<0$、$2\cdot(B\cdot B)<A\cdot A$）を満たすことを `QQ` で検査する。
- 本文の各段を検査する: 代入形 $A=c\cdot c'+2\cdot(b\cdot b')$、$B=-(c\cdot b'+b\cdot c')$、
  正どうしの積の和による $0<A$ と $0<V:=c\cdot b'+b\cdot c'$、
  $D:=2\cdot(b\cdot b)-c\cdot c$ を使う中間比較の鎖
  （$D\cdot(c'\cdot c')<D\cdot(2\cdot(b'\cdot b'))$ と両側の分配則・移項）、
  および $2\cdot(B\cdot B)=2\cdot(V\cdot V)$ から $A\cdot A$ へ至る最終鎖の各行。
- 浮動小数点は使わない。
