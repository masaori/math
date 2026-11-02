# first_dual_coupling_relation（第一の結合定数と双対結合定数の双対関係 sinh(2K_1)sinh(2K_1^*) = 1）の検算が共通に使う準備。
# check/<対象名>/ から読む前提の相対パスで読み込む。
#
# 持ち方:
# - 等号の行は、証明に現れる実数を独立な不定元に置いた有理関数体 SYM で厳密に確かめる。
#     Ep = exp(K_1)、Em = exp(-K_1)、F = exp(2K_1)、G = exp(-2K_1)、T = tanh K_1、
#     P = exp(2K_1^*)、N = exp(-2K_1^*)、S2 = sinh(2K_1)、S2s = sinh(2K_1^*)。
#   各行は書かれたとおりの式で作り、隣の行との差が、その行の根拠が述べる関係（例: P = 1/T）だけを代入して 0 になることを見る
#   （line_step）。根拠が計算だけ（分配法則・通分など）の行は何も代入しない。不定元で成り立つ有理式の等号は、
#   不定元へ実数の値を代入しても成り立つ（代入は環準同型。分母が 0 でないことは証明の冒頭の行で確かめてある）。
# - 代入に使う exp の関係（exp(K)exp(-K) = 1、exp(K)^2 = exp(2K) など）は、本文 scalar_exp_product・scalar_exp_zero の
#   内容であり、ここでは形式冪級数（全次数 D_SERIES まで。hyperbolic_by_definition.sage の exp_series）で別に確かめる。
# - 大小の行と主張は具体の点で確かめる。K_1 = log q（q ∈ QQ、q > 1）の点は exp(K_1) = q なので QQ で厳密に、
#   K_1 ∈ QQ の点は RealBallField(512) へ脱出し、exp は本文の部分和に尾の評価を足したボール、log は有理数の端点で
#   挟んだ区間（positive_coupling_and_real_log.sage の real_log_enclosure）で確かめる。
load("../../_shared/positive_coupling_and_real_log.sage")

SYM = FractionField(PolynomialRing(QQ, ['Ep', 'Em', 'F', 'G', 'T', 'P', 'N', 'S2', 'S2s']))
Ep, Em, F, G, T, P, N, S2, S2s = SYM.gens()

# 本文 def_cosh_sinh・def_positive_coupling_tanh を不定元で書いたもの。
s1 = sinh_by_definition(Ep, Em)     # sinh K_1
c1 = cosh_by_definition(Ep, Em)     # cosh K_1


def line_step(lhs, rhs, used=None, name=""):
    """証明の隣り合う二行 lhs = rhs を、根拠が述べる関係 used（不定元 → 式の辞書）だけを代入して確かめる。"""
    used = used or {}
    diff = SYM(lhs).subs(used) - SYM(rhs).subs(used)
    assert diff == 0, (name, diff)
    return name


SERIES_RING = PolynomialRing(QQ, ['k', 'l'])
k_var, l_var = SERIES_RING.gens()


def series_equal(a, b):
    return truncate_total_degree(SERIES_RING(a), D_SERIES) == truncate_total_degree(SERIES_RING(b), D_SERIES)


def exact_point_values(q):
    """K_1 = log q の点の値（QQ）。exp(K_1) = q（def_real_logarithm_positive の exp(log y) = y）。"""
    q = QQ(q)
    s = sinh_by_definition(q, 1 / q); c = cosh_by_definition(q, 1 / q)
    return s, c, tanh_by_definition(s, c)


def ball_point_values(K0):
    """K_1 = K0 ∈ QQ の点の値（本文の exp の部分和のボール）。"""
    s = sinh_ball(K0); c = cosh_ball(K0)
    return s, c, tanh_by_definition(s, c)
