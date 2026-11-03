# 対象ラベル: relation_of_gamma_2_theta_tilde の検算の準備。
#  - 結合定数は gamma_2_theta_tilde_nonzero の検算と同じく Y = exp(2K_1)、Z = exp(2K_2) を QQ_{>1} の有理数に取る。
#    def_cosh_sinh・def_second_dual_coupling_constant から c_1, s_1, c_2, s_2^* はすべて QQ の元になる。
#  - 角度 θ = θ~_μ = π(2μ - 1)/M_col は円分体 F = Q(ζ_{4M}) の中で exp(iθ) = ζ_{4M}^{2(2μ-1)}、i = ζ_{4M}^M として持つ。
#    exp(-iθ) はその逆元（scalar_exp_product・scalar_exp_zero）。cos・sin は euler_formula_cos_sin の式で作る。
#    F の複素共役は Sage の conjugate()（ζ ↦ ζ^{-1}）で、本文の def_complex_conjugate とは QQbar の実部・虚部で照合する。
#  - 極座標表現・φ_polar・φ_cartesian・s_{[0,2π)}・√z は sagemath/_shared/polar_trigonometry_exact.sage（角度を a + bπ で持つ）。
#  - ℂ を実数の対で持つ和・積・共役・包含は sagemath/_shared/complex_as_real_pairs.sage。
# 浮動小数点（RR・RIF・CC）は使わない。
import sys
load("../../_shared/polar_trigonometry_exact.sage")
load("../../_shared/complex_as_real_pairs.sage")


def couplings(Y, Z):
    Y = QQ(Y); Z = QQ(Z)
    assert Y > 1 and Z > 1
    X = (Z + 1) / (Z - 1)          # exp(2K_2^*)
    return dict(c1=(Y + 1/Y) / 2, s1=(Y - 1/Y) / 2, c2=(Z + 1/Z) / 2, s2s=(X - 1/X) / 2)


COUPLINGS = [(2, 3), (3, 2), (4, 3), (101/100, 7)]   # 臨界点 (2,3)・(3,2) を含む
M_RANGE = range(2, 9)


def cyclotomic_angle(M, mu, sign=1):
    """F = Q(ζ_{4M}) と、i, exp(iφ), exp(-iφ), cos φ, sin φ（φ = sign·θ~_μ）。cos・sin は euler_formula_cos_sin の式。"""
    F = CyclotomicField(4 * M)
    z = F.gen()
    I_ = z**M
    assert I_**2 == -1
    Ep = z**(sign * 2 * (2 * mu - 1))   # exp(iφ)
    Em = 1 / Ep                         # exp(-iφ)
    co = (Ep + Em) / 2
    si = (Ep - Em) / (2 * I_)
    return F, I_, Ep, Em, co, si


def gamma2_by_definition(I_, Ep, co, si, k):
    """def_gamma1_gamma2_of_theta の γ_2(φ) := i exp(iφ) s_2^* (c_1 cos φ - i sin φ - s_1 c_2)。"""
    return I_ * Ep * k['s2s'] * (k['c1'] * co - I_ * si - k['s1'] * k['c2'])


def to_pair(w):
    """F の元を QQbar に送り、実部と虚部の対 (x, y) ∈ AA × AA にする（definition_of_cc の形）。"""
    q = QQbar(w)
    return (AA(q.real()), AA(q.imag()))


class Report:
    def __init__(self, title):
        self.title = title; self.n = 0; self.fail = 0
        print("==", title)

    def check(self, ok, label):
        self.n += 1
        if not ok:
            self.fail += 1
        print(("PASS " if ok else "FAIL ") + label)

    def finish(self):
        print(f"-- {self.title}: {self.n - self.fail}/{self.n} PASS")
        if self.fail:
            print("RESULT: FAIL")
            sys.exit(1)
        print("RESULT: PASS")
