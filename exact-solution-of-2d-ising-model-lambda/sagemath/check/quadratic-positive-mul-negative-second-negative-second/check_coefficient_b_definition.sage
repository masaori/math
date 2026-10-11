# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第二係数の表示：B の定義
# 式: B = a * bp + b * ap
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = B
rhs = a * bp + b * ap
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
