# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 正因子による比較: \ D\text{ の定義}
# 式ペア: D*(2*(bp* bp)) = (2*(b* b)-c* c)*(2*(bp* bp))
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = D*(2*(bp* bp))
rhs = (2*(b* b)-c* c)*(2*(bp* bp))
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
