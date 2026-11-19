# 対象ラベル: claim_quadratic_conjugate_square_sum_identity
c = [QQbar(1), QQbar(2), QQbar(3)]
u = [QQbar(-2), QQbar(0), QQbar(1)]
v = [QQbar(3), QQbar(-1), QQbar(2)]
b = QQbar(2).sqrt()
left = sum(c[i]*(u[i]+v[i]*b)**2 for i in range(3))
left += sum(c[i]*(u[i]-v[i]*b)**2 for i in range(3))
right = sum(c[i]*(u[i]+v[i]*b)**2+c[i]*(u[i]-v[i]*b)**2 for i in range(3))
assert left == right
