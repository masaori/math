# 対象ラベル: sinh_equation_solved_by_arcsinh
# 二つの向きの鎖を確かめる。⇐: u = arcsinh(y) なら sinh u = sinh(arcsinh(y)) = y。
# ⇒: sinh u = y なら sinh u = sinh(arcsinh(y)) で、sinh の単射性から u = arcsinh(y)。
# 帰属: y の 6 点で、u = arcsinh(y) を囲むボールに本文の exp をボール演算で施して sinh u を作り（RealBallField(512)）、
#   ⇐ の鎖を確かめる。⇒ は、u = arcsinh(y) でない有理数の u（arcsinh(y) のボールの外の 4 点）では sinh u のボールが y と
#   重ならないこと（対偶の形）で確かめる。
load("../../_shared/hyperbolic_by_definition.sage")
def sinh_of_ball(ub):
    return sinh_by_definition(exp_ball_of_ball(ub), exp_ball_of_ball(-ub))
points = [QQ(0), QQ(1), QQ(-1), QQ(-3)/7, QQ(25), QQ(1)/10^6]
for y0 in points:
    a = arcsinh_ball(y0)
    assert sinh_of_ball(a).overlaps(RBF512(y0))                     # ⇐
    for du in [QQ(1)/10^3, -QQ(1)/10^3, QQ(1), QQ(-2)]:
        u0 = QQ(a.mid().exact_rational()) + du
        assert not RBF512(u0).overlaps(a)
        assert not sinh_ball(u0).overlaps(RBF512(y0))               # ⇒ の対偶
print(f"{len(points)} 点で sinh(arcsinh(y)) のボールが y と重なり、arcsinh(y) から離した 4 つの u では sinh u が y と重ならない")
print("RESULT: PASS")
