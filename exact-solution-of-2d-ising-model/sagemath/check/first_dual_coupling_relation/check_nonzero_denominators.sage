# 対象ラベル: first_dual_coupling_relation
# 証明の冒頭の六つの含意（分母が 0 でないこと）:
#   K_1 > 0 ⇒ cosh K_1 > sinh K_1 > 0（cosh_sinh_basic_properties の (3)）
#   ⇒ sinh K_1 ≠ 0 かつ cosh K_1 ≠ 0 ⇒ sinh K_1 cosh K_1 ≠ 0
#   K_1 > 0 ⇒ 0 < tanh K_1 < 1（def_positive_coupling_tanh）⇒ tanh K_1 ∈ ℝ_{>0} ⇒ tanh K_1 ≠ 0
# 帰属: K_1 = log q の点は QQ で厳密に、K_1 ∈ QQ の点は RealBallField(512)（exp の値が QQ に収まらない）。
load("_prelude.sage")

def check(s, c, t):
    assert c > s and s > 0                  # cosh K_1 > sinh K_1 > 0
    assert s != 0 and c != 0                # 正の元は 0 でない（ボールでは 0 を含まない）
    assert s * c != 0
    assert t > 0 and t < 1                  # 0 < tanh K_1 < 1
    assert t != 0

for q in Q_EXACT_POINTS:
    s, c, t = exact_point_values(q)
    assert t == (q^2 - 1) / (q^2 + 1)
    check(s, c, t)
for K0 in K_RATIONAL_POINTS:
    s, c, t = ball_point_values(K0)
    check(s, c, t)
    assert not s.contains_zero() and not c.contains_zero() and not (s * c).contains_zero() and not t.contains_zero()
print(f"{len(Q_EXACT_POINTS)} 点 K_1 = log q（QQ）と {len(K_RATIONAL_POINTS)} 点 K_1 ∈ QQ（ボール）で、六つの含意の結論が成り立つ")
print("RESULT: PASS")
