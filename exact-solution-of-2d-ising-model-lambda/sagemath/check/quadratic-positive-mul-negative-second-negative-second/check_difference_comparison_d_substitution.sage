# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 正因子を掛けた比較：D の定義
# 式: D * (ap * ap) = (a * a - 2 * (u * u)) * (ap * ap)
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = D * (ap * ap)
rhs = (a * a - 2 * (u * u)) * (ap * ap)
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
