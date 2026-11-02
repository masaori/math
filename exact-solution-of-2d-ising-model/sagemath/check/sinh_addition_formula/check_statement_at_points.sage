# 対象ラベル: sinh_addition_formula
# 主張そのもの（複号同順の二つの等式）を、具体の点 (x, y) ∈ QQ^2 で本文の exp を囲むボールで確かめる。
# 帰属: exp の値が QQ に収まらないので RealBallField(512) へ脱出する。許容誤差は置かず、ボールの重なりで判定する。
load("../../_shared/hyperbolic_by_definition.sage")
KIND = "sinh"
points = [(QQ(0), QQ(0)), (QQ(1), QQ(2)), (QQ(-3)/7, QQ(5)/4), (QQ(10), QQ(-9)), (QQ(1)/10^6, QQ(-2)/3), (QQ(-20), QQ(-20))]
separated = 0
for x0, y0 in points:
    for sg in (+1, -1):
        if KIND == "cosh":
            lhs = cosh_ball(x0 + sg * y0); rhs = cosh_ball(x0) * cosh_ball(y0) + sg * sinh_ball(x0) * sinh_ball(y0)
            wrong = cosh_ball(x0) * cosh_ball(y0) - sg * sinh_ball(x0) * sinh_ball(y0)
        else:
            lhs = sinh_ball(x0 + sg * y0); rhs = sinh_ball(x0) * cosh_ball(y0) + sg * cosh_ball(x0) * sinh_ball(y0)
            wrong = sinh_ball(x0) * cosh_ball(y0) - sg * cosh_ball(x0) * sinh_ball(y0)
        assert lhs.overlaps(rhs)
        assert max(lhs.rad(), rhs.rad()) < RR(2)^(-150) * max(1, abs(rhs.mid()))
        if x0 != 0 and y0 != 0:
            assert not lhs.overlaps(wrong); separated += 1
print(f"{KIND}: {len(points)} 点の両方の複号で両辺のボールが重なり、複号を取り違えた式は {separated} 通りで重ならない")
print("RESULT: PASS")
