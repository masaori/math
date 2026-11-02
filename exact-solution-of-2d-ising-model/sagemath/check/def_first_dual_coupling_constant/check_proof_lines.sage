# 対象ラベル: def_first_dual_coupling_constant
# 証明の行（K = K_1 ∈ ℝ_{>0}）: 0 < tanh K < 1、tanh K ∈ ℝ_{>0}、log(tanh K) ∈ ℝ、log(tanh K) < 0、
#   -1/2 ∈ ℝ、-1/2 < 0、-(1/2)log(tanh K) ∈ ℝ、負の数二つの積 -(1/2)log(tanh K) > 0、
#   K^* = -(1/2)log(tanh K)、K^* ∈ ℝ、K^* > 0、主張 K^* ∈ ℝ_{>0}。
# 帰属: -1/2 と tanh K（K = log q の点）は QQ で厳密に、tanh K（K ∈ QQ の点）は本文の exp のボールで、
#   log の値と K^* は RealBallField(512) へ脱出（実対数の値は QQ に収まらない）。log の値は有理数の端点で挟む。
load("../../_shared/positive_coupling_and_real_log.sage")

half_neg = -QQ(1) / 2
assert half_neg in QQ and half_neg < 0                 # -1/2 ∈ ℝ（ここでは QQ）、-1/2 < 0

def check_from_tanh(t_ball, t_exact=None):
    """tanh K の値（ボール。K = log q の点では QQ の値も）から、証明の残りの行を確かめる。"""
    if t_exact is not None:
        assert 0 < t_exact < 1                          # 1 行目（def_positive_coupling_tanh）を QQ で
        assert t_ball.contains_exact(t_exact)
    assert t_ball > 0 and 1 - t_ball > 0                # 1・2 行目 0 < tanh K < 1、tanh K ∈ ℝ_{>0}
    # log(tanh K) を含む区間。端点は有理数で、本文の exp の部分和のボールで exp(lo) < tanh K < exp(hi) を確かめてある
    # （real_log_enclosure。K ∈ QQ の点では tanh K のボールのどの点についても）。
    lt = real_log_enclosure(t_exact) if t_exact is not None else real_log_enclosure_of_ball(t_ball)
    assert lt < 0                                       # 4 行目 log(tanh K) < 0（real_log_negative_below_one）
    prod = half_neg * lt
    assert prod > 0                                     # 8 行目 負の数二つの積は正
    # 9〜12 行目: K^* の定義と等しいものの置換は計算を含まない。K^* を定義の関数で作ると prod と同じ計算になる
    # （構成上かならず一致する）ので、比べずに K^* > 0 だけを見る。
    Kstar = dual_coupling_by_definition(lt)
    assert Kstar > 0
    return Kstar

for q in Q_EXACT_POINTS:                                # K = log q、exp(K) = q
    c = cosh_by_definition(q, 1 / q); s = sinh_by_definition(q, 1 / q)
    t = tanh_by_definition(s, c)
    assert t == (q^2 - 1) / (q^2 + 1)
    check_from_tanh(RBF512(t), t)
for K0 in K_RATIONAL_POINTS:
    t = tanh_by_definition(sinh_ball(K0), cosh_ball(K0))
    check_from_tanh(t)
print(f"{len(Q_EXACT_POINTS)} 点 K_1 = log q（tanh は QQ）と {len(K_RATIONAL_POINTS)} 点 K_1 ∈ QQ（tanh はボール）で、鎖の各行と主張 K_1^* > 0 が成り立つ")
print("RESULT: PASS")
