# 対象ラベル: V2_invertible
# 二つの鎖の exp を含む行: exp(Y)exp(-Y) = exp(-(-Y))exp(-Y) = I と exp(-Y)exp(Y) = I（Y := iK_2^* H_2）。
# H_2 は def_H2 どおり Σ Z_mY_m を本文の積と和で KG に作り、-Y・-(-Y) は def_matrix_negation の成分の式で厳密に作る。
# これらの行は K_2^* の値に依らず成り立つ主張（exp_of_negative_is_left_inverse は任意の行列で成り立つ）を当てたものなので、
# K_2^* は有理数 {1/4, 1/2, 1} に取り、exp を本文の部分和と尾の上界のボールで囲む（ℝ への脱出: exp の極限）。
# K_2^* の本来の値（K_2 = log x）での主張は check_claim_exact.sage が厳密に確かめる。
# 対照: exp(-Y) を K_2^* を 2 倍にしたものに替えると、積は I と交わらない成分がある。
load("_prelude.sage")
for M in range(1, 5):
    Id = identity_CB(2**M)
    for K2s in [QQ(1)/4, QQ(1)/2, QQ(1)]:
        Y = body_scalar(i_K * K2s, H2(M))
        mY = body_negation(Y)
        mmY = body_negation(mY)
        assert mmY == Y and mY == -Y         # matrix_double_negation（厳密）
        EY, EmY = exp_ball(Y), exp_ball(mY)
        assert balls_overlap(EY * EmY, exp_ball(mmY) * EmY)
        assert balls_overlap(exp_ball(mmY) * EmY, Id)
        assert balls_overlap(EmY * EY, Id)
        bad = exp_ball(body_negation(body_scalar(i_K * 2 * K2s, H2(M))))
        assert balls_disjoint_somewhere(EY * bad, Id)
    print(f"  M_col={M}: -(-Y) = Y（厳密）、exp の行が重なり I に着く。対照は I と交わらない成分がある")
print("RESULT: PASS")
