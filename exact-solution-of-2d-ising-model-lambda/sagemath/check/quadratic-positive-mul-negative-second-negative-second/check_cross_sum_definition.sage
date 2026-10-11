# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# V\text{ の定義}
# 式: a * up + u * ap = V
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = a * up + u * ap
rhs = V
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
