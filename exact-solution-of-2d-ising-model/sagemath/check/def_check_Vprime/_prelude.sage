# 対象ラベル: def_check_Vprime の検算の準備。
#  - 結合定数は anticommutator_of_check_psi の検算と同じく Y = exp(2K_1)、Z = exp(2K_2) を QQ_{>1} の有理数に取る。
#    def_cosh_sinh・def_second_dual_coupling_constant から c_1, s_1, c_2, c_2^*, s_2^* はすべて QQ の元になる。
#  - 角度 θ~_λ = π(2λ-1)/M_col だけを扱う。L = QQ(ζ_{4M}) の ζ = exp(2πi/(4M)) で exp(iθ~_λ) = ζ^{2(2λ-1)}、i = ζ^M。
#    cos・sin は euler_formula_cos_sin の式で、γ_1・γ_2 は def_gamma1_gamma2_of_theta の式で作る。
#  - Z_j・Y_j は本文の定め方（pauli_sites_exact.sage の jw）で QQ(i) に作って L へ移し、Ž_λ・Y̌_λ は
#    def_half_integer_checkZ・def_half_integer_checkY の有限和を成分の式で組む。
#  - σ = (√M_col)_C は L の中にある。ζ ↦ exp(2πi/(4M)) の埋め込みで正になる方を取る。
#  - r_λ = |a_λ| と γ(θ~_λ) は、厳密な検算では L 上の多項式環の不定元 ρ_λ・g_λ に置く（全ての値について一度に確かめる）。
#    ℝ への脱出を含む検算（exp の値）では、r_λ を RealBallField の √(a_λ conj(a_λ))、γ(θ~_λ) を
#    def_arccosh の log(γ_1 + √(γ_1^2 - 1)) のボールに置く。
import sys
load("../../_shared/pauli_sites_exact.sage")

RB = RealBallField(512)
CB = ComplexBallField(512)


def couplings(Y, Z):
    Y = QQ(Y); Z = QQ(Z)
    assert Y > 1 and Z > 1
    X = (Z + 1) / (Z - 1)          # exp(2K_2^*)
    return dict(c1=(Y + 1/Y) / 2, s1=(Y - 1/Y) / 2, c2=(Z + 1/Z) / 2, c2s=(X + 1/X) / 2, s2s=(X - 1/X) / 2)


COUPLINGS = [(2, 3), (3, 2), (4, 3), (101/100, 7)]   # 臨界点 (2,3)・(3,2) を含む


class Setting:
    """M_col ごとの L・埋め込み・i・σ・Ž_λ・Y̌_λ。"""
    def __init__(self, M):
        self.M = M
        L = CyclotomicField(4 * M, 'z')
        z = L.gen()
        self.L = L; self.z = z
        self.I = z**M
        assert self.I**2 == -1
        emb = [e for e in L.embeddings(QQbar) if e(z) == QQbar.zeta(4 * M)]
        assert len(emb) == 1
        self.emb = emb[0]
        roots = [w for w in L(M).sqrt(all=True) if self.emb(w) > 0]
        assert len(roots) == 1
        self.s = roots[0]
        assert self.s * self.s == L(M)
        iL = self.I

        def conv(A):
            return matrix(L, A.nrows(), A.ncols(),
                          lambda r, c: L(KG(A[r, c]).list()[0]) + L(KG(A[r, c]).list()[1]) * iL)
        J = list(range(1, M + 1))
        self.J = J
        self.n = 2**M
        Zj = {m: conv(jw(M, m, 'z')) for m in J}
        Yj = {m: conv(jw(M, m, 'y')) for m in J}
        self.checkZ = {lam: body_finite_sum([body_scalar(self.phase(-jj, lam), Zj[jj]) for jj in J]) for lam in J}
        self.checkY = {lam: body_finite_sum([body_scalar(self.phase(-jj, lam), Yj[jj]) for jj in J]) for lam in J}
        for lam in J:   # Sage の演算（独立な経路）で組んだ Ž・Y̌ と一致する
            assert self.checkZ[lam] == sum(self.phase(-jj, lam) * Zj[jj] for jj in J)
            assert self.checkY[lam] == sum(self.phase(-jj, lam) * Yj[jj] for jj in J)

    def phase(self, k, lam):
        """exp(i(k_R θ~_λ)_C) = ζ^{2k(2λ-1)}。"""
        return self.z**(2 * k * (2 * lam - 1))

    def angle(self, sign, lam):
        Ep = self.phase(sign, lam)
        Em = 1 / Ep
        return Ep, (Ep + Em) / 2, (Ep - Em) / (2 * self.I)

    def gamma1(self, lam, k):
        """def_gamma1_gamma2_of_theta の γ_1(θ) := c_1 c_2^* - s_1 s_2^* cos θ（θ = θ~_λ）。"""
        _, c, _ = self.angle(+1, lam)
        return k['c1'] * k['c2s'] - k['s1'] * k['s2s'] * c

    def gamma2(self, sign, lam, k):
        """def_gamma1_gamma2_of_theta の γ_2(θ) := i exp(iθ) s_2^* (c_1 cos θ - i sin θ - s_1 c_2)。"""
        Ep, c, s = self.angle(sign, lam)
        return self.I * Ep * k['s2s'] * (k['c1'] * c - self.I * s - k['s1'] * k['c2'])

    def to_CB(self, x):
        return CB(self.emb(x))


def fermi_coeffs(F, S, lam, r, b):
    """def_check_fermi の係数: ψ̌^† = (-r/(2√M b)) Ž + (1/(2√M)) Y̌、ψ̌ = (+r/(2√M b)) Ž + (1/(2√M)) Y̌。"""
    two_s = F(2) * F(S.s)
    return (F(-1) * r / (two_s * F(b)), F(1) / two_s), (r / (two_s * F(b)), F(1) / two_s)


def fermi_pair(F, S, lam, r, b):
    (um, h), (up, _) = fermi_coeffs(F, S, lam, r, b)
    Z = S.checkZ[lam].change_ring(F); Y = S.checkY[lam].change_ring(F)
    return body_sum(body_scalar(um, Z), body_scalar(h, Y)), body_sum(body_scalar(up, Z), body_scalar(h, Y))


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
