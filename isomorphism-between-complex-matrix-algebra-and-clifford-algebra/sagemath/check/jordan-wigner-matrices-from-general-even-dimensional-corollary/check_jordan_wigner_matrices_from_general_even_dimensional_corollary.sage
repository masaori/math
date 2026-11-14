# 系「複素行列版イジングの Jordan–Wigner 行列への接続」の検算（M=1,2,3、QQbar の厳密計算）。
# 行列の添字は P_M の元（frozenset）。行列は辞書 (S,T)->値 で持ち、番号付けを使わずに定義どおり計算する。
from itertools import product as iprod
import random
random.seed(int(20261113))
i_ = QQbar(I)            # 本文の i（i*i = -1 を満たす元の一つ）
h = QQbar(1)/2           # 本文の h=(1+1)^{-1}
passed = 0
def ok(c, msg):
    global passed
    assert c, msg
    passed += 1
def subsets(M):
    return [frozenset(t for t in range(1, M+1) if (k >> (t-1)) & 1) for k in range(2**M)]
def o(T, k):             # def_membership_index_of_subset
    return 2 if k in T else 1
def mat2(a11, a12, a21, a22):
    return {(1,1):QQbar(a11),(1,2):QQbar(a12),(2,1):QQbar(a21),(2,2):QQbar(a22)}
def mul(A, B, X):        # def_matrices_indexed_by_finite_set の積（X の上の和）
    return {(x,y): sum(A[(x,z)]*B[(z,y)] for z in X) for x in X for y in X}
def add(A, B): return {k: A[k]+B[k] for k in A}
def smul(l, A): return {k: l*A[k] for k in A}
def ident(X): return {(x,y): QQbar(1 if x==y else 0) for x in X for y in X}
def prodC(xs):
    p = QQbar(1)
    for x in xs: p *= x
    return p
def kron(M, A):          # def_kronecker_product_indexed_by_power_set, A: list index k-1
    P = subsets(M)
    return {(S,T): prodC([A[k-1][(o(S,k),o(T,k))] for k in range(1, M+1)]) for S in P for T in P}
X2 = [1,2]
sx = mat2(0,1,1,0); sy = mat2(0,-i_,i_,0); sz = mat2(1,0,0,-1); I2 = ident(X2)
K = mat2(1,1,1,-1); Kp = mat2(h,h,h,-h)
E21 = mat2(0,0,1,0); E12 = mat2(0,1,0,0)
# --- 2x2 の主張 ---
ok(i_*i_ == -1, "i*i=-1")
ok(h+h == 1, "h+h=1")
for (lam, lamp) in [(1,1), (-i_, i_), (QQbar(3)/7, -2)]:
    D = add(smul(lam, E21), smul(lamp, E12))   # claim_entries_of_combination_of_off_diagonal_matrix_units
    ok(D == mat2(0, lamp, lam, 0), "D entries")
ok(mul(K, Kp, X2) == I2, "K K' = 1")
ok(mul(Kp, K, X2) == I2, "K' K = 1")
ok(mul(K, sz, X2) == mul(sx, K, X2), "K sz = sx K")
G = add(smul(1, E21), smul(1, E12)); ok(mul(K, G, X2) == mul(sz, K, X2), "K G = sz K")
Gp = add(smul(-i_, E21), smul(i_, E12)); ok(mul(K, Gp, X2) == mul(sy, K, X2), "K G' = sy K")
# 2x2 の積の成分（claim_entry_of_product_of_matrices_indexed_by_two_element_set）
for _ in range(20):
    A = mat2(*[QQbar(int(random.randint(-5,5))) for _ in range(4)]); B = mat2(*[QQbar(int(random.randint(-5,5))) for _ in range(4)])
    AB = mul(A, B, X2)
    for a in X2:
        for b in X2:
            ok(AB[(a,b)] == A[(a,1)]*B[(1,b)] + A[(a,2)]*B[(2,b)], "2x2 entry")
