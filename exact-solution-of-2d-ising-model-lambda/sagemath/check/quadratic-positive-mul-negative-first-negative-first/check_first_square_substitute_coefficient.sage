# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第一係数の平方展開: \ \text{第一係数の表示}
# 式ペア: A * A = (c * cp + 2 * (b * bp)) * (c * cp + 2 * (b * bp))
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = A * A
rhs = (c * cp + 2 * (b * bp)) * (c * cp + 2 * (b * bp))
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
