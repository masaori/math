# 対象ラベル: conjugation_commutes_with_matrix_exp
# 共通の準備。積・スカラー倍・和は本文の成分の式（matrix_operations_by_definition.sage）、
# exp のボールは pauli_sites_exact.sage の body_exp_ball（def_exp の部分和に尾の上界を半径として足す）を使う。
load("../../_shared/pauli_sites_exact.sage")
load("../../_shared/row_configurations.sage")


def T_body(B, A, Binv):
    """mat_conj の T_B(A) := (BA)B^{-1}（積は mat_mult の成分の式）。"""
    return body_product(body_product(B, A), Binv)


def power_body(A, p):
    """def_exp (1) の A^0 := I、A^{p+1} := A^p A。"""
    P = body_identity(A.base_ring(), A.nrows())
    for _ in range(p):
        P = body_product(P, A)
    return P


def c_coeff(R, p):
    """c_p := (1/p!)_C。"""
    return R(QQ(1) / factorial(p))


def partial_sum_body(A, N):
    """P_N(A) := Σ_{p=0}^{N} c_p A^p（P_0 = c_0A^0、P_{N+1} = P_N + c_{N+1}A^{N+1}）。"""
    R = A.base_ring()
    P = body_scalar(c_coeff(R, 0), power_body(A, 0))
    for p in range(1, N + 1):
        P = body_sum(P, body_scalar(c_coeff(R, p), power_body(A, p)))
    return P


def invertible_samples():
    """KG の正則な B と、Sage の inverse で作った B^{-1}（本文の積で BB^{-1} = B^{-1}B = I を確かめる）。"""
    out = []
    for B in [matrix(KG, [[1, 2], [i_K, 3]]),
              matrix(KG, [[2, 1, 0], [0, 1 + i_K, 1], [1, 0, 3]]),
              matrix(KG, [[1, 1, 0, 0], [0, 1, i_K, 0], [0, 0, 1, 2], [3, 0, 0, 1]])]:
        Binv = B.inverse()
        n = B.nrows()
        assert body_product(B, Binv) == body_identity(KG, n) and body_product(Binv, B) == body_identity(KG, n)
        out.append((B, Binv))
    return out
