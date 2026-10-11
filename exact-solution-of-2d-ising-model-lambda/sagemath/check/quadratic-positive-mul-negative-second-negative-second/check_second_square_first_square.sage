# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第二係数の平方から第一係数の平方への比較：第一係数の平方の展開
# 式: (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) + 4 * ((a * ap) * (u * up)) = A * A
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) + 4 * ((a * ap) * (u * up))
rhs = A * A
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
