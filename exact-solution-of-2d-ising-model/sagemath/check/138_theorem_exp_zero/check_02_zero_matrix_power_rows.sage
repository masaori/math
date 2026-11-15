# 対象ラベル: theorem_exp_zero
# 準備の鎖 O^k = O^{k-1} O = O（k ≥ 1。本文の指数 k を、ここでは n と書く。def_exp (1) の A^{m+1} := A^m A と zero_matrix_is_right_zero_of_mat_mult）と、
# 本体の鎖の O^0 = I の行（def_exp (1) の A^0 := I）を確かめる。
# 帰属: QQ[i]（ℂ の有理点の模型）の行列の厳密計算。浮動小数点は使わない。
F.<i> = QuadraticField(-1)
n_checks = 0
for d in range(1, 6):
    O = zero_matrix(F, d, d)
    I = identity_matrix(F, d)
    # 冪を def_exp (1) の再帰そのもので作る: P_0 := I、P_{m+1} := P_m O
    P = [I]
    for m in range(0, 8):
        P.append(P[m] * O)
    assert P[0] == I; n_checks += 1                       # O^0 = I の行
    for n in range(1, 9):
        assert P[n] == P[n - 1] * O; n_checks += 1        # 1 行目: O^n = O^{n-1} O（再帰の形）
        assert O ** n == (O ** (n - 1)) * O; n_checks += 1  # 1 行目を Sage の冪（再帰とは独立の実装）でも
        assert P[n - 1] * O == O; n_checks += 1           # 2 行目: O^{n-1} O = O
    # zero_matrix_is_right_zero_of_mat_mult を O^{n-1} 以外の A でも（右から零行列を掛けると零行列）
    A = matrix(F, d, d, lambda r, c: (r + 1) + (c - 2) * i)
    assert A * O == O; n_checks += 1
# 否定コントロール: 零行列でない行列では 2 行目が崩れる（E = I なら E^{n-1} E = I ≠ O）
neg = 0
for d in range(1, 6):
    E = identity_matrix(F, d)
    for n in range(1, 9):
        assert E ** (n - 1) * E != zero_matrix(F, d, d); neg += 1
# 否定コントロール: 冪の規約を Q_0 := O、Q_{m+1} := Q_m O に差し替えて鎖を作り直すと、本体の鎖の O^0 = I の行が崩れる
for d in range(1, 6):
    Q = [zero_matrix(F, d, d)]
    for m in range(0, 8):
        Q.append(Q[m] * zero_matrix(F, d, d))
    assert Q[0] != identity_matrix(F, d); neg += 1
print("zero matrix power rows of theorem_exp_zero: %d checks" % n_checks)
print("negative controls (broken lines detected): %d" % neg)
print("RESULT: PASS")
