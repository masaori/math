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
print("PASS", passed)
