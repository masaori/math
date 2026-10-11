# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第一係数の平方の展開：第一係数の表示
# 式: A * A = (a * ap + 2 * (u * up)) * (a * ap + 2 * (u * up))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = A * A
rhs = (a * ap + 2 * (u * up)) * (a * ap + 2 * (u * up))
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
