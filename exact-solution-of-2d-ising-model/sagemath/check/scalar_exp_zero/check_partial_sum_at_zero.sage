# 対象ラベル: scalar_exp_zero
# 部分和の N = 0 の鎖（七行）を確かめる。
#   S_0([0]) = Σ_{m=0}^{0} (1/m!)[0]^m = Σ_{j=1}^{1} (1/(j-1)!)[0]^{j-1} = (1/0!)[0]^0 = (1/0!) I = I = [I_11] = [1]
# 第一辺は共通の準備の matrix_partial_sum（本文の冪の定め方で作る）。第二辺は添字 0 から始まる和を、
# 第三辺は def_finite_sum_of_matrices_from_index_zero の添字をずらした和（j = 1 の 1 項）を、
# 第四辺は def_finite_sum_of_matrices の Σ_{j=1}^{1} X_j := X_1 を、それぞれ別に作る。
# 帰属: QQ（K = R）と QQ(i)（K = C）。浮動小数点は使わない。
load("../../_shared/one_by_one_matrix.sage")

neg = 0
for name, F in COEFFICIENT_FIELDS:
    O = zero_matrix(F, 1, 1)
    I1 = identity_matrix(F, 1)
    Z = one_by_one(F, F(0))
    line0 = matrix_partial_sum(Z, 0)
    line1 = sum(((QQ(1) / factorial(m)) * matrix_power_by_definition(Z, m) for m in range(0, 1)), O)
    shifted = [(QQ(1) / factorial(j - 1)) * matrix_power_by_definition(Z, j - 1) for j in range(1, 2)]
    assert len(shifted) == 1
    line2 = shifted[0]                                  # Σ_{j=1}^{1} X_j := X_1
    line3 = (QQ(1) / factorial(0)) * matrix_power_by_definition(Z, 0)
    line4 = (QQ(1) / factorial(0)) * I1                 # A^0 := I
    line5 = I1                                          # 0! = 1
    line6 = one_by_one(F, entry11(I1))
    line7 = one_by_one(F, F(1))
    assert line0 == line1 == line2 == line3 == line4 == line5 == line6 == line7, name
    assert matrix_power_by_definition(Z, 0) == I1
    # 否定の対照: N = 0 の部分和は零行列ではない（A^0 := I が効く）。0 乗を O とする規約では鎖が崩れる
    assert line0 != O; neg += 1
    assert (QQ(1) / factorial(0)) * O != line7; neg += 1
    print(f"{name}: N = 0 の七行が一致し、S_0([0]) = [1]")
print("negative controls (broken lines detected): %d" % neg)
print("RESULT: PASS")
