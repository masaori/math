# 対象ラベル: max_eigenvector_in_even_sector の検算の共通の準備。
# 本文の ψ̌ から作った ε・ň_μ・Q̌_ϵ・η_ϵ は ../epsilon_eigenvalue_on_check_Q/_prelude.sage の EpsilonSetting から取る
#（結合定数 K_1 := 2 log y、K_2 := log x、(x, y) ∈ COUPLINGS、M_col = 2, 3。成分は数体 E_1 の元で厳密。η_ϵ は epsilon_eigenvalue_on_check_Q の (1) の作り方）。
# 実際の V^(+)（def_V_plus の ((V_1^(+))^{1/2}V_2)(V_1^(+))^{1/2}）は ../../_shared/transfer_matrix_factor_inverses.sage の
# exp_V1_half_exact（整数固有値の iH_1^(+) のスペクトル射影で y^λ）と V2_components_exact（成分 x^n）から QQ の行列として組み、E_1 へ移す
#（max_eigenvalue_of_V_plus_simple の検算と同じ作り方）。
load("../epsilon_eigenvalue_on_check_Q/_prelude.sage")
load("../../_shared/transfer_matrix_factor_inverses.sage")


def V_plus_QQ(M, x, y):
    """def_V_plus の V^(+) = ((V_1^(+))^{1/2}V_2)(V_1^(+))^{1/2}（成分は QQ）。"""
    B = exp_V1_half_exact(M, y, +1)
    V2 = V2_components_exact(M, x)
    n = 2**M
    V2q = matrix(QQ, n, n, [QQ(z) for z in V2.list()])
    Bq = matrix(QQ, n, n, [QQ(z) for z in B.list()])
    return (Bq * V2q) * Bq


def r_of(M, x, y):
    """trace_of_epsilon_V_plus の右辺 r := (2exp(−K_2)cosh K_1)^M + (2exp(K_2)sinh K_1)^M（K_1 = 2 log y、K_2 = log x で QQ）。"""
    ch = (y**2 + y**(-2)) / 2      # cosh K_1（def_cosh_sinh）
    sh = (y**2 - y**(-2)) / 2      # sinh K_1
    return (2 * x**(-1) * ch)**M + (2 * x * sh)**M


class MaxSetting(EpsilonSetting):
    """EpsilonSetting と同じ ε・ň_μ・Q̌_ϵ（数体 E_1）に、実際の V^(+)（E_1 へ移したもの）・η_ϵ・Λ̌_ϵ・E_1 → QQbar の埋め込みを足す。
    E_1 の作り方は EpsilonSetting と同じ（ψ̌_μ の数体 E_μ を transport で E_1 へ移す）。"""

    def __init__(self, x, y, M):
        EpsilonSetting.__init__(self, x, y, M)
        self.x, self.y = QQ(x), QQ(y)
        f = Factors(M, self.x, self.y)
        st = NumberOperatorSetting(f)
        s1 = st.S[1]
        assert s1.E is self.F or s1.E == self.F, "E_1 が EpsilonSetting と同じ体でない"
        self.s1 = s1
        self.g1 = [st.S[m].g1_AA for m in st.J]          # γ_1(θ̃_μ)（AA）
        self.VQ = V_plus_QQ(M, self.x, self.y)
        self.V = self.VQ.change_ring(self.F)
        self.eta = {w: eta_of(self, w) for w in self.words}
        self.ones = tuple([1] * M)
        # V^(+)Q̌_ϵ = Λ̌_ϵQ̌_ϵ（eigenvalues_of_V_plus (1)）の Λ̌_ϵ を Q̌_ϵ の 0 でない成分の比として E_1 の元で持つ
        self.lam = {}
        for w in self.words:
            Q = self.Q[w]
            VQw = body_product(self.V, Q)
            k0, l0 = next((k, l) for k in range(self.N) for l in range(self.N) if Q[k, l] != 0)
            lw = VQw[k0, l0] / Q[k0, l0]
            assert VQw == lw * Q, "V^(+)Q̌_ϵ が Q̌_ϵ のスカラー倍でない"
            self.lam[w] = lw

    def to_qqbar(self, e):
        """E_1 → QQbar（max_eigenvalue_of_V_plus_simple の検算の to_qqbar_factory と同じ埋め込み）。"""
        s = self.s1
        emb, rA = s.embF, QQbar(s.r_AA)
        if s.E is s.f.F:
            return emb(e)
        c = s.E(e).list()
        return emb(c[0]) + emb(c[1]) * rA


def body_trace(A):
    """def_trace: 対角成分を k = 1, …, n の順に左から足す。"""
    t = A[0, 0]
    for k in range(1, A.nrows()):
        t = t + A[k, k]
    return t


def cpow(z, k):
    """def_power_of_complex_number: z^0 := 1_ℂ、z^{k+1} := z^k z。"""
    t = z.parent()(1)
    for _ in range(k):
        t = t * z
    return t


def max_settings(Ms):
    return [MaxSetting(x, y, M) for (x, y) in COUPLINGS for M in Ms]
