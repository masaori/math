# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 正因子による比較: \ \text{分配則}
# 式ペア: (2*(b* b))*(cp* cp)-(c* c)*(cp* cp) = (2*(b* b)-c* c)*(cp* cp)
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = (2*(b* b))*(cp* cp)-(c* c)*(cp* cp)
rhs = (2*(b* b)-c* c)*(cp* cp)
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
