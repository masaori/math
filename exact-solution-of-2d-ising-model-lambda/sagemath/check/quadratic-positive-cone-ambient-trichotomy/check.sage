# 対象ラベル: claim_quadratic_positive_cone_ambient_trichotomy
# QQbar への包含が元の値と符号反転を保つことを、厳密な標本で確かめる。
from sage.all import QQ, QQbar

s = QQbar(2).sqrt()
assert s * s == QQbar(2)

def positive(a, b):
    return ((a >= 0 and b >= 0 and (a, b) != (0, 0))
            or (a > 0 and b < 0 and 2 * b * b < a * a)
            or (a < 0 and b > 0 and a * a < 2 * b * b))

samples = [QQ(k) / d for k in range(-5, 6) for d in (1, 2, 3)]
checked = 0
for a in samples:
    for b in samples:
        z = QQbar(a) + QQbar(b) * s
        assert -z == QQbar(-a) + QQbar(-b) * s
        cases = (z == 0, positive(a, b), positive(-a, -b))
        assert sum(cases) == 1
        assert (z == 0) == (a == 0 and b == 0)
        checked += 1
print(f"RESULT: PASS ({checked} rational coefficient pairs)")
