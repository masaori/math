# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 定義の形での平方比較: \ \text{上で示した平方の比較}
# 式ペア: 2*(B* B) < A* A
# 帰属: QQ の有限標本。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
checked = 0
for c, b, cp, bp, a, ap, A, B, V, D in rational_cases():
    lhs = 2*(B* B)
    rhs = A* A
    assert lhs < rhs, (c, b, cp, bp, lhs, rhs)
    checked += 1
assert checked == 99856
print(f'RESULT: PASS ({checked} rational coefficient pairs)')
