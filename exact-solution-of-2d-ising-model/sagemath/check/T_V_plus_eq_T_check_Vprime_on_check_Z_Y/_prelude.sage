# 対象ラベル: T_V_plus_eq_T_check_Vprime_on_check_Z_Y の検算の準備。
# 数体の組み方は commutation_V_plus_check_psi の検算の準備をそのまま写したもの（PsiSetting・Report・組の積・T の合成）。
#  - 結合定数は K_1 := 2 log y、K_2 := log x（x, y ∈ QQ_{>1}）と選ぶ。共通の準備 _shared/transfer_factor_actions_on_check_Z_Y.sage の
#    Factors が、Ž_μ・Y̌_μ・(V_1^{(+)})^{1/2} = exp(X)・exp(-X)・V_2・c_2^*・s_2^*・位相 exp(±i(θ̃_μ)_C) を一つの数体 F に置く。
#  - σ := (√M_col)_C は F の中にあり、ζ ↦ exp(2πi/(4M)) の埋め込みで正になる方を取る。
#  - r_μ := |γ_2(θ̃_μ)| は n_μ := γ_2 conj(γ_2) ∈ F の平方根で、F に無ければ E := F(R)、R^2 = n_μ に持つ。
#    r_μ > 0 を使う所（λ_{±,μ} と exp(±γ) の向き、ボールへの埋め込み）は R ↦ +r_μ（AA）の埋め込みで読む。
# この検算で足したもの: E の元を ComplexBallField へ移す to_cb（ℝ への脱出を含む行のボールの検算で使う）、行列の exp のボール。
import sys
load("../../_shared/transfer_factor_actions_on_check_Z_Y.sage")

class Report:
    def __init__(self, title):
        self.title = title; self.n = 0; self.fail = 0
        print("==", title)

    def check(self, ok, label, quiet=False):
        self.n += 1
        if not ok:
            self.fail += 1
        if not ok or not quiet:
            print(("PASS " if ok else "FAIL ") + label)

    def finish(self):
        print(f"-- {self.title}: {self.n - self.fail}/{self.n} PASS")
        if self.fail:
            print("RESULT: FAIL")
            sys.exit(1)
        print("RESULT: PASS")


COUPLINGS = [(2, 2), (3, 3/2), (5/4, 3)]   # (x, y): K_2 = log x、K_1 = 2 log y


def pair_times_column(A, B, a, b):
    """def_pair_of_matrices_times_column_of_numbers の (A, B)(a; b) := aA + bB（スカラー倍と和は本文の成分の式）。"""
    return body_sum(body_scalar(a, A), body_scalar(b, B))


def pair_times_two_by_two(pair, G):
    """def_pair_of_matrices_times_two_by_two_matrix の (A, B)G := ((A, B)(g_11; g_21), (A, B)(g_12; g_22))。"""
    A, B = pair
    return (pair_times_column(A, B, G[0, 0], G[1, 0]), pair_times_column(A, B, G[0, 1], G[1, 1]))


def pr(l, pair):
    """pr_l(Y_1, Y_2) := Y_l（l = 1, 2）。"""
    return pair[l - 1]


def pair_eq(p, q):
    return p[0] == q[0] and p[1] == q[1]


def conj_body(g, X, ginv):
    """def_T_g の T_g(X) = (gX)g^{-1}（積は mat_mult の成分の式）。"""
    return body_product(body_product(g, X), ginv)


