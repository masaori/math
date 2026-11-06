# epsilon_entries_in_row_configuration_numbering・epsilon_real_permutes_entries_by_spin_flip の共通の準備。
# 1 行ぶんのスピン配置 𝔐、ord、ι、ν、ε（σ_1^x⋯σ_M^x とクロネッカー積表示の両方）を厳密に（QQbar）作る。
import itertools

sigma_x = matrix(QQbar, [[0, 1], [1, 0]])
identity_two = identity_matrix(QQbar, 2)


def configurations(M):
    """def_row_configurations: 𝔐 = Map({1,…,M}, {-1,1})。s[m-1] が s(m)。"""
    return [tuple(s) for s in itertools.product([1, -1], repeat=M)]


def neg(s):
    """(-s)(m) := -s(m)。"""
    return tuple(-a for a in s)


def ord_(s):
    """def_row_configuration_numbering: ord(s) := 1 + Σ_m (1-s(m))/2 · 2^{M-m}。"""
    M = len(s)
    return 1 + sum(ZZ((1 - s[m - 1]) / 2) * 2 ** (M - m) for m in range(1, M + 1))


def iota(s):
    """def_config_basis_iso: i_m := 1（s(m) = +1）、2（s(m) = -1）。"""
    return tuple(1 if a == 1 else 2 for a in s)


def nu(I):
    """def_kronecker の番号付け ν(I) := 1 + Σ_k (i_k - 1) 2^{M-k}。"""
    M = len(I)
    return 1 + sum((I[k - 1] - 1) * 2 ** (M - k) for k in range(1, M + 1))


def kron(factors):
    result = matrix(QQbar, [[1]])
    for A in factors:
        result = result.tensor_product(A)
    return result


def epsilon_site_product(M):
    """def_global_spin_flip_matrix: ε := σ_1^x σ_2^x ⋯ σ_M^x（σ_m^x は第 m 因子だけ σ^x のクロネッカー積）。"""
    result = identity_matrix(QQbar, 2 ** M)
    for m in range(1, M + 1):
        site = kron([sigma_x if k == m else identity_two for k in range(1, M + 1)])
        result = result * site
    return result


def epsilon_kronecker_form(M):
    """global_spin_flip_kronecker_form: ε = σ^x ⊠ ⋯ ⊠ σ^x（M 個の因子）。"""
    return kron([sigma_x] * M)
