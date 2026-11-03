# 対象ラベル: commutation_V_plus_check_psi の検算の準備。
#  - 結合定数は calc_of_TxT_check_Z_Y の検算と同じく K_1 := 2 log y、K_2 := log x（x, y ∈ QQ_{>1}）と選ぶ。
#    共通の準備 _shared/transfer_factor_actions_on_check_Z_Y.sage の Factors が、Ž_μ・Y̌_μ・(V_1^{(+)})^{1/2} = exp(X)・exp(-X)・V_2・
#    c_2^* = cosh 2K_2^*・s_2^* = sinh 2K_2^*・位相 exp(±i(θ̃_μ)_C) を一つの数体 F に置く。
#    c_1 = cosh 2K_1 = (y^4 + y^{-4})/2、s_1 = sinh 2K_1 = (y^4 - y^{-4})/2、c_2 = cosh 2K_2 = (x^2 + x^{-2})/2 は QQ に入る
#    （def_indexed_hyperbolic_abbreviations と def_cosh_sinh に exp(2K_1) = y^4、exp(2K_2) = x^2 を入れたもの）。
#  - σ := (√M_col)_C は F の中にある（M の平方根は QQ(ζ_{4M}) ⊂ F に入る）。ζ ↦ exp(2πi/(4M)) の埋め込みで正になる方を取る。
#  - r_μ := |γ_2(θ̃_μ)| ∈ ℝ_{>0} は n_μ := γ_2 conj(γ_2) ∈ F の平方根である。F に無ければ E := F(R)、R^2 = n_μ に持つ。
#    R ↦ -r_μ の取り方も E の自己同型で移り合うので、代数的な等号はどちらでも同じに判定される。
#    r_μ > 0 を使う行（λ_{+} = exp(+γ) の向き）だけは、AA の値で確かめる。
# 浮動小数点は使わない。ℝ への脱出は K_1・K_2 の選び方、σ・r_μ（ℝ_{≥0} の平方根）、exp(±γ(θ̃_μ))（実数の exp）だけである。
# exp(±γ) は def_arccosh の arccosh(g) = log(g + √(g^2 - 1)) により g ± √(g^2 - 1)（代数的数）に等しく、それを AA で比べ、
# あわせて RealBallField の exp(±acosh(g)) が囲むことも見る。
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
