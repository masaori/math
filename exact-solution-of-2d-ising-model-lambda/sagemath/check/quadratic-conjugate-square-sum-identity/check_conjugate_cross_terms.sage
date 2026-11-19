# 対象ラベル: claim_quadratic_conjugate_square_sum_identity
# 一つの添字で共役の交差項が相殺される。
F = QQbar
a = F(2)
b = F(2).sqrt()
assert b * b == a
for c in [F(-3), F(0), F(2)]:
    for u in [F(-2), F(0), F(3)]:
        for v in [F(-1), F(0), F(2)]:
            left = c * (u + v*b)**2 + c * (u - v*b)**2
            middle = 2*c*(u**2 + v**2*b**2)
            assert left == middle
