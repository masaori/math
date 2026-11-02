# 対象ラベル: V1_plus_half_invertible
# 主張 (V_1^(+))^{1/2} ∈ R^× を、証明の h とは別の経路で確かめる: Sage の ComplexBallField の行列の逆行列
# （ボールのガウス消去）が存在し、証明が取った h = exp(-X) と重なる。逆元は一意（def_invertible_elements_of_R）なので、
# 重なることは証明の h が逆元であることと整合する。
load("_prelude.sage")
for M in range(2, 5):
    for K1 in [QQ(1)/4, QQ(1)/2, QQ(1)]:
        X = V1_half_exponent(M, K1)
        B = exp_ball(X)
        h = exp_ball(body_negation(X))
        Binv = B.inverse()
        assert balls_overlap(Binv, h)
    print(f"  M_col={M}: Sage の逆行列のボールが exp(-X) と重なる")
print("RESULT: PASS")
