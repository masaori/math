# 対象ラベル: gamma_2_theta_tilde_nonzero
# 共通の準備。
#  - 結合定数は Y = exp(2K_1)、Z = exp(2K_2) を QQ_{>1} の有理数に取って表す（K_1, K_2 > 0）。
#    def_cosh_sinh により c_1 = (Y + 1/Y)/2、s_1 = (Y - 1/Y)/2、c_2 = (Z + 1/Z)/2。
#    def_second_dual_coupling_constant の K_2^* = -(1/2) log(tanh K_2) から exp(2K_2^*) = 1/tanh K_2 で、
#    tanh K_2 = (Z - 1)/(Z + 1) なので X := exp(2K_2^*) = (Z + 1)/(Z - 1)、s_2^* = (X - 1/X)/2。
#    K_1^* も同じく exp(2K_1^*) = (Y + 1)/(Y - 1)。いずれも QQ の元になる。
#  - 角度 θ~_μ = 2π(μ - 1/2)/M_col = π(2μ - 1)/M_col は、円分体 Q(ζ_{4M}) の中で
#    exp(iθ~_μ) = ζ_{4M}^{2(2μ-1)}、i = ζ_{4M}^{M} として持つ（M = M_col）。
#    cos θ~_μ・sin θ~_μ は euler_formula_cos_sin の式で作り、Sage 組み込みの sin・cos（QQbar）とも照合する。
import sys

def couplings(Y, Z):
    Y = QQ(Y); Z = QQ(Z)
    assert Y > 1 and Z > 1
    X = (Z + 1) / (Z - 1)          # exp(2K_2^*)
    W = (Y + 1) / (Y - 1)          # exp(2K_1^*)
    return dict(
        Y=Y, Z=Z, X=X, W=W,
        c1=(Y + 1/Y) / 2, s1=(Y - 1/Y) / 2,
        c2=(Z + 1/Z) / 2, s2=(Z - 1/Z) / 2,
        s2s=(X - 1/X) / 2,
    )

def cyclotomic_angle(M, mu):
    """Q(ζ_{4M}) と、その中の i, exp(iθ~_μ), cos θ~_μ, sin θ~_μ を返す。"""
    F = CyclotomicField(4 * M)
    z = F.gen()
    I_ = z**M
    assert I_**2 == -1
    E = z**(2 * (2 * mu - 1))      # exp(iθ~_μ)
    co = (E + 1/E) / 2             # euler_formula_cos_sin
    si = (E - 1/E) / (2 * I_)
    return F, I_, E, co, si

def gamma2_by_definition(I_, E, co, si, k):
    """def_gamma1_gamma2_of_theta の γ_2(θ) := i exp(iθ) s_2^* (c_1 cos θ - i sin θ - s_1 c_2)。"""
    return I_ * E * k['s2s'] * (k['c1'] * co - I_ * si - k['s1'] * k['c2'])

# 臨界点 sinh 2K_1 sinh 2K_2 = 1 を含む結合定数の組 (Y, Z)。
# (2, 3) と (3, 2) は s_1 s_2 = (3/4)(4/3) = 1 で厳密に臨界点。
COUPLINGS = [(2, 3), (3, 2), (4, 3), (3/2, 5), (9, 9/8), (5/4, 5/4), (101/100, 7), (50, 21/20)]


class Report:
    def __init__(self, title):
        self.title = title
        self.n = 0
        self.fail = 0
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
