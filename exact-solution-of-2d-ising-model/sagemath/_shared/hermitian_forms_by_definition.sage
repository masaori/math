# 正定値性の主張（009_eigenvalues_of_V.ts）の検算で共有する準備。
# ℂ は本文 definition_of_cc どおり実数の対で持つ（complex_as_real_pairs.sage）。行列は対を成分に持つ表（リストのリスト）、
# 数ベクトルは対のリストとして、本文の定め方どおりに成分から組む:
#   共役転置 (A^*)_{kl} := conj(A_{lk})（def_hermitian_positive_definite）、積 (AB)_{ik} := Σ_j A_{ij}B_{jk}（mat_mult。
#   有限和は def_finite_sum_of_complex_numbers のとおり左から足す）、和・スカラー倍・符号反転・零・単位行列は
#   def_matrix_sum・def_matrix_scalar_multiple・def_matrix_negation・def_zero_matrix・def_identity_matrix の成分の式、
#   x^*Ay := Σ_k Σ_l (conj(x_k) A_{kl}) y_l（def_conjugate_bilinear_value）。
# 比べる側は、対 (a, b) を QQ(i) 係数の a + i b へ送った Sage の行列・ベクトルと、その conjugate_transpose・積・和である。
# exp は ℝ への脱出を含むので、本文の部分和に尾の評価を半径として足した複素数のボールの行列（body_exp_ball）と、
# Sage 組み込みの ComplexBallField の行列の exp（arb の厳密な囲み）を比べる。
load("../../_shared/complex_as_real_pairs.sage")

KG = QuadraticField(-1, 'i')
i_K = KG.gen()


def fsum(zs):
    s = zs[0]
    for q in zs[1:]:
        s = cc_add(s, q)
    return s


def generic_ring(n, mats=(), vecs=(), scalars=(), real_scalars=()):
    """mats の各文字に n×n、vecs の各文字に長さ n の、成分が QQ 上の不定元の対である表を作る。
    scalars は複素数の不定元の対、real_scalars は実数の不定元（対にしない）。"""
    names = [f"{s}" for s in real_scalars]
    names += [f"{s}_{c}" for s in scalars for c in "ri"]
    names += [f"{x}_{k}_{l}_{c}" for x in mats for k in range(n) for l in range(n) for c in "ri"]
    names += [f"{x}_{k}_{c}" for x in vecs for k in range(n) for c in "ri"]
    P = PolynomialRing(QQ, names)
    g = list(P.gens())
    pos = 0
    rs = g[pos:pos + len(real_scalars)]
    pos += len(real_scalars)
    sc = []
    for _ in scalars:
        sc.append((g[pos], g[pos + 1]))
        pos += 2
    ms = []
    for _ in mats:
        ms.append([[(g[pos + 2 * (k * n + l)], g[pos + 2 * (k * n + l) + 1]) for l in range(n)] for k in range(n)])
        pos += 2 * n * n
    vs = []
    for _ in vecs:
        vs.append([(g[pos + 2 * k], g[pos + 2 * k + 1]) for k in range(n)])
        pos += 2 * n
    return P, rs, sc, ms, vs


def body_star(A):
    n = len(A)
    return [[cc_conj(A[l][k]) for l in range(n)] for k in range(n)]


def body_prod(A, B):
    m, n, p = len(A), len(B), len(B[0])
    return [[fsum([cc_mul(A[r][j], B[j][c]) for j in range(n)]) for c in range(p)] for r in range(m)]


def body_matvec(A, x):
    """mat_mult の p = 1（数ベクトル）。"""
    n = len(x)
    return [fsum([cc_mul(A[k][j], x[j]) for j in range(n)]) for k in range(len(A))]


def body_sum(A, B):
    return [[cc_add(A[r][c], B[r][c]) for c in range(len(A[0]))] for r in range(len(A))]


def body_scalar(a, A):
    return [[cc_mul(a, A[r][c]) for c in range(len(A[0]))] for r in range(len(A))]


def body_neg(A, R):
    return [[cc_neg(A[r][c], R) for c in range(len(A[0]))] for r in range(len(A))]


def body_delta(i, j, R):
    """def_kronecker_delta: 1_C = iota(1)、0_C = iota(0)。"""
    return iota(1, R) if i == j else iota(0, R)


def body_identity(n, R):
    return [[body_delta(k, l, R) for l in range(n)] for k in range(n)]


def body_zero(n, R):
    return [[iota(0, R) for _ in range(n)] for _ in range(n)]


def body_cbv(x, A, y):
    """def_conjugate_bilinear_value の x^*Ay := Σ_k Σ_l (conj(x_k) A_kl) y_l。"""
    n = len(x)
    return fsum([fsum([cc_mul(cc_mul(cc_conj(x[k]), A[k][l]), y[l]) for l in range(n)]) for k in range(n)])


def gauss_ring(P):
    return PolynomialRing(KG, P.variable_names())


def to_g(z, R):
    return R(z[0]) + i_K * R(z[1])


def to_g_mat(A, R):
    return matrix(R, len(A), len(A[0]), lambda r, c: to_g(A[r][c], R))


def to_g_vec(x, R):
    return vector(R, [to_g(z, R) for z in x])


