# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 正因子を掛けた比較：D の定義
# 式: (a * a - 2 * (u * u)) * (2 * (up * up)) = D * (2 * (up * up))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = (a * a - 2 * (u * u)) * (2 * (up * up))
rhs = D * (2 * (up * up))
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
