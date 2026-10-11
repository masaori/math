# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 入力係数の符号: \ \text{負数の加法逆元}
# 式ペア: 0 < c
# 帰属: QQ の有限標本。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
checked = 0
for c, b, cp, bp, a, ap, A, B, V, D in rational_cases():
    lhs = 0
    rhs = c
    assert lhs < rhs, (c, b, cp, bp, lhs, rhs)
    checked += 1
assert checked == 99856
print(f'RESULT: PASS ({checked} rational coefficient pairs)')
