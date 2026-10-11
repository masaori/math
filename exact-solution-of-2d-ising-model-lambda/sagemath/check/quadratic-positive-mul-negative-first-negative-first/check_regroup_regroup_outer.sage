# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 四因子の並べ替え: \ \text{積の結合則}
# 式ペア: p * (r * (q * t)) = (p * r) * (q * t)
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = p * (r * (q * t))
rhs = (p * r) * (q * t)
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
