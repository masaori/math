# 定数項一の形式的平方根は一意である

**対象ラベル**: `claim_formal_square_root_unique`
- 実行: `sage sagemath/check/formal-square-root-uniqueness/check.sage`
- 状態: PASS（2026-08-29）

係数を `QQbar` に固定し、定数項が一の有限多項式を形式的冪級数の有限標本として使う。本文の
因数分解、同じ平方を持つこと、定数項一の分岐では一致することを厳密計算する。反対分岐
`T=-S` は平方が同じでも定数項が負一になり、仮定から外れることも検査する。浮動小数点は使わない。
