# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# \text{第二係数の表示}
# 式: B = -V
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = B
rhs = -V
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
