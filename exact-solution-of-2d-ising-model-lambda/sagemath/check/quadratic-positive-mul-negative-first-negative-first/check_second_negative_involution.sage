# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 入力係数の符号: \ \text{加法逆元の二重適用}
# 式ペア: ap = -cp
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = ap
rhs = -cp
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
