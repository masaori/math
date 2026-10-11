# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第二係数の表示：和の負号
# 式: -(a * up) + -(u * ap) = -(a * up + u * ap)
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = -(a * up) + -(u * ap)
rhs = -(a * up + u * ap)
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
