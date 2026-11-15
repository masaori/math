# 対象ラベル: scalar_exp_zero
# 部分和の鎖とノルムの鎖のうち、K = ℂ の側で主張の参照に替えた 4 行を、引いた主張の形のまま確かめる。
#   I + Σ_{m=1}^{N} (1/m!)O = I + Σ_{m=1}^{N} O   scalar_multiple_of_zero_matrix（m, n → 1、a → (1/m!)_ℂ）を各項へ
#   I + Σ_{m=1}^{N} O = I + O                     finite_sum_of_zero_matrices（m, n → 1、r → N。N ≥ 1）
#   I + O = I                                     matrix_plus_zero_matrix（m, n → 1、X → I）
#   ‖[1]_ℂ − [1]_ℂ‖ = ‖O‖                         matrix_difference_zero_iff_equal（m, p → 1、A, B → [1]_ℂ）の ⇐
# 有限和は def_finite_sum_of_matrices の Σ_{j=1}^{1} X_j := X_1、Σ_{j=1}^{r+1} X_j := (Σ_{j=1}^{r} X_j) + X_{r+1}
# どおりに左から足して作る（Sage の sum とは独立の経路）。
# 帰属: QQ(i)（ℂ の有理点の模型）の 1 行 1 列の行列の厳密計算。浮動小数点は使わない。
load("../../_shared/one_by_one_matrix.sage")

F = GAUSSIAN
O = zero_matrix(F, 1, 1)
I1 = identity_matrix(F, 1)
one = one_by_one(F, F(1))


def finite_sum_by_definition(terms):
    """def_finite_sum_of_matrices の有限和（項の数は 1 以上）。"""
    assert len(terms) >= 1
    S = terms[0]
    for X in terms[1:]:
        S = S + X
    return S


N_MAX = 30
n_checks = 0
for N in range(1, N_MAX + 1):
    scaled = [F(QQ(1) / factorial(m)) * O for m in range(1, N + 1)]
    # scalar_multiple_of_zero_matrix を各項へ: (1/m!)_ℂ O = O
    assert all(X == O for X in scaled); n_checks += 1
    line5 = I1 + finite_sum_by_definition(scaled)
    line6 = I1 + finite_sum_by_definition([O] * N)
    assert line5 == line6; n_checks += 1
    # finite_sum_of_zero_matrices（r → N）: Σ_{j=1}^{N} O = O
    assert finite_sum_by_definition([O] * N) == O; n_checks += 1
    line7 = I1 + O
    assert line6 == line7; n_checks += 1
# matrix_plus_zero_matrix（X → I）: I + O = I
assert I1 + O == I1; n_checks += 1
# matrix_difference_zero_iff_equal の ⇐（A, B → [1]_ℂ）: [1]_ℂ − [1]_ℂ = O。差は def_matrix_difference の成分ごとの差で作る
diff = matrix(F, 1, 1, [entry11(one) - entry11(one)])
assert diff == O and one - one == O; n_checks += 1
# matrix_difference_zero_iff_equal の両向きを、1 行 1 列の行列の小さな範囲で
vals = [F(a) + F(b) * F.gen() for a in range(-2, 3) for b in range(-2, 3)]
for x in vals:
    for y in vals:
        A = one_by_one(F, x); B = one_by_one(F, y)
        assert (matrix(F, 1, 1, [x - y]) == O) == (A == B); n_checks += 1

# 否定の対照: 引いた主張の前提を外すと、行が崩れる
neg = 0
E = one_by_one(F, F(1))
for N in range(1, N_MAX + 1):
    # 零行列でない行列のスカラー倍・有限和は零行列にならない（scalar_multiple_of_zero_matrix・finite_sum_of_zero_matrices は O に固有）
    assert F(QQ(1) / factorial(N)) * E != O; neg += 1
    assert finite_sum_by_definition([E] * N) != O; neg += 1
# 零行列でない行列を足すと I は変わる（matrix_plus_zero_matrix は O に固有）
assert I1 + E != I1; neg += 1
# 等しくない 2 つの行列の差は零行列でない（⇐ の向きに A = B が要る）
assert matrix(F, 1, 1, [entry11(one) - F(2)]) != O; neg += 1
print("complex-side cited rows of scalar_exp_zero: %d checks" % n_checks)
print("negative controls (broken lines detected): %d" % neg)
print("RESULT: PASS")
