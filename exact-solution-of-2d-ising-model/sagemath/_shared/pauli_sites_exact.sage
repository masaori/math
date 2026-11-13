# ε・サイトの Pauli 行列・Jordan–Wigner 行列・転送行列の可換性の検算で共有する準備。
# 成分は QQ(i)（KG）か、その上の多項式環に置き、等号は厳密に判定する。
# 本文の定め方の経路:
#   σ^x, σ^y, σ^z（def_pauli_matrices）、I（def_identity_matrix）、クロネッカー積は def_kronecker (2) の成分の式
#   (A_1⊠⋯⊠A_M)_{ν(I),ν(J)} := ∏_k (A_k)_{i_k j_k}、σ_k^a は def_site_pauli_matrices（第 k 因子だけ σ^a）、
#   積は mat_mult の成分の式（matrix_operations_by_definition.sage の body_product）、ε は def_global_spin_flip_matrix の
#   σ_1^x⋯σ_M^x を左から掛けたもの、Z_m・Y_m は def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices の
#   σ_1^x⋯σ_{m-1}^x σ_m^{z/y} を左から掛けたもの。
# 比べる側は Sage の tensor_product と `*` で組んだ同じ行列である（kron_sage・*_sage）。
# exp は ℝ への脱出を含むので、本文の部分和に尾の上界を半径として足した複素数のボールの行列（body_exp_ball）と、
# Sage の ComplexBallField の行列の exp を比べる。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

KG = QuadraticField(-1, 'i')
i_K = KG.gen()

SX = matrix(KG, [[0, 1], [1, 0]])
SY = matrix(KG, [[0, -i_K], [i_K, 0]])
SZ = matrix(KG, [[1, 0], [0, -1]])
I2 = matrix(KG, [[1, 0], [0, 1]])
PAULI = {'x': SX, 'y': SY, 'z': SZ}


def index_set(M):
    return list(cartesian_product([[1, 2]] * M))


def nu(I):
    """def_kronecker の ν(I) = 1 + Σ_k (i_k - 1) 2^{M-k}。"""
    M = len(I)
    return 1 + sum((I[k - 1] - 1) * 2**(M - k) for k in range(1, M + 1))


def kron_def(factors):
    """def_kronecker (2) の成分の式でクロネッカー積を組む。"""
    M = len(factors)
    R = factors[0].base_ring()
    K = matrix(R, 2**M, 2**M)
    for I in index_set(M):
        for J in index_set(M):
            K[nu(I) - 1, nu(J) - 1] = prod(factors[k][I[k] - 1, J[k] - 1] for k in range(M))
    return K


def kron_sage(factors):
    K = factors[0]
    for B in factors[1:]:
        K = K.tensor_product(B)
    return K


def kron(factors):
    K = kron_def(factors)
    assert K == kron_sage(factors)
    return K


def site_factors(M, k, A):
    """def_site_pauli_matrices: 第 k 因子だけ A、他は I。"""
    return [A if j == k else I2 for j in range(1, M + 1)]


def site(M, k, a):
    """σ_k^a。"""
    return kron(site_factors(M, k, PAULI[a]))


def prefix_product(M, a_list):
    """Π_{j=1}^{r}σ_j^{a_j}（def_finite_product_of_matrices: Π^1 := σ_1^{a_1}、Π^{s+1} := (Π^s)σ_{s+1}^{a_{s+1}}。左から掛ける）。"""
    P = site(M, 1, a_list[0])
    for s in range(2, len(a_list) + 1):
        P = body_product(P, site(M, s, a_list[s - 1]))
    return P


def epsilon(M):
    E = prefix_product(M, ['x'] * M)
    Es = identity_matrix(KG, 2**M)
    for k in range(1, M + 1):
        Es = Es * kron_sage(site_factors(M, k, SX))
    assert E == Es
    return E


def jw(M, m, a):
    """Z_m（a='z'）、Y_m（a='y'）。"""
    P = prefix_product(M, ['x'] * (m - 1) + [a])
    Ps = identity_matrix(KG, 2**M)
    for k in range(1, m):
        Ps = Ps * kron_sage(site_factors(M, k, SX))
    Ps = Ps * kron_sage(site_factors(M, m, PAULI[a]))
    assert P == Ps
    return P


def site_periodic_z(M, k):
    """def_site_pauli_periodic_extension: σ_{M+1}^z := σ_1^z。"""
    return site(M, 1, 'z') if k == M + 1 else site(M, k, 'z')


def bond_sum(M):
    """D := Σ_{m=1}^{M} σ_m^z σ_{m+1}^z（有限和は左から）。"""
    return body_finite_sum([body_product(site(M, m, 'z'), site_periodic_z(M, m + 1)) for m in range(1, M + 1)])


def H1_plus(M):
    """def_H1_plus: Σ_{m=1}^{M-1} Y_m Z_{m+1} - Y_M Z_1。"""
    S = body_finite_sum([body_product(jw(M, m, 'y'), jw(M, m + 1, 'z')) for m in range(1, M)])
    return body_difference(S, body_product(jw(M, M, 'y'), jw(M, 1, 'z')))


def check_chain(lines, label):
    for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
        assert a == b, f"{label}: 第 {k} 行と第 {k+1} 行が一致しない"


RB = RealBallField(256)
CB = ComplexBallField(256)


def to_KG(z):
    return KG(z)


def body_exp_ball(S, N=None):
    """def_exp (1) の部分和 S_N = Σ_{p=0}^{N} (1/p!) S^p（KG で厳密に、冪は A^{p+1} := A^p A）に、
    尾 Σ_{p>N} ‖S‖^p/p! の上界（matrix_norm_submultiplicativity と |成分| ≤ ‖·‖）を各成分の半径として足したボールの行列。"""
    n = S.nrows()
    s = RB(sum(QQ(z.real())**2 + QQ(z.imag())**2 for z in S.list())).sqrt().upper()
    s = RB(s)
    if N is None:
        N = 40
        while not (s < N + 2 and RB((s**(N + 1) / factorial(N + 1)).upper()) < RB(2)**(-200)):
            N += 20
    P = identity_matrix(KG, n)
    E = matrix(KG, n, n, 0)
    for p in range(N + 1):
        E = E + (KG(1) / factorial(p)) * P
        P = body_product(P, S)
    tail = s**(N + 1) / factorial(N + 1) / (1 - s / (N + 2))
    rad = tail.upper()

    def ball(z):
        return CB(RB(QQ(z.real())).add_error(rad), RB(QQ(z.imag())).add_error(rad))
    return matrix(CB, n, n, lambda r, c: ball(E[r, c]))


def sage_exp_ball(S):
    return S.change_ring(CB).exp()


def exp_ball(S):
    A = body_exp_ball(S)
    B = sage_exp_ball(S)
    assert balls_overlap(A, B)
    return A


def balls_overlap(M1, M2):
    return all(M1[r, c].overlaps(M2[r, c]) for r in range(M1.nrows()) for c in range(M1.ncols()))


def balls_disjoint_somewhere(M1, M2):
    return any(not M1[r, c].overlaps(M2[r, c]) for r in range(M1.nrows()) for c in range(M1.ncols()))


def to_CB(A):
    return A.change_ring(CB)
