# <linearity_of_T>: 任意の可逆な有限複素行列 g に対して T_g が C-線型
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
rep = CheckReport("linearity_of_T")
K.<ii> = QuadraticField(-1)

def exact_conjugation(g, X):
    return g * X * g.inverse()

for n in [2,4,8]:
    for trial in range(3):
        a = K(trial + 1 + (trial + 2)*ii)
        b = K(-(trial + 2) + (2*trial + 1)*ii)
        Xr = matrix(K, n, n, lambda j, k: K((j + 1)*(k + trial + 2) + (j - k)*ii))
        Wr = matrix(K, n, n, lambda j, k: K((j - k - trial) + (j + 2)*(k + 1)*ii))
        # 非零対角成分を持つ上三角行列なので、可逆性は厳密に保証される。
        g = matrix(K, n, n, lambda j, k:
                   K(0) if j > k else K(j + trial + 2 + ii) if j == k
                   else K(j + k + trial + 1 + (k - j)*ii))
        gi = g.inverse()

        lhs = exact_conjugation(g, a*Xr + b*Wr)
        definition = g * (a*Xr + b*Wr) * gi
        left_distributive = (g * (a*Xr) + g * (b*Wr)) * gi
        right_distributive = g * (a*Xr) * gi + g * (b*Wr) * gi
        left_scalar_compatible = a*(g * Xr) * gi + b*(g * Wr) * gi
        right_scalar_compatible = a*(g * Xr * gi) + b*(g * Wr * gi)
        rhs = a*exact_conjugation(g, Xr) + b*exact_conjugation(g, Wr)

        prefix = f"n={n}, trial={trial}"
        rep.truth(lhs == definition, f"{prefix}: T_g の定義")
        rep.truth(definition == left_distributive, f"{prefix}: 左分配")
        rep.truth(left_distributive == right_distributive, f"{prefix}: 右分配")
        rep.truth(right_distributive == left_scalar_compatible, f"{prefix}: 左行列積とスカラー倍の両立")
        rep.truth(left_scalar_compatible == right_scalar_compatible, f"{prefix}: 右行列積とスカラー倍の両立")
        rep.truth(right_scalar_compatible == rhs, f"{prefix}: T_g の定義へ戻す")
rep.finish()
