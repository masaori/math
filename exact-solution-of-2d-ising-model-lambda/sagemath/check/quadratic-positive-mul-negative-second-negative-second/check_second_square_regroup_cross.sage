# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第二係数の平方から第一係数の平方への比較：上の四因子の並べ替え
# 式: 2 * (((a * a) * (up * up) + (a * u) * (ap * up)) + ((a * u) * (ap * up) + (u * u) * (ap * ap))) = 2 * (((a * a) * (up * up) + (a * ap) * (u * up)) + ((a * ap) * (u * up) + (u * u) * (ap * ap)))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = 2 * (((a * a) * (up * up) + (a * u) * (ap * up)) + ((a * u) * (ap * up) + (u * u) * (ap * ap)))
rhs = 2 * (((a * a) * (up * up) + (a * ap) * (u * up)) + ((a * ap) * (u * up) + (u * u) * (ap * ap)))
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
