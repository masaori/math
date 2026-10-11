# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第二係数の表示: \ \text{和の負号}
# 式ペア: -(c* bp)+-(b* cp) = -(c* bp+b* cp)
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = -(c* bp)+-(b* cp)
rhs = -(c* bp+b* cp)
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
