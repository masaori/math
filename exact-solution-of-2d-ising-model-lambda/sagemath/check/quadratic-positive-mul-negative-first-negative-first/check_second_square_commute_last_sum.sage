# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第二係数の平方からの比較: \ \text{和の可換則}
# 式ペア: (c * c) * (2 * (bp * bp)) + (4 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (cp * cp)) = (c * c) * (2 * (bp * bp)) + ((2 * (b * b)) * (cp * cp) + 4 * ((c * cp) * (b * bp)))
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = (c * c) * (2 * (bp * bp)) + (4 * ((c * cp) * (b * bp)) + (2 * (b * b)) * (cp * cp))
rhs = (c * c) * (2 * (bp * bp)) + ((2 * (b * b)) * (cp * cp) + 4 * ((c * cp) * (b * bp)))
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
