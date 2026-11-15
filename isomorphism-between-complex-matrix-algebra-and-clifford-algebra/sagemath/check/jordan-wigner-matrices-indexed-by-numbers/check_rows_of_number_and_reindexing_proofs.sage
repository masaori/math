# 系「Jordan–Wigner 行列への接続」の後半の、証明の途中の行を一行ずつ確かめる検算（M=1,2,3、ZZ と QQbar の厳密計算）。
# 対象: 整数の番号順の和の二つの主張（最初の項を分ける・番号をずらす）、番号 M を含まない／足した部分集合の組の番号の二つの主張の各行、
# ℂ の中の番号順の積とクロネッカー積（部分集合全体・番号）の「因子ごとに等しければ等しい」の三つの主張、
# Z・Y の付け替えの主張の各行（ν(ϑ_j)=⊠̂𝔷^{[j]}=⊠̂(σ^a,I_2 の族)=σ^a_j=F_{m,j}、ν(∏ϑ_j)=∏ν(ϑ_j) など）。
# 各行の値は、その行の式の形どおりに別々に計算し、隣り合う行を比べる。否定の対照は、行の根拠を外すと一致しないことを確かめる。
from itertools import product as iprod
import random
random.seed(int(20261115))
i_ = QQbar(I)
passed = 0
neg = 0
def ok(c, msg):
    global passed
    assert c, msg
    passed += 1
def ng(c, msg):
    global neg
    assert c, msg
    neg += 1
def chain(vals, msg):    # 一続きの式変形: 隣り合う行が等しいこと
    for a in range(len(vals) - 1):
        ok(vals[a] == vals[a + 1], msg + " row %d" % (a + 1))

# def_ordered_sum_of_integers: b<a なら 0、b>=a なら (Σ_{a}^{b-1}) + n_b（最後の項で帰納的に定める）
def S(a, b, n):
    return 0 if b < a else S(a, b - 1, n) + n(b)

# claim_ordered_sum_of_integers_splits_off_first_term（証明の各行）
for _ in range(60):
    a = random.randint(-3, 3); b = a + random.randint(0, 6)
    tbl = {t: ZZ(random.randint(-9, 9)) for t in range(a, b + 2)}
    n = lambda t: tbl[t]
    if b == a:
        chain([S(a, a, n), S(a, a - 1, n) + n(a), 0 + n(a), n(a) + 0, n(a) + S(a + 1, a, n)], "split first term base")
    else:
        chain([S(a, b, n), S(a, b - 1, n) + n(b), (n(a) + S(a + 1, b - 1, n)) + n(b), n(a) + (S(a + 1, b - 1, n) + n(b)), n(a) + S(a + 1, b, n)], "split first term step")
    if n(a) != 0:
        ng(S(a, b, n) != S(a + 1, b, n), "control: dropping the first term changes the sum")

# claim_ordered_sum_of_integers_is_unchanged_by_shifting_index（証明の各行）
for _ in range(60):
    a = random.randint(-3, 3); b = a + random.randint(-3, 6)
    tbl = {t: ZZ(random.randint(-9, 9)) for t in range(a - 4, b + 3)}
    n = lambda t: tbl[t]
    sh = lambda s: n(s + 1)
    if b < a:
        chain([S(a + 1, b + 1, n), 0, S(a, b, sh)], "shift base")
    else:
        chain([S(a + 1, b + 1, n), S(a + 1, b, n) + n(b + 1), S(a + 1, (b - 1) + 1, n) + n(b + 1), S(a, b - 1, sh) + n(b + 1), S(a, b, sh)], "shift step")
    if b >= a and n(b + 1) != n(a):   # 番号をずらさずに足すと n_{b+1}-n_a だけ違う
        ng(S(a + 1, b + 1, n) != S(a, b, n), "control: sum without shifting the index differs")

def two_pow(M): return 1 if M == 0 else 2 * two_pow(M - 1)
def e(M, k):             # def_binary_numbering_of_power_set
    if M == 0: return frozenset()
    h = two_pow(M - 1)
    return e(M - 1, k) if k <= h else e(M - 1, k - h) | frozenset([M])
def rho(M, T): return frozenset(M + 1 - s for s in T)
def r(M, k): return rho(M, e(M, k))
def o(M, T, k):          # def_membership_index_of_subset（o_{M,T}(k)、k は 1..M）
    assert 1 <= k <= M and all(1 <= s <= M for s in T)
    return 2 if k in T else 1
def obar(M, T): return tuple(o(M, T, t) for t in range(1, M + 1))
def num(M, I): return 1 + S(1, M, lambda t: (I[t - 1] - 1) * 2**(M - t))   # def_number_of_tuple_with_first_site_as_highest_digit（和は S）
def subsets(M): return [frozenset(t for t in range(1, M + 1) if (k >> (t - 1)) & 1) for k in range(2**M)]
def tuples(M): return list(iprod([1, 2], repeat=M))

