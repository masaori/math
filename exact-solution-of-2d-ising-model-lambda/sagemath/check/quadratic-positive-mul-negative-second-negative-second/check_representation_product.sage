# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 積の表示と係数の定義
# 式: (a * ap + 2 * (b * bp), a * bp + b * ap) = (A,B)
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = (a * ap + 2 * (b * bp), a * bp + b * ap)
rhs = (A,B)
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