def g_conj(p):
    """比べる側の複素共役: 係数の共役（不定元は実の不定元なので、これが複素共役に当たる）。"""
    try:
        return p.map_coefficients(lambda c: c.conjugate())
    except AttributeError:
        return p.conjugate()


def sage_star(M):
    return M.transpose().apply_map(g_conj)


def from_g(z):
    """QQ(i) の元を本文の対 (a, b) へ。"""
    return (QQ(z.real()), QQ(z.imag()))


def from_g_mat(M):
    return [[from_g(M[r, c]) for c in range(M.ncols())] for r in range(M.nrows())]


def from_g_vec(v):
    return [from_g(z) for z in v]


def is_positive_real_inclusion(z):
    """z が r_C = (r, 0)（r ∈ ℝ_{>0}）の形かを厳密に判定する（成分は QQ）。"""
    return z[1] == 0 and z[0] > 0


def rand_gauss(lo=-4, hi=5):
    return KG(ZZ.random_element(lo, hi)) + i_K * KG(ZZ.random_element(lo, hi))


def rand_gauss_matrix(n):
    return matrix(KG, n, n, lambda r, c: rand_gauss())


def rand_hermitian(n):
    C = rand_gauss_matrix(n)
    return C + C.conjugate_transpose()


def rand_posdef(n):
    """C^*C + I は正定値（Sage の is_positive_definite で別に確かめる）。"""
    C = rand_gauss_matrix(n)
    return C.conjugate_transpose() * C + identity_matrix(KG, n)


def rand_nonzero_vector(n):
    while True:
        v = vector(KG, [rand_gauss(-3, 4) for _ in range(n)])
        if v != 0:
            return v


def sage_is_positive_definite(M):
    return M.is_hermitian() and M.change_ring(QQbar).is_positive_definite()


CB = ComplexBallField(256)
RB = RealBallField(256)


def body_exp_ball(Sg, N=60):
    """def_exp (1) の部分和 E_N = Σ_{m=0}^{N} (1/m!) S^m（QQ(i) で厳密に、冪は A^{m+1} := A^m A）に、
    尾 Σ_{m>N} ‖S‖^m/m! の上界（matrix_norm_submultiplicativity と |成分| ≤ ‖·‖）を各成分の半径として足したボールの行列。"""
    n = Sg.nrows()
    P = identity_matrix(KG, n)
    E = matrix(KG, n, n, 0)
    for m in range(N + 1):
        E += (1 / factorial(m)) * P
        P = P * Sg
    s = RB(sum(QQ(z.real())^2 + QQ(z.imag())^2 for z in Sg.list())).sqrt().upper()
    s = RB(s)
    assert s < N + 2
    tail = s^(N + 1) / factorial(N + 1) / (1 - s / (N + 2))
    rad = tail.upper()
    def ball(z):
        return CB(RB(QQ(z.real())).add_error(rad), RB(QQ(z.imag())).add_error(rad))
    return matrix(CB, n, n, lambda r, c: ball(E[r, c]))


def sage_exp_ball(Sg):
    return Sg.change_ring(CB).exp()


def balls_overlap(M1, M2):
    return all(M1[r, c].overlaps(M2[r, c]) for r in range(M1.nrows()) for c in range(M1.ncols()))


def ball_contains_exact(M, Mg):
    """ボールの行列 M の各成分が、QQ(i) の行列 Mg の対応する成分を含むか。"""
    return all(M[r, c].real().contains_exact(QQ(Mg[r, c].real())) and M[r, c].imag().contains_exact(QQ(Mg[r, c].imag()))
               for r in range(M.nrows()) for c in range(M.ncols()))


def hermitian_from_generic(M, R):
    """不定元の表 M の上三角と対角の実部から、A_lk := conj(A_kl)、対角の虚部 0 のエルミートな表を作る（仮定 A^* = A の実現）。"""
    n = len(M)
    H = [[None] * n for _ in range(n)]
    for k in range(n):
        H[k][k] = (M[k][k][0], R(0))
        for l in range(k + 1, n):
            H[k][l] = M[k][l]
            H[l][k] = cc_conj(M[k][l])
    return H


def body_pow(A, m, R):
    """def_exp (1) の A^0 := I、A^{m+1} := A^m A。"""
    Pm = body_identity(len(A), R)
    for _ in range(m):
        Pm = body_prod(Pm, A)
    return Pm


def body_partial_exp(A, N, R):
    """def_exp (1) の部分和 E_N = Σ_{m=0}^{N} (1/m!)_C A^m（行列の和は左から）。"""
    E = body_scalar(iota(1, R), body_pow(A, 0, R))
    for m in range(1, N + 1):
        E = body_sum(E, body_scalar(iota(1 / factorial(m), R), body_pow(A, m, R)))
    return E


def truncate_in(p, t, D):
    """多項式 p から t の次数が D 以下の項だけを残す（形式冪級数 mod t^{D+1}）。"""
    R = p.parent()
    j = R.gens().index(t)
    return sum((c * R.monomial(*e) for e, c in p.dict().items() if e[j] <= D), R(0))


def trunc_mat(A, t, D):
    return [[(truncate_in(z[0], t, D), truncate_in(z[1], t, D)) for z in row] for row in A]
