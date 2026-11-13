# 対象ラベル: Z_Y_linearly_independent
# コードの z・y は本文の写像 q_Z・q_Y（z[m] = q_Z(m) = π^{-1}(ζ(m))、y[m] = q_Y(m) = π^{-1}(η(m))）。
# Step 2・Step 4・Step 5・Step 6（係数の族 d_q をクロネッカーのデルタで置く経路）を一行ずつ確かめる。
# (1) Step 2: ((c_1I+c_2σ^x)+c_3σ^y)+c_4σ^z から Σ_{a=1}^4 c_a e_a までの鎖（e_a の定義と def_finite_sum_of_matrices の r=1, 2, 3, 4 の段）、
#     F_q := e_{π(q)_1}⊠⋯⊠e_{π(q)_M}（def_kronecker (2) の成分の式で組み、Sage の tensor_product とも比べる）の族の階数が N。
# (2) Step 4: q_Z(m) := π^{-1}(ζ(m))・q_Y(m) := π^{-1}(η(m)) について F_{q_Z(m)} = Z_m・F_{q_Y(m)} = Y_m の 6 行の鎖（ζ(m)・η(m) の定義の行と e_a の定義の行を含む）。
#     Z_m・Y_m は def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices の σ_1^x⋯σ_{m-1}^x σ_m^{z,y}（サイトの Pauli 行列の積）で別に組む。
# (3) Step 5: 場合分けの各場合で比べる成分の値、π^{-1} の単射性の 3 行の鎖（π^{-1}(p) = π^{-1}(p') を満たす組。全単射ではその組は p = p' だけ）、
#     q_Z(1..M)・q_Y(1..M) が相異なる。
# (4) 準備 (t)・(u)・(v) の各 3 行・2 行の鎖を、全ての q, m, m_0 で。
# 行は等号の行で数える。
# (5) Σ_q d_qF_q の 11 行の鎖の 10 行目まで。α_m・β_m を QQ(i) 上の多項式環の不定元に置き、各行を書かれた式どおりの順序で組む。
#     仮定を使う最後の行（= O）は仮定そのものなので検算の対象外。
# (6) α_{m_0}・β_{m_0} の各 8 行の鎖の 7 行目 d_{q_Z(m_0)}（d_{q_Y(m_0)}）までを恒等式で。最後の行 d_q = 0_C は Step 2 の結論
#     （(1) の階数 N）をそのまま使う行なので、行の検算は (1) が担う。
# (7) 主張全体を確かめる（行の検算ではない）: (α,β) ↦ (d_q)_q の係数行列と、d_q・F_q を経た (α,β) ↦ Σ_q d_qF_q の係数行列の階数が 2M、
#     および Z_m・Y_m から直接組んだ (α,β) ↦ Σ α_mZ_m + Σ β_mY_m の係数行列の階数が 2M。
# 否定の対照: π の逆写像でない写像で z を取ると F_{z(m)} = Z_m が崩れる、d_q の α の項の δ を δ_{q y(m)} に取り違えると
# 10 行目が仮定の左辺と合わない、(u) を m = m_0 で使うと崩れる、α の鎖で d_{y(m_0)} に着くと α_{m_0} と合わない。
# π は辞書式の並びと、乱数で並べ替えた全単射の 2 通り（主張は任意の全単射について述べる）。M = 1, 2, 3。浮動小数点なし。
import itertools
from functools import reduce

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
        print("FAIL " + label)

def chain_check(lines, name):
    for k in range(len(lines) - 1):
        check(lines[k] == lines[k + 1], f"{name} 第 {k} 式 = 第 {k+1} 式（左辺を第 0 式とし、等号の第 {k+1} 行）")

K0.<I0> = QuadraticField(-1)

