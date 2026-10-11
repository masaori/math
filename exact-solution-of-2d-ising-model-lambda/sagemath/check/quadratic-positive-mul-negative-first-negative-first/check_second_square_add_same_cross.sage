# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 第二係数の平方からの比較: \ \text{移項した比較の両辺へ同じ項を加える}
# 式ペア: (2 * (b * b)) * (cp * cp) + (c * c) * (2 * (bp * bp)) + 4 * ((c * cp) * (b * bp)) < (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp))
# 帰属: QQ の有限標本。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
checked = 0
for c, b, cp, bp, a, ap, A, B, V, D in rational_cases():
    lhs = (2 * (b * b)) * (cp * cp) + (c * c) * (2 * (bp * bp)) + 4 * ((c * cp) * (b * bp))
    rhs = (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) + 4 * ((c * cp) * (b * bp))
    assert lhs < rhs, (c, b, cp, bp, lhs, rhs)
    checked += 1
assert checked == 99856
print(f'RESULT: PASS ({checked} rational coefficient pairs)')
