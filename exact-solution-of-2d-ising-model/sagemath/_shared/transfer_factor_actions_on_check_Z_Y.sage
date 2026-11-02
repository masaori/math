# 共通の準備: T_{(V_1^{(+)})^{1/2}}・T_{V_2} の Ž・Y̌ への作用を数体 F の中で厳密に扱う。
# 使う検算: T_actions_on_check_Z_Y・calc_of_TxT_check_Z_Y。
# 可逆性の三つの主張・T_V_plus_is_conjugation の検算と同じく K_1 := 2 log y（y ∈ QQ, y > 1）、K_2 := log x（x ∈ QQ, x > 1）と選ぶ。
# このとき（transfer_matrix_factor_inverses.sage）
#   exp(±X)（X := ((i/2)(K_1)_C)H_1^(+) = (log y)(iH_1^(+))）は固有値 λ の射影に y^{±λ} を掛けて QQ に、
#   V_2 は成分 exp(K_2 n) = x^n で QQ に、t := tanh K_2 ∈ QQ、exp(-2K_2^*) = t、
#   exp(±Y)（Y := (i(K_2^*)_C)H_2 = K_2^*(iH_2)）は固有値 λ の射影に (√t)^{∓λ} を掛けて、a = (√(2s_2))^{M_col} とともに AA に入る。
# さらに cosh K_1 = (y^2 + y^{-2})/2、sinh K_1 = (y^2 - y^{-2})/2、cosh 2K_2^* = (t^{-1} + t)/2、sinh 2K_2^* = (t^{-1} - t)/2 が QQ に入る
# （def_cosh_sinh の (exp(z) ± exp(-z))/2 に exp(K_1) = y^2、exp(2K_2^*) = t^{-1} を入れたもの）。
# 半整数運動量の位相 exp(∓i(θ̃_μ)_C) は 1 の冪根 ζ_{4M}^{∓2(2μ-1)}（half_integer_check_operators.sage。本文の exp との照合は
# nesting_of_commutator_of_H_and_check_Z の検算）。これらを全て一つの数体 F := QQ(ζ_{4M}, √(2s_2), √t) に置き、等号を厳密に判定する。
# ℝ への脱出は K_1・K_2 の選び方と 1 の冪根の表し方だけである。
load("../../_shared/half_integer_check_operators.sage")


def report(ok, label):
    print(("PASS: " if ok else "FAIL: ") + label)
    assert ok, label


class Factors:
    """一つの (M_col, x, y) について、F の中に H_1^(+)・H_2・Ž_μ・Y̌_μ・exp(±X)・V_2・a・exp(±Y) と cosh・sinh・位相を持つ。"""

    def __init__(self, M, x, y):
        self.M, self.x, self.y = M, QQ(x), QQ(y)
        s2, t = second_coupling_exact(self.x)
        self.s2, self.t = s2, t
        F, (z, sq, rt), _ = number_field_elements_from_algebraics(
            [QQbar.zeta(4 * M), AA(2 * s2).sqrt(), AA(t).sqrt()], minimal=True)
        self.F, self.z, self.sq, self.rt = F, z, sq, rt
        self.i = z**M
        assert self.i**2 == -1
        n = 2**M
        self.n = n
        S0 = Setting(M)
        hom = S0.L.hom([z])
        self._hom = hom
        to_F_P = lambda A: matrix(F, A.nrows(), A.ncols(), lambda r, c: hom(S0.L(A[r, c].constant_coefficient())))
        self.H1 = to_F_P(S0.H1)
        self.H2 = to_F_P(S0.H2)
        self.Zc = {mu: to_F_P(S0.checkZ(mu)) for mu in range(1, M + 1)}
        self.Yc = {mu: to_F_P(S0.checkY(mu)) for mu in range(1, M + 1)}
        # exp(sign X) = Σ_λ y^{sign λ} P_λ（S_1 := iH_1^(+) は整数行列）
        self.S1 = iH1_plus_integer_matrix(M)
        self.expX = exp_by_spectral_projectors(self.S1, lambda lam: self.y**lam, F)
        self.expmX = exp_by_spectral_projectors(self.S1, lambda lam: self.y**(-lam), F)
        # exp(sign Y) = Σ_λ (√t)^{-sign λ} P_λ（S_2 := iH_2 は整数行列）
        self.S2 = iH2_integer_matrix(M)
        self.expY = exp_by_spectral_projectors(self.S2, lambda lam: rt**(-lam), F)
        self.expmY = exp_by_spectral_projectors(self.S2, lambda lam: rt**lam, F)
        self.V2 = V2_by_components(M, lambda m: self.x**m, F)
        self.a = sq**M
        self.ainv = self.a**(-1)
        # cosh・sinh の値（QQ）
        y2 = self.y**2
        self.ch1, self.sh1 = (y2 + y2**(-1)) / 2, (y2 - y2**(-1)) / 2
        self.ch2, self.sh2 = (t**(-1) + t) / 2, (t**(-1) - t) / 2

    def phase(self, mu, s):
        """exp(s·i(θ̃_μ)_C) = ζ_{4M}^{2(2μ-1)s}。"""
        return self.z**(2 * (2 * mu - 1) * s)

    def kg_to_F(self, A):
        """QQ(i) の行列を F へ移す（i ↦ ζ^M）。"""
        return matrix(self.F, A.nrows(), A.ncols(), lambda r, c: self.F(KG(A[r, c]).list()[0]) + self.F(KG(A[r, c]).list()[1]) * self.i)


def pair_times_column(A, B, a, b):
    """def_pair_of_matrices_times_column_of_numbers の (A, B)(a; b) := aA + bB（スカラー倍と和は本文の成分の式）。"""
    return body_sum(body_scalar(a, A), body_scalar(b, B))


def embedding_to_qqbar(f):
    """F → QQbar の埋め込みのうち、ζ ↦ exp(2πi/(4M))、√(2s_2)・√t ↦ 正の平方根 となるもの（ただ一つ）。"""
    embs = [e for e in f.F.embeddings(QQbar)
            if e(f.z) == QQbar.zeta(4 * f.M) and e(f.sq) == AA(2 * f.s2).sqrt() and e(f.rt) == AA(f.t).sqrt()]
    assert len(embs) == 1
    return embs[0]
