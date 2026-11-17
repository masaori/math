# 対象ラベル: claim_quadratic_positive_cone_is_subfield_positive_cone
from sage.all import QQ, QQbar

s = QQbar(2).sqrt()
assert s * s == QQbar(2)

def positive(a, b):
    return ((a >= 0 and b >= 0 and (a, b) != (0, 0))
            or (a > 0 and b < 0 and 2 * b * b < a * a)
            or (a < 0 and b > 0 and a * a < 2 * b * b))

samples = sorted({QQ(k) / d for k in range(-3, 4) for d in (1, 2)})
positive_pairs = []
for a in samples:
    for b in samples:
        z = QQbar(a) + QQbar(b) * s
        assert sum((z == 0, positive(a, b), positive(-a, -b))) == 1
        if positive(a, b):
            positive_pairs.append((a, b, z))

checked = 0
for a, b, x in positive_pairs:
    for c, d, y in positive_pairs:
        assert x + y == QQbar(a + c) + QQbar(b + d) * s
        assert positive(a + c, b + d)
        assert x * y == QQbar(a * c + 2 * b * d) + QQbar(a * d + b * c) * s
        assert positive(a * c + 2 * b * d, a * d + b * c)
        checked += 1

print(f"RESULT: PASS ({len(samples) ** 2} elements, {checked} positive pairs)")
