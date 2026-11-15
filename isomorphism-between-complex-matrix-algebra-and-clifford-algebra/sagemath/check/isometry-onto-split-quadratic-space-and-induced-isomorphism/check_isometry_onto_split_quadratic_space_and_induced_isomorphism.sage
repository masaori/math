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
    A_, B_ = K(u), K(v)
    # 本文の s·s の式変形の各行（乗法・加法の法則を一つずつ当てた形）を独立に計算して隣と比べる
    rows = [s * s,
            (A_ + I_ * B_) * (A_ + I_ * B_),
            A_ * (A_ + I_ * B_) + (I_ * B_) * (A_ + I_ * B_),
            (A_ * A_ + A_ * (I_ * B_)) + ((I_ * B_) * A_ + (I_ * B_) * (I_ * B_)),
            (A_ * A_ + (A_ * I_) * B_) + (I_ * (B_ * A_) + ((I_ * B_) * I_) * B_),
            (A_ * A_ + (I_ * A_) * B_) + (I_ * (B_ * A_) + (I_ * (I_ * B_)) * B_),
            (A_ * A_ + I_ * (A_ * B_)) + (I_ * (B_ * A_) + ((I_ * I_) * B_) * B_),
            (A_ * A_ + I_ * (A_ * B_)) + (I_ * (B_ * A_) + (I_ * I_) * (B_ * B_)),
            (A_ * A_ + I_ * (A_ * B_)) + (I_ * (B_ * A_) + (-1) * (B_ * B_)),
            (A_ * A_ + I_ * (A_ * B_)) + (I_ * (B_ * A_) + (-(B_ * B_))),
            A_ * A_ + (I_ * (A_ * B_) + (I_ * (B_ * A_) + (-(B_ * B_)))),
            A_ * A_ + ((I_ * (A_ * B_) + I_ * (B_ * A_)) + (-(B_ * B_))),
            A_ * A_ + ((-(B_ * B_)) + (I_ * (A_ * B_) + I_ * (B_ * A_))),
            (A_ * A_ + (-(B_ * B_))) + (I_ * (A_ * B_) + I_ * (B_ * A_)),
            (A_ * A_ + (-(B_ * B_))) + I_ * (A_ * B_ + B_ * A_),
            (K(u * u) + (-K(v * v))) + I_ * (K(u * v) + K(v * u)),
            (K(u * u) + K(-(v * v))) + I_ * (K(u * v) + K(v * u)),
            K(u * u + (-(v * v))) + I_ * K(u * v + v * u),
            K(u * u - v * v) + I_ * K(u * v + v * u),
            K(u * u - v * v) + I_ * K(2 * u * v),
            K(a) + I_ * K(b),
            z]
    assert all(rows[i] == rows[i + 1] for i in range(len(rows) - 1))
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

stats = {"cases": 0, "neg_u": 0, "neg_h": 0, "neg_psi": 0, "neg_fix": 0, "neg_um": 0}
import random as _pyrandom
_local_rng = _pyrandom.Random(int(20261114))
def rnd_q():
    # 一行ずつの検算で使う有理数。大域の乱数の状態を消費しないので、乱数の例の行列は前の版の検算と同じになる
    return QQ(_local_rng.randint(int(-5), int(5))) / QQ(_local_rng.randint(int(1), int(3)))

def ordered_matrix_product(mats, Id):
    X = Id
    for Y_ in mats:
        X = X * Y_
    return X

def Psi_evaluated(F, P, adag, ann, Id):
    # def_homomorphism_from_matrix_algebra_to_clifford_algebra：Ψ(F)=Σ_{S,T} F_{S,T} a†_S P a_T を、
    # 生成元 a†_i・a_i を行列 adag[i]・ann[i] に置き換えて評価する（a†_S は小さい順、a_T は大きい順の積、
    # P=a_1a†_1⋯a_Ma†_M）。ℂ-代数の準同型は生成元の像で決まるので、これが像 Θ(Ψ(F)) である。
    M_ = len(adag)
    Pm = ordered_matrix_product([ann[i] * adag[i] for i in range(1, M_ + 1)], Id)
    tot = 0 * Id
    for si, S in enumerate(P):
        for ti, T in enumerate(P):
            if F[si, ti] != 0:
                aS = ordered_matrix_product([adag[i] for i in sorted(S)], Id)
                aT = ordered_matrix_product([ann[i] for i in sorted(T, reverse=True)], Id)
                tot = tot + F[si, ti] * (aS * Pm * aT)
    return tot

