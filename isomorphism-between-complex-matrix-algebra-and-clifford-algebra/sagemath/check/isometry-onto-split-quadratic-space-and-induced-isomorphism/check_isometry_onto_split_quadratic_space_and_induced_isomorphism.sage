# 対象ラベル: theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra ほか（overview.md を見よ）
# 一般の偶数次元の非退化な二次空間 (Y,Q) を Y:=K^{2M}、Q(x):=x^T A x（A は有理数の対称行列、行列式が 0 でない）とし、
# 本文の証明の手順（直交基底 → 平方根で正規化 → 族 u・v と θ:=L_{e,u}、θ':=L_{d,v}）をそのまま実装して各主張を厳密計算で確かめる。
# K は QQbar（代数的数）。平方根は本文の主張の証明の場合分けを AA（実代数的数）で実装する。
# クリフォード代数の中の主張は、行列環 Mat_{P_M}(K) への像（Φ∘Cl(θ) は γ_Y(y) を φ(θ(y)) へ移す）で確かめる。
from itertools import combinations
set_random_seed(20261112)
K = QQbar
I_ = K(I)

# ---- ℂ の元の平方根（claim_existence_of_square_root_in_complex_numbers）----
def sqrt_by_proof(z):
    z = K(z)
    a = AA(z.real()); b = AA(z.imag())
    if b == 0 and a >= 0:
        u, v = a.sqrt(), AA(0)
    elif b == 0:
        u, v = AA(0), (-a).sqrt()
    else:
        r = (a * a + b * b).sqrt()
        assert r >= 0 and r * r == a * a + b * b and r * r > a * a
        assert r + a > 0                                    # 本文の r+a>0
        u = ((r + a) / 2).sqrt()
        assert u * u == (r + a) / 2 and u != 0
        v = b / (2 * u)
    assert u * u - v * v == a and 2 * u * v == b            # (★)
    s = K(u) + I_ * K(v)
    assert s * s == z
    return s

sq_cases = [QQ(4), QQ(0), QQ(-9), QQ(2), QQ(-3), K(3 + 4 * I), K(-5 - 12 * I), K(1 / 2 - 7 / 3 * I), K(-2 * I), K(-1 + I)]
for z in sq_cases + [K(QQ.random_element(num_bound=9, den_bound=4) + QQ.random_element(num_bound=9, den_bound=4) * I) for _ in range(20)]:
    sqrt_by_proof(z)
# 否定の対照: v の符号を逆にすると 2uv=-b になり、b≠0 では平方が z にならない
bad = 0
for z in sq_cases:
    z = K(z); a = AA(z.real()); b = AA(z.imag())
    if b != 0:
        r = (a * a + b * b).sqrt(); u = ((r + a) / 2).sqrt(); v = -b / (2 * u)
        bad += int((K(u) + I_ * K(v)) ** 2 != z)
assert bad == 5

def lin_comb(nu, fam):                                       # def_linear_combination（左から足す）
    L = 0 * fam[0]
    for k in range(len(fam)):
        L = L + nu[k] * fam[k]
    return L

def L_map(basis, fam):                                       # def_map_by_coordinates_and_family
    Binv = matrix(K, basis).transpose().inverse()            # 座標の写像 β^b_k(x) は Binv*x の第 k 成分
    return lambda x: lin_comb(list(Binv * x), fam)

def orthogonal_basis(A, n, q, B):                            # claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form の手順
    e = [vector(K, [1 if i == j else 0 for i in range(n)]) for j in range(n)]
    for k in range(n):
        if q(e[k]) == 0:
            j = next(j for j in range(k + 1, n) if B(e[k], e[j]) != 0)
            t = 1 if q(e[k] + e[j]) != 0 else -1
            e[k] = e[k] + t * e[j]
        d = B(e[k], e[k])
        for r in range(k + 1, n):
            e[r] = e[r] - (B(e[r], e[k]) / d) * e[k]
    return e

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def N_(i, T):
    return len([t for t in T if t < i])

