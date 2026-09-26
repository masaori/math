# ---------------------------------------------------------
# 共通: 分配関数の章の成分定義の転送行列（<def_transfer_matrix>）と、
#       転送行列の章のパウリ行列表示（<first_transfer_matrix_pauli_form>, <second_transfer_matrix_pauli_form>）
#
# 記号（本文に合わせる）:
#   M      : 列数 M_col（1 行のサイト数。転送行列は 2^M 次）
#   N_row  : 行数（転送の回数）
#   K_1    : 同じ行の隣り合うサイトの結合定数
#   K_2    : 隣り合う行の同じ列のサイトの結合定数
#
# 行・列番号は <def_row_configuration_numbering> の ord(μ) = 1 + Σ_m (1-μ(m))/2 · 2^{M-m}。
# これは <config_numbering_equals_kronecker_numbering> により ν(ι(μ)) に等しく、
# クロネッカー積（tensor_product、先頭因子が最上位）の並びと一致する。
# ここでは 0 始まりの添字 ord(μ) - 1 を使う。
# ---------------------------------------------------------
import os
import itertools
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../../_shared/spin_ops.sage'))
load(os.path.join(_dir, '../../../_shared/row_configurations.sage'))


def all_configs(M):
    """mu in Map({1..M},{-1,1}) を tuple (mu(1),...,mu(M)) として列挙する。"""
    return list(itertools.product([1, -1], repeat=M))


def config_index(mu):
    """mu -> 行・列番号（0 始まり）= ord(mu) - 1（<def_row_configuration_numbering>）。"""
    return int(ord_number(tuple(ZZ(s) for s in mu))) - 1


def V1_component(M, K1):
    """<def_transfer_matrix>: (V_1)_{ord(mu),ord(mu')} = delta_{mu=mu'} exp( K_1 sum_m mu(m) mu(m+1) )"""
    K1 = RDF(K1)
    d = 2 ** M
    A = matrix(CDF, d, d, 0)
    for mu in all_configs(M):
        e = sum(K1 * mu[j] * mu[(j + 1) % M] for j in range(M))
        A[config_index(mu), config_index(mu)] = CDF(exp(RDF(e)))
    return A


def V2_component(M, K2):
    """<def_transfer_matrix>: (V_2)_{ord(mu),ord(mu')} = exp( K_2 sum_m mu(m) mu'(m) )"""
    K2 = RDF(K2)
    d = 2 ** M
    A = matrix(CDF, d, d, 0)
    cfgs = all_configs(M)
    for mu in cfgs:
        for mup in cfgs:
            e = sum(K2 * mu[j] * mup[j] for j in range(M))
            A[config_index(mu), config_index(mup)] = CDF(exp(RDF(e)))
    return A


def V1_pauli(O, K1):
    """<first_transfer_matrix_pauli_form> の右辺: exp( K_1 sum_{m=1}^{M} sigma^z_m sigma^z_{m+1} )"""
    M = O.M
    bonds = matrix(CDF, O.d, O.d, 0)
    for m in range(1, M + 1):
        mp = m + 1 if m < M else 1
        bonds = bonds + O.SZ[m] * O.SZ[mp]
    return matrix(CDF, (RDF(K1) * bonds).exp())


def V2_pauli(O, K2):
    """<second_transfer_matrix_pauli_form> の右辺: (2 sinh 2K_2)^{M/2} exp( K_2^* sum_m sigma^x_m )"""
    M = O.M
    K2 = RDF(K2)
    K2s = K_star(K2)
    s2 = RDF(sinh(2 * K2))
    sx_sum = sum([O.SX[m] for m in range(1, M + 1)], matrix(CDF, O.d, O.d, 0))
    return CDF((2 * s2) ** (RDF(M) / 2)) * matrix(CDF, (K2s * sx_sum).exp())


def epsilon_op(O):
    """epsilon = sigma^x_1 ... sigma^x_M"""
    out = identity_matrix(CDF, O.d)
    for m in range(1, O.M + 1):
        out = out * O.SX[m]
    return matrix(CDF, out)


def projectors(O):
    """P^{(+)}, P^{(-)} = (I +- epsilon)/2"""
    Id = identity_matrix(CDF, O.d)
    eps = epsilon_op(O)
    return ((Id + eps) / 2, (Id - eps) / 2)


def V_sym(O, K1, K2, sgn):
    """V^{(pm)} = exp(i K_1 H_1^{(pm)} / 2) V_2 exp(i K_1 H_1^{(pm)} / 2)"""
    half = matrix(CDF, (CDF(I) / 2 * RDF(K1) * O.H1(sgn)).exp())
    return half * V2_pauli(O, K2) * half


def V1_pm(O, K1, sgn):
    """V_1^{(pm)} = exp(i K_1 H_1^{(pm)})"""
    return matrix(CDF, (CDF(I) * RDF(K1) * O.H1(sgn)).exp())


def Z_direct(N_row, M, K1, K2):
    """<def_partition_function_2d_ising> の Z(K_1,K_2) をスピン配置についての直接和で計算する。

    Z = sum_s exp( sum_{i,j} ( K_1 s(i,j)s(i,j+1) + K_2 s(i,j)s(i+1,j) ) )
    i は行（周期 N_row）、j は列（周期 M = M_col）。
    """
    K1 = RDF(K1); K2 = RDF(K2)
    tot = RDF(0)
    for flat in itertools.product([1, -1], repeat=N_row * M):
        s = [[flat[i * M + j] for j in range(M)] for i in range(N_row)]
        e = RDF(0)
        for i in range(N_row):
            for j in range(M):
                e += K2 * s[i][j] * s[(i + 1) % N_row][j] + K1 * s[i][j] * s[i][(j + 1) % M]
        tot += RDF(exp(e))
    return tot


BRIDGE_CASES = [
    (2, 0.4, 0.8), (2, 0.7, 0.3),
    (3, 0.4, 0.8), (3, 0.7, 0.3), (3, 0.25, 1.1),
    (4, 0.4, 0.8), (4, 0.7, 0.3),
]

# 直接和は 2^{N_row * M} 通りを回すので小さい格子に限る
Z_CASES = [(2, 2), (3, 2), (2, 3), (3, 3), (2, 4)]

TOL = 1e-8
