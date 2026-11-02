# 対象ラベル: V1_plus_half_invertible
# 証明の二つの鎖を一行ずつ確かめる。X := (i/2)K_1 H_1^(+)、h := exp(-X)。
#   (V_1^(+))^{1/2} h = exp(X)exp(-X) = exp(-(-X))exp(-X) = I
#   h (V_1^(+))^{1/2} = exp(-X)exp(X) = I
# X・-X・-(-X) は KG で厳密に作る（-X は def_matrix_negation の成分の式）。exp を含む行は、本文の部分和に尾の上界を
# 半径として足したボール（Sage の ComplexBallField の exp とも重なる）で囲む。
# 対照: h を K_1 を 2 倍にした exp(-X') に替えると、積はどこかの成分で I と交わらない（検算が空でないこと）。
load("_prelude.sage")
for M in range(2, 5):
    n = 2**M
    Id = identity_CB(n)
    for K1 in [QQ(1)/4, QQ(1)/2, QQ(1)]:
        X = V1_half_exponent(M, K1)
        mX = body_negation(X)
        mmX = body_negation(mX)
        # exp(-(-X)) の行の根拠 matrix_double_negation: -(-X) = X（厳密）。Sage の `-` とも一致する。
        assert mmX == X and mX == -X
        B = exp_ball(X)            # (V_1^(+))^{1/2} = exp(X)（def_V1_plus_square_root）
        h = exp_ball(mX)           # h = exp(-X)
        # 第一の鎖: (V_1^(+))^{1/2} h から exp(X)exp(-X) までは同じ行列の積、次の行が exp(-(-X))exp(-X)
        line1 = B * h
        line2 = exp_ball(mmX) * h
        assert balls_overlap(line1, line2)
        assert balls_overlap(line2, Id)
        # 第二の鎖
        line1b = h * B
        assert balls_overlap(line1b, Id)
        # 対照
        hbad = exp_ball(body_negation(V1_half_exponent(M, 2 * K1)))
        assert balls_disjoint_somewhere(B * hbad, Id)
    print(f"  M_col={M}: K_1 ∈ {{1/4,1/2,1}} で -(-X) = X（厳密）、二つの鎖の各行が重なり I に着く。対照は I と交わらない成分がある")
print("RESULT: PASS")
