# 対象ラベル: scalar_exp_zero
# 部分和の十行の鎖を N = 0,…,30 で確かめる。
#   S_N([0]) = Σ_{m=0}^{N} (1/m!)[0]^m = (1/0!)[0]^0 + Σ_{m=1}^{N} (1/m!)[0]^m = (1/0!) I + Σ_{m=1}^{N} (1/m!)[0]^m
#            = I + Σ_{m=1}^{N} (1/m!)[0]^m = I + Σ_{m=1}^{N} (1/m!) O = I + Σ_{m=1}^{N} O = I + O = I
#            = [I_11] = [1]
# 第一辺は共通の準備の matrix_partial_sum（本文の冪の定め方で作る）、第二辺以降は Sage の冪と行列演算で作る。
# 続けて、ノルムの鎖 ‖S_N([0]) - [1]‖ = ‖[1] - [1]‖ = ‖O‖ = 0 と、最後の鎖
# exp(0) = (exp([0]))_11 = ([1])_11 = 1 の最後の二行（成分の取り出し）を確かめる。
# ノルムは def_matrix_norm の √(Σ|a_ij|^2) を、根号の中が 0 であることで確かめる（平方根を取らずに厳密に済む）。
# 帰属: QQ（K = R）と QQ(i)（K = C）。浮動小数点は使わない。
load("../../_shared/one_by_one_matrix.sage")

N_MAX = 30
for name, F in COEFFICIENT_FIELDS:
    O = zero_matrix(F, 1, 1)
    I1 = identity_matrix(F, 1)
    Z = one_by_one(F, F(0))
    one = one_by_one(F, F(1))
    for N in range(N_MAX + 1):
        line0 = matrix_partial_sum(Z, N)
        line1 = sum(((QQ(1) / factorial(m)) * Z^m for m in range(N + 1)), O)
        line2 = (QQ(1) / factorial(0)) * Z^0 + sum(((QQ(1) / factorial(m)) * Z^m for m in range(1, N + 1)), O)
        line3 = (QQ(1) / factorial(0)) * I1 + sum(((QQ(1) / factorial(m)) * Z^m for m in range(1, N + 1)), O)
        line4 = I1 + sum(((QQ(1) / factorial(m)) * Z^m for m in range(1, N + 1)), O)
        line5 = I1 + sum(((QQ(1) / factorial(m)) * O for m in range(1, N + 1)), O)
        line6 = I1 + sum((O for m in range(1, N + 1)), O)                      # 零行列のスカラー倍は零行列
        line7 = I1 + O                                                          # 零行列どうしの和は零行列
        line8 = I1                                                              # 零行列は加法の単位元
        line9 = one_by_one(F, entry11(I1))                                      # 1 行 1 列の行列は成分だけで決まる
        line10 = one                                                            # 単位行列の対角成分は 1
        assert all((1 / factorial(m)) * O == O for m in range(1, N + 1))
        assert line0 == line1 == line2 == line3 == line4 == line5 == line6 == line7 == line8 == line9 == line10, (name, N)
        # ノルムの鎖: 差は零行列で、根号の中 Σ|a_ij|^2 は 0
        diff = line0 - one
        assert diff == one - one == O
        squared_norm = sum(a * a.conjugate() if F is GAUSSIAN else a * a for a in diff.list())
        assert squared_norm == 0
    assert factorial(0) == 1
    # 最後の鎖の二行: ([1])_11 = 1
    assert entry11(one) == F(1)
    print(f"{name}: N = 0,…,{N_MAX} で十行が一致し、S_N([0]) - [1] のノルムは 0")
print("RESULT: PASS")