# claim_number_of_membership_tuple_of_reversed_subset_without_top_element / with_top_element（各行）
for M in [1, 2, 3]:
    for Sset in subsets(M - 1):
        for top in [False, True]:
            T = rho(M, Sset | {M}) if top else rho(M, Sset); Tp = rho(M - 1, Sset)
            ok(o(M, T, 1) == (2 if top else 1), "(一) first index")
            for t in range(2, M + 1):
                ok(o(M, T, t) == o(M - 1, Tp, t - 1), "(二) shifted index")
            term = lambda t: (o(M, T, t) - 1) * 2**(M - t)
            rows = [num(M, obar(M, T)),
                    1 + S(1, M, lambda t: (obar(M, T)[t - 1] - 1) * 2**(M - t)),
                    1 + S(1, M, term),
                    1 + ((o(M, T, 1) - 1) * 2**(M - 1) + S(2, M, term))]
            c1 = (2 - 1) if top else (1 - 1)
            rows.append(1 + (c1 * 2**(M - 1) + S(2, M, term)))
            if top:
                rows.append(1 + (2**(M - 1) + S(2, M, term)))
                rows.append(2**(M - 1) + (1 + S(2, M, term)))
                pre = 2**(M - 1)
            else:
                rows.append(1 + S(2, M, term))
                pre = 0
            rows += [pre + 1 + S(2, M, lambda t: (o(M - 1, Tp, t - 1) - 1) * 2**(M - t)),
                     pre + 1 + S(2, M, lambda t: (o(M - 1, Tp, t - 1) - 1) * 2**((M - 1) - (t - 1))),
                     pre + 1 + S(1, M - 1, lambda s: (o(M - 1, Tp, (s + 1) - 1) - 1) * 2**((M - 1) - ((s + 1) - 1))),
                     pre + 1 + S(1, M - 1, lambda s: (o(M - 1, Tp, s) - 1) * 2**((M - 1) - s)),
                     pre + 1 + S(1, M - 1, lambda s: (obar(M - 1, Tp)[s - 1] - 1) * 2**((M - 1) - s)),
                     pre + num(M - 1, obar(M - 1, Tp))]
            chain(rows, "number of reversed subset (top=%s, M=%d)" % (top, M))
            if top:
                ng(num(M, obar(M, T)) != num(M - 1, obar(M - 1, Tp)), "control: with top element the number is shifted by 2^{M-1}")
            if len(Tp) > 0:   # ずらしの行で指数を付け替えないと一致しない（根拠を外した対照）
                ng(pre + 1 + S(1, M - 1, lambda s: (o(M - 1, Tp, s) - 1) * 2**(M - s)) != pre + num(M - 1, obar(M - 1, Tp)), "control: exponent not shifted")


# ℂ の中の番号順の積・クロネッカー積の「因子ごとに等しければ等しい」
def prodC_partial(xs):   # def_ordered_product_in_complex_numbers の P_0..P_k
    P = [QQbar(1)]
    for x in xs: P.append(P[-1] * x)
    return P
sx = matrix(QQbar, [[0, 1], [1, 0]]); sy = matrix(QQbar, [[0, -i_], [i_, 0]]); sz = matrix(QQbar, [[1, 0], [0, -1]]); I2 = identity_matrix(QQbar, 2)
pauli = {'x': sx, 'y': sy, 'z': sz}
def kronP(M, A):
    P = subsets(M)
    return {(Sx, T): prod([A[t - 1][o(M, Sx, t) - 1, o(M, T, t) - 1] for t in range(1, M + 1)], QQbar(1)) for Sx in P for T in P}
def kronN(M, A):         # def_kronecker_product_indexed_by_numbers（num の逆を表で引く）
    n = two_pow(M); inv = {num(M, I_): I_ for I_ in tuples(M)}
    return matrix(QQbar, n, n, lambda k, l: prod([A[t - 1][inv[k + 1][t - 1] - 1, inv[l + 1][t - 1] - 1] for t in range(1, M + 1)], QQbar(1)))
def kron_sage(A):
    R = A[0]
    for B in A[1:]: R = R.tensor_product(B)
    return R
def mulP(A, B, P): return {(x, y): sum(A[(x, z)] * B[(z, y)] for z in P) for x in P for y in P}
def nu(M, F, numbering):
    n = two_pow(M)
    return matrix(QQbar, n, n, lambda k, l: F[(numbering(M, k + 1), numbering(M, l + 1))])