stats = {"cases": 0, "neg_u": 0, "neg_h": 0}
for M in [1, 2, 3]:
    n = 2 * M
    examples = [diagonal_matrix(QQ, [1] * n), diagonal_matrix(QQ, [-1, 2] * M)]
    J = block_matrix(QQ, [[zero_matrix(QQ, M), identity_matrix(QQ, M) / 2], [identity_matrix(QQ, M) / 2, zero_matrix(QQ, M)]])
    examples.append(J)                                       # 対角成分がすべて 0 の形（取り替えの段を通る）
    while len(examples) < 4:
        R = random_matrix(QQ, n, n, num_bound=4, den_bound=2)
        A = R + R.transpose()
        if A.det() != 0:
            examples.append(A)
    for A in examples:
        stats["cases"] += 1
        A = A.change_ring(K)
        Q = lambda x: x * A * x
        BQ = lambda x, y: Q(x + y) - Q(x) - Q(y)
        et = orthogonal_basis(A, n, Q, BQ)
        assert matrix(K, et).rank() == n
        assert all(BQ(et[i], et[j]) == 0 for i in range(n) for j in range(n) if i != j) and all(Q(x) != 0 for x in et)
        # 正規化（claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form、claim_nonzero_scalar_multiples_of_basis_members_form_basis）
        s = [sqrt_by_proof(Q(x)) for x in et]
        e = [(1 / s[k]) * et[k] for k in range(n)]
        assert matrix(K, e).rank() == n
        assert all(Q(x) == 1 for x in e) and all(BQ(e[i], e[j]) == 0 for i in range(n) for j in range(n) if i != j)
        # 直交する族の線型結合での値（claim_quadratic_form_of_linear_combination_of_orthogonal_family）
        for _ in range(3):
            nu = [K(QQ.random_element(num_bound=5, den_bound=3)) for _ in range(n)]
            assert Q(lin_comb(nu, et)) == sum(nu[k] * (nu[k] * Q(et[k])) for k in range(n))
        # 分裂した二次空間 V=W⊕W^*（W=K^M、w は標準基底、f はその双対基底）。V の元を (x;g) の 2M 成分の列で表す。
        qW = lambda y: sum(y[M + k] * y[k] for k in range(M))                  # q_W((x,g))=g(x)
        Bq = lambda y, z: qW(y + z) - qW(y) - qW(z)
        wv = lambda m: vector(K, [1 if k == m else 0 for k in range(M)] + [0] * M)   # in_1(w_m)
        fv = lambda m: vector(K, [0] * M + [1 if k == m else 0 for k in range(M)])   # in_2(f_m)
        d = [wv(m) for m in range(M)] + [fv(m) for m in range(M)]               # 基底 d
        u = [wv(m) + fv(m) for m in range(M)] + [(-I_) * wv(m) + I_ * fv(m) for m in range(M)]   # def_family_in_split_space_for_isometry
        h = 1 / K(2)
        v = [h * (e[m] + I_ * e[M + m]) for m in range(M)] + [h * (e[m] + (-I_) * e[M + m]) for m in range(M)]   # def_family_in_general_space_for_inverse_isometry
        assert all(qW(x) == 1 for x in u)                                       # claim_quadratic_form_on_family_in_split_space_is_one
        assert all(Bq(u[k], u[l]) == 0 for k in range(n) for l in range(n) if k != l)   # claim_family_in_split_space_is_orthogonal
        th = L_map(e, u)                                                        # def_map_to_split_quadratic_space
        thp = L_map(d, v)                                                       # def_map_from_split_quadratic_space
        assert all(th(e[k]) == u[k] for k in range(n)) and all(thp(d[l]) == v[l] for l in range(n))
        assert all(thp(u[k]) == e[k] for k in range(n))                         # claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis
        assert all(th(v[l]) == d[l] for l in range(n))                          # claim_map_to_split_quadratic_space_sends_family_to_basis
        Th = matrix(K, [th(x) for x in identity_matrix(K, n).rows()]).transpose()
        Thp = matrix(K, [thp(x) for x in identity_matrix(K, n).rows()]).transpose()
        assert Thp * Th == identity_matrix(K, n) and Th * Thp == identity_matrix(K, n)   # 二つの合成は恒等写像
        for _ in range(3):
            x = vector(K, [QQ.random_element(num_bound=5, den_bound=3) for _ in range(n)])
            y = vector(K, [QQ.random_element(num_bound=5, den_bound=3) for _ in range(n)])
            assert th(x + 3 * y) == th(x) + 3 * th(y)                           # θ は線型
            assert qW(th(x)) == Q(x)                                            # claim_map_to_split_quadratic_space_is_isometry
            assert Q(thp(y)) == qW(y)                                           # claim_map_from_split_quadratic_space_is_isometry
        # 否定の対照: u_{M+m} の第一成分の符号を i にすると q(u_{M+m})=-1 になり、等長写像でなくなる
        u_bad = u[:M] + [I_ * wv(m) + I_ * fv(m) for m in range(M)]
        x = e[M]
        stats["neg_u"] += int(qW(L_map(e, u_bad)(x)) != Q(x))
        # 否定の対照: v から h を落とすと θ'∘θ は恒等写像の 2 倍になる
        v_bad = [(e[m] + I_ * e[M + m]) for m in range(M)] + [(e[m] + (-I_) * e[M + m]) for m in range(M)]
        Thp_bad = matrix(K, [L_map(d, v_bad)(x) for x in identity_matrix(K, n).rows()]).transpose()
        stats["neg_h"] += int(Thp_bad * Th == 2 * identity_matrix(K, n))
        print("M =", M, "case", stats["cases"], "ok", flush=True)
    # ---- 行列環への像（Φ∘Cl(θ) と Cl(θ')∘Ψ）----
    P = power_set(M); nP = len(P)
    KI = QuadraticField(-1, 'ii'); ii = KI.gen()
    c = {i: matrix(KI, nP, nP, lambda s_, t_: (-1) ** N_(i, P[t_]) if (i not in P[t_] and P[s_] == P[t_] | {i}) else 0) for i in range(1, M + 1)}
    ct = {i: c[i].transpose() for i in c}
    Id = identity_matrix(KI, nP)
    phi = lambda y: sum((y[k] * c[k + 1] for k in range(M)), 0 * Id) + sum((y[M + k] * ct[k + 1] for k in range(M)), 0 * Id)   # def_matrix_valued_map_on_split_quadratic_space
    # γ_Y(e_k) の Φ∘Cl(θ) による像は φ(θ(e_k))=φ(u_k)。u の成分は {0,±1,±i} なので KI で厳密に計算できる。
    uK = [vector(KI, [1 if k == m else 0 for k in range(M)] + [1 if k == m else 0 for k in range(M)]) for m in range(M)] + \
         [vector(KI, [-ii if k == m else 0 for k in range(M)] + [ii if k == m else 0 for k in range(M)]) for m in range(M)]
    G = [phi(x) for x in uK]
    for k in range(n):
        for l in range(n):
            assert G[k] * G[l] + G[l] * G[k] == (2 if k == l else 0) * Id      # φ∘θ は普遍性の条件 f(y)^2=Q(y)1 を正規直交基底で満たす
    # 単調な積 G_{k_1}…G_{k_r}（k_1<…<k_r）の 4^M 個が行列環を張る（Φ_Y の全射性の像での裏取り）
    mons = []
    for r in range(n + 1):
        for S in combinations(range(n), r):
            Mx = Id
            for k in S:
                Mx = Mx * G[k]
            mons.append(Mx.list())
    assert matrix(KI, mons).rank() == nP * nP
    # Φ_Y(Ψ_Y(c_i)) = φ(θ(θ'(d_i))) = φ(θ(v_i)) = c_i：θ(v_l)=d_l の像
    vK = [(uK[m] + ii * uK[M + m]) / 2 for m in range(M)] + [(uK[m] - ii * uK[M + m]) / 2 for m in range(M)]   # θ(v_l)=h(θ(e_m)±iθ(e_{M+m}))
    assert all(phi(vK[m]) == c[m + 1] and phi(vK[M + m]) == ct[m + 1] for m in range(M))
print(stats)
assert stats["neg_u"] == stats["cases"] and stats["neg_h"] == stats["cases"]
print("PASS")
