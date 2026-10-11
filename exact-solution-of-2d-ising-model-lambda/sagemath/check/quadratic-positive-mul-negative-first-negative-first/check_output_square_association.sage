# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 定義の形での平方比較: \ \text{積の結合則}
# 式ペア: (2* B)* B = 2*(B* B)
# 帰属: QQ 上の多項式環。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
lhs = (2* B)* B
rhs = 2*(B* B)
assert lhs == rhs, (lhs, rhs)
print('RESULT: PASS (QQ polynomial identity)')
