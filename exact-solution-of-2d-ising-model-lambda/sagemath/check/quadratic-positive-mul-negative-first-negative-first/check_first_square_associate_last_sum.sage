# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第一係数の平方展開: \ \text{和の結合則}
# 式ペア: ((c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp))) + (2 * (b * b)) * (2 * (bp * bp)) = (c * c) * (cp * cp) + (4 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (2 * (bp * bp)))
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = ((c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp))) + (2 * (b * b)) * (2 * (bp * bp))
rhs = (c * c) * (cp * cp) + (4 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (2 * (bp * bp)))
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
