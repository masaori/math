# 対象ラベル: first_dual_coupling_relation
# 証明の鎖:
#   sinh(2K_1^*) = (exp(2K_1^*) - exp(-2K_1^*))/2      （def_cosh_sinh）
#                = (1/tanh K_1 - exp(-2K_1^*))/2         （exp(2K_1^*) = 1/tanh K_1）
#                = (1/tanh K_1 - tanh K_1)/2             （exp(-2K_1^*) = tanh K_1）
#                = (1/2)(1/tanh K_1 - tanh K_1)          （分配法則）
# 帰属: 等号は SYM（P = exp(2K_1^*)、N = exp(-2K_1^*)、T = tanh K_1）で厳密に。各行は根拠の関係だけを代入する。
#   具体の点は RealBallField(512)。
load("_prelude.sage")

line1 = S2s
line2 = sinh_by_definition(P, N)
line3 = (1 / T - N) / 2
line4 = (1 / T - T) / 2
line5 = QQ(1) / 2 * (1 / T - T)
line_step(line1, line2, {S2s: sinh_by_definition(P, N)}, "sinh の定義")
line_step(line2, line3, {P: 1 / T}, "exp(2K^*) = 1/T を代入")
line_step(line3, line4, {N: T}, "exp(-2K^*) = T を代入")
line_step(line4, line5, None, "分配法則")
# 根拠の関係を代入しなければ等しくない（その行が本当にその関係を使っている）ことも見る。
assert SYM(line2) != SYM(line3) and SYM(line3) != SYM(line4)

def check_point(t_ball, t_exact=None):
    L = real_log_enclosure(t_exact) if t_exact is not None else real_log_enclosure_of_ball(t_ball)
    twoKs = 2 * dual_coupling_by_definition(L)
    v1 = sinh_by_definition(exp_ball_of_ball(twoKs), exp_ball_of_ball(-twoKs))
    v4 = QQ(1) / 2 * (1 / t_ball - t_ball)
    assert v1.overlaps(v4)
    if t_exact is not None:
        assert v1.contains_exact(QQ(1) / 2 * (1 / t_exact - t_exact))

for q in Q_EXACT_POINTS:
    s, c, t = exact_point_values(q)
    check_point(RBF512(t), t)
for K0 in K_RATIONAL_POINTS:
    s, c, t = ball_point_values(K0)
    check_point(t)
print("sinh(2K_1^*) の鎖の 4 つの等号を SYM で厳密に、両端の一致を "
      f"{len(Q_EXACT_POINTS) + len(K_RATIONAL_POINTS)} 点のボールで確かめた")
print("RESULT: PASS")
