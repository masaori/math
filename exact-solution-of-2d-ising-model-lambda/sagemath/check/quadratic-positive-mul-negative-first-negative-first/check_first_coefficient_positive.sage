# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 係数と平方差の符号: \ \text{第一係数の表示}
# 式ペア: c * cp + 2 * (b * bp) = A
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = c * cp + 2 * (b * bp)
rhs = A
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
