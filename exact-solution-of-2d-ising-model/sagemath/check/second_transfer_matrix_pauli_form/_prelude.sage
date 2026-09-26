import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))

# exp(K_2) の値として選ぶ 1 より大きい有理数（K_2 = log x > 0）。
# このとき
#   2 sinh 2K_2 = x^2 - x^{-2} ∈ QQ_{>0}
#   tanh K_2    = (x^2 - 1)/(x^2 + 1) ∈ QQ, 0 < tanh K_2 < 1
#   K_2^* = -1/2 log(tanh K_2)（<def_second_dual_coupling_constant>）より
#   exp(K_2^* λ) = (tanh K_2)^{-λ/2} = (√tanh K_2)^{-λ} ∈ AA（実代数的数）
X_VALUES = [QQ(2), QQ(3) / 2, QQ(5) / 4, QQ(7) / 3]


def two_sinh_2K2(x):
    return QQ(x) ** 2 - QQ(x) ** (-2)


def tanh_K2(x):
    return (QQ(x) ** 2 - 1) / (QQ(x) ** 2 + 1)


def exp_dual(x):
    """λ ↦ exp(K_2^* λ) を AA で返す関数。"""
    r = AA(tanh_K2(x)).sqrt()          # 正の平方根
    return lambda lam: r ** (-ZZ(lam))


def prefactor(x, M_col):
    """<def_second_transfer_matrix_prefactor>: (√(2 sinh 2K_2))^{M_col}（√ は非負平方根）。"""
    return AA(two_sinh_2K2(x)).sqrt() ** M_col


def sigma_x_sum(M_col):
    """S := Σ_{m=1}^{M_col} σ_m^x（ZZ 行列）。"""
    return sum([site_pauli('x', m, M_col) for m in range(1, M_col + 1)], matrix(ZZ, 2 ** M_col, 2 ** M_col, 0))