for M in [1, 2, 3]:
    n = 2 * M
    PK = power_set(M); nPK = len(PK)
    cK = {i: matrix(QQ, nPK, nPK, lambda s_, t_: (-1) ** N_(i, PK[t_]) if (i not in PK[t_] and PK[s_] == PK[t_] | {i}) else 0) for i in range(1, M + 1)}
    ctK = {i: cK[i].transpose() for i in cK}
    IdK = identity_matrix(QQ, nPK)
    cKbar = {i: cK[i].change_ring(K) for i in cK}; ctKbar = {i: ctK[i].change_ring(K) for i in ctK}; IdKbar = IdK.change_ring(K)
    phiKbar = lambda y: sum((y[k] * cKbar[k + 1] for k in range(M)), 0 * IdKbar) + sum((y[M + k] * ctKbar[k + 1] for k in range(M)), 0 * IdKbar)
    toQQ = lambda y: vector(QQ, [QQ(t) for t in y])          # 成分が有理数の代数的数を有理数へ（成分が有理数でなければ失敗する）
    phiK = lambda y: sum((y[k] * cK[k + 1] for k in range(M)), 0 * IdK) + sum((y[M + k] * ctK[k + 1] for k in range(M)), 0 * IdK)
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
        # claim_linear_map_fixing_basis_members_is_identity：F:=L_{e,e} は基底 e を動かさない線型写像。F(x)=x の式変形の各行
        Binv_e = matrix(K, e).transpose().inverse()
        Fm = L_map(e, e)
        assert all(Fm(e[k]) == e[k] for k in range(n))
        x = vector(K, [rnd_q() for _ in range(n)])
        beta = list(Binv_e * x)
        rows = [Fm(x), Fm(lin_comb(beta, e)), lin_comb(beta, [Fm(e[k]) for k in range(n)]), lin_comb(beta, e), x]
        assert all(rows[i] == rows[i + 1] for i in range(len(rows) - 1))
        # 否定の対照：最後の基底の元だけを 2 倍する線型写像 F_bad（他の基底の元は動かさない）では、F_bad(e_k)=e_k を当てる行が落ち、
        # β_n(x)≠0 の x で F_bad(x)≠x になる（仮定「すべての基底の元を動かさない」を一つ外すと結論が成り立たない）
        Fbad = lambda y: lin_comb([c_ * (2 if k == n - 1 else 1) for k, c_ in enumerate(Binv_e * y)], e)
        xb = x if beta[n - 1] != 0 else x + e[n - 1]
        betab = list(Binv_e * xb)
        assert Fbad(lin_comb(betab, e)) == lin_comb(betab, [Fbad(e[k]) for k in range(n)])       # 線型写像の行は通る
        stats["neg_fix"] += int(lin_comb(betab, [Fbad(e[k]) for k in range(n)]) != lin_comb(betab, e) and Fbad(xb) != xb)
        # claim_linear_right_inverse_of_isometry_is_isometry：θ を等長写像、θ' をその右逆写像として q(θ'(y))=q'(θ(θ'(y)))=q'(y)
        y = vector(K, [rnd_q() for _ in range(n)])
        rows = [Q(thp(y)), qW(th(thp(y))), qW(y)]
        assert all(rows[i] == rows[i + 1] for i in range(len(rows) - 1))
        # claim_existence_and_uniqueness_of_homomorphism_of_clifford_algebras_induced_by_isometry：g:=γ∘θ が
        # g(v)g(v)=q(θ(v))1=Q(v)1 を満たすことを、Φ による行列環への像 φ(θ(v)) で確かめる（像での確認）
        x = vector(K, [rnd_q() for _ in range(n)])
        Gx = phiKbar(th(x))
        assert Gx * Gx == qW(th(x)) * IdKbar == Q(x) * IdKbar
        # θ'(u_{M+m})=e_{M+m} と θ(v_l)=d_l の式変形を一行ずつ（直和の元は (W の成分, W^* の成分) の組で持つ）
        pair = lambda a_, b_: vector(K, list(a_) + list(b_))
        wW = lambda m: vector(K, [1 if k == m else 0 for k in range(M)])
        fW = lambda m: vector(K, [1 if k == m else 0 for k in range(M)])
        zW = vector(K, [0] * M)
        for m in range(M):
            ep_ = e[M + m]
            prep3 = [(-I_) * h + I_ * h, ((-I_) + I_) * h, 0 * h, K(0)]
            prep4 = [((-I_) * h) * I_ + (I_ * h) * (-I_), (-I_) * (h * I_) + I_ * (h * (-I_)), (-I_) * (I_ * h) + I_ * ((-I_) * h),
                     ((-I_) * I_) * h + (I_ * (-I_)) * h, 1 * h + 1 * h, (1 + 1) * h, K(1)]
            assert all(r[i] == r[i + 1] for r in [prep3, prep4] for i in range(len(r) - 1))
            # claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis の k=m の場合：u_m の表示の 3 行と θ'(u_m)=e_m の 15 行
            one_ = K(1)
            rows = [u[m], pair(wW(m), fW(m)), pair(wW(m), zW) + pair(zW, fW(m)), d[m] + d[M + m]]
            assert all(rows[i] == rows[i + 1] for i in range(len(rows) - 1))
            rows = [thp(u[m]), thp(d[m] + d[M + m]), thp(d[m]) + thp(d[M + m]), v[m] + v[M + m],
                    h * (e[m] + I_ * ep_) + h * (e[m] + (-I_) * ep_),
                    h * ((e[m] + I_ * ep_) + (e[m] + (-I_) * ep_)),
                    h * ((e[m] + e[m]) + (I_ * ep_ + (-I_) * ep_)),
                    h * ((one_ * e[m] + one_ * e[m]) + (I_ * ep_ + (-I_) * ep_)),
                    h * ((one_ + one_) * e[m] + (I_ + (-I_)) * ep_),
                    h * ((one_ + one_) * e[m] + K(0) * ep_),
                    h * ((one_ + one_) * e[m] + vector(K, [0] * n)),
                    h * ((one_ + one_) * e[m]),
                    (h * (one_ + one_)) * e[m],
                    one_ * e[m],
                    e[m]]
            assert len(rows) == 15 and all(rows[i] == rows[i + 1] for i in range(len(rows) - 1))
            # 否定の対照：v_{M+m} の i の符号を v_m と同じにすると、θ'(u_m) は e_m にならない（e' の係数が 0 にならない）
            stats["neg_um"] += int(v[m] + h * (e[m] + I_ * ep_) != e[m])
            rows = [thp(u[M + m]), thp(pair((-I_) * wW(m), I_ * fW(m))), thp(pair((-I_) * wW(m), zW) + pair(zW, I_ * fW(m))),
                    thp((-I_) * d[m] + I_ * d[M + m]), thp((-I_) * d[m]) + thp(I_ * d[M + m]), (-I_) * thp(d[m]) + I_ * thp(d[M + m]),
                    (-I_) * v[m] + I_ * v[M + m],
                    (-I_) * (h * (e[m] + I_ * ep_)) + I_ * (h * (e[m] + (-I_) * ep_)),
                    ((-I_) * h) * (e[m] + I_ * ep_) + (I_ * h) * (e[m] + (-I_) * ep_),
                    (((-I_) * h) * e[m] + ((-I_) * h) * (I_ * ep_)) + ((I_ * h) * e[m] + (I_ * h) * ((-I_) * ep_)),
                    (((-I_) * h) * e[m] + (((-I_) * h) * I_) * ep_) + ((I_ * h) * e[m] + ((I_ * h) * (-I_)) * ep_),
                    (((-I_) * h) * e[m] + (I_ * h) * e[m]) + ((((-I_) * h) * I_) * ep_ + ((I_ * h) * (-I_)) * ep_),
                    ((-I_) * h + I_ * h) * e[m] + (((-I_) * h) * I_ + (I_ * h) * (-I_)) * ep_,
                    0 * e[m] + 1 * ep_, ep_]
            assert all(rows[i] == rows[i + 1] for i in range(len(rows) - 1))
            for sgn in [1, -1]:
                c_ = sgn * I_
                rows = [th(v[m] if sgn == 1 else v[M + m]), th(h * (e[m] + c_ * ep_)), h * th(e[m] + c_ * ep_), h * (th(e[m]) + th(c_ * ep_)),
                        h * (th(e[m]) + c_ * th(ep_)), h * (u[m] + c_ * u[M + m]),
                        h * (pair(wW(m), fW(m)) + c_ * pair((-I_) * wW(m), I_ * fW(m))),
                        h * (pair(wW(m), fW(m)) + pair(c_ * ((-I_) * wW(m)), c_ * (I_ * fW(m)))),
                        h * pair(wW(m) + c_ * ((-I_) * wW(m)), fW(m) + c_ * (I_ * fW(m))),
                        h * pair(wW(m) + (c_ * (-I_)) * wW(m), fW(m) + (c_ * I_) * fW(m)),
                        h * pair((1 + c_ * (-I_)) * wW(m), (1 + c_ * I_) * fW(m))]
                assert all(rows[i] == rows[i + 1] for i in range(len(rows) - 1))
                assert rows[-1] == (d[m] if sgn == 1 else d[M + m])
        # Φ_Y(Ψ_Y(c_m))=c_m：Ψ_Y=Cl(θ')∘Ψ、Φ_Y=Φ∘Cl(θ)。Cl(θ') は a†_i=γ(d_i)・a_i=γ(d_{M+i}) を γ_Y(v_i)・γ_Y(v_{M+i}) へ、
        # Φ∘Cl(θ) は γ_Y(y) を φ(θ(y)) へ移すので、Ψ の式の生成元を φ(θ(v_i))・φ(θ(v_{M+i})) に置き換えて評価する（θ は th で計算する）。
        adagY = {i: phiK(toQQ(th(v[i - 1]))) for i in range(1, M + 1)}
        annY = {i: phiK(toQQ(th(v[M + i - 1]))) for i in range(1, M + 1)}
        for i in range(1, M + 1):
            assert Psi_evaluated(cK[i], PK, adagY, annY, IdK) == cK[i]
            assert Psi_evaluated(ctK[i], PK, adagY, annY, IdK) == ctK[i]
        # 否定の対照：a_i の像を a†_i の像に取り違えると c_m に戻らない
        stats["neg_psi"] += int(Psi_evaluated(cK[1], PK, adagY, adagY, IdK) != cK[1])
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
print(stats, flush=True)
assert stats["neg_u"] == stats["cases"] and stats["neg_h"] == stats["cases"] and stats["neg_psi"] == stats["cases"] and stats["neg_fix"] == stats["cases"] and stats["neg_um"] > 0
print("PASS")