# ℂ の番号順の積の補題
for _ in range(20):
    k = int(random.randint(0,6)); al = [QQbar(int(random.randint(-4,4))) for _ in range(k)]; be = [QQbar(int(random.randint(-4,4))) for _ in range(k)]
    ok(prodC(al)*prodC(be) == prodC([a*b for a,b in zip(al,be)]), "product of two ordered products")
    if k >= 1:
        r = int(random.randint(0,k)); al2 = al[:r] + [QQbar(1)]*(k-r)
        ok(prodC(al2) == prodC(al2[:r]), "unit factors after index")
        rr = int(random.randint(1,k)); al3 = list(al); al3[rr-1] = 0
        ok(prodC(al3) == 0, "zero factor")
def N(i, T):             # def_count_of_subset_elements_below_index（帰納的定義）
    n = 0
    for t in range(2, i+1):
        if t-1 in T: n += 1
    return n
def vs(n): return QQbar((-1)**n)   # def_sign_of_nonnegative_integer
def cmat(M, m):          # def_creation_operator_matrix
    P = subsets(M)
    return {(S,T): (vs(N(m,T)) if (m not in T and S == T|{m}) else QQbar(0)) for S in P for T in P}
def transp(C): return {(S,T): C[(T,S)] for (S,T) in C}
for M in [1,2,3]:
    P = subsets(M)
    # 部分集合全体の上の和と因子の和の積
    for _ in range(5):
        x = [QQbar(int(random.randint(-3,3))) for _ in range(M)]; y = [QQbar(int(random.randint(-3,3))) for _ in range(M)]
        lhs = sum(prodC([x[k-1] if k in R else y[k-1] for k in range(1,M+1)]) for R in P)
        ok(lhs == prodC([y[k]+x[k] for k in range(M)]), "sum over P_M of selected products")
    # クロネッカー積の積・単位行列・一つの因子の線型性
    for _ in range(3):
        A = [mat2(*[QQbar(int(random.randint(-2,2))) for _ in range(4)]) for _ in range(M)]
        Bf = [mat2(*[QQbar(int(random.randint(-2,2))) for _ in range(4)]) for _ in range(M)]
        ok(mul(kron(M,A), kron(M,Bf), P) == kron(M, [mul(A[k],Bf[k],X2) for k in range(M)]), "kron multiplicative")
        r = int(random.randint(1,M)); l1 = QQbar(int(random.randint(-3,3))); l2 = QQbar(int(random.randint(-3,3)))
        App = [A[k] if k != r-1 else add(smul(l1, A[k]), smul(l2, Bf[k])) for k in range(M)]
        Ap2 = [A[k] if k != r-1 else Bf[k] for k in range(M)]
        ok(kron(M, App) == add(smul(l1, kron(M,A)), smul(l2, kron(M,Ap2))), "kron linear in one factor")
    ok(kron(M, [I2]*M) == ident(P), "kron of identities")
    U = kron(M, [K]*M); Up = kron(M, [Kp]*M)
    ok(mul(U, Up, P) == ident(P), "U U' = 1"); ok(mul(Up, U, P) == ident(P), "U' U = 1")
    for m in range(1, M+1):
        c = cmat(M, m); cT = transp(c)
        # 符号の補題: 前の m-1 個の σ^z の対角成分の積
        for T in P:
            ok(prodC([sz[(o(T,k),o(T,k))] for k in range(1,m)]) == vs(N(m,T)), "sign lemma")
        A = [sz if k < m else (E21 if k == m else I2) for k in range(1, M+1)]
        Ap = [sz if k < m else (E12 if k == m else I2) for k in range(1, M+1)]
        ok(c == kron(M, A), "c_m kronecker form"); ok(cT == kron(M, Ap), "c_m^T kronecker form")
        Z = kron(M, [sx if k < m else (sz if k == m else I2) for k in range(1, M+1)])
        Y = kron(M, [sx if k < m else (sy if k == m else I2) for k in range(1, M+1)])
        X = add(c, cT); Xy = add(smul(-i_, c), smul(i_, cT))
        ok(mul(mul(U, X, P), Up, P) == Z, "U (c+c^T) U' = Z_m")
        ok(mul(mul(U, Xy, P), Up, P) == Y, "U ((-i)c + i c^T) U' = Y_m")
        # 否定の対照: K' を K のままにすると 2^M 倍になる、σ^y の代わりに -σ^y では一致しない
        ok(mul(mul(U, X, P), U, P) != Z, "control: without h")
        Ym = kron(M, [sx if k < m else (smul(-1, sy) if k == m else I2) for k in range(1, M+1)])
        ok(mul(mul(U, Xy, P), Up, P) != Ym, "control: sign of sigma^y")
    # Z_m, Y_m の反交換関係（同型の像として 2δ I になること。裏取り）
    gens = []
    for m in range(1, M+1):
        gens.append(kron(M, [sx if k < m else (sz if k == m else I2) for k in range(1, M+1)]))
    for m in range(1, M+1):
        gens.append(kron(M, [sx if k < m else (sy if k == m else I2) for k in range(1, M+1)]))
    for a in range(2*M):
        for b in range(2*M):
            ac = add(mul(gens[a], gens[b], P), mul(gens[b], gens[a], P))
            ok(ac == smul(2 if a == b else 0, ident(P)), "Jordan-Wigner anticommutation")

