# 正の結合定数の tanh（本文 def_positive_coupling_tanh）・正の実数上の実対数（def_real_logarithm_positive）・
# 二つの双対結合定数（def_first_dual_coupling_constant・def_second_dual_coupling_constant）の検算が使う共通の準備。
# check/<対象名>/ から読む前提の相対パスで読み込む。
#
# 三つの持ち方を使い分ける。
# - exp の値を不定元 E に置く（QQ(E)）: exp の性質を使わない等号の行。不定元で成り立つ有理式の等号は、
#   E へ実数の exp(K) の値を代入しても成り立つ（代入は環準同型である）。exp(-K) は 1/E と置く
#   （本文 scalar_exp_product と scalar_exp_zero から exp(K)exp(-K) = exp(0) = 1）。
# - K = log q（q ∈ QQ、q > 1）の点: 本文 def_real_logarithm_positive の exp(log y) = y により exp(K) = q なので、
#   sinh K・cosh K・tanh K は QQ に入り、大小を QQ で厳密に判定できる。K > 0 は log の狭義単調増加と log 1 = 0 から。
# - K ∈ QQ の点: exp(K) が QQ に収まらないので RealBallField(512) へ脱出する。exp は本文の部分和に尾の評価を
#   半径として足したボール（hyperbolic_by_definition.sage の cosh_ball・sinh_ball）で、Arb の exp は使わない。
#   実対数の値は、有理数の端点 lo < hi で挟む（real_log_enclosure）。端点の候補は Arb の log から作るが、
#   本文の log の値が [lo, hi] に入ることは、本文の exp のボールで exp(lo) < y < exp(hi) を確かめ、
#   real_exp_strictly_increasing と exp(log y) = y から導く（log y ≤ lo なら y = exp(log y) ≤ exp(lo) < y で矛盾。hi も同様）。
load("../../_shared/hyperbolic_by_definition.sage")

E_FIELD = FractionField(PolynomialRing(QQ, 'E'))
E = E_FIELD.gen()

# K ∈ QQ_{>0} の点（ボールで確かめる）と、K = log q の q（QQ で厳密に確かめる）。
K_RATIONAL_POINTS = [QQ(1)/10^6, QQ(1)/1000, QQ(1)/3, QQ(1), QQ(5)/2, QQ(7), QQ(30)]
Q_EXACT_POINTS = [QQ(1000001)/1000000, QQ(11)/10, QQ(2), QQ(5), QQ(100), QQ(10)^6]


def tanh_by_definition(sinh_value, cosh_value):
    """本文 def_positive_coupling_tanh: tanh K := sinh K / cosh K。"""
    return sinh_value / cosh_value


LOG_ENCLOSURE_MARGIN = QQ(1) / 2^130


def real_log_enclosure(y_lower, y_upper=None):
    """本文 def_real_logarithm_positive の log y を、y_lower ≤ y ≤ y_upper（有理数。省略時は y = y_lower）の
    どの y についても含む区間 [lo, hi]（lo, hi ∈ QQ）を返し、RealBallField(512) のボールとして渡す。
    根拠: 本文の exp の部分和のボール（Arb の exp は使わない）で exp(lo) < y_lower かつ y_upper < exp(hi) を確かめる。
    real_exp_strictly_increasing と exp(log y) = y により lo < log y < hi が従う。"""
    y_lower = QQ(y_lower)
    y_upper = y_lower if y_upper is None else QQ(y_upper)
    assert 0 < y_lower <= y_upper
    lo = QQ(RBF512(y_lower).log().lower().exact_rational()) - LOG_ENCLOSURE_MARGIN
    hi = QQ(RBF512(y_upper).log().upper().exact_rational()) + LOG_ENCLOSURE_MARGIN
    # lo, hi は 2 進の有理数（分母が 2 の冪）なので RBF512 で厳密に表せる（下で確かめる）。exp_ball_of_ball は本文の
    # 部分和をボール演算で計算し尾の評価を半径に足すので、本文の exp(lo)・exp(hi) を含む。
    blo = RBF512(lo); bhi = RBF512(hi)
    assert blo.rad() == 0 and blo.contains_exact(lo) and bhi.rad() == 0 and bhi.contains_exact(hi)
    assert exp_ball_of_ball(blo) < y_lower, (lo, y_lower)
    assert exp_ball_of_ball(bhi) > y_upper, (hi, y_upper)
    return blo.union(bhi)


def real_log_enclosure_of_ball(yb):
    """ボール yb（下端 > 0）に入るどの y についても log y を含む区間。端点を有理数に取って real_log_enclosure へ渡す。"""
    assert yb > 0
    return real_log_enclosure(QQ(yb.lower().exact_rational()), QQ(yb.upper().exact_rational()))


def dual_coupling_by_definition(log_tanh_value):
    """本文 def_first_dual_coupling_constant / def_second_dual_coupling_constant: K^* := -(1/2) log(tanh K)。"""
    return -QQ(1) / 2 * log_tanh_value
