# 系「Jordan–Wigner 行列への接続」の後半（番号の行列環への移し）の検算（M=1,2,3、QQbar の厳密計算）。
# P_M で添字づけた行列は辞書 (S,T)->値、番号 1..2^M で添字づけた行列は Sage の行列（0 始まりの添字 k-1）で持つ。
# 番号で添字づけた側の Pauli 行列と Jordan–Wigner 行列は、複素行列版イジングの論文と同じく、
# Sage の tensor_product（第 1 因子が最上位の桁。def_kronecker の ν(I)=1+Σ(i_k-1)2^{M-k} と同じ並び）で独立に作る。
from itertools import product as iprod
import random
random.seed(int(20261114))
i_ = QQbar(I)
passed = 0
neg = 0
def ok(c, msg):
    global passed
    assert c, msg
    passed += 1
def ng(c, msg):          # 否定の対照: 一致しないことを確かめる
    global neg
    assert c, msg
    neg += 1
def two_pow(M): return 1 if M == 0 else 2 * two_pow(M - 1)
def e(M, k):             # def_binary_numbering_of_power_set
    if M == 0: return frozenset()
    h = two_pow(M - 1)
    return e(M - 1, k) if k <= h else e(M - 1, k - h) | frozenset([M])
def rho(M, T): return frozenset(M + 1 - s for s in T)          # def_reversal_of_subsets
def r(M, k): return rho(M, e(M, k))                             # def_numbering_of_power_set_with_first_site_as_highest_digit
def o(T, k): return 2 if k in T else 1                          # def_membership_index_of_subset（本文の o_{M,T}(k)。M は T と k の範囲で決まる）
def obar(M, T): return tuple(o(T, t) for t in range(1, M + 1))  # def_tuple_of_membership_indices（I(t) は tuple の t-1 番目）
def pos(M, I): return frozenset(t for t in range(1, M + 1) if I[t - 1] == 2)   # def_positions_of_two_in_tuple
def num(M, I): return 1 + sum((I[t - 1] - 1) * 2**(M - t) for t in range(1, M + 1))  # def_number_of_tuple_with_first_site_as_highest_digit
def subsets(M): return [frozenset(t for t in range(1, M + 1) if (k >> (t - 1)) & 1) for k in range(2**M)]
def tuples(M): return list(iprod([1, 2], repeat=M))
def prodC(xs):
    p = QQbar(1)
    for x in xs: p *= x
    return p
def kronP(M, A):         # def_kronecker_product_indexed_by_power_set（A[t-1] は {1,2} で添字づけた 2x2 の Sage 行列、成分 A[a-1,b-1]）
    P = subsets(M)
    return {(S, T): prodC([A[t - 1][o(S, t) - 1, o(T, t) - 1] for t in range(1, M + 1)]) for S in P for T in P}
def kronN(M, A):         # def_kronecker_product_indexed_by_numbers（num の逆を表で引く）
    n = two_pow(M); inv = {num(M, I): I for I in tuples(M)}
    return matrix(QQbar, n, n, lambda k, l: prodC([A[t - 1][inv[k + 1][t - 1] - 1, inv[l + 1][t - 1] - 1] for t in range(1, M + 1)]))
def kron_sage(A):        # 複素行列版イジングの def_kronecker と同じ並びの独立な構成
    R = A[0]
    for B in A[1:]: R = R.tensor_product(B)
    return R
def mulP(A, B, P): return {(x, y): sum(A[(x, z)] * B[(z, y)] for z in P) for x in P for y in P}
def nu(M, F, numbering):  # def_reindexing_of_matrices_by_numbering
    n = two_pow(M)
    return matrix(QQbar, n, n, lambda k, l: F[(numbering(M, k + 1), numbering(M, l + 1))])
def mu(M, G, numbering):  # def_reindexing_of_matrices_by_inverse_numbering
    n = two_pow(M); inv = {numbering(M, k): k for k in range(1, n + 1)}
    return {(S, T): G[inv[S] - 1, inv[T] - 1] for S in subsets(M) for T in subsets(M)}
