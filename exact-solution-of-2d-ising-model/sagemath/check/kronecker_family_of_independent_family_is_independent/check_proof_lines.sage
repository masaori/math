# 対象ラベル: kronecker_family_of_independent_family_is_independent
# 証明の各行を一行ずつ確かめる。
# (0) 仮定: b_1..b_4 が線型独立（2 つの族: Pauli 族 {I,σ^x,σ^y,σ^z} と、別の線型独立な族）。
# (1) 準備 (a) の P^{(s)}_q と (R)（s ≥ 2 の 3 行の鎖と s = 1 の 4 行の鎖）、(b) の χ^{(s)}_q（s を M から下げる帰納的定義）。
# (2) Step 1 の 8 行の鎖（A(M)）を、係数 d を乱数に取って 6 行目まで（仮定を使う 7 行目は (7) で）。
# (3) Step 2: (2a) の 11 行の鎖（A(s) を使う 10 行目は「9 行目 = A(s) の左辺」で、def_zero_matrix の 11 行目は O の成分で）、
#     (2b) の δ の 2 行の鎖と b_{π(q)_s} の 3 行の鎖と B の 6 行の鎖、(2d) の 6 行の鎖（(2c) を使う 6 行目は
#     「5 行目 = B の b_a の係数」で）。係数 d は乱数（仮定を満たさない）なので、A(s) を使う行は値の一致ではなく、
#     B = Σ_a (A(s-1) の左辺 (a,τ')) b_a と B_{uv} = A(s) の左辺 ((U',u),(V',v),τ') という、Step 2 の論法の骨格の恒等式で確かめる。
# (4) Step 4 の E(s) を全ての s, q, τ で、三つの場合の鎖を一行ずつ。
# (5) Step 5 の q ≠ q_0 の 3 行の鎖と d_{q_0} の 6 行の鎖（A(0) を使う最後の行は「5 行目 = A(0) の左辺」で）。
# (6) 主張: 族 (F_q) の線型独立性（係数行列の階数 N）。否定の対照: 線型独立でない族 {I,σ^x,σ^y,σ^x} では
#     (F_q) が線型独立でないこと、(2d) の δ の添字を第 s-1 成分に取り違えると B の係数と合わないこと、
#     χ の定義の δ を第 s+1 成分で取ると E(s) が崩れること。
# (7) 仮定・A(s)・(2c) を使う行: 線型独立でない族の、Σ_q d_q F_q = O を満たす零でない d で、仮定を使う行と A(M)・(2a) の B = O が
#     成り立ち、(2c) の結論がどこかで崩れて A(s-1) が崩れること（線型独立性の仮定が (2c) で効いていることの確認）。
# M = 1, 2, 3（(7) は M = 1, 2）。行列は QQ(i) 上で厳密に計算する。浮動小数点なし。
import itertools

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
        check(lines[k] == lines[k + 1], f"{name} 第 {k+1} 行 = 第 {k+2} 行")

K0.<i> = QuadraticField(-1)
one = K0(1); zero = K0(0)
I2 = identity_matrix(K0, 2)
sx = matrix(K0, [[0, 1], [1, 0]])
sy = matrix(K0, [[0, -i], [i, 0]])
sz = matrix(K0, [[1, 0], [0, -1]])
O2 = matrix(K0, 2, 2, 0)

def unit(r, c):
    m = matrix(K0, 2, 2, 0); m[r, c] = 1; return m

def kron(mats):  # def_kronecker（Sage の tensor_product は第 1 因子が最上位の桁）
    out = mats[0]
    for m in mats[1:]:
        out = out.tensor_product(m)
    return out

def nu(I):  # def_kronecker の ν（1 始まり）
    M = len(I)
    return 1 + sum((I[k] - 1) * 2^(M - 1 - k) for k in range(M))

def delta(x, y):  # def_kronecker_delta
    return one if x == y else zero

def msum(ms, n):  # def_finite_sum_of_matrices（左から順に足す）
    out = matrix(K0, n, n, 0)
    for m in ms:
        out = out + m
    return out

def csum(zs):  # def_finite_sum_of_complex_numbers
    out = zero
    for z in zs:
        out = out + z
    return out

def cprod(zs):  # def_finite_product_of_complex_numbers（左から順に掛ける）
    out = zs[0]
    for z in zs[1:]:
        out = out * z
    return out

def vec(m):
    return vector(K0, m.list())

families = {
    "Pauli": [I2, sx, sy, sz],
    "別の線型独立な族": [I2 + sx, sx + i * sy, sz - 2 * I2, unit(0, 1) + unit(1, 1)],
}
set_random_seed(20261112)
def rndc():
    return K0(ZZ.random_element(-3, 4)) + i * ZZ.random_element(-3, 4)

