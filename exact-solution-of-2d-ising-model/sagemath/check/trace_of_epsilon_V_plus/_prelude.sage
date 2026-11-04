# 対象ラベル: trace_of_epsilon_V_plus の検算の共通の準備。
#
# 厳密に計算するための結合定数の選び方（ℝ への脱出を「K の選び方」の一点に閉じ込める）:
#   K_1 := 2 log p、K_2 := log q（p, q は 1 より大きい有理数）と置くと、
#   exp(K_1 n/2) = p^n、exp(K_2 n) = q^n（n ∈ ZZ）、cosh K_1 = (p^2 + p^{-2})/2、sinh K_1 = (p^2 − p^{-2})/2 が QQ に入る。
#   行列の exp は、整数の固有値を持ち対角化できる整数行列 S について、スペクトル射影
#   P_λ := Π_{λ'≠λ}(S − λ'I)/(λ − λ') で exp(cS) := Σ_λ exp(cλ)P_λ として QQ(i) で厳密に組む
#   （S^n = Σ λ^n P_λ なので def_exp の級数は Σ_λ (Σ_n (cλ)^n/n!) P_λ に一致する）。
#   Σ P_λ = I、SP_λ = λP_λ を確かめてから使う。
# 行列は pauli_sites_exact.sage の def_kronecker (2) の成分の式で組んだサイトの Pauli 行列から作り、
# 積・スカラー倍・和は本文の定め方の成分の式（body_*）で組む。
load("../../_shared/pauli_sites_exact.sage")
import itertools

P_ = body_product
S_ = body_scalar
A_ = body_sum

# (p, q): K_1 = 2 log p、K_2 = log q
COUPLINGS = [(QQ(2), QQ(3) / 2), (QQ(3) / 2, QQ(5) / 4), (QQ(5) / 3, QQ(2))]
M_RANGE = [2, 3, 4, 5]


def configs(M):
    """𝔐（def_row_configurations）。s(m) は s[m-1]。"""
    return [tuple(c) for c in itertools.product([1, -1], repeat=M)]


def neg(s):
    """(−s)(m) := −s(m)。"""
    return tuple(-x for x in s)


