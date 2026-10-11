# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# D\text{ の定義}
# 式: a * a - 2 * (u * u) = D
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = a * a - 2 * (u * u)
rhs = D
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
