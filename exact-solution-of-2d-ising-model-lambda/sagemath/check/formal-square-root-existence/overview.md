# 定数項一の形式的平方根は存在する

**対象ラベル**: `claim_formal_square_root_exists`
- 実行: `sage sagemath/check/formal-square-root-existence/check.sage`
- 状態: PASS（2026-08-29）

平方根係数列の再帰（`def_sqrt_coefficient_recursion`）を `QQbar` で打ち切り次数 8 まで実行し、
Cauchy 積の各次係数が `d_n` に一致すること、定数項が 1 であることを厳密検算する。
`D=(1+x)^2` では再帰が `1+x` をそのまま返すことも確認する。浮動小数点は使わない。
