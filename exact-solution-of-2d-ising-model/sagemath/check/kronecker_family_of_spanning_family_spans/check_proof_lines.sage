# 対象ラベル: kronecker_family_of_spanning_family_spans
# 証明の各行を一行ずつ確かめる。
# (0) 仮定: b_1..b_4 が Mat(2,C) を張る（2 つの族: Pauli 族 {I,σ^x,σ^y,σ^z} と、別の張る族）。
# (1) Step 1 の 5 行の鎖（X_a の表示・finite_sum_of_scalar_multiples・scalar_multiple_is_associative・
#     finite_double_sum_of_matrices_interchange・finite_sum_of_scalar_multiples_of_one_matrix）。
# (2) Step 2 の s = 0 の前提の鎖 δ_{qq_0}F_q = 0_C F_q = O（q ≠ q_0）と 5 行の鎖（A_k = b_{a_k}・F_{q_0}・1_C F_{q_0}・δ_{q_0q_0}F_{q_0}・Σ_q δ_{qq_0}F_q）を 𝒫 の全ての元で。
#     5 行の鎖の第 1〜3 行の比較は代入の行なので、同じ値を別の式で書いたものどうしの比較になる（恒真に近い）。
# (3) Step 2 の帰納の一段の 2 行の鎖（X_{s+1} の表示・kronecker_multilinear）を全ての s で、右辺の各項の因子の条件も。
# (4) Step 3: X = Σ_t κ_t E_{I_t,J_t}（tensor_basis (1)）と、E_{I,J} が行列単位のクロネッカー積であること。結論 X ∈ 𝒮（係数を解いて再構成）。
# M = 1, 2, 3。行列は QQ(i) 上で厳密に計算する。浮動小数点なし。
import itertools

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
    print(("PASS " if ok else "FAIL ") + label)

def chain_check(lines, name):
    for k in range(len(lines) - 1):
        check(lines[k] == lines[k + 1], f"{name} 第 {k+1} 行 = 第 {k+2} 行")

K0.<i> = QuadraticField(-1)
I2 = identity_matrix(K0, 2)
sx = matrix(K0, [[0, 1], [1, 0]])
sy = matrix(K0, [[0, -i], [i, 0]])
sz = matrix(K0, [[1, 0], [0, -1]])

def unit(r, c):
    m = matrix(K0, 2, 2, 0); m[r, c] = 1; return m

def kron(mats):  # def_kronecker（Sage の tensor_product は第 1 因子が最上位の桁）
    out = mats[0]
    for m in mats[1:]:
        out = out.tensor_product(m)
    return out

def msum(ms, n):  # def_finite_sum_of_matrices（左から順に足す）
    out = matrix(K0, n, n, 0)
    for m in ms:
        out = out + m
    return out

def vec(m):
    return vector(K0, m.list())

def coeffs_in(fam, X):  # X = Σ d_q fam_q となる d を解く（張らなければ例外）
    A = matrix(K0, [vec(f) for f in fam]).transpose()
    return A.solve_right(vec(X))

families = {
    "Pauli": [I2, sx, sy, sz],
    "別の張る族": [I2 + sx, sx + i * sy, sz - 2 * I2, unit(0, 1) + unit(1, 1)],
}
set_random_seed(20261112)
def rnd2():
    return matrix(K0, 2, 2, [K0(ZZ.random_element(-3, 4)) + i * ZZ.random_element(-3, 4) for _ in range(4)])

