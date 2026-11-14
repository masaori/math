# 系「奇数次元」の検算。クリフォード代数の中の主張は、準同型 Φ（Φ(a†_i)=c_i、Φ(a_i)=c_i^T）と
# Φ'（Φ'∘γ'=φ'。生成元 γ'(in'_1(d_k))・g=γ'(in'_2(1)) の像を φ' の定義から計算し、A' の元の像は生成元の像の積と線型結合で作る）
# による行列（の組）への像で確かめる。Φ(ε) と Φ'(g) は手で置かず、Φ(χ_i) の番号順の積と φ'((0,1)) から計算する。
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
    # ---- Φ' を生成元の像から組み立てる ----
    # V の元は基底 d の座標 y（長さ 2M。d_k=in_1(w_k)、d_{M+k}=in_2(f_k)）で持つ。Φ∘γ は線型写像で、
    # Φ(γ(d_k))=Φ(a†_k)=c_k、Φ(γ(d_{M+k}))=Φ(a_k)=c_k^T なので、Φ(γ(y))=Σ y_k c_k + Σ y_{M+k} c_k^T。
    def PhiGamma(y):
        return sum((y[k] * c[k + 1] for k in range(M)), Z0) + sum((y[M + k] * ct[k + 1] for k in range(M)), Z0)
    def phi_p(y, t):                                           # def_map_from_odd_extension_to_pair_of_matrices
        return (PhiGamma(y) + t * E, PhiGamma(y) + (-t) * E)
    dvec = lambda k: [QQ(1) if l == k else QQ(0) for l in range(2 * M)]   # 基底 d の k+1 番目の座標
    zeroV = [QQ(0)] * (2 * M)
    # Φ'(γ'(in'_1(d_k))) = φ'((d_k,0))。j∘γ=γ'∘in'_1 なので、これが Φ'(j(γ(d_k))) である。
    # claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism の式変形の各行（v:=d_k と乱数の v）
    vs_ = [dvec(k) for k in range(2 * M)] + [[QQ.random_element(num_bound=9, den_bound=4) for _ in range(2 * M)] for _ in range(3)]
    for v in vs_:
        rows = [phi_p(v, QQ(0)),
                (PhiGamma(v) + QQ(0) * E, PhiGamma(v) + (-QQ(0)) * E),
                (PhiGamma(v) + QQ(0) * E, PhiGamma(v) + QQ(0) * E),
                (PhiGamma(v) + Z0, PhiGamma(v) + Z0),
                (PhiGamma(v), PhiGamma(v))]
        for r in range(len(rows) - 1):
            ok(rows[r] == rows[r + 1])
    Gj = {k: phi_p(dvec(k - 1), QQ(0)) for k in range(1, 2 * M + 1)}   # Φ'(j(a†_i))=Gj[i]、Φ'(j(a_i))=Gj[M+i]
    for i in range(1, M + 1):
        ok(Gj[i] == (c[i], c[i]) and Gj[M + i] == (ct[i], ct[i]))
    # 否定の対照: φ' の第二成分で t の符号を反転しない写像は、v の成分が 0 でない限り別の組になる（t=1 で確かめる）
    assert phi_p(dvec(0), QQ(1)) != (PhiGamma(dvec(0)) + E, PhiGamma(dvec(0)) + E); counts['neg'] += 1
    # g=γ'(u)、u=in'_2(1_ℂ)=(0_V,1_ℂ)（def_added_generator_of_odd_extension_clifford_algebra）。
    # claim_homomorphism_to_pair_of_matrices_on_added_generator の式変形の各行
    ok(PhiGamma(zeroV) == Z0)                                  # Φ(γ(0_V))=0_B
    rows = [phi_p(zeroV, QQ(1)),
            (PhiGamma(zeroV) + QQ(1) * E, PhiGamma(zeroV) + (-QQ(1)) * E),
            (Z0 + QQ(1) * E, Z0 + QQ(-1) * E),
            (QQ(1) * E + Z0, QQ(-1) * E + Z0),
            (QQ(1) * E, QQ(-1) * E),
            (E, QQ(-1) * E)]
    for r in range(len(rows) - 1):
        ok(rows[r] == rows[r + 1])
    Pg = phi_p(zeroV, QQ(1))                                   # Φ'(g) を φ' の定義から計算した値
    ok(pmul(Pg, Pg) == (I, I))                                 # claim_square_of_added_generator_is_one の像
    for k in range(1, 2 * M + 1):
        ok(padd(pmul(Pg, Gj[k]), pmul(Gj[k], Pg)) == (Z0, Z0))  # claim_added_generator_anticommutes_with_image_of_split_space の像
    # Φ'(j(χ_i)) = Φ'(j(a_i))Φ'(j(a†_i)) − Φ'(j(a†_i))Φ'(j(a_i))（j と Φ' は準同型、def_parity_factor_of_split_clifford_algebra）
    PjChi = {i: padd(pmul(Gj[M + i], Gj[i]), psc(-1, pmul(Gj[i], Gj[M + i]))) for i in range(1, M + 1)}
    PjE = (I, I)
    for i in range(1, M + 1):                                  # Φ'(j(ε)) = 番号順の積（def_parity_element_of_split_clifford_algebra）
        PjE = pmul(PjE, PjChi[i])
    ok(PjE == (E, E))                                          # claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism の a:=ε
    Pz = pmul(PjE, Pg)                                         # Φ'(z)=Φ'(j(ε))·Φ'(g)（def_central_element_of_odd_dimensional_clifford_algebra）
    # claim_homomorphism_to_pair_of_matrices_on_central_element の式変形の各行
    rows = [Pz,
            pmul((E, E), Pg),
            pmul((E, E), (E, QQ(-1) * E)),
            (E * E, E * (QQ(-1) * E)),
            (E * E, QQ(-1) * (E * E)),
            (I, QQ(-1) * I)]
    for r in range(len(rows) - 1):
        ok(rows[r] == rows[r + 1])
    ok(Pz == (I, -I))
    ok(pmul(Pz, Pz) == (I, I))                                 # claim_square_of_central_element_is_one の像
    # 否定の対照: χ_i の符号を + にすると Φ'(j(ε))=(I,I) になり、Φ'(z) は Φ'(g) のままで (I,-I) にならない
    PjEbad = (I, I)
    for i in range(1, M + 1):
        PjEbad = pmul(PjEbad, padd(pmul(Gj[M + i], Gj[i]), pmul(Gj[i], Gj[M + i])))
    assert pmul(PjEbad, Pg) != (I, -I); counts['neg'] += 1
    # 否定の対照: Φ'(g) の第二成分の符号を反転しないと Φ'(z)=(I,I) になる
    Pg_bad = (PhiGamma(zeroV) + QQ(1) * E, PhiGamma(zeroV) + QQ(1) * E)
    assert pmul(PjE, Pg_bad) != (I, -I); counts['neg'] += 1
    # Φ'(e_σ)=h((I,I)+σΦ'(z))（def_idempotents_of_odd_dimensional_clifford_algebra。Φ' は線型で単位元を保つ）
    ep = psc(h, padd((I, I), psc(1, Pz)))
    em = psc(h, padd((I, I), psc(-1, Pz)))
    ok(ep == (I, Z0))                                          # claim_homomorphism_to_pair_of_matrices_on_idempotents
    ok(em == (Z0, I))
    ok(pmul(ep, ep) == (I, Z0) and pmul(em, em) == (Z0, I))    # claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself の像
    ok(pmul(ep, em) == (Z0, Z0) and pmul(em, ep) == (Z0, Z0))  # claim_product_of_different_idempotents_... の像
    ok(padd(ep, em) == (I, I))                                 # claim_sum_of_idempotents_... の像
    ok(padd(ep, psc(-1, em)) == (I, -I))                       # claim_difference_of_idempotents_... の像（期待値 Φ'(z)=(I,-I)）
    # 否定の対照: σ の符号を入れ替えた e_∓ は期待値と一致しない
    assert psc(h, padd((I, I), psc(-1, Pz))) != (I, Z0); counts['neg'] += 1
    assert psc(h, padd((I, I), psc(1, Pz))) != (Z0, I); counts['neg'] += 1
    # 否定の対照: h を落とした 1±z は冪等でなく、和は (I,I) に、差は (I,-I) にならない
    epb = padd((I, I), Pz); emb = padd((I, I), psc(-1, Pz))
    assert epb != (I, Z0) and pmul(epb, epb) != epb; counts['neg'] += 1
    assert padd(epb, emb) != (I, I); counts['neg'] += 1
    assert padd(epb, psc(-1, emb)) != (I, -I); counts['neg'] += 1
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
    gl = [Gj[k] for k in range(1, 2 * M + 1)] + [Pg]
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
