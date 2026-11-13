# two_by_two_transfer_identity（2×2 の転送行列の恒等式）の検算が共通に使う準備。
# check/<対象名>/ から読む前提の相対パスで読み込む。
#
# 持ち方:
# - 冪・各項の成分・部分和の行は、τ を不定元とする GAUSSIAN[τ]（GAUSSIAN = QQ(i)。本文の ℂ の可算な部分）の
#   行列で厳密に確かめる。不定元で成り立つ多項式の等号は、τ へ任意の実数を代入しても成り立つ（代入は環準同型）。
#   本文の実数 x の像 x_C（inclusion_rr_to_cc）は、QQ ⊂ GAUSSIAN の包含でそのまま係数として持つ。
# - exp・cosh・sinh の値を使う行は、exp の値を不定元 E に置いた QQ(E)（exp の性質を使わない等号の行）と、
#   K_2 = log x（x ∈ QQ、x > 1）の点の AA（実代数的数。等号と大小が決定可能）で確かめる。
#   K_2 = log x では exp(K_2) = x（def_real_logarithm_positive の exp(log y) = y）なので、
#   t = tanh K_2 = (x²-1)/(x²+1) と 2s_2 = x² - x^{-2} は QQ、r = √t と q = √(2s_2) は AA に住む。
# - exp・log の値そのもの（exp(±K_2^*)、極限）を使う行は RealBallField(512) へ脱出する。exp は本文の部分和に
#   尾の評価を半径として足したボール（Arb の exp は使わない）、log は有理数の端点で挟んだ区間（real_log_enclosure）。
load("../../_shared/positive_coupling_and_real_log.sage")

C_COEFF = GAUSSIAN
R_TAU = PolynomialRing(C_COEFF, 'tau')
tau = R_TAU.gen()

# 実数の側: τ を不定元とする QQ[τ]。本文の包含 ι_{R→C}（inclusion_rr_to_cc）は、係数の包含 QQ ⊂ GAUSSIAN による
# 環準同型 inc: QQ[τ] → GAUSSIAN[τ] として持つ（実数の像 a_C）。
QQ_TAU = PolynomialRing(QQ, 'tau_r')
tr = QQ_TAU.gen()
inc = QQ_TAU.hom([tau], R_TAU)

# 本文 def_pauli_matrices の σ^x と I = I_{Mat(2,C)}（def_identity_matrix の δ_ij）。
SX = matrix(R_TAU, [[0, 1], [1, 0]])
I2 = identity_matrix(R_TAU, 2)


def b_matrix(m):
    """証明の準備の b^(m): m が偶数なら I、奇数なら σ^x。"""
    return I2 if m % 2 == 0 else SX


def beta(m, i, j):
    """証明の準備の β^(m)_ij（QQ）: i = j なら (1 + (-1)^m)/2、i ≠ j なら (1 - (-1)^m)/2。"""
    return (1 + (-1)^m) / QQ(2) if i == j else (1 - (-1)^m) / QQ(2)

# K_2 = log x の点（exp(K_2) = x）と、K_2 ∈ QQ の点。
X_LOG_POINTS = [QQ(1000001)/1000000, QQ(11)/10, QQ(2), QQ(5), QQ(100)]
K2_RATIONAL_POINTS = [QQ(1)/1000, QQ(1)/3, QQ(1), QQ(5)/2, QQ(7)]


def E_partial(x, N):
    """証明の準備の E_N(x) = Σ_{m=0}^{N} x^m/m!（scalar_exp_is_limit_of_partial_sums の部分和）。冪は右から掛ける。"""
    return sum(scalar_power_by_definition(x, m) / factorial(m) for m in range(N + 1))


def exp_matrix_ball(Bc, N=200):
    """本文 def_exp (1) の exp(B) を成分ごとに含むボールの 2×2 行列。B の成分はボール。
    中心は部分和 S_N(B)（冪は本文の定め方で右から 1 つずつ掛ける）をボール演算で計算したもの。
    半径: 成分の絶対値の最大を b とすると |(B^m)_ij| ≤ (2b)^m なので、尾の各成分は 2(2b)^{N+1}/(N+1)!
    （N + 2 ≥ 4b のとき。exp_ball_of_ball と同じ等比級数の評価）で抑えられる。exp_converges (1b) により
    S_N の成分は exp(B) の成分へ収束するので、真の値はこのボールに入る。"""
    b = max(Bc[i, j].abs().upper() for i in range(2) for j in range(2))
    assert N + 2 >= 4 * b
    S = matrix(RBF512, 2, 2)
    P = identity_matrix(RBF512, 2)
    for m in range(N + 1):
        S = S + P / factorial(m)
        P = P * Bc
    tail = (2 * RBF512(2 * b)^(N + 1) / factorial(N + 1)).upper()
    return matrix(RBF512, 2, 2, [S[i, j].add_error(tail) for i in range(2) for j in range(2)])
