# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# \text{加法逆元の二重適用}
# 式: b = -u
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = b
rhs = -u
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