def ord_(s):
    """def_row_configuration_numbering: ord(s) = 1 + Σ (1 − s(m))/2 · 2^{M−m}。"""
    M = len(s)
    return 1 + sum(((1 - s[m - 1]) // 2) * 2**(M - m) for m in range(1, M + 1))


def iota(s):
    """def_config_basis_iso: +1 ↦ 1、−1 ↦ 2。"""
    return tuple(1 if x == 1 else 2 for x in s)


def f_basis(I):
    """def_end_iso の f_I（def_kronecker (1) の数ベクトルの成分の式 (f_I)_{ν(J)} = Π_m (e_{i_m})_{j_m}）。2^M 行 1 列。"""
    M = len(I)
    e = {1: (1, 0), 2: (0, 1)}
    v = matrix(KG, 2**M, 1)
    for J in index_set(M):
        v[nu(J) - 1, 0] = prod(KG(e[I[m]][J[m] - 1]) for m in range(M))
    return v


def energy(s):
    """def_open_chain_spin_energy: E(s) = Σ_{m=1}^{M−1} s(m)s(m+1)。"""
    return sum(s[m - 1] * s[m] for m in range(1, len(s)))


def incl(r):
    """inclusion_rr_to_cc: r ↦ (r, 0)。"""
    return KG([QQ(r), 0])


def tr(A):
    """def_trace: 対角成分を k = 1, …, n の順に足す。"""
    t = A[0, 0]
    for k in range(1, A.nrows()):
        t = t + A[k, k]
    return t


def sum_over_configs(M, a):
    """準備の Σ_{s∈𝔐} a(s) := Σ_{k=1}^{2^M} a(ord^{-1}(k))（左から足す）。"""
    inv = {ord_(s): s for s in configs(M)}
    t = a(inv[1])
    for k in range(2, 2**M + 1):
        t = t + a(inv[k])
    return t


def real_prod(xs):
    """def_finite_product_of_real_numbers: Π_{j=1}^{1} := r_1、Π_{j=1}^{m+1} := (Π_{j=1}^{m}) r_{m+1}。"""
    t = xs[0]
    for x in xs[1:]:
        t = t * x
    return t


def rpow(x, n):
    """x^n := Π_{j=1}^{n} x（n ≥ 1）。"""
    return real_prod([x] * n)


def spectral_exp(S, w):
    """整数の固有値を持ち対角化できる S について、exp(cS) := Σ_λ w(λ) P_λ（w(λ) が exp(cλ) の値）。"""
    n = S.nrows()
    Sq = matrix(QQ, S)
    assert matrix(KG, Sq) == S, "S の成分が QQ に無い"
    cp = Sq.charpoly()
    roots = cp.roots(ZZ)
    assert sum(m for _, m in roots) == n, "固有値が整数だけではない"
    lams = [ZZ(r) for r, _ in roots]
    Id = identity_matrix(QQ, n)
    Ps = {}
    for lam in lams:
        Pl = Id
        for lp in lams:
            if lp != lam:
                Pl = Pl * (Sq - lp * Id) / (lam - lp)
        Ps[lam] = Pl
    assert sum(Ps.values(), matrix(QQ, n, n)) == Id
    for lam in lams:
        assert Sq * Ps[lam] == lam * Ps[lam]
    out = matrix(QQ, n, n)
    for lam in lams:
        out = out + QQ(w(lam)) * Ps[lam]
    return matrix(KG, out)


class Setting:
    """M_col と (p, q) を固定した本文の行列と実数。"""

    def __init__(self, M, p, q):
        self.M, self.p, self.q = M, p, q
        n = 2**M
        self.n = n
        self.I = body_identity(KG, n)
        self.eps = epsilon(M)                                  # def_global_spin_flip_matrix
        sz = [None] + [site(M, k, 'z') for k in range(1, M + 1)]
        self.D0 = body_finite_sum([P_(sz[m], sz[m + 1]) for m in range(1, M)])   # def_D0_open_chain_operator
        self.G = P_(sz[M], sz[1])                              # def_G_boundary_operator
        self.H1 = H1_plus(M)                                   # def_H1_plus
        self.iH1 = S_(i_K, self.H1)
        # 実数（QQ に入るように選んだ値）
        self.ch = (p**2 + p**-2) / 2                           # cosh K_1
        self.sh = (p**2 - p**-2) / 2                           # sinh K_1
        self.kappa_exp = lambda n_: p**(2 * n_)                # exp(K_1 n)
        self.k2exp = lambda n_: q**n_                          # exp(K_2 n)
        # B := exp((i/2)K_1H_1^{(+)}) = exp((K_1/2)(iH_1^{(+)}))、V_1^{(+)} := exp(iK_1H_1^{(+)}) = exp(K_1(iH_1^{(+)}))。
        # iH_1^{(+)} の固有値 λ ごとに exp((K_1/2)λ) = p^λ、exp(K_1λ) = p^{2λ}。
        self.B = spectral_exp(self.iH1, lambda lam: p**lam)
        self.V1 = spectral_exp(self.iH1, lambda lam: p**(2 * lam))
        # V_2: def_transfer_matrix の成分（行・列を ord で指す）
        self.V2 = matrix(KG, n, n)
        for s in configs(M):
            for sp in configs(M):
                self.V2[ord_(s) - 1, ord_(sp) - 1] = incl(q**sum(s[m] * sp[m] for m in range(M)))
        self.V = P_(P_(self.B, self.V2), self.B)              # def_V_plus
        self.epsG = P_(self.eps, self.G)
        # exp(κD_0)・exp(κ(εG)) はそれぞれ D_0・εG のスペクトル射影で（exp(K_1λ) = p^{2λ}）
        self.expD0 = spectral_exp(self.D0, lambda lam: p**(2 * lam))
        self.expEG = spectral_exp(self.epsG, lambda lam: p**(2 * lam))

    def closed_form(self):
        """主張の右辺 (2exp(−K_2)cosh K_1)^M + (2exp(K_2)sinh K_1)^M ∈ QQ。"""
        q, M = self.q, self.M
        return rpow(2 * q**-1 * self.ch, M) + rpow(2 * q * self.sh, M)


class Report:
    def __init__(self, title):
        self.title, self.n, self.neg, self.fail = title, 0, 0, 0
        print(f"=== {title} ===", flush=True)

    def chain(self, lines, label):
        for k, ((a, A), (b, B)) in enumerate(zip(lines, lines[1:]), start=1):
            self.n += 1
            if not (A == B):
                self.fail += 1
                print(f"FAIL: {label} の {k} 行目: 「{a}」≠「{b}」", flush=True)

    def check(self, ok, label):
        self.n += 1
        if not ok:
            self.fail += 1
            print(f"FAIL: {label}", flush=True)

    def negative(self, differs, label):
        self.neg += 1
        if not differs:
            self.fail += 1
            print(f"FAIL（否定コントロールが外れない）: {label}", flush=True)

    def finish(self):
        print(f"等号・主張 {self.n} 件、否定コントロール {self.neg} 件、失敗 {self.fail} 件")
        print("RESULT: " + ("PASS" if self.fail == 0 else "FAIL"))
        assert self.fail == 0
