# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# \text{第一係数の表示}
# 式: a * ap + 2 * (u * up) = A
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = a * ap + 2 * (u * up)
rhs = A
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
