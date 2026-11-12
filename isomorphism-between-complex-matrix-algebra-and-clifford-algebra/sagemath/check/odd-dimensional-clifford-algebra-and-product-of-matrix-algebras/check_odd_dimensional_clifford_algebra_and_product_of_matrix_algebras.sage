# 系「奇数次元」の検算。クリフォード代数の中の主張は、準同型 Φ（Φ(a†_i)=c_i、Φ(a_i)=c_i^T）と
# Φ'（Φ'(j(a))=(Φ(a),Φ(a))、Φ'(g)=(Φ(ε),-Φ(ε))）による行列（の組）への像で確かめる。
# 像での確認であり、クリフォード代数の中の主張の証明ではない。M=1,2,3、整数・有理数の厳密計算（ZZ・QQ）。
from itertools import combinations

def N_(i, T):                                     # def_count_of_subset_elements_below_index
    if i == 1:
        return 0
    return N_(i - 1, T) + 1 if (i - 1) in T else N_(i - 1, T)

def sign(n):                                      # def_sign_of_nonnegative_integer
    return ZZ(1) if n == 0 else ZZ(-1) * sign(n - 1)

def oprod(factors, I):                            # def_ordered_product_in_algebra
    r = I
    for f in factors:
        r = r * f
    return r

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def pmul(X, Y):                                   # def_product_of_two_complex_algebras の乗法
    return (X[0] * Y[0], X[1] * Y[1])

def padd(X, Y):
    return (X[0] + Y[0], X[1] + Y[1])

def psc(l, X):
    return (l * X[0], l * X[1])

counts = {'pass': 0, 'neg': 0}
def ok(b):
    assert b
    counts['pass'] += 1

