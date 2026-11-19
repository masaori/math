# 対象ラベル: claim_quadratic_conjugate_square_sum_identity
c,u,v,b = QQbar(3), QQbar(2), QQbar(-1), QQbar(5).sqrt()
r,s = u,v*b
assert 2*c*(r**2+s**2) == 2*c*(u**2+v**2*b**2)
