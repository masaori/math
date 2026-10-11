# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第一入力の平方比較: \ \text{積の結合則}
# 式ペア: (2* b)* b = 2*(b* b)
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = (2* b)* b
rhs = 2*(b* b)
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
