# 対象ラベル: claim_increasing_positive_cone_union_is_positive_cone
from sage.all import QQ

# F_0 = QQ, F_n = QQ(sqrt(2)) (n >= 1) の係数表示を使う。
def positive(a, b):
    if b == 0:
        return a > 0
    if b > 0:
        return a >= 0 or 2 * b * b > a * a
    return a > 0 and a * a > 2 * b * b

def in_cone(stage, a, b):
    return (b == 0 and a > 0) if stage == 0 else positive(a, b)

values = [QQ(k) / 3 for k in range(-3, 4)]
elements = [(0, a, QQ(0)) for a in values]
elements += [(1, a, b) for a in values for b in values]

for stage, a, b in elements:
    assert sum((a == 0 and b == 0, in_cone(stage, a, b),
                in_cone(stage, -a, -b))) == 1
    if stage == 0:
        assert in_cone(stage, a, b) == in_cone(1, a, b)

positive_elements = [(stage, a, b) for stage, a, b in elements
                     if in_cone(stage, a, b)]
for i, a, b in positive_elements:
    for j, c, d in positive_elements:
        k = max(i, j)
        assert in_cone(k, a + c, b + d)
        assert in_cone(k, a * c + 2 * b * d, a * d + b * c)

print(f"RESULT: PASS ({len(elements)} elements, "
      f"{len(positive_elements) ** 2} positive pairs)")
