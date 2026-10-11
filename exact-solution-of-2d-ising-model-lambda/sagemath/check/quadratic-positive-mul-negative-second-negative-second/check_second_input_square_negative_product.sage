# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 入力の平方比較：負号どうしの積
# 式: 2 * ((-bp) * (-bp)) = 2 * (bp * bp)
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = 2 * ((-bp) * (-bp))
rhs = 2 * (bp * bp)
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
