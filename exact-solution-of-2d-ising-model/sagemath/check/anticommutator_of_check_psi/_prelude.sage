# 対象ラベル: anticommutator_of_check_psi の検算の準備。
#  - 結合定数は periodicity_of_check_fermi の検算と同じく Y = exp(2K_1)、Z = exp(2K_2) を QQ_{>1} の有理数に取る。
#    def_cosh_sinh・def_second_dual_coupling_constant から c_1, s_1, c_2, c_2^*, s_2^* はすべて QQ の元になる。
#  - 角度 θ~_λ = π(2λ-1)/M_col だけを扱う。L = QQ(ζ_{4M}) の ζ = exp(2πi/(4M)) で exp(iθ~_λ) = ζ^{2(2λ-1)}、i = ζ^M。
#    cos・sin は euler_formula_cos_sin の式で作り、γ_2 は def_gamma1_gamma2_of_theta の式で作る。
#  - Z_j・Y_j は本文の定め方（pauli_sites_exact.sage の jw: クロネッカー積と積の成分の式）で QQ(i) に作って L へ移し、
#    Ž_λ・Y̌_λ は def_half_integer_checkZ・def_half_integer_checkY の有限和を成分の式で組む。
#  - s = √((M_col)_R) は L の中にある（M の平方根は QQ(ζ_{4M}) に入る）。ζ ↦ exp(2πi/(4M)) の埋め込みで正になる方を取る。
#    r_λ = |a_λ| は n_λ := a_λ conj(a_λ) ∈ L の平方根で、L に無ければ L 上の二次拡大 L(R)、R^2 = n_λ に持つ。
# 浮動小数点・ボールは使わない。ℝ への脱出は s と r_λ（ℝ_{≥0} の平方根）だけで、どちらも代数的数として厳密に持つ。
import sys
load("../../_shared/pauli_sites_exact.sage")


def couplings(Y, Z):
    Y = QQ(Y); Z = QQ(Z)
    assert Y > 1 and Z > 1
    X = (Z + 1) / (Z - 1)          # exp(2K_2^*)
    return dict(c1=(Y + 1/Y) / 2, s1=(Y - 1/Y) / 2, c2=(Z + 1/Z) / 2, c2s=(X + 1/X) / 2, s2s=(X - 1/X) / 2)


COUPLINGS = [(2, 3), (3, 2), (4, 3), (101/100, 7)]   # 臨界点 (2,3)・(3,2) を含む


class Setting:
    """M_col ごとの L・埋め込み・i・s・Z_j・Y_j。"""
    def __init__(self, M, with_ops=True):
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
        self.s = roots[0]                               # σ = s_C
        assert self.s * self.s == L(M)
        if with_ops:
            iL = self.I

            def conv(A):
                return matrix(L, A.nrows(), A.ncols(),
                              lambda r, c: L(KG(A[r, c]).list()[0]) + L(KG(A[r, c]).list()[1]) * iL)
            J = list(range(1, M + 1))
            self.Zj = {m: conv(jw(M, m, 'z')) for m in J}
            self.Yj = {m: conv(jw(M, m, 'y')) for m in J}
            self.n = 2**M
            self.checkZ = {lam: body_finite_sum([body_scalar(self.phase(-jj, lam), self.Zj[jj]) for jj in J]) for lam in J}
            self.checkY = {lam: body_finite_sum([body_scalar(self.phase(-jj, lam), self.Yj[jj]) for jj in J]) for lam in J}
            for lam in J:   # Sage の演算（独立な経路）で組んだ Ž・Y̌ と一致する
                assert self.checkZ[lam] == sum(self.phase(-jj, lam) * self.Zj[jj] for jj in J)
                assert self.checkY[lam] == sum(self.phase(-jj, lam) * self.Yj[jj] for jj in J)

    def phase(self, k, lam):
        """exp(i(k_R θ~_λ)_C) = ζ^{2k(2λ-1)}。"""
        return self.z**(2 * k * (2 * lam - 1))

    def angle(self, sign, lam):
        """θ = sign·θ~_λ の exp(±iθ)・cos θ・sin θ（euler_formula_cos_sin の式）。"""
        Ep = self.phase(sign, lam)
        Em = 1 / Ep
        return Ep, (Ep + Em) / 2, (Ep - Em) / (2 * self.I)

    def gamma2(self, sign, lam, k):
        """def_gamma1_gamma2_of_theta の γ_2(θ) := i exp(iθ) s_2^* (c_1 cos θ - i sin θ - s_1 c_2)。"""
        Ep, c, s = self.angle(sign, lam)
        return self.I * Ep * k['s2s'] * (k['c1'] * c - self.I * s - k['s1'] * k['c2'])


def kron_delta(M, a, b):
    """def_kronecker_delta（n = M_col）。"""
    assert 1 <= a <= M and 1 <= b <= M
    return 1 if a == b else 0


def acomm_body(X, W):
    """def_matrix_anticommutator: [X, W]_+ := XW + WX（成分の式）。"""
    return body_sum(body_product(X, W), body_product(W, X))


def acomm_sage(X, W):
    return X * W + W * X


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
