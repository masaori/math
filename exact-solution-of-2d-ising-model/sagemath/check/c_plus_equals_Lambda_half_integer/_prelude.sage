# 対象ラベル: c_plus_equals_Lambda_half_integer の検算の共通の準備。
# 結合定数は K_1 := 2 log y、K_2 := log x、(x, y) ∈ COUPLINGS = {(2, 2), (3, 3/2), (5/4, 3)}、M_col = 2, 3。
# - 本文の ψ̌ から作った ε・ň_μ・Q̌_ε と、実際の V^(+)（def_V_plus の ((V_1^(+))^{1/2}V_2)(V_1^(+))^{1/2}。成分は QQ）、
#   V^(+)Q̌_ε = Λ̌_εQ̌_ε の Λ̌_ε を数体 E_1 の元として持つ lam[ε]、E_1 → QQbar の埋め込み to_qqbar は
#   ../max_eigenvector_in_even_sector/_prelude.sage の MaxSetting から取る（複製しない）。
# - W（def_symmetrized_transfer_matrix の (BV_2)B。B = exp((1/2)K_1D) は D の固有値の射影に y^λ を掛けて QQ）は
#   ../rayleigh_bounds_operator_norm/_prelude.sage の W_exact から取る。V^(+) とは別の経路（D と H_1^(+) は別の行列）で作る。
# - Λ̌_ε（AA）は eigenvalues_of_V_plus の定義 a·Π_μ exp(γ_μ(ε_μ − 1/2))（a := (2s_2)^{M_col/2}、exp(γ_μ) := γ_1 + √(γ_1^2 − 1)、
#   γ_1 = γ_1(θ̃_μ)）。Λ^{(1/2)}_{M_col} は ../max_eigenvalue_of_V_plus_simple/_prelude.sage の gamma_exp_independent
#   （結合定数と 1 の冪根から直接作る独立な経路）で作る。
# ℝ への脱出は K_1・K_2 の選び方と γ を arccosh の実対数の式から作る一点だけで、以後の等号・不等号は全て E_1・QQbar・AA の厳密計算である。
load("../rayleigh_bounds_operator_norm/_prelude.sage")      # W_exact
load("../max_eigenvector_in_even_sector/_prelude.sage")     # MaxSetting・body_trace・cpow（最後に読むので名前はこちらが勝つ）
load("../max_eigenvalue_of_V_plus_simple/_prelude.sage")    # gamma_exp_independent・fsum_left・to_qqbar_matrix


class Report:
    def __init__(self, title):
        self.title = title
        self.n_eq = 0
        self.n_ineq = 0
        self.n_neg = 0

    def eq(self, a, b, what):
        assert a == b, f"{self.title}: {what}"
        self.n_eq += 1

    def chain(self, lines, what):
        for k in range(len(lines) - 1):
            self.eq(lines[k], lines[k + 1], f"{what}: {k+1} 行目と {k+2} 行目")

    def ineq(self, ok, what):
        assert ok, f"{self.title}: {what}"
        self.n_ineq += 1

    def neg(self, ok, what):
        """否定コントロール: ok が真（崩れるべきものが崩れた）であることを確かめる。"""
        assert ok, f"{self.title}: 否定コントロールが崩れない: {what}"
        self.n_neg += 1

    def finish(self):
        print(f"{self.title}: 等号 {self.n_eq} 件、不等号・真偽 {self.n_ineq} 件、否定コントロール {self.n_neg} 件、失敗 0 件")
        print("RESULT: PASS")


def col(R, entries):
    """数ベクトルを mat_mult の約束どおり n 行 1 列の行列として置く。"""
    return matrix(R, len(entries), 1, list(entries))


def row_of(x):
    """x^⊤（n 行 1 列の行列の転置。body_transpose と同じ成分の式）。"""
    return body_transpose(x)


def scalar_of(A):
    """1 行 1 列の行列の成分。"""
    assert A.nrows() == 1 and A.ncols() == 1
    return A[0, 0]


def epsilon_orbits(E):
    """ε が不動点の無い置換行列（成分が 0 と 1、各行・各列に 1 が一つ、対角成分が 0）であることを確かめ、
    軌道 {k, π(k)}（k < π(k)）の並びを返す。F^(+) ∩ ℝ^n の元は x_k = x_{π(k)} を満たす実ベクトルである。"""
    n = E.nrows()
    pi = []
    for k in range(n):
        ones = [l for l in range(n) if E[k, l] == 1]
        assert len(ones) == 1 and all(E[k, l] in (0, 1) for l in range(n))
        pi.append(ones[0])
    assert sorted(pi) == list(range(n)) and all(pi[k] != k for k in range(n)) and all(pi[pi[k]] == k for k in range(n))
    return [(k, pi[k]) for k in range(n) if k < pi[k]]


def rational_unit_sphere_point(t):
    """t ∈ QQ^{d-1} から単位球面 S^{d-1} の有理点 u := (2t, |t|^2 − 1)/(|t|^2 + 1) を作る（立体射影の逆）。"""
    s = sum(a * a for a in t)
    u = [2 * a / (s + 1) for a in t] + [(s - 1) / (s + 1)]
    assert sum(a * a for a in u) == 1
    return u


