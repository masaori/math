# 対象ラベル: trace_of_epsilon_V_plus_via_check_eigenvalues の検算の共通の準備。
# 本文の ψ̌・ε・ň_μ・Q̌_ϵ・η_ϵ は ../epsilon_eigenvalue_on_check_Q/_prelude.sage の EpsilonSetting から取る
# （結合定数 K_1 := 2 log y、K_2 := log x、(x, y) ∈ COUPLINGS、M_col = 2, 3。成分は数体 E_1 の元で厳密）。
# ここで足すもの:
#   - 和・トレース・有限積を本文の定義の帰納法どおりに組む関数（def_sum_over_binary_words・_of_complex_numbers・_of_real_numbers、
#     def_trace、def_finite_product_of_matrices・_of_real_numbers）。
#   - E_1 → ComplexBallField の埋め込み（主張の検算で ℝ の値の球と比べるため）と、γ(θ̃_μ) の球
#     （def_gamma_theta・def_arccosh の式。arccosh の実対数と cos・cosh・sinh・tanh の値は ℝ への脱出）。
load("../epsilon_eigenvalue_on_check_Q/_prelude.sage")
import itertools

RB = RealBallField(512)
CB = ComplexBallField(512)


def tr(A):
    """def_trace: 対角成分を k = 1, …, n の順に足す。"""
    total = A[0, 0]
    for k in range(1, A.nrows()):
        total = total + A[k, k]
    return total


def left_product(factors, mul=None):
    """def_finite_product_of_matrices・def_finite_product_of_real_numbers（左から掛ける）。"""
    mul = mul or (lambda x, y: x * y)
    P = factors[0]
    for A in factors[1:]:
        P = mul(P, A)
    return P


def binary_word_matrix_sum(r, B):
    """def_sum_over_binary_words（最後の成分で 1 を 0 より先に足す）。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_matrix_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


def binary_word_sum(r, z):
    """def_sum_over_binary_words_of_complex_numbers・_of_real_numbers（数の和。帰納法は行列の和と同じ）。"""
    if r == 1:
        return z((1,)) + z((0,))
    return binary_word_sum(r - 1, lambda ep: z(ep + (1,)) + z(ep + (0,)))


def popcount_prefix(eps, k):
    """|ϵ|_k := #{μ ∈ {1, …, k} | ϵ_μ = 1}（k は 1 始まり）。"""
    return sum(eps[:k])


def u_sign(e):
    """ǔ^{(1)} := 1、ǔ^{(0)} := −1。"""
    return 1 if e == 1 else -1


class TraceSetting(EpsilonSetting):
    """EpsilonSetting に、E_1 → CB の埋め込みと γ(θ̃_μ) の球、K_1・K_2 の球を足したもの。"""

    def __init__(self, x, y, M):
        EpsilonSetting.__init__(self, x, y, M)
        f = Factors(M, x, y)
        st = NumberOperatorSetting(f)
        self.to_cb = to_cb_factory(st.S[1])
        assert st.S[1].E is self.F or st.S[1].E == self.F
        self.K1 = 2 * RB(QQ(y)).log()
        self.K2 = RB(QQ(x)).log()
        self.gam = [gamma_tilde_ball(M, mu, self.K1, self.K2) for mu in range(1, M + 1)]
        self.eta = {w: eta_of(self, w) for w in self.words}

    def cb(self, A):
        return matrix(CB, A.nrows(), A.ncols(), lambda r, c: CB(self.to_cb(A[r, c])))


def gamma_tilde_ball(M, mu, K1, K2):
    """γ(θ̃_μ) := arccosh(γ_1(θ̃_μ))、γ_1(θ) = c_1c_2^* − s_1s_2^* cos θ、θ̃_μ = 2π(μ − 1/2)/M、K_2^* := −(1/2) log tanh K_2。"""
    K2s = -(K2.tanh().log()) / 2
    c1, s1 = (2 * K1).cosh(), (2 * K1).sinh()
    c2s, s2s = (2 * K2s).cosh(), (2 * K2s).sinh()
    th = 2 * RB.pi() * (RB(mu) - RB(1) / 2) / M
    g1 = c1 * c2s - s1 * s2s * th.cos()
    assert g1 > 1, ("gamma_1 <= 1", M, mu)
    return (g1 + (g1 ** 2 - 1).sqrt()).log()                      # def_arccosh（実対数）


def trace_settings(Ms):
    return [TraceSetting(x, y, M) for (x, y) in COUPLINGS for M in Ms]
