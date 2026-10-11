# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第二入力の平方比較: \ c'\text{ の定義}
# 式ペア: cp* cp = (-ap)*(-ap)
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = cp* cp
rhs = (-ap)*(-ap)
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
