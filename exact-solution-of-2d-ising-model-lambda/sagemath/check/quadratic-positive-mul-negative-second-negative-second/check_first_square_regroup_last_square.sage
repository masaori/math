# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第一係数の平方の展開：上の四因子の並べ替え
# 式: ((a * a) * (ap * ap) + (a * ap) * (2 * (u * up))) + ((2 * (u * up)) * (a * ap) + (2 * 2) * ((u * up) * (u * up))) = ((a * a) * (ap * ap) + (a * ap) * (2 * (u * up))) + ((2 * (u * up)) * (a * ap) + (2 * 2) * ((u * u) * (up * up)))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = ((a * a) * (ap * ap) + (a * ap) * (2 * (u * up))) + ((2 * (u * up)) * (a * ap) + (2 * 2) * ((u * up) * (u * up)))
rhs = ((a * a) * (ap * ap) + (a * ap) * (2 * (u * up))) + ((2 * (u * up)) * (a * ap) + (2 * 2) * ((u * u) * (up * up)))
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
