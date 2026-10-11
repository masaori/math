# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第一係数の表示: \ A\text{ の定義}
# 式ペア: A = a* ap+2*(b* bp)
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = A
rhs = a* ap+2*(b* bp)
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