for fname, b in families.items():
    check(matrix(K0, [vec(x) for x in b]).rank() == 4, f"{fname}: 仮定 b_1..b_4 は Mat(2,C) を張る")
    for M in [1, 2, 3]:
        N = 4^M
        P = list(itertools.product(range(4), repeat=M))       # π(q) = P[q]
        F = [kron([b[a] for a in p]) for p in P]
        n = 2^M
        # (1) Step 1
        r = 3
        d = [[K0(ZZ.random_element(-2, 3)) + i * ZZ.random_element(-2, 3) for _ in range(N)] for _ in range(r)]
        kap = [K0(ZZ.random_element(-2, 3)) - i * ZZ.random_element(-2, 3) for _ in range(r)]
        Xa = [msum([d[a][q] * F[q] for q in range(N)], n) for a in range(r)]
        lines = [
            msum([kap[a] * Xa[a] for a in range(r)], n),
            msum([kap[a] * msum([d[a][q] * F[q] for q in range(N)], n) for a in range(r)], n),
            msum([msum([kap[a] * (d[a][q] * F[q]) for q in range(N)], n) for a in range(r)], n),
            msum([msum([(kap[a] * d[a][q]) * F[q] for q in range(N)], n) for a in range(r)], n),
            msum([msum([(kap[a] * d[a][q]) * F[q] for a in range(r)], n) for q in range(N)], n),
            msum([sum(kap[a] * d[a][q] for a in range(r)) * F[q] for q in range(N)], n),
        ]
        chain_check(lines, f"{fname} M={M} Step 1")
        # (2) s = 0
        for q0, p in enumerate(P):
            X = [b[a] for a in p]
            delta = lambda q, qq: K0(1) if q == qq else K0(0)
            lines = [kron(X), kron([b[a] for a in p]), F[q0], K0(1) * F[q0], delta(q0, q0) * F[q0],
                     msum([delta(q, q0) * F[q] for q in range(N)], n)]
            chain_check(lines, f"{fname} M={M} s=0 p={p}")
            if M <= 2:
                for q in range(N):
                    if q != q0:
                        chain_check([delta(q, q0) * F[q], K0(0) * F[q], matrix(K0, n, n, 0)], f"{fname} M={M} s=0 前提 q0={q0} q={q}")
        # (3) 帰納の一段
        for s in range(M):
            X = [rnd2() if k <= s else b[ZZ.random_element(0, 4)] for k in range(M)]   # 0 始まり: 第 k+1 因子
            c = coeffs_in(b, X[s])
            check(msum([c[a] * b[a] for a in range(4)], 2) == X[s], f"{fname} M={M} s={s}: X_(s+1) = Σ c_a b_a")
            rep = lambda e: [e if k == s else X[k] for k in range(M)]
            lines = [kron(X), kron(rep(msum([c[a] * b[a] for a in range(4)], 2))),
                     msum([c[a] * kron(rep(b[a])) for a in range(4)], n)]
            chain_check(lines, f"{fname} M={M} s={s} 一段")
            ok = all(all(any(rep(b[a])[k] == bb for bb in b) for k in range(s, M)) for a in range(4))
            check(ok, f"{fname} M={M} s={s}: 各項の第 s+1 以降の因子は b の元")
        # (4) Step 3
        X = matrix(K0, n, n, [K0(ZZ.random_element(-3, 4)) + i * ZZ.random_element(-3, 4) for _ in range(n * n)])
        IJ = list(itertools.product(itertools.product(range(2), repeat=M), repeat=2))
        E = [kron([unit(I[k], J[k]) for k in range(M)]) for (I, J) in IJ]
        def nu(I):
            return sum(I[k] * 2^(M - 1 - k) for k in range(M))
        kapt = [X[nu(I), nu(J)] for (I, J) in IJ]
        check(msum([kapt[t] * E[t] for t in range(N)], n) == X, f"{fname} M={M} Step 3: X = Σ κ_t E_(I_t,J_t)")
        check(all(all((E[t][u, v] == (1 if (u, v) == (nu(IJ[t][0]), nu(IJ[t][1])) else 0)) for u in range(n) for v in range(n))
                  for t in range(N)), f"{fname} M={M} Step 3: E_(I,J) は行列単位")
        dX = coeffs_in(F, X)
        check(msum([dX[q] * F[q] for q in range(N)], n) == X, f"{fname} M={M} 結論: X ∈ 𝒮")

# 否定の対照
b = families["Pauli"]
bad = [I2, sx, sy, sx]   # b_4 を σ^x にすると張らない
check(matrix(K0, [vec(x) for x in bad]).rank() < 4, "否定の対照: {I,σ^x,σ^y,σ^x} は張らない")
Fbad = [kron([bad[a] for a in p]) for p in itertools.product(range(4), repeat=2)]
check(matrix(K0, [vec(f) for f in Fbad]).rank() < 16, "否定の対照: 張らない族のクロネッカー積の族は Mat(4,C) を張らない")
# Step 1 の入れ替えで係数の添字を取り違えると外れる
N = 16; P = list(itertools.product(range(4), repeat=2)); F = [kron([b[a] for a in p]) for p in P]
d = [[K0(q + 3 * a + 1) for q in range(N)] for a in range(3)]; kap = [K0(2), K0(-1), i]
good = msum([sum(kap[a] * d[a][q] for a in range(3)) * F[q] for q in range(N)], 4)
wrong = msum([sum(kap[a] * d[(a + 1) % 3][q] for a in range(3)) * F[q] for q in range(N)], 4)
check(good != wrong, "否定の対照: Step 1 の係数 κ_a d^(a)_q を κ_a d^(a+1)_q と取り違えると外れる")
# 一段で展開を別の因子へ置くと外れる
X = [sy, sz]; c = coeffs_in(b, X[0])
check(kron(X) != msum([c[a] * kron([X[0], b[a]]) for a in range(4)], 4), "否定の対照: 展開を第 2 因子へ置くと外れる")

print(f"\n合計 {n_check} 件、失敗 {n_fail} 件")
if n_fail:
    raise SystemExit(1)
