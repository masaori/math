# 対象ラベル: gamma1_gt_1_theta_tilde の検算の準備。
#  - 結合定数は det_A_theta_tilde の検算と同じく Y = exp(2K_1)、Z = exp(2K_2) を QQ_{>1} の有理数に取る。
#    def_cosh_sinh・def_second_dual_coupling_constant から c_1, s_1, c_2, c_2^*, s_2^* と X = exp(2K_2^*) はすべて QQ の元になる。
#  - 角度 θ = θ~_μ = π(2μ - 1)/M_col は円分体 F = Q(ζ_{4M}) の中で exp(iθ) = ζ_{4M}^{2(2μ-1)}、i = ζ_{4M}^M として持ち、
#    cos θ は euler_formula_cos_sin の式 (exp(iθ) + exp(-iθ))/2 で作る。
#  - γ_1・γ_2 は def_gamma1_gamma2_of_theta の定義式から作り、r = |γ_2| は AA の中の非負の平方根 √(γ_2 conj(γ_2))。
# 浮動小数点（RR・RIF・CC）は使わない。
import sys


def couplings(Y, Z):
    """Y = exp(2K_1)、Z = exp(2K_2)、X = exp(2K_2^*) = (Z+1)/(Z-1)（def_second_dual_coupling_constant）。"""
    Y = QQ(Y); Z = QQ(Z)
    assert Y > 1 and Z > 1
    X = (Z + 1) / (Z - 1)
    return dict(Y=Y, X=X, c1=(Y + 1/Y) / 2, s1=(Y - 1/Y) / 2, c2=(Z + 1/Z) / 2, s2=(Z - 1/Z) / 2,
                c2s=(X + 1/X) / 2, s2s=(X - 1/X) / 2)


COUPLINGS = [(2, 3), (3, 2), (4, 3), (101/100, 7)]   # 臨界点 (2,3)・(3,2) を含む（このとき X = Y、すなわち K_1 = K_2^*）
M_RANGE = range(2, 9)


def cyclotomic_angle(M, mu):
    F = CyclotomicField(4 * M)
    z = F.gen()
    I_ = z**M
    assert I_**2 == -1
    Ep = z**(2 * (2 * mu - 1))
    Em = 1 / Ep
    co = (Ep + Em) / 2
    si = (Ep - Em) / (2 * I_)
    return F, I_, Ep, Em, co, si


def gamma1_gamma2(k, I_, Ep, co, si):
    """def_gamma1_gamma2_of_theta の γ_1(θ)・γ_2(θ)。"""
    g1 = k['c1'] * k['c2s'] - k['s1'] * k['s2s'] * co
    g2 = I_ * Ep * k['s2s'] * (k['c1'] * co - I_ * si - k['s1'] * k['c2'])
    return g1, g2


def to_AA(x):
    return AA(QQbar(x))


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
