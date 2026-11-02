# 対象ラベル: T_V_plus_is_conjugation
# 共通の準備。S := (V_1^(+))^{1/2}（証明の記号）・V_2 とそれらの逆元を、可逆性の三つの主張の検算と同じく厳密に作る
# （K_1 := 2 log y で S^{±1} を QQ に、K_2 := log x で V_2 を QQ に、V2_invertible の証明の h = (a^{-1})_C exp(-Y) を AA に）。
# ℝ への脱出は K_1・K_2 の選び方だけである。
load("../../_shared/transfer_matrix_factor_inverses.sage")


def number_field_matrices(mats):
    """AA の行列の組を、全成分を含む一つの数体の行列の組へ厳密に移す（AA の多項式環の計算を避けるため）。"""
    entries = [z for A in mats for z in A.list()]
    K, elts, _ = number_field_elements_from_algebraics(entries, minimal=True)
    out, k = [], 0
    for A in mats:
        m = A.nrows() * A.ncols()
        out.append(matrix(K, A.nrows(), A.ncols(), elts[k:k + m]))
        k += m
    return K, out


def factors_exact(M, x, y):
    """S, S^{-1}, V_2, V_2^{-1} を厳密に作り、定義どおりの逆元であることを確かめてから数体へ移して返す。"""
    n = 2**M
    a = prefactor_exact(M, x)
    V2 = V2_components_exact(M, x)
    V2inv = body_scalar(a**(-1), exp_iK2star_H2_exact(M, x, -1))
    S = exp_V1_half_exact(M, y, +1).change_ring(AA)
    Sinv = exp_V1_half_exact(M, y, -1).change_ring(AA)
    Id = body_identity(AA, n)
    assert body_product(S, Sinv) == Id == body_product(Sinv, S)
    assert body_product(V2, V2inv) == Id == body_product(V2inv, V2)
    return number_field_matrices([S, Sinv, V2, V2inv])


def generic_matrix(K, n):
    """成分が独立な不定元 x_{IJ} の n 次正方行列（全ての X ∈ R を一度に表す）。"""
    P = PolynomialRing(K, [f"x_{r}_{c}" for r in range(n) for c in range(n)])
    return P, matrix(P, n, n, P.gens())


def T_def(g, X):
    """def_T_g の T_g(X) = g·X·g^{-1}。Sage の行列積と Sage の inverse で作る（独立な経路）。"""
    R = X.base_ring()
    gi = g.inverse().change_ring(R)
    return (g.change_ring(R) * X) * gi


def T_prime(g, ginv, X):
    """mat_conj の T'_g(X) = (gX)g^{-1}。積は mat_mult の成分の式、g^{-1} は (ii) などが与える逆元で作る。"""
    R = X.base_ring()
    return body_product(body_product(g.change_ring(R), X), ginv.change_ring(R))
