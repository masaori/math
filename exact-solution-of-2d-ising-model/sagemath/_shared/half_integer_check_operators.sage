# 共通の準備（nesting_of_commutator_of_H_and_check_Z・commutator_of_scalar_multiples・cosh_sinh_coefficient_conversion_for_check の検算が使う）。
# Z_m・Y_m・H_1^(+)・H_2 は本文の定め方（pauli_sites_exact.sage・transfer_matrix_factor_inverses.sage の
# 成分の式）で QQ(i) に作り、半整数運動量の位相 exp(-i(j_R θ̃_μ)_C) は 1 の冪根として円分体 L := QQ(ζ_{4M}) に持つ。
# θ̃_μ = 2π(μ - 1/2)/M なので exp(i(θ̃_μ)_C) = ζ_{4M}^{2(2μ-1)}、i = ζ_{4M}^{M}。
# (K_1)_C・(K_2^*)_C は L 上の多項式環の不定元 k1・k2 に置く（全ての実数 K_1, K_2^* の像を一度に表す）。
# ℝ への脱出は位相の値（Euler の公式を前提にした 1 の冪根の表し方）だけで、それは half_integer_phase_exact.sage の
# E（QQbar）と、本文の exp の部分和のボール body_exp_i_ball で別に確かめる（nesting_of_commutator_of_H_and_check_Z の check_premises.sage）。
load("../../_shared/transfer_matrix_factor_inverses.sage")
load("../../_shared/half_integer_phase_exact.sage")


def cyclotomic_setting(M):
    L = CyclotomicField(4 * M, 'z')
    zeta = L.gen()
    P = PolynomialRing(L, ['k1', 'k2'])
    return L, zeta, P


def to_ring(A, L, zeta, P):
    """QQ(i) の行列を P の行列へ移す（i ↦ ζ^M）。"""
    iL = zeta**(L.gen().multiplicative_order() // 4)
    assert iL**2 == -1

    def conv(z):
        a, b = KG(z).list()
        return P(L(a) + L(b) * iL)
    return matrix(P, A.nrows(), A.ncols(), lambda r, c: conv(A[r, c]))


def phase(L, zeta, M, mu, s):
    """exp(s·i(θ̃_μ)_C)（s ∈ ZZ）を L の元として返す。exp(i(θ̃_μ)_C) = ζ_{4M}^{2(2μ-1)}。"""
    return zeta**(2 * (2 * mu - 1) * s)


def phase_qqbar_crosscheck(L, zeta, M, mu, s):
    """phase を QQbar へ埋め込んだ値が、E(s·θ̃_μ/(2π))（half_integer_phase_exact.sage）に一致することを確かめる。"""
    emb = [e for e in L.embeddings(QQbar) if e(zeta) == QQbar.zeta(4 * M)]
    assert len(emb) == 1
    return emb[0](phase(L, zeta, M, mu, s)) == E(s * theta_over_2pi(M, mu))


class Setting:
    """一つの M_col について、本文の定め方で作った H_1^(+)・H_2・Ž_μ・Y̌_μ を P の行列として持つ。"""

    def __init__(self, M):
        self.M = M
        self.L, self.zeta, self.P = cyclotomic_setting(M)
        self.k1, self.k2 = self.P.gens()
        self.iL = self.zeta**M
        cv = lambda A: to_ring(A, self.L, self.zeta, self.P)
        self.Z = {m: cv(jw(M, m, 'z')) for m in range(1, M + 1)}
        self.Y = {m: cv(jw(M, m, 'y')) for m in range(1, M + 1)}
        self.H1 = cv(H1_plus(M))
        self.H2 = cv(H2(M))
        self.n = 2**M

    def ph(self, mu, s):
        return self.P(phase(self.L, self.zeta, self.M, mu, s))

    def checkZ(self, mu):
        """def_half_integer_checkZ: Σ_j exp(-i(j_R θ̃_μ)_C) Z_j（スカラー倍と有限和は本文の成分の式）。"""
        return body_finite_sum([body_scalar(self.ph(mu, -j), self.Z[j]) for j in range(1, self.M + 1)])

    def checkY(self, mu):
        return body_finite_sum([body_scalar(self.ph(mu, -j), self.Y[j]) for j in range(1, self.M + 1)])


def comm_body(X, W):
    """def_ad_X_matrix の交換子 [X, W] := XW - WX（積は mat_mult、差は def_matrix_difference の成分の式）。"""
    return body_difference(body_product(X, W), body_product(W, X))


def comm_sage(X, W):
    """比べる側: Sage の `*` と `-` で作る交換子。"""
    return X * W - W * X


def ad_power_sage(X, W, n):
    """ad_X^n(W) を Sage の演算で再帰 ad^0 = W、ad^{m+1} = [X, ad^m] のとおりに作る。"""
    out = W
    for _ in range(n):
        out = comm_sage(X, out)
    return out


def report(ok, label):
    print(("PASS: " if ok else "FAIL: ") + label)
    assert ok, label
