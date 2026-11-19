# 対象ラベル: claim_quadratic_conjugate_square_sum_identity
c = [QQbar(1), QQbar(2), QQbar(3)]
u = [QQbar(-2), QQbar(0), QQbar(1)]
v = [QQbar(3), QQbar(-1), QQbar(2)]
a = QQbar(2)
assert sum(2*c[i]*(u[i]**2+a*v[i]**2) for i in range(3)) == 2*sum(c[i]*(u[i]**2+a*v[i]**2) for i in range(3))
