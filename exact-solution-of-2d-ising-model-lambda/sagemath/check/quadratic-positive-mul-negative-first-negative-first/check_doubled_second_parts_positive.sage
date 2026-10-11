# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 係数と平方差の符号: \ 0<2,\ 0<b\cdot b'
# 式ペア: 0 < 2 * (b * bp)
# 帰属: QQ の有限標本。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
checked = 0
for c, b, cp, bp, a, ap, A, B, V, D in rational_cases():
    lhs = 0
    rhs = 2 * (b * bp)
    assert lhs < rhs, (c, b, cp, bp, lhs, rhs)
    checked += 1
assert checked == 99856
print(f'RESULT: PASS ({checked} rational coefficient pairs)')
