# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 四因子の並べ替え：積の結合則
# 式: (p * q) * (r * t) = p * (q * (r * t))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
lhs = (p * q) * (r * t)
rhs = p * (q * (r * t))
assert lhs == rhs, (lhs,rhs)
print('RESULT: PASS (QQ polynomial identity)')
