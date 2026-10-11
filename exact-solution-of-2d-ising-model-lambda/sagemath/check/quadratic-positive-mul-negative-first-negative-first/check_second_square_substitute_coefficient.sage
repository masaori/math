# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第二係数の平方からの比較: \ \text{第二係数の表示}
# 式ペア: 2 * (B * B) = 2 * ((-V) * (-V))
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = 2 * (B * B)
rhs = 2 * ((-V) * (-V))
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