negs = 0
def neg(c, msg):
    # 否定の対照：c が真（一致しない）であることを確かめる
    global negs
    assert c, msg
    negs += 1

# ==== 途中の行：c_m + c_m^T = ⊠G_k、(U(⊠G))U' から Z_m まで、Y の側の同じ形（本文の式変形の各行）====
one = QQbar(1)
for M in [1,2,3]:
    P = subsets(M)
    U = kron(M, [K]*M); Up = kron(M, [Kp]*M); IdP = ident(P)
    for m in range(1, M+1):
        c = cmat(M, m); cT = transp(c)
        A_ = [sz if k < m else (E21 if k == m else I2) for k in range(1, M+1)]     # claim_creation_operator_matrix_is_kronecker_product の族
        Ap_ = [sz if k < m else (E12 if k == m else I2) for k in range(1, M+1)]    # claim_annihilation_operator_matrix_is_kronecker_product の族
        for (lam, lamp, Fm, JW, nm) in [(one, one, sz, None, "Z"), (-i_, i_, sy, None, "Y")]:
            Gm = add(smul(lam, E21), smul(lamp, E12))                              # G_m / G'_m
            Gk = [A_[k-1] if k != m else Gm for k in range(1, M+1)]
            Fk = [sx if k < m else (Fm if k == m else I2) for k in range(1, M+1)]  # Z_m / Y_m の第 k 因子
            JWm = kron(M, Fk)                                                      # def_jordan_wigner_z_matrix / def_jordan_wigner_y_matrix
            X = add(smul(lam, c), smul(lamp, cT))
            # （一）
            rows1 = ([add(c, cT)] if nm == "Z" else []) + [
                add(smul(lam, c), smul(lamp, cT)),
                add(smul(lam, kron(M, A_)), smul(lamp, kron(M, Ap_))),
                kron(M, Gk)]
            for r in range(len(rows1)-1):
                ok(rows1[r] == rows1[r+1], "row (1) %s M=%d m=%d r=%d" % (nm, M, m, r))
            # （二）K G_k = F_k K
            for k in range(M):
                ok(mul(K, Gk[k], X2) == mul(Fk[k], K, X2), "(2) K G_k = F_k K")
            # 本体の式変形
            rows = [mul(mul(U, X, P), Up, P),
                    mul(mul(U, kron(M, Gk), P), Up, P),
                    mul(mul(kron(M, [K]*M), kron(M, Gk), P), Up, P),
                    mul(kron(M, [mul(K, Gk[k], X2) for k in range(M)]), Up, P),
                    mul(kron(M, [mul(Fk[k], K, X2) for k in range(M)]), Up, P),
                    mul(mul(kron(M, Fk), kron(M, [K]*M), P), Up, P),
                    mul(mul(JWm, kron(M, [K]*M), P), Up, P),
                    mul(mul(JWm, U, P), Up, P),
                    mul(JWm, mul(U, Up, P), P),
                    mul(JWm, IdP, P),
                    JWm]
            for r in range(len(rows)-1):
                ok(rows[r] == rows[r+1], "conjugation row %s M=%d m=%d r=%d" % (nm, M, m, r))
            # 否定の対照：G_m から E_{1,2} の項を落とすと X と一致しない。m 番の因子で K G_m は σ^x K と一致しない
            neg(kron(M, [A_[k-1] if k != m else smul(lam, E21) for k in range(1, M+1)]) != X, "control: drop E12")
            neg(mul(K, Gm, X2) != mul(sx, K, X2), "control: K G_m != sx K")

