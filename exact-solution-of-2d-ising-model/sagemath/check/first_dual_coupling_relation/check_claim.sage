# 対象ラベル: first_dual_coupling_relation
# 主張: K_1 ∈ ℝ_{>0} について sinh(2K_1) sinh(2K_1^*) = 1（K_1^* := -(1/2)log(tanh K_1)）。
# 証明の鎖を通らずに、定義から直接作った両辺の値で確かめる。
# 帰属: K_1 = log q の点は、sinh(2K_1^*) を exp(2K_1^*) の定義どおりのボール（log は有理数の端点で挟む）で作り、
#   sinh(2K_1) = (q² - q^{-2})/2 は QQ。K_1 ∈ QQ の点はすべて RealBallField(512)。
load("_prelude.sage")

def dual_sinh(t_ball, t_exact=None):
    L = real_log_enclosure(t_exact) if t_exact is not None else real_log_enclosure_of_ball(t_ball)
    twoKs = 2 * dual_coupling_by_definition(L)
    return sinh_by_definition(exp_ball_of_ball(twoKs), exp_ball_of_ball(-twoKs))

for q in Q_EXACT_POINTS:
    s, c, t = exact_point_values(q)
    lhs = sinh_by_definition(QQ(q)^2, 1 / QQ(q)^2) * dual_sinh(RBF512(t), t)
    assert lhs.contains_exact(1), (q, lhs)
    assert lhs.rad() < 2^-80
for K0 in K_RATIONAL_POINTS:
    s, c, t = ball_point_values(K0)
    lhs = sinh_ball(2 * K0) * dual_sinh(t)
    assert lhs.contains_exact(1), (K0, lhs)
    # 幅は sinh(2K_1)（K_1 = 30 で約 10^26）が sinh(2K_1^*) の幅（log を挟む余白 2^-130 由来）を増幅した分だけ広がる。
    # 実測で最悪 2^-44（K_1 = 30）。1 を含むことが中身のある判定になるよう、幅が 2^-40 未満であることを見る。
    assert lhs.rad() < 2^-40
# 比較が中身のあるものであることの裏付けとして、K_1^* を 2 倍に取り違えた値（2K_1^* = -2L）では 1 にならないことも見る。
s, c, t = exact_point_values(2)
L = real_log_enclosure(t)
assert not (sinh_by_definition(QQ(4), QQ(1)/4) * sinh_by_definition(exp_ball_of_ball(-2 * L), exp_ball_of_ball(2 * L))).contains_exact(1)
print(f"{len(Q_EXACT_POINTS)} 点 K_1 = log q と {len(K_RATIONAL_POINTS)} 点 K_1 ∈ QQ で sinh(2K_1)sinh(2K_1^*) を含むボールが 1 を含む")
print("RESULT: PASS")
