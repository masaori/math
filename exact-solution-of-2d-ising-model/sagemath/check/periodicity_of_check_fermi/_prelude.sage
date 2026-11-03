# 対象ラベル: periodicity_of_check_fermi の検算の準備。
#  - 結合定数は relation_of_gamma_2_theta_tilde の検算と同じく Y = exp(2K_1)、Z = exp(2K_2) を QQ_{>1} の有理数に取る。
#    def_cosh_sinh・def_second_dual_coupling_constant から c_1, s_1, c_2, s_2^* はすべて QQ の元になる。
#  - 角度は θ = qπ（q ∈ QQ）だけを扱う。F = CyclotomicField(4M) の ζ = exp(2πi/(4M)) で exp(iqπ) = ζ^{2Mq} とする
#    （θ~_μ とその ±、2π の整数倍の和はすべて q ∈ (1/M)ZZ なので 2Mq ∈ ZZ）。
#    exp(-iθ) はその逆元。cos・sin は euler_formula_cos_sin の式で作る。
# 浮動小数点・ボールは使わない。
import sys


def couplings(Y, Z):
    Y = QQ(Y); Z = QQ(Z)
    assert Y > 1 and Z > 1
    X = (Z + 1) / (Z - 1)          # exp(2K_2^*)
    return dict(c1=(Y + 1/Y) / 2, s1=(Y - 1/Y) / 2, c2=(Z + 1/Z) / 2, c2s=(X + 1/X) / 2, s2s=(X - 1/X) / 2)


COUPLINGS = [(2, 3), (3, 2), (4, 3), (101/100, 7)]   # 臨界点 (2,3)・(3,2) を含む
M_RANGE = range(2, 9)


def theta_tilde_over_pi(M, mu):
    """antiperiodic_exp_sum の θ~_μ = 2π(μ - 1/2)/M を π で割った有理数。"""
    return QQ(2) * (QQ(mu) - QQ(1) / 2) / QQ(M)


class Angle:
    """θ = qπ（q ∈ QQ）について、円分体 F の中の i, exp(±iθ), cos θ, sin θ（euler_formula_cos_sin の式）。"""
    def __init__(self, F, q):
        N = F.zeta_order()
        e = q * N / 2
        assert e in ZZ, (q, N)
        z = F.gen()
        self.F = F
        self.I = z**(N // 4)
        assert self.I**2 == -1
        self.Ep = z**ZZ(e)
        self.Em = 1 / self.Ep
        self.cos = (self.Ep + self.Em) / 2
        self.sin = (self.Ep - self.Em) / (2 * self.I)


def field_for(M):
    """θ~ の分母は M、全ての角度 qπ で qN/2 ∈ ZZ となる N = 4M。"""
    return CyclotomicField(4 * M)


def gamma1(a, k):
    """def_gamma1_gamma2_of_theta の γ_1(θ) := c_1 c_2^* - s_1 s_2^* cos θ。"""
    return k['c1'] * k['c2s'] - k['s1'] * k['s2s'] * a.cos


def gamma2(a, k):
    """def_gamma1_gamma2_of_theta の γ_2(θ) := i exp(iθ) s_2^* (c_1 cos θ - i sin θ - s_1 c_2)。"""
    return a.I * a.Ep * k['s2s'] * (k['c1'] * a.cos - a.I * a.sin - k['s1'] * k['c2'])


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