def even_real_unit_vector(orbits, n, t):
    """F^(+) ∩ QQ^n の ‖x‖ = 1 の元。軌道の数 r（偶数）の単位球面の有理点 u から c_{2j−1} := (u_{2j−1} + u_{2j})/2、
    c_{2j} := (u_{2j−1} − u_{2j})/2 と置くと Σc_j^2 = 1/2 なので、軌道 j の二つの成分に c_j を置いた x は ‖x‖^2 = 2Σc_j^2 = 1。"""
    r = len(orbits)
    assert r % 2 == 0 and len(t) == r - 1
    u = rational_unit_sphere_point(t)
    c = []
    for j in range(0, r, 2):
        c += [(u[j] + u[j + 1]) / 2, (u[j] - u[j + 1]) / 2]
    x = [QQ(0)] * n
    for (k, l), cj in zip(orbits, c):
        x[k] = cj
        x[l] = cj
    assert sum(a * a for a in x) == 1
    return x


def odd_real_vector(orbits, n, t):
    """対照: 軌道 j の二つの成分に +c_j と −c_j を置いた実ベクトル（εx = −x。F^(+) の外）。"""
    x = [QQ(0)] * n
    for (k, l), cj in zip(orbits, t):
        x[k] = QQ(cj)
        x[l] = -QQ(cj)
    return x


def norm2_AA(w_qqbar):
    """def_matrix_norm の ‖w‖^2 = Σ_m |w_m|^2（値は AA）。w は QQbar の n 行 1 列の行列。"""
    return AA(sum((z * z.conjugate()).real() for z in w_qqbar.list()))


def conj_col(w):
    """QQbar の列ベクトルの成分ごとの複素共役。"""
    return matrix(QQbar, w.nrows(), w.ncols(), [z.conjugate() for z in w.list()])


def is_real_col(w):
    return all(z.imag() == 0 for z in w.list())


class CPlusSetting(MaxSetting):
    """MaxSetting（ε・Q̌_ε・V^(+)・lam・to_qqbar）に W・P^(+)・Λ̌_ε（AA）・ε の軌道を足す。"""

    def __init__(self, x, y, M):
        MaxSetting.__init__(self, x, y, M)
        n = self.N
        self.WQ = W_exact(M, self.x, self.y)                 # 成分は QQ
        self.W = self.WQ.change_ring(self.F)
        half = self.F(1) / 2
        self.Pplus = body_scalar(half, body_sum(self.Id, self.E))   # def_epsilon_projectors の P^(+) := (1/2)(I + ε)
        self.orbits = epsilon_orbits(self.E)
        self.a = prefactor_exact(M, self.x)                 # (2s_2)^{M_col/2}（AA）
        eg = [g + (g**2 - 1).sqrt() for g in self.g1]        # exp(γ(θ̃_μ))（AA）
        self.eh = [e.sqrt() for e in eg]                     # exp(γ(θ̃_μ)/2)
        self.eg = eg

        def Lam(w):
            v = AA(1)
            for mu in range(M):
                v = v * (self.eh[mu] if w[mu] == 1 else 1 / self.eh[mu])
            return self.a * v
        self.L = {w: Lam(w) for w in self.words}
        self.Lmax = self.L[self.ones]
        for w in self.words:
            assert self.to_qqbar(self.lam[w]) == QQbar(self.L[w]), "lam[ε] の像が Λ̌_ε でない"

    def i_F(self):
        """E_1 の中の虚数単位（埋め込みで QQbar の I へ移る根）。"""
        R = PolynomialRing(self.F, 't')
        roots = [r for r, _ in R([1, 0, 1]).roots()]
        cand = [r for r in roots if self.to_qqbar(r) == QQbar(I)]
        assert len(cand) == 1
        return cand[0]

    def to_qqbar_mat(self, A):
        return matrix(QQbar, A.nrows(), A.ncols(), [self.to_qqbar(z) for z in A.list()])


def c_plus_settings(Ms):
    return [CPlusSetting(x, y, M) for (x, y) in COUPLINGS for M in Ms]


def real_bilinear(x, P, y):
    """def_real_bilinear_value の x^⊤Py := Σ_k Σ_l (x_k P_kl) y_l（左から順に足す。x, y は数の並び、P の成分は実）。"""
    n = P.nrows()
    s = 0
    for k in range(n):
        for l in range(n):
            s = s + (x[k] * P[k, l]) * y[l]
    return s


def conj_bilinear(u, A, v, conj):
    """def_conjugate_bilinear_value の u^*Av := Σ_k Σ_l (conj(u_k) A_kl) v_l（左から順に足す）。conj は複素共役の写像。"""
    n = A.nrows()
    s = 0
    for k in range(n):
        for l in range(n):
            s = s + (conj(u[k]) * A[k, l]) * v[l]
    return s


def ordered_sum(xs, zero):
    s = zero
    for t in xs:
        s = s + t
    return s