# ==== Φ_Y、Ω、Ω' を具体的な (Y,Q) で計算する（体は Q(i)=QuadraticField(-1)、厳密計算）====
# Y:=K^{2M}、正規直交基底 e を有理数の可逆行列 Eb の列に取り、Q(y):=y^T (Eb^{-1})^T Eb^{-1} y と置く（Q(e_k)=1、e は直交）。
# θ=L_{e,u}（座標 β^e(y)=Eb^{-1}y と族 u）、θ'=L_{d,v}。Φ_Y=Φ∘Cl(θ) は γ_Y(y) を Φ(γ(θ(y)))=φ(θ(y)) へ移す。
# Ψ_Y=Cl(θ')∘Ψ：Ψ(F)=Σ F_{S,T} a†_S P a_T（def_homomorphism_from_matrix_algebra_to_clifford_algebra）の a†_i=γ(d_i)・a_i=γ(d_{M+i}) を
# Cl(θ') が γ_Y(θ'(d_i))・γ_Y(θ'(d_{M+i})) へ移すので、Φ_Y(Ψ_Y(F)) は Ψ の式の生成元を φ(θ(θ'(d_i)))・φ(θ(θ'(d_{M+i}))) に置き換えて評価した値である。
# クリフォード代数の元は Φ_Y による行列への像で表す（像での確認であり、クリフォード代数の中の等式の証明ではない）。
KI = QuadraticField(-1, 'ii'); ii = KI.gen()
from itertools import combinations as _comb
set_random_seed(20261114)
def to_sage(D, Pl):          # 辞書の行列を Sage の行列へ（行・列の並びは Pl）
    return matrix(KI, len(Pl), len(Pl), lambda a, b: KI(QQ(D[(Pl[a], Pl[b])].real())) + ii * KI(QQ(D[(Pl[a], Pl[b])].imag())))
def oprod_m(ms, Id):
    X = Id
    for Y_ in ms:
        X = X * Y_
    return X
