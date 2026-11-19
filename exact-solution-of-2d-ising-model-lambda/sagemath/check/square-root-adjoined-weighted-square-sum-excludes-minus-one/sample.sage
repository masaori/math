# 対象ラベル: claim_square_root_adjoined_weighted_square_sum_excludes_minus_one
# F=QQ、a=2、b=sqrt(2) の有限標本。全称命題の証明には使わない。
a = QQbar(2)
b = a.sqrt()
assert b * b == a
c = [QQbar(1), QQbar(2), QQbar(3)]
u = [QQbar(1), QQbar(-2), QQbar(3)]
v = [QQbar(2), QQbar(0), QQbar(-1)]
A = sum(c[i] * (u[i] * u[i] + a * v[i] * v[i]) for i in range(len(c)))
B = sum(2 * c[i] * u[i] * v[i] for i in range(len(c)))

Splus = sum(c[i] * (u[i] + v[i] * b)^2 for i in range(len(c)))
Sminus = sum(c[i] * (u[i] - v[i] * b)^2 for i in range(len(c)))
Pexpand = sum(c[i] * (u[i]^2 + 2*u[i]*v[i]*b + v[i]^2*b^2) for i in range(len(c)))
Psubstitute = sum(c[i] * (u[i]^2 + 2*u[i]*v[i]*b + a*v[i]^2) for i in range(len(c)))
Pdistribute = sum(c[i]*(u[i]^2+a*v[i]^2) + (2*c[i]*u[i]*v[i])*b for i in range(len(c)))
Psplit = sum(c[i]*(u[i]^2+a*v[i]^2) for i in range(len(c))) + sum((2*c[i]*u[i]*v[i])*b for i in range(len(c)))
Mexpand = sum(c[i] * (u[i]^2 - 2*u[i]*v[i]*b + v[i]^2*b^2) for i in range(len(c)))
Msubstitute = sum(c[i] * (u[i]^2 - 2*u[i]*v[i]*b + a*v[i]^2) for i in range(len(c)))
Mdistribute = sum(c[i]*(u[i]^2+a*v[i]^2) - (2*c[i]*u[i]*v[i])*b for i in range(len(c)))
Msplit = sum(c[i]*(u[i]^2+a*v[i]^2) for i in range(len(c))) - sum((2*c[i]*u[i]*v[i])*b for i in range(len(c)))