for fname, b0 in families.items():
    b = {a + 1: b0[a] for a in range(4)}
    # (0) 仮定: 線型独立（4 元の係数行列の階数 4）
    check(matrix(K0, [vec(b[a]) for a in range(1, 5)]).rank() == 4, f"{fname}: b_1..b_4 は線型独立")
    for M in [1, 2, 3]:
        N = 4^M
        Pset = list(itertools.product(range(1, 5), repeat=M))
        pi = {q: Pset[q - 1] for q in range(1, N + 1)}           # π: {1..N} → 𝒫（全単射）
        F = {q: kron([b[pi[q][k]] for k in range(M)]) for q in range(1, N + 1)}
        tag = f"{fname} M={M}"
        # (6) 主張: (F_q) は線型独立
        check(matrix(K0, [vec(F[q]) for q in range(1, N + 1)]).rank() == N, f"{tag}: (F_q) は線型独立")
        d = {q: rndc() for q in range(1, N + 1)}
        S = msum([d[q] * F[q] for q in range(1, N + 1)], 2^M)
        OM = matrix(K0, 2^M, 2^M, 0)
        # (1) 準備 (a): P^{(s)}_q（s=0 は 1_C、s≥1 は有限積）
        def P(q, s, U, V):
            if s == 0:
                return one
            return cprod([b[pi[q][k]][U[k] - 1, V[k] - 1] for k in range(s)])
        for s in range(1, M + 1):
            for Up in itertools.product([1, 2], repeat=s - 1):
                for Vp in itertools.product([1, 2], repeat=s - 1):
                    for u in [1, 2]:
                        for v in [1, 2]:
                            for q in range(1, N + 1):
                                lhs = P(q, s, Up + (u,), Vp + (v,))
                                bsuv = b[pi[q][s - 1]][u - 1, v - 1]
                                Uf, Vf = Up + (u,), Vp + (v,)
                                if s == 1:
                                    chain_check([lhs, cprod([b[pi[q][k]][Uf[k] - 1, Vf[k] - 1] for k in range(1)]), bsuv, one * bsuv,
                                                 P(q, 0, (), ()) * bsuv], f"{tag} (R) s=1 q={q}")
                                else:
                                    chain_check([lhs, cprod([b[pi[q][k]][Uf[k] - 1, Vf[k] - 1] for k in range(s)]),
                                                 cprod([b[pi[q][k]][Uf[k] - 1, Vf[k] - 1] for k in range(s - 1)]) * bsuv,
                                                 P(q, s - 1, Up, Vp) * bsuv], f"{tag} (R) s={s} q={q}")
        # (1) 準備 (b): χ^{(s)}_q（τ = (τ_{s+1},…,τ_M)、s を M から下げる帰納的定義）
        def chi(q, s, tau, shift=0):
            if s == M:
                return one
            a = tau[0]
            k = min(s + 1 + shift, M)   # shift=0 が本文の δ_{π(q)_{s+1} a}（χ^{(s)} の (a,τ') の a は第 s+1 成分）
            return delta(pi[q][k - 1], a) * chi(q, s + 1, tau[1:], shift)
        def Asum(s, U, V, tau):
            return csum([d[q] * (P(q, s, U, V) * chi(q, s, tau)) for q in range(1, N + 1)])
        # (2) Step 1: A(M) の 8 行の鎖
        for U in itertools.product([1, 2], repeat=M):
            for V in itertools.product([1, 2], repeat=M):
                r, c = nu(U) - 1, nu(V) - 1
                lines = [
                    csum([d[q] * (P(q, M, U, V) * chi(q, M, ())) for q in range(1, N + 1)]),
                    csum([d[q] * (P(q, M, U, V) * one) for q in range(1, N + 1)]),
                    csum([d[q] * P(q, M, U, V) for q in range(1, N + 1)]),
                    csum([d[q] * cprod([b[pi[q][k]][U[k] - 1, V[k] - 1] for k in range(M)]) for q in range(1, N + 1)]),
                    csum([d[q] * F[q][r, c] for q in range(1, N + 1)]),
                    csum([(d[q] * F[q])[r, c] for q in range(1, N + 1)]),
                    S[r, c],
                ]
                chain_check(lines, f"{tag} Step 1 U={U} V={V}")
                check(OM[r, c] == zero, f"{tag} Step 1 def_zero_matrix")
        # (3) Step 2
        for s in range(1, M + 1):
            for Up in itertools.product([1, 2], repeat=s - 1):
                for Vp in itertools.product([1, 2], repeat=s - 1):
                    for taup in itertools.product(range(1, 5), repeat=M - s):
                        wq = {q: d[q] * (P(q, s - 1, Up, Vp) * chi(q, s, taup)) for q in range(1, N + 1)}
                        B = msum([wq[q] * b[pi[q][s - 1]] for q in range(1, N + 1)], 2)
                        t2 = f"{tag} s={s} U'={Up} V'={Vp} τ'={taup}"
                        # (2a) の鎖
                        for u in [1, 2]:
                            for v in [1, 2]:
                                bs = {q: b[pi[q][s - 1]][u - 1, v - 1] for q in range(1, N + 1)}
                                Pm = {q: P(q, s - 1, Up, Vp) for q in range(1, N + 1)}
                                ch = {q: chi(q, s, taup) for q in range(1, N + 1)}
                                lines = [
                                    B[u - 1, v - 1],
                                    csum([(wq[q] * b[pi[q][s - 1]])[u - 1, v - 1] for q in range(1, N + 1)]),
                                    csum([wq[q] * bs[q] for q in range(1, N + 1)]),
                                    csum([(d[q] * (Pm[q] * ch[q])) * bs[q] for q in range(1, N + 1)]),
                                    csum([d[q] * ((Pm[q] * ch[q]) * bs[q]) for q in range(1, N + 1)]),
                                    csum([d[q] * (Pm[q] * (ch[q] * bs[q])) for q in range(1, N + 1)]),
                                    csum([d[q] * (Pm[q] * (bs[q] * ch[q])) for q in range(1, N + 1)]),
                                    csum([d[q] * ((Pm[q] * bs[q]) * ch[q]) for q in range(1, N + 1)]),
                                    csum([d[q] * (P(q, s, Up + (u,), Vp + (v,)) * ch[q]) for q in range(1, N + 1)]),
                                ]
                                chain_check(lines, f"{t2} (2a) u={u} v={v}")
                                # A(s) を使う行: 9 行目は A(s) の左辺そのもの
                                check(lines[-1] == Asum(s, Up + (u,), Vp + (v,), taup), f"{t2} (2a) 9 行目 = A(s) の左辺")
                                check(O2[u - 1, v - 1] == zero, f"{t2} (2a) def_zero_matrix")
                        # (2b): δ の鎖、b_{π(q)_s} の鎖、B の鎖
                        for q in range(1, N + 1):
                            ps = pi[q][s - 1]
                            for a in range(1, 5):
                                if a != ps:
                                    chain_check([delta(ps, a) * b[a], zero * b[a], O2], f"{t2} (2b) δ q={q} a={a}")
                            chain_check([b[ps], one * b[ps], delta(ps, ps) * b[ps],
                                         msum([delta(ps, a) * b[a] for a in range(1, 5)], 2)], f"{t2} (2b) b_π(q)_s q={q}")
                        lines = [
                            B,
                            msum([wq[q] * msum([delta(pi[q][s - 1], a) * b[a] for a in range(1, 5)], 2) for q in range(1, N + 1)], 2),
                            msum([msum([wq[q] * (delta(pi[q][s - 1], a) * b[a]) for a in range(1, 5)], 2) for q in range(1, N + 1)], 2),
                            msum([msum([(wq[q] * delta(pi[q][s - 1], a)) * b[a] for a in range(1, 5)], 2) for q in range(1, N + 1)], 2),
                            msum([msum([(wq[q] * delta(pi[q][s - 1], a)) * b[a] for q in range(1, N + 1)], 2) for a in range(1, 5)], 2),
                            msum([csum([wq[q] * delta(pi[q][s - 1], a) for q in range(1, N + 1)]) * b[a] for a in range(1, 5)], 2),
                        ]
                        chain_check(lines, f"{t2} (2b) B")
                        # (2d) の鎖
                        for a in range(1, 5):
                            Pm = {q: P(q, s - 1, Up, Vp) for q in range(1, N + 1)}
                            ch = {q: chi(q, s, taup) for q in range(1, N + 1)}
                            dl = {q: delta(pi[q][s - 1], a) for q in range(1, N + 1)}
                            lines = [
                                csum([d[q] * (Pm[q] * chi(q, s - 1, (a,) + taup)) for q in range(1, N + 1)]),
                                csum([d[q] * (Pm[q] * (dl[q] * ch[q])) for q in range(1, N + 1)]),
                                csum([d[q] * (Pm[q] * (ch[q] * dl[q])) for q in range(1, N + 1)]),
                                csum([d[q] * ((Pm[q] * ch[q]) * dl[q]) for q in range(1, N + 1)]),
                                csum([(d[q] * (Pm[q] * ch[q])) * dl[q] for q in range(1, N + 1)]),
                                csum([wq[q] * dl[q] for q in range(1, N + 1)]),
                            ]
                            chain_check(lines, f"{t2} (2d) a={a}")
                            check(lines[0] == Asum(s - 1, Up, Vp, (a,) + taup), f"{t2} (2d) 1 行目 = A(s-1) の左辺")
                        # 論法の骨格: B = Σ_a (A(s-1) の左辺 (a,τ')) b_a
                        check(B == msum([Asum(s - 1, Up, Vp, (a,) + taup) * b[a] for a in range(1, 5)], 2), f"{t2} B = Σ_a A(s-1)_a b_a")
        # 否定の対照: (2d) の δ を第 s-1 成分で取ると B の係数と合わない（M ≥ 2、s = 2 で調べる）
        if M >= 2:
            s = 2
            bad = False
            for Up in itertools.product([1, 2], repeat=s - 1):
                for Vp in itertools.product([1, 2], repeat=s - 1):
                    for taup in itertools.product(range(1, 5), repeat=M - s):
                        wq = {q: d[q] * (P(q, s - 1, Up, Vp) * chi(q, s, taup)) for q in range(1, N + 1)}
                        B = msum([wq[q] * b[pi[q][s - 1]] for q in range(1, N + 1)], 2)
                        Bw = msum([csum([wq[q] * delta(pi[q][s - 2], a) for q in range(1, N + 1)]) * b[a] for a in range(1, 5)], 2)
                        if B != Bw:
                            bad = True
            check(bad, f"{tag} 否定の対照: δ の添字の取り違えで B の表示が崩れる")
        # (4) Step 4: E(s) と三つの場合の鎖
        for s in range(M, -1, -1):
            for tau in itertools.product(range(1, 5), repeat=M - s):
                for q in range(1, N + 1):
                    agree = all(pi[q][k - 1] == tau[k - s - 1] for k in range(s + 1, M + 1))
                    check(chi(q, s, tau) == (one if agree else zero), f"{tag} E({s}) q={q} τ={tau}")
            if s >= 1:
                for a in range(1, 5):
                    for taup in itertools.product(range(1, 5), repeat=M - s):
                        for q in range(1, N + 1):
                            ps = pi[q][s - 1]
                            rest = all(pi[q][k - 1] == taup[k - s - 1] for k in range(s + 1, M + 1))
                            e1 = chi(q, s - 1, (a,) + taup)
                            if ps == a and rest:
                                chain_check([e1, delta(ps, a) * chi(q, s, taup), one * chi(q, s, taup), one * one, one], f"{tag} E 場合1 s={s}")
                            elif ps != a:
                                chain_check([e1, delta(ps, a) * chi(q, s, taup), zero * chi(q, s, taup), zero], f"{tag} E 場合2 s={s}")
                            else:
                                chain_check([e1, delta(ps, a) * chi(q, s, taup), delta(ps, a) * zero, zero], f"{tag} E 場合3 s={s}")
        # 否定の対照: χ の δ を第 s+2 成分（ずらし）で取ると E(s) が崩れる
        if M >= 2:
            bad = False
            for q in range(1, N + 1):
                for tau in itertools.product(range(1, 5), repeat=M):
                    agree = all(pi[q][k - 1] == tau[k - 1] for k in range(1, M + 1))
                    if chi(q, 0, tau, shift=1) != (one if agree else zero):
                        bad = True
            check(bad, f"{tag} 否定の対照: χ の δ の添字をずらすと E(0) が崩れる")
        # (5) Step 5
        for q0 in range(1, N + 1):
            t0 = pi[q0]
            for q in range(1, N + 1):
                if q != q0:
                    chain_check([d[q] * (P(q, 0, (), ()) * chi(q, 0, t0)), d[q] * (P(q, 0, (), ()) * zero), d[q] * zero, zero], f"{tag} Step 5 q≠q0")
            lines = [
                d[q0],
                d[q0] * one,
                d[q0] * (one * one),
                d[q0] * (P(q0, 0, (), ()) * one),
                d[q0] * (P(q0, 0, (), ()) * chi(q0, 0, t0)),
                csum([d[q] * (P(q, 0, (), ()) * chi(q, 0, t0)) for q in range(1, N + 1)]),
            ]
            chain_check(lines, f"{tag} Step 5 q0={q0}")
            check(lines[-1] == Asum(0, (), (), t0), f"{tag} Step 5 最後の行 = A(0) の左辺")

