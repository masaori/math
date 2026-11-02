# 対象ラベル: calc_of_TxT_check_Z_Y
# 共通の準備は _shared/transfer_factor_actions_on_check_Z_Y.sage（T_actions_on_check_Z_Y の検算と共有）。
# K_1 = 2 log y・K_2 = log x と選び、Ž_μ・Y̌_μ・(V_1^{(+)})^{1/2} = exp(X)・V_2・cosh・sinh・位相を一つの数体 F に置く。
load("../../_shared/transfer_factor_actions_on_check_Z_Y.sage")


def pair_times_two_by_two(A, B, P):
    """def_pair_of_matrices_times_two_by_two_matrix の (A, B)P := ((A, B)(P_11; P_21), (A, B)(P_12; P_22))。"""
    return (pair_times_column(A, B, P[0, 0], P[1, 0]), pair_times_column(A, B, P[0, 1], P[1, 1]))


def B1_by_definition(f, theta_phase_plus, theta_phase_minus):
    """def_B1_theta_B2 の B_1(θ)。exp(i(θ)_C)・exp(-i(θ)_C) の値を引数で受け取り、成分を定義の式どおりに組む。"""
    i = f.i
    return matrix(f.F, 2, 2, [f.ch1, ((-i) * theta_phase_plus) * f.sh1,
                              (i * theta_phase_minus) * f.sh1, f.ch1])


def B2_by_definition(f):
    """def_B1_theta_B2 の B_2。"""
    i = f.i
    return matrix(f.F, 2, 2, [f.ch2, i * f.sh2, (-i) * f.sh2, f.ch2])
