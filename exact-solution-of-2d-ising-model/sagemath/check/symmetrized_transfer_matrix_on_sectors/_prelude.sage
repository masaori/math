# 対象ラベル: symmetrized_transfer_matrix_on_sectors
# 共通の準備。ε・P^{(+)}・サイトの Pauli 行列・H_1^{(+)}・D は QQ(i)（KG）で厳密（epsilon_projector_exact.sage）。
# end は def_end_iso の文言どおりに基底 (E_{I,J})・(f_K) の座標から組む（end_by_definition.sage）。
# exp を含む値だけ、本文の部分和に尾の上界を半径として足したボール（exp_ball）で囲む。
load("../../_shared/epsilon_projector_exact.sage")
load("../../_shared/end_by_definition.sage")


def mat_vec(A, x):
    """mat_mult の成分の式で、n 行 1 列の行列として x を右から掛ける。"""
    col = matrix(A.base_ring(), A.ncols(), 1, list(x))
    return vector(A.base_ring(), body_product(A, col).list())


def even_vectors(M):
    """F^{(+)} = {f | εf = f} を張る f_k := e_k + εe_k（k = 1..2^M）。εf_k = f_k を確かめてから返す。"""
    E = epsilon(M)
    n = 2 ** M
    out = []
    for k in range(n):
        e = vector(KG, [1 if j == k else 0 for j in range(n)])
        f = e + mat_vec(E, e)
        assert mat_vec(E, f) == f
        out.append(f)
    return out


def odd_vectors(M):
    """対照: f_k := e_k - εe_k（εf = -f。F^{(+)} の外）。"""
    E = epsilon(M)
    n = 2 ** M
    out = []
    for k in range(n):
        e = vector(KG, [1 if j == k else 0 for j in range(n)])
        out.append(e - mat_vec(E, e))
    return out


def vec_balls_overlap(u, v):
    return all(a.overlaps(b) for a, b in zip(u, v))


def vec_balls_disjoint_somewhere(u, v):
    return any(not a.overlaps(b) for a, b in zip(u, v))
