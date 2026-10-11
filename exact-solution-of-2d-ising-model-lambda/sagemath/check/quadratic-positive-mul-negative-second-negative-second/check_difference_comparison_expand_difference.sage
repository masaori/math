# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 正因子を掛けた比較：分配則
# 式: (a * a - 2 * (u * u)) * (ap * ap) = (a * a) * (ap * ap) - (2 * (u * u)) * (ap * ap)
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = (a * a - 2 * (u * u)) * (ap * ap)
rhs = (a * a) * (ap * ap) - (2 * (u * u)) * (ap * ap)
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
