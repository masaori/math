# 対象ラベル: det_A_theta_tilde の検算の準備。
#  - 結合定数は relation_of_gamma_2_theta_tilde の検算と同じく Y = exp(2K_1)、Z = exp(2K_2) を QQ_{>1} の有理数に取る。
#    def_cosh_sinh・def_second_dual_coupling_constant から c_1, s_1, c_2, c_2^*, s_2^* はすべて QQ の元になる。
#  - 角度 θ = θ~_μ = π(2μ - 1)/M_col は円分体 F = Q(ζ_{4M}) の中で exp(iθ) = ζ_{4M}^{2(2μ-1)}、i = ζ_{4M}^M として持つ。
#    exp(-iθ) はその逆元、cos・sin は euler_formula_cos_sin の式で作る。|γ_2| は AA の中の非負の平方根。
#  - 一般の点の鎖は、QQ 上の多項式環（i も不定元 I）の有理関数として各行を本文の式から別々に作り、
#    隣り合う行の差の分子が「その行の根拠が与える関係」だけで生成したイデアルに入ることを見る。
# 浮動小数点（RR・RIF・CC）は使わない。
import sys
load("../../_shared/complex_as_real_pairs.sage")


def couplings(Y, Z):
    """Y = exp(2K_1)、Z = exp(2K_2)、X = exp(2K_2^*) = (Z+1)/(Z-1)（def_second_dual_coupling_constant）。"""
    Y = QQ(Y); Z = QQ(Z)
    assert Y > 1 and Z > 1
    X = (Z + 1) / (Z - 1)
    return dict(c1=(Y + 1/Y) / 2, s1=(Y - 1/Y) / 2, c2=(Z + 1/Z) / 2, s2=(Z - 1/Z) / 2,
                c2s=(X + 1/X) / 2, s2s=(X - 1/X) / 2)


COUPLINGS = [(2, 3), (3, 2), (4, 3), (101/100, 7)]   # 臨界点 (2,3)・(3,2) を含む
M_RANGE = range(2, 9)


def cyclotomic_angle(M, mu):
    """F = Q(ζ_{4M}) と、i, exp(iθ), exp(-iθ), cos θ, sin θ（θ = θ~_μ）。cos・sin は euler_formula_cos_sin の式。"""
    F = CyclotomicField(4 * M)
    z = F.gen()
    I_ = z**M
    assert I_**2 == -1
    Ep = z**(2 * (2 * mu - 1))
    Em = 1 / Ep
    co = (Ep + Em) / 2
    si = (Ep - Em) / (2 * I_)
    return F, I_, Ep, Em, co, si


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
