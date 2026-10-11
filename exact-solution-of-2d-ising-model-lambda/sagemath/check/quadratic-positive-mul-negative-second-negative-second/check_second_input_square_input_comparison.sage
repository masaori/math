# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 入力の平方比較：INPUT
# 式: 2 * (bp * bp) < ap * ap
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
checked = 0
for a,u,ap,up,b,bp,A,B,V,D in rational_cases():
    assert (2 * (bp * bp)) < (ap * ap)
    checked += 1
assert checked == 45369
print(f'RESULT: PASS ({checked} rational coefficient pairs)')
