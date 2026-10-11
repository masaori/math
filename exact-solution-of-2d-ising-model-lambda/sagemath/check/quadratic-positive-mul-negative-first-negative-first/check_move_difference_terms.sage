# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 比較の移項: \ \text{上の比較の移項}
# 式ペア: (2*(b* b))*(cp* cp)+(c* c)*(2*(bp* bp)) < (2*(b* b))*(2*(bp* bp))+(c* c)*(cp* cp)
# 帰属: QQ の有限標本。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
checked = 0
for c, b, cp, bp, a, ap, A, B, V, D in rational_cases():
    lhs = (2*(b* b))*(cp* cp)+(c* c)*(2*(bp* bp))
    rhs = (2*(b* b))*(2*(bp* bp))+(c* c)*(cp* cp)
    assert lhs < rhs, (c, b, cp, bp, lhs, rhs)
    checked += 1
assert checked == 99856
print(f'RESULT: PASS ({checked} rational coefficient pairs)')
