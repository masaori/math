# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# \text{上の比較の移項}
# 式: (a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap) < (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up))
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
checked = 0
for a,u,ap,up,b,bp,A,B,V,D in rational_cases():
    assert ((a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap)) < ((a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)))
    checked += 1
assert checked == 45369
print(f'RESULT: PASS ({checked} rational coefficient pairs)')
