# 対象ラベル: epsilon_eigenvalue_on_check_Q の検算の共通の準備。
# 本文の ψ̌（def_check_fermi の第二の式どおりの行列）を、結合定数 K_1 := 2 log y、K_2 := log x、(x, y) ∈ COUPLINGS、M_col = 2, 3 で作り、
# 全ての μ を一つの数体 E_1 に移す（../epsilon_anticommutes_with_check_Z_Y/check_part3_part4_with_check_psi.sage と同じ移し方）。
# ň_μ := ψ̌_μ^†ψ̌_{σ(μ)}（def_check_number_operator）、Q̌_ϵ := Π_μ (ϵ_μň_μ + (1-ϵ_μ)(I-ň_μ))（check_joint_eigenspace_decomposition）。
# 行列の演算は本文の定め方（body_product・body_scalar・body_sum・body_difference・body_negation・body_identity・body_finite_sum）で
# 行の括弧どおりに組む。Sage の `*`・`+`・`-` は比べる相手を独立に作るときと、主張の確認にだけ使う。ベクトルは 2^M 行 1 列の行列で持つ。
# 等号は全て数体 E_1 の中で厳密に判定する。
load("../def_check_number_operator/_prelude.sage")
load("../epsilon_anticommutes_with_check_Z_Y/_prelude.sage")   # Report・factor_A・body_finite_product・Q_check_by_definition

P_ = lambda A, B: body_product(A, B)
S_ = lambda a, A: body_scalar(a, A)
D_ = lambda A, B: body_difference(A, B)
N_ = lambda A: body_negation(A)


class EpsilonSetting:
    """一つの (x, y, M_col) について、E_1 の成分の ε・σ_1^z・ψ̌_μ^†・ψ̌_{σ(μ)}・ψ̌_μ（対照）・ň_μ・Q̌_ϵ を持つ。"""

    def __init__(self, x, y, M):
        self.tag = f"(x,y)=({x},{y}) M={M}"
        self.M, self.N = M, 2**M
        f = Factors(M, x, y)
        st = NumberOperatorSetting(f)
        F1 = st.S[1].E
        self.F = F1
        maps = {}
        for m in st.J:
            s = st.S[m]
            if m == 1:
                maps[m] = lambda X: X
            elif s.E is st.f.F:
                maps[m] = lambda X, F1=F1: X.change_ring(F1)
            else:
                maps[m] = transport(s, st.S[1])
        self.E = f.kg_to_F(epsilon(M)).change_ring(F1)
        self.G = f.kg_to_F(site(M, 1, 'z')).change_ring(F1)          # 否定コントロール用
        self.Id = body_identity(F1, self.N)
        self.O = matrix(F1, self.N, self.N, 0)
        self.Ds = [maps[m](st.dag[m]) for m in st.J]                 # ψ̌_μ^†
        self.Ps = [maps[m](st.psi_sig[m]) for m in st.J]             # ψ̌_{σ(μ)}
        self.Pself = [maps[m](st.psi_self[m]) for m in st.J]               # 対照用: 対を μ 自身に取り違えた ψ̌_μ
        self.ns = [body_product(self.Ds[k], self.Ps[k]) for k in range(M)]
        self.words = [tuple(w) for w in cartesian_product([[0, 1]] * M)]   # def_sum_over_binary_words の並び（辞書式）
        self.Q = {w: body_finite_product([factor_A(w[k], self.ns[k], self.Id) for k in range(M)]) for w in self.words}

    def basis(self, k):
        """I の第 k 列 e_k（0 始まり）を def_identity_matrix の δ から組む。"""
        return matrix(self.F, self.N, 1, lambda i, j: body_delta(self.F, i, k))

    def chosen_q(self, w):
        """証明の (1) の q := Q̌_ϵ x。x は Q̌_ϵ e_k ≠ 0 となる最初の e_k。"""
        Q = self.Q[w]
        for k in range(self.N):
            x = self.basis(k)
            q = P_(Q, x)
            if q != 0:
                return x, q
        raise AssertionError("Q̌_ϵ = O")


def coefficient_on(v, q):
    """v ∈ Cq なら v = cq なる c を返し、そうでなければ None を返す（q ≠ 0）。"""
    i = next(i for i in range(q.nrows()) if q[i, 0] != 0)
    c = v[i, 0] / q[i, 0]
    return c if v == c * q else None


def columns(cols):
    """列ベクトルを並べた行列 [b_1 ⋯ b_p]（mat_columnwise の記法）。"""
    return block_matrix([cols], subdivide=False)


def eta_of(st, w):
    """ε q = η q の η（証明の (1) の作り方）。"""
    x, q = st.chosen_q(w)
    return coefficient_on(P_(st.E, q), q)


def popcount(w):
    return sum(w)


def settings(Ms):
    return [EpsilonSetting(x, y, M) for (x, y) in COUPLINGS for M in Ms]
