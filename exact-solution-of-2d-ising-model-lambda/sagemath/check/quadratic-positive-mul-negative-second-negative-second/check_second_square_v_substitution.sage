# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 第二係数の平方から第一係数の平方への比較：V の定義
# 式: 2 * (V * V) = 2 * ((a * up + u * ap) * (a * up + u * ap))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = 2 * (V * V)
rhs = 2 * ((a * up + u * ap) * (a * up + u * ap))
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
