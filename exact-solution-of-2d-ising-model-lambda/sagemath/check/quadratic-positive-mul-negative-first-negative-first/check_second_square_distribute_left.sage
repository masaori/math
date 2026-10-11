# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第二係数の平方からの比較: \ \text{分配則}
# 式ペア: 2 * ((c * bp + b * cp) * (c * bp + b * cp)) = 2 * ((c * bp) * (c * bp + b * cp) + (b * cp) * (c * bp + b * cp))
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = 2 * ((c * bp + b * cp) * (c * bp + b * cp))
rhs = 2 * ((c * bp) * (c * bp + b * cp) + (b * cp) * (c * bp + b * cp))
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