# 否定の対照: 線型独立でない族では (F_q) も線型独立でない
bdep = [I2, sx, sy, sx]
check(matrix(K0, [vec(m) for m in bdep]).rank() < 4, "否定の対照: {I,σ^x,σ^y,σ^x} は線型独立でない")
for M in [1, 2]:
    N = 4^M
    Pset = list(itertools.product(range(4), repeat=M))
    Fd = [kron([bdep[p[k]] for k in range(M)]) for p in Pset]
    check(matrix(K0, [vec(f) for f in Fd]).rank() < N, f"否定の対照: M={M} で線型独立でない族のクロネッカー積の族は線型独立でない")

# 仮定・A(s)・(2c) を使う行: 線型独立でない族 b' = {I,σ^x,σ^y,σ^x} の、Σ_q d_q F_q = O を満たす零でない d で回す。
# 仮定を使う Step 1 の 7 行目（= O の成分）と A(M) は 0_C になり、(2a) の B = O も成り立つが、
# (2c)（線型独立性の当てはめ）の結論 Σ_q w_q δ_{π(q)_s a} = 0_C がどこかで崩れ、A(s-1) が崩れることを確かめる。
bd = {a + 1: bdep[a] for a in range(4)}
for M in [1, 2]:
    N = 4^M
    Pset = list(itertools.product(range(1, 5), repeat=M))
    pi = {q: Pset[q - 1] for q in range(1, N + 1)}
    F = {q: kron([bd[pi[q][k]] for k in range(M)]) for q in range(1, N + 1)}
    A = matrix(K0, [vec(F[q]) for q in range(1, N + 1)]).transpose()
    ker = A.right_kernel().basis()
    dv = ker[0]
    d = {q: dv[q - 1] for q in range(1, N + 1)}
    tag = f"線型独立でない族 M={M}"
    S = msum([d[q] * F[q] for q in range(1, N + 1)], 2^M)
    check(S == matrix(K0, 2^M, 2^M, 0) and dv != 0, f"{tag}: Σ_q d_q F_q = O となる零でない d")
    def P(q, s, U, V):
        if s == 0:
            return one
        return cprod([bd[pi[q][k]][U[k] - 1, V[k] - 1] for k in range(s)])
    def chi(q, s, tau):
        if s == M:
            return one
        return delta(pi[q][s], tau[0]) * chi(q, s + 1, tau[1:])
    def Asum(s, U, V, tau):
        return csum([d[q] * (P(q, s, U, V) * chi(q, s, tau)) for q in range(1, N + 1)])
    # Step 1: 仮定を使う 7 行目とその後は 0_C（A(M)）
    for U in itertools.product([1, 2], repeat=M):
        for V in itertools.product([1, 2], repeat=M):
            r, c = nu(U) - 1, nu(V) - 1
            check(S[r, c] == zero and Asum(M, U, V, ()) == zero, f"{tag} Step 1 仮定の行と A(M) U={U} V={V}")
    # 各 s で (2a) の B = O は A(s) から従うが、(2c) の結論が崩れる箇所がある
    broken = False
    for s in range(M, 0, -1):
        holds_s = all(Asum(s, U, V, tau) == zero for U in itertools.product([1, 2], repeat=s)
                      for V in itertools.product([1, 2], repeat=s) for tau in itertools.product(range(1, 5), repeat=M - s))
        if not holds_s:
            break
        for Up in itertools.product([1, 2], repeat=s - 1):
            for Vp in itertools.product([1, 2], repeat=s - 1):
                for taup in itertools.product(range(1, 5), repeat=M - s):
                    wq = {q: d[q] * (P(q, s - 1, Up, Vp) * chi(q, s, taup)) for q in range(1, N + 1)}
                    B = msum([wq[q] * bd[pi[q][s - 1]] for q in range(1, N + 1)], 2)
                    check(B == O2, f"{tag} s={s} (2a): A(s) から B = O")
                    coeffs = [csum([wq[q] * delta(pi[q][s - 1], a) for q in range(1, N + 1)]) for a in range(1, 5)]
                    if any(x != zero for x in coeffs):
                        broken = True
                        check(any(Asum(s - 1, Up, Vp, (a,) + taup) != zero for a in range(1, 5)),
                              f"{tag} s={s}: (2c) が崩れると A(s-1) が崩れる")
    check(broken, f"{tag}: 否定の対照: 線型独立性が無いと (2c) の結論が崩れる")

print(f"checks: {n_check}, failures: {n_fail}")
print("RESULT: " + ("PASS" if n_fail == 0 else "FAIL"))
