# 対象ラベル: epsilon_projector_properties
# 共通の準備。行列・ベクトルの成分は QQ（または QQ 上の多項式環）に置き、等号は厳密に判定する。
# 浮動小数点と RR / CC への脱出はない。QQ ⊂ ℂ の包含の前に判定する。
#
# 各行の両辺を同じ式から作ると何も確かめないので、行ごとにその行の式を本文の定め方
# （sagemath/_shared/matrix_operations_by_definition.sage の body_product・body_sum・body_scalar・body_identity）で
# 組み、隣の行と比べる。ε と P^{(+)} は、本文の定め方の経路と Sage 組み込みの経路（tensor_product・`*`・`+`）の
# 二通りで作り、一致を確かめてから使う。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/site_sigma_z_kronecker.sage")   # index_set・nu・kron_matrix_by_definition・kron_sage・site_factors

M_COL_RANGE = [1, 2, 3, 4, 5]

SIGMA_X = matrix(ZZ, [[0, 1], [1, 0]])   # def_pauli_matrices の σ^x


def epsilon_body(M):
    """def_global_spin_flip_matrix: ε := σ^x_1 σ^x_2 ⋯ σ^x_M（サイト番号の昇順の積）。
    σ^x_m は def_site_pauli_matrices のとおり第 m 因子だけ σ^x のクロネッカー積を def_kronecker の成分の式で組み、
    積は mat_mult の成分の式で取る。"""
    n = 2 ** M
    E = body_identity(QQ, n)
    for m in range(1, M + 1):
        S = kron_matrix_by_definition(site_factors(M, m, SIGMA_X)).change_ring(QQ)
        E = body_product(E, S)
    return E


def epsilon_sage(M):
    """比べる側: Sage の tensor_product と `*` で作る ε。"""
    E = identity_matrix(QQ, 2 ** M)
    for m in range(1, M + 1):
        E = E * kron_sage(site_factors(M, m, SIGMA_X)).change_ring(QQ)
    return E


def epsilon(M):
    E = epsilon_body(M)
    assert E == epsilon_sage(M)
    return E


def projector_body(E):
    """def_epsilon_projectors: P^{(+)} := (1/2)(I + ε)。"""
    n = E.nrows()
    return body_scalar(QQ(1) / 2, body_sum(body_identity(E.base_ring(), n), E))


def projector(M):
    E = epsilon(M)
    P = projector_body(E)
    assert P == (identity_matrix(QQ, 2 ** M) + epsilon_sage(M)) / 2
    return E, P


def generic_vector(n, name):
    """成分を QQ 上の独立な不定元とする n 行 1 列の行列（mat_mult のとおり ℂ^n の元を n 行 1 列の行列として持つ）。"""
    R = PolynomialRing(QQ, [f"{name}{k}" for k in range(1, n + 1)])
    return R, matrix(R, n, 1, R.gens())


def generic_matrix(n, name):
    """成分を QQ 上の独立な不定元とする n 次の正方行列。ε の性質を何も持たない行列として、
    各行が ε^2 = I を使うかどうかを見分けるのに使う。"""
    R = PolynomialRing(QQ, [f"{name}_{i}_{j}" for i in range(1, n + 1) for j in range(1, n + 1)])
    return R, matrix(R, n, n, R.gens())


def check_chain(lines, label):
    """lines は各行の値の列。隣り合う行が等しいことを確かめる。"""
    for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
        assert a == b, f"{label}: 第 {k} 行と第 {k+1} 行が一致しない"