for M in [1,2,3]:
    P = subsets(M); nP = len(P); n = 2*M
    Id = identity_matrix(KI, nP); Z0 = zero_matrix(KI, nP)
    c = {m: to_sage(cmat(M, m), P) for m in range(1, M+1)}; ct = {m: c[m].transpose() for m in c}
    Us = to_sage(kron(M, [K]*M), P); Ups = to_sage(kron(M, [Kp]*M), P)
    Zs = {m: to_sage(kron(M, [sx if k < m else (sz if k == m else I2) for k in range(1, M+1)]), P) for m in c}
    Ys = {m: to_sage(kron(M, [sx if k < m else (sy if k == m else I2) for k in range(1, M+1)]), P) for m in c}
    kap = lambda L, R, F: (L * F) * R                               # def_conjugation_of_matrices
    phi = lambda y: sum((y[k] * c[k+1] for k in range(M)), Z0) + sum((y[M+k] * ct[k+1] for k in range(M)), Z0)   # Φ(γ(y))、y は基底 d の座標
    pair = lambda a_, b_: vector(KI, list(a_) + list(b_))         # (W の成分, W^* の成分)
    wW = lambda m: vector(KI, [1 if k == m else 0 for k in range(M)]); zW = vector(KI, [0]*M)
    in1 = lambda x: pair(x, zW); in2 = lambda g: pair(zW, g)
    d = [in1(wW(m)) for m in range(M)] + [in2(wW(m)) for m in range(M)]          # d_m=in_1(w_m)、d_{M+m}=in_2(f_m)
    u = [pair(wW(m), wW(m)) for m in range(M)] + [pair((-ii) * wW(m), ii * wW(m)) for m in range(M)]   # def_family_in_split_space_for_isometry
    for trial in range(2):
        while True:
            Eb = random_matrix(QQ, n, n, num_bound=3, den_bound=2)
            if Eb.det() != 0: break
        Eb = Eb.change_ring(KI); Ebi = Eb.inverse()
        e = Eb.columns()
        Qf = lambda y: y * (Ebi.transpose() * Ebi) * y
        ok(all(Qf(x) == 1 for x in e), "e orthonormal (Q=1)")
        th = lambda y: sum((b * uu for b, uu in zip(Ebi * y, u)), vector(KI, [0]*n))          # θ=L_{e,u}
        hK = KI(1)/2
        v = [hK * (e[m] + ii * e[M+m]) for m in range(M)] + [hK * (e[m] + (-ii) * e[M+m]) for m in range(M)]   # def_family_in_general_space_for_inverse_isometry
        thp = lambda x: sum((x[l] * v[l] for l in range(n)), vector(KI, [0]*n))                # θ'=L_{d,v}（d は標準基底なので座標は成分）
        PhiY_gen = lambda y: phi(th(y))                                                          # Φ_Y(γ_Y(y))
        for m in range(M):
            # claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis の各行
            rows = [PhiY_gen(e[m]), phi(th(e[m])), phi(u[m]), phi(pair(wW(m), wW(m))),
                    phi(in1(wW(m)) + in2(wW(m))), phi(in1(wW(m))) + phi(in2(wW(m))), phi(d[m]) + phi(d[M+m]), c[m+1] + ct[m+1]]
            for r in range(len(rows)-1):
                ok(rows[r] == rows[r+1], "first half row %d" % r)
            neg(PhiY_gen(e[m]) != c[m+1] - ct[m+1], "control: c - c^T")
            # claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis の各行
            rows = [PhiY_gen(e[M+m]), phi(th(e[M+m])), phi(u[M+m]), phi(pair((-ii) * wW(m), ii * wW(m))),
                    phi(in1((-ii) * wW(m)) + in2(ii * wW(m))), phi((-ii) * in1(wW(m)) + ii * in2(wW(m))),
                    phi((-ii) * in1(wW(m))) + phi(ii * in2(wW(m))), (-ii) * phi(in1(wW(m))) + ii * phi(in2(wW(m))),
                    (-ii) * phi(d[m]) + ii * phi(d[M+m]), (-ii) * c[m+1] + ii * ct[m+1]]
            for r in range(len(rows)-1):
                ok(rows[r] == rows[r+1], "second half row %d" % r)
            neg(PhiY_gen(e[M+m]) != ii * c[m+1] + (-ii) * ct[m+1], "control: swapped signs of i")
            # Ω(γ_Y(e_m))=Z_m、Ω(γ_Y(e_{M+m}))=Y_m（Ω=κ_{U,U'}∘Φ_Y）
            ok(kap(Us, Ups, PhiY_gen(e[m])) == Zs[m+1], "Omega e_m = Z_m")
            ok(kap(Us, Ups, PhiY_gen(e[M+m])) == Ys[m+1], "Omega e_{M+m} = Y_m")
            neg(kap(Us, Ups, PhiY_gen(e[m])) != Ys[m+1], "control: Omega e_m != Y_m")
            neg(kap(Us, Ups, PhiY_gen(e[M+m])) != Zs[m+1], "control: Omega e_{M+m} != Z_m")
        # Φ_Y(Ψ_Y(F)) の評価
        adag = {i: phi(th(thp(d[i-1]))) for i in range(1, M+1)}
        ann = {i: phi(th(thp(d[M+i-1]))) for i in range(1, M+1)}
        Pv = oprod_m([ann[i] * adag[i] for i in range(1, M+1)], Id)
        Emat = {}
        for a, S in enumerate(P):
            aS = oprod_m([adag[t] for t in sorted(S)], Id)
            for b, T in enumerate(P):
                Emat[(a, b)] = aS * Pv * oprod_m([ann[t] for t in sorted(T, reverse=True)], Id)   # Φ_Y(Cl(θ')(a†_S P a_T))
        PhiY_PsiY = lambda F: sum((F[a, b] * Emat[(a, b)] for a in range(nP) for b in range(nP) if F[a, b] != 0), Z0)
        Omega_Omegap = lambda F: kap(Us, Ups, PhiY_PsiY(kap(Ups, Us, F)))   # Ω(Ω'(F))=κ_{U,U'}(Φ_Y(Ψ_Y(κ_{U',U}(F))))
        tests = [matrix(KI, nP, nP, lambda a, b: 1 if (a, b) == (s_, t_) else 0) for s_ in range(nP) for t_ in range(nP)]
        tests += [matrix(KI, nP, nP, lambda a, b: QQ.random_element(num_bound=5, den_bound=3) + ii * QQ.random_element(num_bound=5, den_bound=3)) for _ in range(3)]
        for F in tests:
            ok(Omega_Omegap(F) == F, "Omega Omega' = id")
        Fr = tests[-1]
        # （κ_{U,U'} を二度当てる形は U·U=2^M·1 のため恒等写像になり、対照にならない。κ_{U',U} を落とした形を対照にする）
        neg(kap(Us, Ups, PhiY_PsiY(Fr)) != Fr, "control: Omega' without kappa_{U',U}")
        neg(kap(Us, Us, PhiY_PsiY(kap(Us, Us, Fr))) != Fr, "control: without h (U for U')")
        # Ω'∘Ω=id を生成元 γ_Y(e_k) の像で：Φ_Y(Ω'(Ω(γ_Y(e_k))))=Φ_Y(Ψ_Y(κ_{U',U}(κ_{U,U'}(Φ_Y(γ_Y(e_k))))))=Φ_Y(γ_Y(e_k))
        for k in range(n):
            g = PhiY_gen(e[k])
            ok(PhiY_PsiY(kap(Ups, Us, kap(Us, Ups, g))) == g, "Omega' Omega = id on generator image")
        # 同じことを生成元の像の積（γ_Y(e_k)γ_Y(e_l)、Φ_Y は乗法を保つ）でも
        for k in range(n):
            for l in range(n):
                g = PhiY_gen(e[k]) * PhiY_gen(e[l])
                ok(PhiY_PsiY(kap(Ups, Us, kap(Us, Ups, g))) == g, "Omega' Omega = id on product of generator images")
        # 否定の対照：Ψ の式で a_i の像と a†_i の像を取り違えると Ω'∘Ω は生成元を戻さない
        # （c_m+c_m^T は取り違えで変わらないので、後半の生成元 γ_Y(e_{M+1}) の像で確かめる）
        PvB = oprod_m([adag[i] * ann[i] for i in range(1, M+1)], Id)
        badPsi = lambda F: sum((F[a, b] * (oprod_m([ann[t] for t in sorted(P[a])], Id) * PvB * oprod_m([adag[t] for t in sorted(P[b], reverse=True)], Id))
                                for a in range(nP) for b in range(nP) if F[a, b] != 0), Z0)
        g = PhiY_gen(e[M])
        neg(badPsi(kap(Ups, Us, kap(Us, Ups, g))) != g, "control: swapped a and a-dagger in Psi")
    print("M =", M, "Omega checks ok", flush=True)
print("PASS", passed, "negative controls", negs)
