# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 正因子を掛けた比較：正因子 D を掛ける
# 式: D * (2 * (up * up)) < D * (ap * ap)
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
checked = 0
for a,u,ap,up,b,bp,A,B,V,D in rational_cases():
    assert (D * (2 * (up * up))) < (D * (ap * ap))
    checked += 1
assert checked == 45369
print(f'RESULT: PASS ({checked} rational coefficient pairs)')