h = QQ(1) / 2
for M in range(1, 4):
    P = power_set(M)
    n = len(P)
    I = identity_matrix(QQ, n)
    Z0 = zero_matrix(QQ, n)
    c = {i: matrix(QQ, n, n, lambda s, t: sign(N_(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
         for i in range(1, M + 1)}                # 生成作用素の行列 = Φ(a†_i)
    ct = {i: c[i].transpose() for i in c}         # 消滅作用素の行列 = Φ(a_i)
    chi = {i: ct[i] * c[i] - c[i] * ct[i] for i in c}          # Φ(χ_i)（def_parity_factor_of_split_clifford_algebra）
    for i in c:
        ok(chi[i] * ct[i] == ct[i])                            # claim_parity_factor_times_annihilation_generator
        ok(ct[i] * chi[i] == -(chi[i] * ct[i]))                # claim_annihilation_generator_anticommutes_with_parity_factor
        ok(chi[i] * c[i] == -c[i])                             # claim_parity_factor_times_creation_generator
        ok(c[i] * chi[i] == -(chi[i] * c[i]))                  # claim_creation_generator_anticommutes_with_parity_factor
        ok(chi[i] * chi[i] == I)                               # claim_square_of_parity_factor_is_one
        for k in c:
            if k != i:
                ok(ct[k] * chi[i] == chi[i] * ct[k])           # claim_generators_commute_with_parity_factor_of_other_number
                ok(c[k] * chi[i] == chi[i] * c[k])
                ok(chi[k] * chi[i] == chi[i] * chi[k])         # claim_parity_factors_with_different_numbers_commute
    E = oprod([chi[i] for i in range(1, M + 1)], I)            # Φ(ε)（def_parity_element_of_split_clifford_algebra）
    ok(E * E == I)                                             # claim_square_of_parity_element_is_one
    for k in c:
        ok(c[k] * E == -(E * c[k]))                            # claim_generators_anticommute_with_parity_element
        ok(ct[k] * E == -(E * ct[k]))
    ok(E == diagonal_matrix(QQ, [sign(len(T)) for T in P]))   # 参考: Φ(ε) は (-1)^{#T} の対角行列（本文では使わない）
    # 否定の対照: 符号を + にした因子 a_i a†_i + a†_i a_i は 1 になり、ε の代わりにすると反交換しない
    bad = oprod([ct[i] * c[i] + c[i] * ct[i] for i in c], I)
    assert bad == I and c[1] * bad != -(bad * c[1]); counts['neg'] += 1
    # 否定の対照: 最後の因子を落とした積は、M 番の生成元と反交換しない
    if M >= 2:
        Ebad = oprod([chi[i] for i in range(1, M)], I)
        assert c[M] * Ebad != -(Ebad * c[M]); counts['neg'] += 1
    set_random_seed(20261112 + M)
    gens = []
    for trial in range(6):
        beta = [QQ.random_element(num_bound=9, den_bound=4) for _ in range(M)]
        xi = [QQ.random_element(num_bound=9, den_bound=4) for _ in range(M)]
        t = QQ.random_element(num_bound=9, den_bound=4)
        G = sum((beta[k] * c[k + 1] for k in range(M)), Z0) + sum((xi[k] * ct[k + 1] for k in range(M)), Z0)  # Φ(γ((x,ξ)))
        qv = sum(beta[k] * xi[k] for k in range(M))            # q_W((x,ξ)) = ξ(x)
        ok(G * G == qv * I)
        ok(G * E + E * G == Z0)                                # claim_image_of_split_space_anticommutes_with_parity_element
        s = QQ.random_element(num_bound=9, den_bound=4)
        ok((G + s * E) * (G + s * E) == (qv + s * s) * I)       # claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity
        phi = (G + t * E, G + (-t) * E)                        # def_map_from_odd_extension_to_pair_of_matrices
        ok(pmul(phi, phi) == psc(qv + t * t, (I, I)))           # claim_square_of_map_from_odd_extension_to_pair_of_matrices
    Pg = (E, -E)                                               # claim_homomorphism_to_pair_of_matrices_on_added_generator
    ok(pmul(Pg, Pg) == (I, I))                                 # claim_square_of_added_generator_is_one の像
    for k in c:
        for X in (c[k], ct[k]):
            ok(padd(pmul(Pg, (X, X)), pmul((X, X), Pg)) == (Z0, Z0))   # claim_added_generator_anticommutes_with_image_of_split_space の像
    Pz = pmul((E, E), Pg)                                      # Φ'(z) = Φ'(j(ε))Φ'(g)
    ok(Pz == (I, -I))                                          # claim_homomorphism_to_pair_of_matrices_on_central_element
    ok(pmul(Pz, Pz) == (I, I))                                 # claim_square_of_central_element_is_one の像
    ep = psc(h, padd((I, I), psc(1, Pz)))
    em = psc(h, padd((I, I), psc(-1, Pz)))                     # Φ'(e_±)
    ok(ep == (I, Z0) and em == (Z0, I))                        # claim_homomorphism_to_pair_of_matrices_on_idempotents
    ok(pmul(ep, ep) == ep and pmul(em, em) == em)              # claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself の像
    ok(pmul(ep, em) == (Z0, Z0) and pmul(em, ep) == (Z0, Z0))  # claim_product_of_different_idempotents_... の像
    ok(padd(ep, em) == (I, I))                                 # claim_sum_of_idempotents_... の像
    ok(padd(ep, psc(-1, em)) == Pz)                            # claim_difference_of_idempotents_... の像
    # Φ∘Ψ の像: Ψ(F)=Σ F_{S,T} a†_S P a_T の Φ による像が F に戻ること（Φ'∘Ψ' = id の第一・第二成分の材料）
    Ad = lambda S: oprod([c[t] if t in S else I for t in range(1, M + 1)], I)
    An = lambda T: oprod([ct[M + 1 - k] if (M + 1 - k) in T else I for k in range(1, M + 1)], I)
    Pv = oprod([ct[i] * c[i] for i in range(1, M + 1)], I)
    PhiPsi = lambda F: sum((F[a, b] * (Ad(P[a]) * Pv) * An(P[b]) for a in range(n) for b in range(n)), Z0)
    for trial in range(3):
        F = random_matrix(QQ, n, n, num_bound=9, den_bound=4)
        Gm = random_matrix(QQ, n, n, num_bound=9, den_bound=4)
        img = padd(pmul((PhiPsi(F), PhiPsi(F)), ep), pmul((PhiPsi(Gm), PhiPsi(Gm)), em))   # Φ'(Ψ'((F,G)))
        ok(img == (F, Gm))                                     # claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity
    # Φ' の像が B×B を張ること: 2M+1 個の生成元の像の、番号順の部分積 2^{2M+1} 個の階数が 2·4^M
    gl = [(c[k], c[k]) for k in c] + [(ct[k], ct[k]) for k in c] + [Pg]
    mons = []
    for r in range(len(gl) + 1):
        for sub in combinations(range(len(gl)), r):
            X = (I, I)
            for a in sub:
                X = pmul(X, gl[a])
            mons.append(X[0].list() + X[1].list())
    ok(matrix(QQ, mons).rank() == 2 * n * n)
    # 否定の対照: Φ'(g) を (Φ(ε),Φ(ε)) にすると、像は対角の組に閉じ込められて階数が 4^M に落ちる
    glb = gl[:-1] + [(E, E)]
    monsb = []
    for r in range(len(glb) + 1):
        for sub in combinations(range(len(glb)), r):
            X = (I, I)
            for a in sub:
                X = pmul(X, glb[a])
            monsb.append(X[0].list() + X[1].list())
    assert matrix(QQ, monsb).rank() == n * n; counts['neg'] += 1
    print("M =", M, "通過")
print("PASS", counts)
