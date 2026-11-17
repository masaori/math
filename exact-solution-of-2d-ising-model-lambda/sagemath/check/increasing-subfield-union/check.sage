# 対象ラベル: claim_increasing_subfield_union_is_subfield
from sage.all import QQ, QQbar

s = QQbar(2).sqrt()
assert s * s == QQbar(2)

# F_0 = QQ, F_n = QQ(s) (n >= 1) の有限標本で、各閉包の式を検算する。
samples = [QQ(-2), QQ(-1), QQ(0), QQ(1), QQ(2)]
elements = [(0, a, QQ(0)) for a in samples]
elements += [(1, a, b) for a in samples for b in samples]

def value(a, b):
    return QQbar(a) + QQbar(b) * s

assert value(0, 0) == 0
assert value(1, 0) == 1
for i, a, b in elements:
    assert value(-a, -b) == -value(a, b)
    if (a, b) != (0, 0):
        denominator = a * a - 2 * b * b
        assert denominator != 0
        assert value(a / denominator, -b / denominator) * value(a, b) == 1
    for j, c, d in elements:
        k = max(i, j)
        if k == 0:
            assert b == d == 0
        assert value(a + c, b + d) == value(a, b) + value(c, d)
        assert value(a * c + 2 * b * d, a * d + b * c) == value(a, b) * value(c, d)

print(f"RESULT: PASS ({len(elements)} elements, {len(elements) ** 2} pairs)")
