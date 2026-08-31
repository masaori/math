# ---------------------------------------------------------
# 共通: 章 E（臨界点と比熱の対数発散）の数値検証の土台
#   structured-latex/content/020_critical_point.ts に対応
#
#   kappa := 2K1 - 2K2*,  A := sinh(2K1) sinh(2K2*)
#   gamma(theta) = arccosh( cosh2K1 cosh2K2* - sinh2K1 sinh2K2* cos theta )
#   等方 (K1=K2=K) では A = 1、gamma は kappa だけを通じて K に依存する
#
# 数値精度: 2 階の数値微分と kappa -> 0 の極限を扱うため、RDF ではなく
# mpmath（dps=40）を使う。RDF（倍精度）では f'' の数値差分が桁落ちで壊れる。
# ---------------------------------------------------------
import mpmath as mp

mp.mp.dps = 40

PI = mp.pi
TOL = mp.mpf('1e-25')          # 恒等式の許容残差
TOL_NUM = mp.mpf('1e-12')      # 数値微分との比較の許容残差
# arccosh(y) は y -> 1 で導関数が発散するため、gamma を arccosh 経由で作ると
# kappa = 0 かつ theta = 0 の近傍で有効桁が約半分（dps=40 なら 20 桁）落ちる。
# arccosh 経由の値と arcsinh 表示を突き合わせる比較にはこの条件数に見合う許容を使う。
TOL_ACOSH = mp.mpf('1e-18')


def F(x):
    """Sage の Integer/Rational/RealNumber を mpmath の mpf へ落とす。
    すでに mpf のものは精度を落とさずそのまま通す（float 経由にすると倍精度へ丸められる）。"""
    if isinstance(x, mp.mpf):
        return x
    if isinstance(x, int):
        return mp.mpf(x)
    return mp.mpf(str(x))


def K_star(K):
    """K* := -(1/2) log(tanh K)   <=>   sinh(2K) sinh(2K*) = 1"""
    return -mp.log(mp.tanh(F(K))) / 2


def kappa_of(K1, K2):
    """def_kappa: kappa = 2K1 - 2K2*"""
    return 2 * F(K1) - 2 * K_star(K2)


def A_of(K1, K2):
    """def_critical_sinh_product_A: A = sinh(2K1) sinh(2K2*)"""
    return mp.sinh(2 * F(K1)) * mp.sinh(2 * K_star(K2))


def gamma1_of(K1, K2, th):
    """def_A_theta: gamma_1(theta) = c1 c2* - s1 s2* cos theta"""
    K1 = F(K1); K2s = K_star(K2); th = F(th)
    return (mp.cosh(2 * K1) * mp.cosh(2 * K2s)
            - mp.sinh(2 * K1) * mp.sinh(2 * K2s) * mp.cos(th))


def gamma_of(K1, K2, th):
    """gamma(theta) = arccosh(gamma_1(theta)) >= 0"""
    return mp.acosh(gamma1_of(K1, K2, th))


# --- 等方な場合（kappa だけの関数） -------------------------------------

def S_of(kap, th, A=1):
    """S = sinh^2(kappa/2) + A sin^2(theta/2)"""
    return mp.sinh(F(kap) / 2) ** 2 + F(A) * mp.sin(F(th) / 2) ** 2


def gamma_kappa(kap, th, A=1):
    """gamma_kappa_identity: gamma = 2 arcsinh( sqrt(S) )"""
    return 2 * mp.asinh(mp.sqrt(S_of(kap, th, A)))


def dgamma_dkappa(kap, th):
    """gamma_derivatives_in_kappa (2): d gamma / d kappa = sinh k / sinh gamma"""
    g = gamma_kappa(kap, th)
    return mp.sinh(F(kap)) / mp.sinh(g)


def d2gamma_dkappa2(kap, th):
    """gamma_derivatives_in_kappa (2):
       d^2 gamma / d kappa^2 = cosh k / sinh g - sinh^2 k cosh g / sinh^3 g"""
    kap = F(kap)
    g = gamma_kappa(kap, th)
    sg = mp.sinh(g); cg = mp.cosh(g)
    return mp.cosh(kap) / sg - mp.sinh(kap) ** 2 * cg / sg ** 3


