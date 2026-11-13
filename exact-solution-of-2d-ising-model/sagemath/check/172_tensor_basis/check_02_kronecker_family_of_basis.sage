# <tensor_basis> (2) とその証明の Step 4: Mat(2,C) の基底 b_1..b_4 のクロネッカー積の族 (F_q) は、
# Mat(2^M,C) を張り（kronecker_family_of_spanning_family_spans）、かつ線型独立である
# （kronecker_family_of_independent_family_is_independent）ので基底である。
# (0) 仮定: b_1..b_4 が Mat(2,C) を張り、かつ線型独立（4 つの行列を並べた 4×4 の係数行列の階数が 4）。
# (1) Step 4 の「(F_q) は張る」: 任意の X について X = Σ_q d_q F_q となる d を解いて見つけ、等式を厳密に確かめる
#     （X は行列単位の全てと、乱数の行列）。
# (2) Step 4 の「(F_q) は線型独立」: (F_q) を並べた係数行列の核が 0（階数が N = 4^M）。
# (3) π は全単射: 多重添字 (a_1..a_M) の並べ方 π の像の個数が N。
# 否定の対照: 張らない族（b_3 = b_1 + b_2）では (F_q) の係数行列の階数が N 未満で、張らない X があり、線型独立でもない。
# (4) Step 5 の表示式: {u_1,u_2} を C^2 の基底、e_i = Σ_a d^{(i)}_a u_a として
#     f_I = Σ_{(a_1..a_M)∈{1,2}^M} (Π_k d^{(i_k)}_{a_k}) (u_{a_1}⊠…⊠u_{a_M}) を全ての I で厳密に確かめる。
# 基底は Pauli 族 {I,σ^x,σ^y,σ^z} と、別の基底（上三角と下三角を混ぜた族）。M = 1, 2, 3。QQ(i) 上の厳密計算。浮動小数点なし。
import itertools

K = QuadraticField(-1, 'i')
i = K.gen()

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
        print("FAIL " + label)

def kron_list(ms):
    out = ms[0]
    for m in ms[1:]:
        out = out.tensor_product(m)
    return out

def vec(m):
    return vector(K, m.list())

I2 = identity_matrix(K, 2)
sx = matrix(K, [[0, 1], [1, 0]])
sy = matrix(K, [[0, -i], [i, 0]])
sz = matrix(K, [[1, 0], [0, -1]])
families = {
    "Pauli": [I2, sx, sy, sz],
    "other": [matrix(K, [[1, 2], [0, 1]]), matrix(K, [[0, 1], [1, i]]), matrix(K, [[3, 0], [1, 0]]), matrix(K, [[1, 0], [0, 2]])],
}
not_basis = [I2, sx, I2 + sx, sz]   # b_3 = b_1 + b_2 なので張らず、線型独立でもない

set_random_seed(20261113)
def random_matrix_K(n):
    return matrix(K, n, n, [K(ZZ.random_element(-3, 4)) + i * K(ZZ.random_element(-3, 4)) for _ in range(n * n)])

for name, b in families.items():
    B4 = matrix(K, [vec(m) for m in b])
    # (0) 仮定: 張り、かつ線型独立
    check(B4.rank() == 4, f"{name}: b_1..b_4 の係数行列の階数は 4（張り、かつ線型独立）")
    for M in [1, 2, 3]:
        n = 2 ** M
        N = 4 ** M
        P = list(itertools.product(range(4), repeat=M))   # π: {1..N} -> P を辞書式の並びで取る
        check(len(set(P)) == N, f"{name}, M={M}: π は全単射（像の個数が N = 4^M）")
        F = [kron_list([b[a] for a in p]) for p in P]
        FM = matrix(K, [vec(f) for f in F])   # 行 q が F_q の成分
        # (2) 線型独立: 核が 0
        check(FM.rank() == N, f"{name}, M={M}: (F_q) の係数行列の階数が N（線型独立）")
        check(FM.left_kernel().dimension() == 0, f"{name}, M={M}: Σ d_q F_q = O なら d = 0")
        # (1) 張る: 各 X について d を解き、Σ d_q F_q = X を厳密に確かめる
        Xs = []
        for r in range(n):
            for c in range(n):
                E = matrix(K, n, n, 0)
                E[r, c] = 1
                Xs.append(E)
        Xs += [random_matrix_K(n) for _ in range(5)]
        for X in Xs:
            d = FM.solve_left(vec(X))
            S = sum((d[q] * F[q] for q in range(N)), matrix(K, n, n, 0))
            check(S == X, f"{name}, M={M}: X = Σ d_q F_q")

