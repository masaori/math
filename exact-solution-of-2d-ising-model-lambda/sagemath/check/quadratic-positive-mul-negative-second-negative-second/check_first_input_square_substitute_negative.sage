# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 入力の平方比較：u と u′ の定義
# 式: 2 * (u * u) = 2 * ((-b) * (-b))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = 2 * (u * u)
rhs = 2 * ((-b) * (-b))
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
