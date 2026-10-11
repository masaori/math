# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第二係数の平方から第一係数の平方への比較：和の結合則
# 式: (a * a) * (2 * (up * up)) + ((2 * (u * u)) * (ap * ap) + 4 * ((a * ap) * (u * up))) = (a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap) + 4 * ((a * ap) * (u * up))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = (a * a) * (2 * (up * up)) + ((2 * (u * u)) * (ap * ap) + 4 * ((a * ap) * (u * up)))
rhs = (a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap) + 4 * ((a * ap) * (u * up))
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