def gauss(): return QQbar(random.randint(-4, 4)) + i_ * QQbar(random.randint(-3, 3))
for M in [1, 2, 3]:
    for _ in range(3):
        # 因子を別の経路で作る: A'_t は Pauli 行列と単位行列の線型結合で、A_t は成分から直接作る
        coef = [[gauss() for _ in range(4)] for _ in range(M)]
        A = [matrix(QQbar, 2, 2, [c[0] + c[3], c[1] - i_ * c[2], c[1] + i_ * c[2], c[0] - c[3]]) for c in coef]
        Ap = [c[0] * I2 + c[1] * sx + c[2] * sy + c[3] * sz for c in coef]
        for t in range(M): ok(A[t] == Ap[t], "factors equal")
        for (Sx, T) in iprod(subsets(M), subsets(M)):
            al = [A[t - 1][o(M, Sx, t) - 1, o(M, T, t) - 1] for t in range(1, M + 1)]
            alp = [Ap[t - 1][o(M, Sx, t) - 1, o(M, T, t) - 1] for t in range(1, M + 1)]
            ok(prodC_partial(al) == prodC_partial(alp), "claim_ordered_products_in_complex_numbers_with_equal_factors_are_equal: P_m = P'_m for all m")
        ok(kronP(M, A) == kronP(M, Ap), "claim_kronecker_products_of_factorwise_equal_families_are_equal")
        KN = kronN(M, A)
        chain([KN, nu(M, kronP(M, A), r), nu(M, kronP(M, Ap), r), kronN(M, Ap)], "claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal")
        B_ = list(A); B_[0] = A[0] + I2
        ng(kronP(M, B_) != kronP(M, A), "control: changing one factor changes the Kronecker product")
        ng(kronN(M, B_) != KN, "control: changing one factor changes the numbered Kronecker product")

# claim_reindexing_of_jordan_wigner_{z,y}_matrix_is_jordan_wigner_{z,y}_matrix_indexed_by_numbers の各行
for M in [1, 2, 3]:
    n = two_pow(M); P = subsets(M)
    site = {(a, k): kron_sage([pauli[a] if t == k else I2 for t in range(1, M + 1)]) for a in 'xyz' for k in range(1, M + 1)}   # Ising の論文の形
    def site_def(a, k): return kronN(M, [pauli[a] if t == k else I2 for t in range(1, M + 1)])   # def_site_pauli_matrices_indexed_by_numbers
    for m in range(1, M + 1):
        for b in 'zy':
            fam = [sx if t < m else (pauli[b] if t == m else I2) for t in range(1, M + 1)]          # 𝔷_t / 𝔶_t の置き方
            def single(j): return [fam[j - 1] if t == j else I2 for t in range(1, M + 1)]          # def_single_site_family_of_matrices
            def initial(p): return [fam[t - 1] if t <= p else I2 for t in range(1, M + 1)]         # def_initial_part_family_of_matrices
            def F(j): return site_def('x', j) if j < m else site_def(b, m)                          # def_factors_of_jordan_wigner_matrices_indexed_by_numbers
            JW_P_def = kronP(M, [sx if k < m else (pauli[b] if k == m else I2) for k in range(1, M + 1)])   # def_jordan_wigner_z/y_matrix
            theta = {j: kronP(M, single(j)) for j in range(1, M + 1)}                               # ϑ_j / ϖ_j
            # （一）各 j の場合の行
            for j in range(1, m + 1):
                a = 'x' if j < m else b
                cases = [pauli[a] if t == j else I2 for t in range(1, M + 1)]
                ok(single(j)[j - 1] == fam[j - 1] and fam[j - 1] == pauli[a], "(一) factor at t=j")
                for t in range(1, M + 1):
                    if t != j: ok(single(j)[t - 1] == I2, "(一) factor at t!=j")
                chain([nu(M, theta[j], r), kronN(M, single(j)), kronN(M, cases), site[(a, j)], F(j)], "(一) nu(theta_j) = F_{m,j} (%s, M=%d, m=%d, j=%d)" % (b, M, m, j))
                if 2 * j != M + 1:   # 2 進の番号付け e_M はサイトの順を逆にするので、中央以外のサイトでは一致しない
                    ng(nu(M, theta[j], e) != kronN(M, single(j)), "control: nu_{e_M} breaks row 1")
            # （二）
            for t in range(1, M + 1):
                ok(initial(m)[t - 1] == fam[t - 1], "(二) initial part equals family")
            # 主の式変形の各行
            Pi_P = {(x, y): QQbar(1 if x == y else 0) for x in P for y in P}
            for j in range(1, m + 1): Pi_P = mulP(Pi_P, theta[j], P)
            Pi_N = identity_matrix(QQbar, n)
            for j in range(1, m + 1): Pi_N = Pi_N * nu(M, theta[j], r)
            Pi_F = identity_matrix(QQbar, n)
            for j in range(1, m + 1): Pi_F = Pi_F * F(j)
            chain([nu(M, JW_P_def, r), nu(M, kronP(M, fam), r), nu(M, kronP(M, initial(m)), r), nu(M, Pi_P, r), Pi_N, Pi_F, kron_sage(fam)],
                  "nu(Z_m)=Z^{(2^M)}_m rows (%s, M=%d, m=%d)" % (b, M, m))
            if m >= 2:
                Pi_short = identity_matrix(QQbar, n)
                for j in range(1, m): Pi_short = Pi_short * nu(M, theta[j], r)
                ng(Pi_short != Pi_N, "control: the product without the factor j=m differs")
print("PASS rows of number and reindexing proofs M=1,2,3: confirmations", passed, "negative controls", neg)