class PsiSetting:
    """一つの (M_col, x, y, μ) について、E の中に Ž_μ・Y̌_μ・S・S^{-1}・V_2・V_2^{-1}・A(θ̃_μ)・P̌_μ・Ď_μ・ψ̌ を持つ。"""

    def __init__(self, f, mu):
        self.f, self.mu = f, mu
        F, i = f.F, f.i
        emb = embedding_to_qqbar(f)
        self.embF = emb
        # θ̃_μ の exp・cos・sin（euler_formula_cos_sin の式）
        e = f.phase(mu, 1)
        einv = f.phase(mu, -1)
        assert e * einv == 1
        cos, sin = (e + einv) / 2, (e - einv) / (2 * i)
        # def_indexed_hyperbolic_abbreviations の c_i := cosh 2K_i・s_i := sinh 2K_i。exp(2K_1) = y^4、exp(2K_2) = x^2（def_cosh_sinh）。
        # c_2^*・s_2^* は Factors の cosh 2K_2^*・sinh 2K_2^*。
        c1, s1 = (f.y**4 + f.y**(-4)) / 2, (f.y**4 - f.y**(-4)) / 2
        c2s, s2s = f.ch2, f.sh2
        c2 = (f.x**2 + f.x**(-2)) / 2
        self.c2 = c2
        # def_gamma1_gamma2_of_theta の γ_1(θ̃)・γ_2(±θ̃)
        self.g1 = c1 * c2s - s1 * s2s * cos
        self.a = i * e * s2s * (c1 * cos - i * sin - s1 * c2)              # γ_2(θ̃_μ)
        self.b = i * einv * s2s * (c1 * cos + i * sin - s1 * c2)           # γ_2(-θ̃_μ)（cos(-θ) = cos θ、sin(-θ) = -sin θ）
        abar = (-i) * einv * s2s * (c1 * cos + i * sin - s1 * c2)          # conj(γ_2(θ̃_μ))
        assert emb(abar) == emb(self.a).conjugate()
        nmu = self.a * abar
        # σ = (√M)_C
        roots = [w for w in F(f.M).sqrt(all=True) if emb(w) > 0]
        assert len(roots) == 1
        sigF = roots[0]
        # r_μ
        if nmu.is_square():
            rts = [w for w in nmu.sqrt(all=True) if emb(w) > 0]
            assert len(rts) == 1
            E = F; r = rts[0]; self.embE = emb
        else:
            PolF = PolynomialRing(F, 'T')
            E = F.extension(PolF.gen()**2 - nmu, 'R')
            r = E.gen()
            self.embE = None
        self.E = E; self.r = r; self.sigma = E(sigF)
        self.r_AA = AA(emb(nmu)).sqrt()
        self.g1_AA = AA(emb(self.g1))
        toE = lambda A: A.change_ring(E)
        self.Z = toE(f.Zc[mu]); self.Y = toE(f.Yc[mu])
        self.S = toE(f.expX); self.Sinv = toE(f.expmX)
        self.V2 = toE(f.V2)
        n = f.n
        self.n = n
        # V_2^{-1} は Sage の inverse で作り、本文の積で V_2 V_2^{-1} = V_2^{-1} V_2 = I を確かめてから使う
        # （def_invertible_elements_of_R の逆元はこの性質でただ一つに定まる）。
        self.V2inv = self.V2.inverse()
        I = body_identity(E, n)
        assert body_product(self.S, self.Sinv) == I and body_product(self.Sinv, self.S) == I
        assert body_product(self.V2, self.V2inv) == I and body_product(self.V2inv, self.V2) == I
        a, b, g1 = E(self.a), E(self.b), E(self.g1)
        # def_A_theta の A(θ̃_μ)（実数の成分は包含の像）
        self.A = matrix(E, 2, 2, [g1, a,
                                  (-i) * einv * s2s * (c1 * cos + i * sin - s1 * c2), g1])
        # eigenvector_of_A_theta_tilde の λ_{±,μ}、diagonalization_check_P_D の P̌_μ・Ď_μ
        self.lp, self.lm = g1 + r, g1 - r
        sg = self.sigma
        self.P = matrix(E, 2, 2, [(-r) / (2 * sg * b), r / (2 * sg * b),
                                  1 / (2 * sg), 1 / (2 * sg)])
        self.D = matrix(E, 2, 2, [self.lp, 0, 0, self.lm])
        # def_check_fermi の第二の式（P̌ との積を使わずに書いた形）
        self.psid = body_sum(body_scalar((-r) / (2 * sg * b), self.Z), body_scalar(1 / (2 * sg), self.Y))
        self.psi = body_sum(body_scalar(r / (2 * sg * b), self.Z), body_scalar(1 / (2 * sg), self.Y))

    def T_composite(self, X):
        """def_T_V_plus の T_{(V^{(+)})}(X) := T_S(T_{V_2}(T_S(X)))。"""
        return conj_body(self.S, conj_body(self.V2, conj_body(self.S, X, self.Sinv), self.V2inv), self.Sinv)

    def Vplus(self):
        """def_V_plus の V^{(+)} := (S V_2) S と、その逆元 (S^{-1} V_2^{-1}) S^{-1}（def_invertible_elements_of_R (ii)）。"""
        V = body_product(body_product(self.S, self.V2), self.S)
        Vinv = body_product(body_product(self.Sinv, self.V2inv), self.Sinv)
        return V, Vinv


CB = ComplexBallField(512)
RB = RealBallField(512)


def to_cb_factory(s):
    """E → ComplexBallField。F の元は embedding_to_qqbar で、E = F(R) の元 c_0 + c_1 R は emb(c_0) + emb(c_1) r_μ（r_μ > 0 の AA の値）で移す。"""
    emb = s.embF
    rA = s.r_AA

    def to_cb(e):
        if s.E is s.f.F:
            return CB(emb(e))
        c = s.E(e).list()
        return CB(emb(c[0]) + emb(c[1]) * rA)
    assert to_cb(s.r).overlaps(CB(rA)) and rA > 0      # R ↦ +r_μ
    return to_cb


def mat_cb(A, to_cb):
    return matrix(CB, A.nrows(), A.ncols(), lambda r_, c_: to_cb(A[r_, c_]))


def body_exp_ball(A):
    """def_exp の部分和 Σ_{p=0}^{N} A^p/p!（積は mat_mult の成分の式）に、尾の上界 s^{N+1}/(N+1)!/(1 - s/(N+2))
    （s は成分の 2 乗和の平方根の上界で、def_matrix_norm のノルム以上）を各成分の半径として足したボール。"""
    n = A.nrows()
    s = sum((z.real()**2 + z.imag()**2) for z in A.list()).sqrt()
    s = RB(s.upper())
    N = 20
    while not (s < N + 2 and (s**(N + 1) / factorial(N + 1)) < RB(2)**(-300)):
        N += 10
    E = matrix(CB, n, n, 0); Pw = body_identity(CB, n)
    for p in range(N + 1):
        E = body_sum(E, body_scalar(CB(1) / factorial(p), Pw))
        if p < N:
            Pw = body_product(Pw, A)
    rad = (s**(N + 1) / factorial(N + 1) / (1 - s / (N + 2))).upper()
    return matrix(CB, n, n, lambda r_, c_: CB(E[r_, c_].real().add_error(rad), E[r_, c_].imag().add_error(rad)))


def balls_overlap(A, B):
    return all(A[i, j].overlaps(B[i, j]) for i in range(A.nrows()) for j in range(A.ncols()))
