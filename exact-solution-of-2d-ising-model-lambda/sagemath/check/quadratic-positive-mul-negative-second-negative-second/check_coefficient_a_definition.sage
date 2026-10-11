# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第一係数の表示：A の定義
# 式: A = a * ap + 2 * (b * bp)
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = A
rhs = a * ap + 2 * (b * bp)
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