def G(kap):
    """second_derivative_log_divergence: G(kappa) = (1/4pi) int_0^{2pi} gamma d theta"""
    kap = F(kap)
    return mp.quad(lambda th: gamma_kappa(kap, th), [0, PI, 2 * PI]) / (4 * PI)


def G2(kap):
    """G''(kappa) を被積分関数の 2 階微分の積分として計算する（本文 Step 1・Step 3）"""
    kap = F(kap)
    return mp.quad(lambda th: d2gamma_dkappa2(kap, th), [0, PI, 2 * PI]) / (4 * PI)


# --- 臨界点と自由エネルギー（等方） -------------------------------------

KC = mp.asinh(1) / 2                      # sinh 2K_c = 1
C0 = 1 - PI ** 2 / 24                     # elementary_sine_bounds の c_0
BCONST = PI ** 2 / (12 * C0 * (1 + C0))   # sine_integral_two_sided の B


def kappa_K(K):
    """等方な場合の kappa(K) = 2K - 2K*"""
    return kappa_of(K, K)


def kappa_prime(K):
    """kappa_of_K_basic (1): kappa'(K) = 2 + 2/sinh 2K"""
    return 2 + 2 / mp.sinh(2 * F(K))


def kappa_second(K):
    """kappa_of_K_basic (3): kappa''(K) = -4 cosh 2K / sinh^2 2K"""
    K = F(K)
    return -4 * mp.cosh(2 * K) / mp.sinh(2 * K) ** 2


def f_free(K):
    """specific_heat_log_divergence: f(K) = (1/2) log(2 sinh 2K) + G(kappa(K))"""
    K = F(K)
    return mp.log(2 * mp.sinh(2 * K)) / 2 + G(kappa_K(K))


def f_free_finite_M(K, M, delta=mp.mpf(1) / 2):
    """有限 M の (1/M) log Lambda^{(delta)}_M（onsager_free_energy_expression）"""
    K = F(K)
    M = int(M)
    s = mp.mpf(0)
    for mu in range(1, M + 1):
        th = 2 * PI * (mu - F(delta)) / M
        s += gamma_of(K, K, th)
    return mp.log(2 * mp.sinh(2 * K)) / 2 + s / (2 * M)


def second_diff(fn, x, h):
    """中心 2 階差分"""
    return (fn(x + h) - 2 * fn(x) + fn(x - h)) / h ** 2


def report(name, value, bound, ok):
    print(f"  {name}: {mp.nstr(value, 8)} (許容 {mp.nstr(bound, 6)})  -> {'PASS' if ok else 'FAIL'}")
    return ok


# 検証に使うパラメータ。臨界点近傍を必ず含める。
#   K_c = arcsinh(1)/2 = 0.4406867935...
ISO_K_LIST = [mp.mpf('0.20'), mp.mpf('0.35'), KC - mp.mpf('0.01'), KC,
              KC + mp.mpf('0.01'), mp.mpf('0.55'), mp.mpf('0.90')]

def dual_partner(K1):
    """sinh(2K1) sinh(2K2) = 1 を満たす K2（非等方な臨界点）"""
    return mp.asinh(1 / mp.sinh(2 * F(K1))) / 2


ANISO_PAIRS = [
    (mp.mpf('0.30'), mp.mpf('0.70')),
    (mp.mpf('0.44'), mp.mpf('0.45')),
    (KC, KC),                                            # 臨界点（等方）
    (mp.mpf('0.25'), dual_partner(mp.mpf('0.25'))),      # 臨界点（非等方）
    (mp.mpf('0.70'), dual_partner(mp.mpf('0.70'))),      # 臨界点（非等方）
    (mp.mpf('1.20'), mp.mpf('0.20')),
    (mp.mpf('0.10'), mp.mpf('1.50')),
]

M_LIST = [2, 3, 4, 5]