# 否定の対照
Bn = matrix(K, [vec(m) for m in not_basis])
check(Bn.rank() < 4, "対照: b_3 = b_1 + b_2 の族は基底でない")
for M in [1, 2]:
    n = 2 ** M
    N = 4 ** M
    P = list(itertools.product(range(4), repeat=M))
    F = [kron_list([not_basis[a] for a in p]) for p in P]
    FM = matrix(K, [vec(f) for f in F])
    check(FM.rank() < N, f"対照 M={M}: (F_q) の係数行列の階数は N 未満")
    check(FM.left_kernel().dimension() > 0, f"対照 M={M}: 零でない d で Σ d_q F_q = O")
    E = matrix(K, n, n, 0)
    E[0, n - 1] = 1
    try:
        FM.solve_left(vec(E))
        spans = True
    except ValueError:
        spans = False
    check(not spans, f"対照 M={M}: 行列単位 E_(1,2^M) は (F_q) の線型結合で書けない")

# (4) Step 5 の表示式
controls_done = 0
e_std = [vector(K, [1, 0]), vector(K, [0, 1])]
def kv(vs):
    out = vs[0]
    for v in vs[1:]:
        out = vector(K, [x * y for x in out for y in v])
    return out
for ubasis in [[vector(K, [1, 1]), vector(K, [1, -1])], [vector(K, [2, i]), vector(K, [1, 3])]]:
    U = matrix(K, ubasis).transpose()          # 列が u_1, u_2
    D = [U.solve_right(e_std[t]) for t in range(2)]   # e_t = Σ_a D[t][a] u_a
    for t in range(2):
        check(sum((D[t][a] * ubasis[a] for a in range(2)), vector(K, [0, 0])) == e_std[t], "Step 5: e_i = Σ_a d^{(i)}_a u_a")
    for M in [1, 2, 3]:
        for I_ in itertools.product(range(2), repeat=M):
            fI = kv([e_std[t] for t in I_])
            rhs = sum((prod(D[I_[k]][A[k]] for k in range(M)) * kv([ubasis[a] for a in A])
                       for A in itertools.product(range(2), repeat=M)), vector(K, [0] * 2 ** M))
            check(fI == rhs, f"Step 5, M={M}, I={I_}: f_I の展開")
    # 否定の対照: 係数の添字を取り違える（d^{(i_k)}_{a_k} の代わりに d^{(a_k)}_{i_k}）と崩れる。
    # 係数の行列 (d^{(i)}_a) が対称な基底（u_1 = (1,1), u_2 = (1,-1)）では取り違えても値が変わらないので、対称でない基底でだけ行う。
    if all(D[t][a] == D[a][t] for t in range(2) for a in range(2)):
        continue
    controls_done += 1
    I_ = (0, 1)
    wrong = sum((prod(D[A[k]][I_[k]] for k in range(2)) * kv([ubasis[a] for a in A])
                 for A in itertools.product(range(2), repeat=2)), vector(K, [0] * 4))
    check(wrong != kv([e_std[t] for t in I_]), "対照: Step 5 の係数の添字を取り違えると崩れる")

check(controls_done >= 1, "対照: Step 5 の否定の対照を少なくとも 1 つの基底で行った")

print(f"checks: {n_check}, failures: {n_fail}")
if n_fail == 0:
    print("PASS")
else:
    print("FAIL")
    raise SystemExit(1)