sx = matrix(QQbar, [[0, 1], [1, 0]]); sy = matrix(QQbar, [[0, -i_], [i_, 0]]); sz = matrix(QQbar, [[1, 0], [0, -1]]); I2 = identity_matrix(QQbar, 2)
pauli = {'x': sx, 'y': sy, 'z': sz}
def N(i, T): return len([t for t in T if t < i])
def cmat(M, m):          # def_creation_operator_matrix
    P = subsets(M)
    return {(S, T): (QQbar((-1)**N(m, T)) if (m not in T and S == T | {m}) else QQbar(0)) for S in P for T in P}
def transp(C): return {(S, T): C[(T, S)] for (S, T) in C}
K = matrix(QQbar, [[1, 1], [1, -1]]); Kp = K / 2
for M in [1, 2, 3]:
    n = two_pow(M); P = subsets(M)
    # 逆順の写像: 所属の言い換えと、二回で元に戻ること
    for T in P:
        for t in range(1, M + 1):
            ok((t in rho(M, T)) == ((M + 1 - t) in T), "membership in reversed subset")
        ok(rho(M, rho(M, T)) == T, "reversal is involution")
        ok(rho(M, T) <= frozenset(range(1, M + 1)), "reversal lands in P_M")
    # r_M は番号付け
    imgs = [r(M, k) for k in range(1, n + 1)]
    ok(len(set(imgs)) == n and set(imgs) == set(P), "r_M is numbering")
    # 組と部分集合の行き来
    for I in tuples(M):
        ok(obar(M, pos(M, I)) == I, "obar(pos(I)) = I")
    # 逆順の部分集合の組の番号（M-1 の部分集合 S について二つの主張）
    for S in subsets(M - 1):
        ok(num(M, obar(M, rho(M, S))) == num(M - 1, obar(M - 1, rho(M - 1, S))), "without top element")
        ok(num(M, obar(M, rho(M, S | {M}))) == two_pow(M - 1) + num(M - 1, obar(M - 1, rho(M - 1, S))), "with top element")
    # num∘obar∘r = id と、num が全単射
    for k in range(1, n + 1):
        ok(num(M, obar(M, r(M, k))) == k, "num(obar(r(k))) = k")
    vals = [num(M, I) for I in tuples(M)]
    ok(sorted(vals) == list(range(1, n + 1)), "num is bijection onto 1..2^M")
    for I in tuples(M):
        ok(num(M, I) == [k for k in range(1, n + 1) if r(M, k) == pos(M, I)][0], "num(I) = r^{-1}(pos(I))")
    # 否定の対照: 2 進の番号付け e_M では num∘obar∘e は恒等写像にならない（M>=2）
    if M >= 2:
        ng(any(num(M, obar(M, e(M, k))) != k for k in range(1, n + 1)), "e_M is not the first-site-highest numbering")
    # 番号で添字づけたクロネッカー積: 本文の定義（num の逆）と Sage の tensor_product の一致、ν_{r_M} での一致
    for _ in range(4):
        A = [matrix(QQbar, 2, 2, [QQbar(random.randint(-4, 4)) + i_ * QQbar(random.randint(-2, 2)) for _ in range(4)]) for _ in range(M)]
        KN = kronN(M, A)
        ok(KN == kron_sage(A), "kronN equals Ising-paper Kronecker")
        for (I, J) in iprod(tuples(M), tuples(M)):
            ok(KN[num(M, I) - 1, num(M, J) - 1] == prodC([A[t - 1][I[t - 1] - 1, J[t - 1] - 1] for t in range(1, M + 1)]), "kronN defining entry")
        ok(nu(M, kronP(M, A), r) == KN, "nu_{r_M}(kronP A) = kronN A")
        if M >= 2:
            ng(nu(M, kronP(M, A), e) != KN, "nu_{e_M} does not give kronN")
    # 一つの因子だけを残したクロネッカー積の番号順の積
    for _ in range(3):
        f = [matrix(QQbar, 2, 2, [QQbar(random.randint(-3, 3)) for _ in range(4)]) for _ in range(M)]
        for p in range(0, M + 1):
            Pi = {(S, T): QQbar(1 if S == T else 0) for S in P for T in P}
            for j in range(1, p + 1):
                fj = [f[t - 1] if t == j else I2 for t in range(1, M + 1)]
                Pi = mulP(Pi, kronP(M, fj), P)
            fle = [f[t - 1] if t <= p else I2 for t in range(1, M + 1)]
            ok(Pi == kronP(M, fle), "ordered product of single-site Kronecker products")
            if 1 <= p < M:
                ng(Pi != kronP(M, [f[t - 1] if t <= p + 1 else I2 for t in range(1, M + 1)]), "ordered product does not include site p+1")
    # サイトごとの Pauli 行列と Jordan–Wigner 行列（番号の側は Sage の tensor_product で独立に作る）
    site = {(a, k): kron_sage([pauli[a] if t == k else I2 for t in range(1, M + 1)]) for a in 'xyz' for k in range(1, M + 1)}
    U = kronP(M, [K] * M); Up = kronP(M, [Kp] * M)
    for (a, k) in site:
        ok(site[(a, k)] == kronN(M, [pauli[a] if t == k else I2 for t in range(1, M + 1)]), "site Pauli: def form equals Ising form")
    for m in range(1, M + 1):
        for b in 'zy':
            F = [site[('x', j)] if j < m else site[(b, m)] for j in range(1, m + 1)]   # def_factors_of_jordan_wigner_matrices_indexed_by_numbers
            JW_num = identity_matrix(QQbar, n)
            for Fj in F: JW_num = JW_num * Fj
            JW_P = kronP(M, [sx if t < m else (pauli[b] if t == m else I2) for t in range(1, M + 1)])   # def_jordan_wigner_z/y_matrix
            # 証明の途中の行（Z の側は 𝔷・ϑ_j、Y の側は 𝔶・ϖ_j）: ϑ_j の像が因子、番号順の積の像
            xs = [kronP(M, [(sx if j < m else pauli[b]) if t == j else I2 for t in range(1, M + 1)]) for j in range(1, m + 1)]
            for j in range(1, m + 1):
                ok(nu(M, xs[j - 1], r) == F[j - 1], "nu_r(theta_j) = F_{m,j}")
            Pi = {(S, T): QQbar(1 if S == T else 0) for S in P for T in P}
            for xj in xs: Pi = mulP(Pi, xj, P)
            ok(Pi == JW_P, "prod theta_j = Z_m / Y_m in Mat_P")
            ok(nu(M, JW_P, r) == JW_num, "nu_{r_M}(Z_m)=Z^{(2^M)}_m / Y")
            if M >= 2:
                ng(nu(M, JW_P, e) != JW_num, "nu_{e_M} does not give the Ising-paper matrix")
            # 生成・消滅作用素の行列からの通しの確認: ν_r(κ_{U,U'}(c_m ± c_m^T)) が番号の側の行列
            c = cmat(M, m); ct = transp(c)
            X = {k_: c[k_] + ct[k_] for k_ in c} if b == 'z' else {k_: (-i_) * c[k_] + i_ * ct[k_] for k_ in c}
            conj = mulP(mulP(U, X, P), Up, P)
            ok(nu(M, conj, r) == JW_num, "nu_r(kappa(Phi(gamma(e)))) = JW matrix indexed by numbers")
            ng(nu(M, conj, r) != (site[('x', m)] if b == 'z' else -JW_num), "control: not a different Pauli matrix")
    # ν_{r_M} と μ_{r_M} は互いに逆で、積を保つ
    for _ in range(2):
        F1 = {(S, T): QQbar(random.randint(-3, 3)) for S in P for T in P}; F2 = {(S, T): QQbar(random.randint(-3, 3)) for S in P for T in P}
        ok(mu(M, nu(M, F1, r), r) == F1, "mu nu = id")
        ok(nu(M, mulP(F1, F2, P), r) == nu(M, F1, r) * nu(M, F2, r), "nu preserves product")
        G = random_matrix(ZZ, n, n, x=-3, y=4).change_ring(QQbar)
        ok(nu(M, mu(M, G, r), r) == G, "nu mu = id")
print("PASS jordan-wigner-matrices-indexed-by-numbers M=1,2,3: confirmations", passed, "negative controls", neg)
