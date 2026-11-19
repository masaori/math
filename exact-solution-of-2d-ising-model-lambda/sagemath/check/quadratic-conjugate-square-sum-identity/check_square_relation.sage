# 対象ラベル: claim_quadratic_conjugate_square_sum_identity
# b^2=a を代入する一行を確認する。
F = QQbar
a = F(2)
b = F(2).sqrt()
assert b * b == a
for c in [F(-3), F(0), F(2)]:
    for u in [F(-2), F(0), F(3)]:
        for v in [F(-1), F(0), F(2)]:
            assert 2*c*(u**2 + v**2*b**2) == 2*c*(u**2 + a*v**2)
