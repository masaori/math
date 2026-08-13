# SageMath Check: 非負係数条件と負の第二係数条件の積

**対象ラベル**: `claim_quadratic_positive_mul_nonnegative_negative_second`

**結果**: PASS（2026-08-14。実行時の組数と場合の件数は `check.sage` の出力に記録）

- 非負かつ非零な有理数係数の組 $(a,b)$ と、負の第二係数条件を満たす組 $(a',b')=(a',-u)$ を列挙し、
  積の表示 $(A,B)=(a\cdot a'+2\cdot(b\cdot b'),\ a\cdot b'+b\cdot a')$ が正錐の三条件のいずれかを
  満たすことを `QQ` で検査する。
- 本文の二つの場合（$2\cdot(b\cdot b)<a\cdot a$ と $a\cdot a<2\cdot(b\cdot b)$）ごとに、
  片係数の正値を導く背理法の平方の鎖、線形比較の鎖（$a'\cdot V\le u\cdot A$、
  $a'\cdot C\le(2\cdot u)\cdot B$）、平方の鎖の各段を検査する。
- 混合符号の排除（$a\cdot a\ne2\cdot(b\cdot b)$）も同じ標本で検査する。
- 浮動小数点は使わない。
