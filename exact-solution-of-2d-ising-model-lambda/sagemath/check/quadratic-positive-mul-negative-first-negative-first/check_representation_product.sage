# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 積の表示: \ A,B\text{ の定義}
# 式ペア: (a*ap+2*(b*bp), a*bp+b*ap) = (A,B)
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = (a*ap+2*(b*bp), a*bp+b*ap)
rhs = (A,B)
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