def run(M, perm_seed):
    N = 4^M
    R = PolynomialRing(K0, [f"al{m}" for m in range(1, M + 1)] + [f"be{m}" for m in range(1, M + 1)])
    al = {m: R.gen(m - 1) for m in range(1, M + 1)}
    be = {m: R.gen(M + m - 1) for m in range(1, M + 1)}
    one, zero = R(1), R(0)
    i = R(I0)
    D = 2^M
    O = matrix(R, D, D, 0)
    Id = matrix(R, 2, 2, lambda a, b: one if a == b else zero)
    sx = matrix(R, [[0, 1], [1, 0]]); sy = matrix(R, [[0, -i], [i, 0]]); sz = matrix(R, [[1, 0], [0, -1]])
    e = {1: Id, 2: sx, 3: sy, 4: sz}
    tag = f"M={M} π={'辞書式' if perm_seed is None else '乱数' + str(perm_seed)}"

    def msum(Xs):                       # def_finite_sum_of_matrices: 左から足す
        return reduce(lambda A, B: A + B, Xs)
    def csum(zs):                       # def_finite_sum_of_complex_numbers: 左から足す
        return reduce(lambda a, b: a + b, zs)
    def delta(a, b):                    # def_kronecker_delta（n → N）
        return one if a == b else zero
    # def_kronecker (2): (A_1⊠⋯⊠A_M)_{ν(I),ν(J)} = Π_k (A_k)_{i_k j_k}
    idx = list(itertools.product([0, 1], repeat=M))      # ν の順（辞書式）
    def kron(As):
        Mt = matrix(R, D, D, lambda r, c: prod(As[k][idx[r][k], idx[c][k]] for k in range(M)))
        return Mt
    # 𝒫 と π
    P = list(itertools.product([1, 2, 3, 4], repeat=M))
    if perm_seed is not None:
        set_random_seed(perm_seed)
        P = list(Permutations(P).random_element())
    pi = {q: P[q - 1] for q in range(1, N + 1)}
    pinv = {p: q for q, p in pi.items()}
    check(sorted(pi.values()) == sorted(itertools.product([1, 2, 3, 4], repeat=M)), f"{tag} π は全単射")
    F = {q: kron([e[pi[q][k]] for k in range(M)]) for q in range(1, N + 1)}
    check(all(F[q] == reduce(lambda A, B: A.tensor_product(B), [e[a] for a in pi[q]]) for q in F),
          f"{tag} F_q を def_kronecker の成分で組んだものが Sage の tensor_product と一致")

    # (1) Step 2
    S = PolynomialRing(K0, "c1,c2,c3,c4"); cs = S.gens()
    eS = {a: matrix(S, 2, 2, lambda r, c: S(e[a][r, c].constant_coefficient())) for a in e}
    pauliS = {1: matrix(S, [[1, 0], [0, 1]]), 2: matrix(S, [[0, 1], [1, 0]]), 3: matrix(S, [[0, -S(I0)], [S(I0), 0]]), 4: matrix(S, [[1, 0], [0, -1]])}
    def psum(r):                        # def_finite_sum_of_matrices の段: Σ_{a=1}^{1} := X_1、Σ^{r+1} := Σ^{r} + X_{r+1}
        acc = cs[0] * eS[1]
        for a in range(2, r + 1):
            acc = acc + cs[a - 1] * eS[a]
        return acc
    chain_check([((cs[0] * pauliS[1] + cs[1] * pauliS[2]) + cs[2] * pauliS[3]) + cs[3] * pauliS[4],
                 ((cs[0] * eS[1] + cs[1] * eS[2]) + cs[2] * eS[3]) + cs[3] * eS[4],
                 ((psum(1) + cs[1] * eS[2]) + cs[2] * eS[3]) + cs[3] * eS[4],
                 (psum(2) + cs[2] * eS[3]) + cs[3] * eS[4],
                 psum(3) + cs[3] * eS[4],
                 psum(4),
                 msum([cs[a - 1] * eS[a] for a in range(1, 5)])], f"{tag} Step 2 の鎖")
    Fmat = matrix(K0, [[F[q][r, c].constant_coefficient() for r in range(D) for c in range(D)] for q in range(1, N + 1)])
    check(Fmat.rank() == N, f"{tag} Step 2: 族 (F_q) は線型独立（階数 N）")

    # (2) Step 4
    def site(a, k):                     # σ_k^a: 第 k 因子だけ σ^a
        return kron([a if kk == k else Id for kk in range(1, M + 1)])
    def Zm(m): return reduce(lambda A, B: A * B, [site(sx, k) for k in range(1, m)] + [site(sz, m)])
    def Ym(m): return reduce(lambda A, B: A * B, [site(sx, k) for k in range(1, m)] + [site(sy, m)])
    zeta = {m: tuple(2 if k < m else (4 if k == m else 1) for k in range(1, M + 1)) for m in range(1, M + 1)}
    eta = {m: tuple(2 if k < m else (3 if k == m else 1) for k in range(1, M + 1)) for m in range(1, M + 1)}
    z = {m: pinv[zeta[m]] for m in zeta}
    y = {m: pinv[eta[m]] for m in eta}
    for m in range(1, M + 1):
        chain_check([F[z[m]], kron([e[pi[z[m]][k]] for k in range(M)]), kron([e[pi[pinv[zeta[m]]][k]] for k in range(M)]), kron([e[zeta[m][k]] for k in range(M)]), kron([e[2]] * (m - 1) + [e[4]] + [e[1]] * (M - m)), kron([sx] * (m - 1) + [sz] + [Id] * (M - m)), Zm(m)],
                    f"{tag} Step 4 F_z({m}) = Z_{m}")
        chain_check([F[y[m]], kron([e[pi[y[m]][k]] for k in range(M)]), kron([e[pi[pinv[eta[m]]][k]] for k in range(M)]), kron([e[eta[m][k]] for k in range(M)]), kron([e[2]] * (m - 1) + [e[3]] + [e[1]] * (M - m)), kron([sx] * (m - 1) + [sy] + [Id] * (M - m)), Ym(m)],
                    f"{tag} Step 4 F_y({m}) = Y_{m}")
    # 否定の対照: 逆写像でない写像（z をずらす）
    if N > 1:
        badz = {m: (z[m] % N) + 1 for m in z}
        check(any(F[badz[m]] != Zm(m) for m in z), f"{tag} 否定の対照: π の逆写像でない写像では F_z(m) = Z_m が崩れる")

    # (3) Step 5
    for p1 in pinv:
        for p2 in pinv:
            if pinv[p1] == pinv[p2]:
                chain_check([p1, pi[pinv[p1]], pi[pinv[p2]], p2], f"{tag} Step 5 π^{{-1}} は単射 p={p1}")
    for m in range(1, M + 1):
        for m2 in range(m + 1, M + 1):
            check(zeta[m][m - 1] == 4 and zeta[m2][m - 1] == 2, f"{tag} Step 5 ζ({m}) と ζ({m2}) の第 {m} 成分は 4 と 2")
            check(eta[m][m - 1] == 3 and eta[m2][m - 1] == 2, f"{tag} Step 5 η({m}) と η({m2}) の第 {m} 成分は 3 と 2")
        for m2 in range(1, M + 1):
            if m == m2:
                check(zeta[m][m - 1] == 4 and eta[m2][m - 1] == 3, f"{tag} Step 5 ζ({m}) と η({m2}) の第 {m} 成分は 4 と 3")
            elif m < m2:
                check(zeta[m][m - 1] == 4 and eta[m2][m - 1] == 2, f"{tag} Step 5 ζ({m}) と η({m2}) の第 {m} 成分は 4 と 2")
            else:
                check(zeta[m][m2 - 1] == 2 and eta[m2][m2 - 1] == 3, f"{tag} Step 5 ζ({m}) と η({m2}) の第 {m2} 成分は 2 と 3")
    # 否定の対照: 単射でない写像 g（全ての p を 1 へ送る）では、g(p) = g(p') でも p = p' へ移れない（M ≥ 1 で 𝒫 は 2 元以上）
    g = {p: 1 for p in pinv}
    plist = list(pinv)
    check(g[plist[0]] == g[plist[1]] and plist[0] != plist[1], f"{tag} 否定の対照: 単射でない写像では仮定から p = p' へ移れない")
    allzy = [z[m] for m in z] + [y[m] for m in y]
    check(len(set(allzy)) == 2 * M, f"{tag} Step 5: z(1..M), y(1..M) は相異なる")

    # (4) 準備
    for m in range(1, M + 1):
        for q in range(1, N + 1):
            if q != z[m]:
                chain_check([al[m] * (delta(q, z[m]) * F[q]), al[m] * (zero * F[q]), al[m] * O, O], f"{tag} (t) α q={q} m={m}")
            if q != y[m]:
                chain_check([be[m] * (delta(q, y[m]) * F[q]), be[m] * (zero * F[q]), be[m] * O, O], f"{tag} (t) β q={q} m={m}")
        for m0 in range(1, M + 1):
            if m != m0:
                chain_check([al[m] * delta(z[m0], z[m]), al[m] * zero, zero], f"{tag} (u) α m={m} m0={m0}")
                chain_check([be[m] * delta(y[m0], y[m]), be[m] * zero, zero], f"{tag} (u) β m={m} m0={m0}")
            chain_check([be[m] * delta(z[m0], y[m]), be[m] * zero, zero], f"{tag} (v) β m={m} m0={m0}")
            chain_check([al[m] * delta(y[m0], z[m]), al[m] * zero, zero], f"{tag} (v) α m={m} m0={m0}")
    # 否定の対照: (u) を m = m_0 で使うと崩れる
    check(al[1] * delta(z[1], z[1]) != zero, f"{tag} 否定の対照: (u) は m = m_0 では成り立たない")

    # (5) Σ_q d_qF_q の鎖
    Ms = range(1, M + 1); Qs = range(1, N + 1)
    d = {q: csum([al[m] * delta(q, z[m]) for m in Ms]) + csum([be[m] * delta(q, y[m]) for m in Ms]) for q in Qs}
    lines = [
        msum([d[q] * F[q] for q in Qs]),
        msum([(csum([al[m] * delta(q, z[m]) for m in Ms]) + csum([be[m] * delta(q, y[m]) for m in Ms])) * F[q] for q in Qs]),
        msum([csum([al[m] * delta(q, z[m]) for m in Ms]) * F[q] + csum([be[m] * delta(q, y[m]) for m in Ms]) * F[q] for q in Qs]),
        msum([msum([(al[m] * delta(q, z[m])) * F[q] for m in Ms]) + msum([(be[m] * delta(q, y[m])) * F[q] for m in Ms]) for q in Qs]),
        msum([msum([al[m] * (delta(q, z[m]) * F[q]) for m in Ms]) + msum([be[m] * (delta(q, y[m]) * F[q]) for m in Ms]) for q in Qs]),
        msum([msum([al[m] * (delta(q, z[m]) * F[q]) for m in Ms]) for q in Qs]) + msum([msum([be[m] * (delta(q, y[m]) * F[q]) for m in Ms]) for q in Qs]),
        msum([msum([al[m] * (delta(q, z[m]) * F[q]) for q in Qs]) for m in Ms]) + msum([msum([be[m] * (delta(q, y[m]) * F[q]) for q in Qs]) for m in Ms]),
        msum([al[m] * (delta(z[m], z[m]) * F[z[m]]) for m in Ms]) + msum([be[m] * (delta(y[m], y[m]) * F[y[m]]) for m in Ms]),
        msum([al[m] * (one * F[z[m]]) for m in Ms]) + msum([be[m] * (one * F[y[m]]) for m in Ms]),
        msum([al[m] * F[z[m]] for m in Ms]) + msum([be[m] * F[y[m]] for m in Ms]),
        msum([al[m] * Zm(m) for m in Ms]) + msum([be[m] * Ym(m) for m in Ms]),
    ]
    chain_check(lines, f"{tag} Σ_q d_qF_q の鎖")
    hyp_lhs = msum(  # 否定の対照の比較相手（最後の行 = O は仮定そのもので検算の対象外）
        [al[m] * Zm(m) for m in Ms]) + msum([be[m] * Ym(m) for m in Ms])
    # 各行で finite_sum_of_matrices_with_single_nonzero_term の使い方: 7 行目の内側の和の z(m) 以外の項は O
    for m in Ms:
        check(all(al[m] * (delta(q, z[m]) * F[q]) == O for q in Qs if q != z[m]), f"{tag} 7 行目（6→7）m={m} の α の項は q = q_Z(m) 以外 O")
        check(all(be[m] * (delta(q, y[m]) * F[q]) == O for q in Qs if q != y[m]), f"{tag} 7 行目（6→7）m={m} の β の項は q = q_Y(m) 以外 O")
    # 否定の対照: α の項の δ を δ_{q y(m)} に取り違える
    dbad = {q: csum([al[m] * delta(q, y[m]) for m in Ms]) + csum([be[m] * delta(q, y[m]) for m in Ms]) for q in Qs}
    check(msum([dbad[q] * F[q] for q in Qs]) != hyp_lhs, f"{tag} 否定の対照: δ_{{q z(m)}} を δ_{{q y(m)}} にすると仮定の左辺と合わない")

    # (6) α_{m0}・β_{m0} の鎖
    for m0 in Ms:
        la = [al[m0], al[m0] * one, al[m0] * delta(z[m0], z[m0]),
              csum([al[m] * delta(z[m0], z[m]) for m in Ms]),
              csum([al[m] * delta(z[m0], z[m]) for m in Ms]) + zero,
              csum([al[m] * delta(z[m0], z[m]) for m in Ms]) + be[1] * delta(z[m0], y[1]),
              csum([al[m] * delta(z[m0], z[m]) for m in Ms]) + csum([be[m] * delta(z[m0], y[m]) for m in Ms]),
              d[z[m0]]]
        chain_check(la, f"{tag} α_{m0} の鎖")
        lb = [be[m0], be[m0] * one, be[m0] * delta(y[m0], y[m0]),
              csum([be[m] * delta(y[m0], y[m]) for m in Ms]),
              zero + csum([be[m] * delta(y[m0], y[m]) for m in Ms]),
              al[1] * delta(y[m0], z[1]) + csum([be[m] * delta(y[m0], y[m]) for m in Ms]),
              csum([al[m] * delta(y[m0], z[m]) for m in Ms]) + csum([be[m] * delta(y[m0], y[m]) for m in Ms]),
              d[y[m0]]]
        chain_check(lb, f"{tag} β_{m0} の鎖")
        check(d[y[m0]] != al[m0], f"{tag} 否定の対照: α の鎖が d_y({m0}) に着くと α_{m0} と合わない")
    # 最後の行: Σ_q d_qF_q = O の解は d = 0 だけ（Step 2）。d の各成分は α・β の一次式で、
    # 写像 (α,β) ↦ (d_q)_q が単射なので α = β = 0。ここでは d を α・β の係数行列にして、
    # Σ_q d_qF_q の係数ベクトル = (d_q)_q · Fmat の核が 0 であることと、(α,β) ↦ d の係数行列の階数 2M を見る。
    Dm = matrix(K0, [[d[q].monomial_coefficient(R.gen(j)) for q in Qs] for j in range(2 * M)])
    check(Dm.rank() == 2 * M, f"{tag} (α,β) ↦ (d_q)_q は単射（階数 2M）")
    check((Dm * Fmat).rank() == 2 * M, f"{tag} 主張: d_q・F_q を経た (α,β) ↦ Σ_q d_qF_q は単射")
    ZY = matrix(K0, [[Zm(m)[r, c].constant_coefficient() for r in range(D) for c in range(D)] for m in Ms]
                    + [[Ym(m)[r, c].constant_coefficient() for r in range(D) for c in range(D)] for m in Ms])
    check(ZY.rank() == 2 * M, f"{tag} 主張: Z_m・Y_m から直接組んだ (α,β) ↦ Σ α_mZ_m + Σ β_mY_m は単射")

for M in [1, 2, 3]:
    run(M, None)
    run(M, 20261113 + M)

print(f"checks: {n_check}, failures: {n_fail}")
if n_fail:
    raise SystemExit(1)
print("ALL PASS")
