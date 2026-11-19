# 対象ラベル: claim_quadratic_conjugate_square_sum_identity
c,r,s = QQbar(3), QQbar(2), QQbar(5).sqrt()
assert c*(2*r**2+2*s**2) == 2*c*(r**2+s**2)
