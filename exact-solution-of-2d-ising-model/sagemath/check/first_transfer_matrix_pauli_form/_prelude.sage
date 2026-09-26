import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))


def bond_sum_D(M_col):
    """D := Σ_{m=1}^{M_col} σ_m^z σ_{m+1}^z（<def_site_pauli_periodic_extension> の σ_{M_col+1}^z := σ_1^z）。ZZ 行列。"""
    sz = [None] + [site_pauli('z', k, M_col) for k in range(1, M_col + 1)]
    sz_ext = sz + [sz[1]]                     # 周期的な延長
    return sum([sz_ext[m] * sz_ext[m + 1] for m in range(1, M_col + 1)], matrix(ZZ, 2 ** M_col, 2 ** M_col, 0))


def bond_count(mu):
    """d(μ) := Σ_{m=1}^{M_col} μ(m) μ(m+1)（μ(M_col+1) := μ(1)）。"""
    M_col = len(mu)
    return sum(mu[m - 1] * mu[m % M_col] for m in range(1, M_col + 1))


# exp(K_1) の値として選ぶ 1 より大きい有理数（K_1 = log x > 0）
X_VALUES = [QQ(2), QQ(3) / 2, QQ(5) / 4, QQ(7) / 3]
