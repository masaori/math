# 対象ラベル: trace_power_sandwich
# 共通の準備。本文の W の厳密な作り方（K_1 := 2 log y、K_2 := log x で QQ の行列になる）、def_matrix_norm のノルム、
# def_real_bilinear_value の x^⊤Py、mat_mult の成分の式の行列・ベクトル積、def_exp (1) の冪、実対称性と正定値性の判定、
# def_rayleigh_sup の c（特性多項式の最大の実根として AA で作り、上界であることと到達することを確かめる）は、
# rayleigh_bounds_operator_norm の検算の準備をそのまま使う（W_exact・norm_exact・bil・matvec・power_by_def_exp・
# is_real_symmetric・real_rooted_with_signs・rayleigh_sup_exact）。
load("../rayleigh_bounds_operator_norm/_prelude.sage")


def rational_unit_vector(s):
    """s ∈ QQ^{d−1} から、逆立体射影 x := (2s_1, …, 2s_{d−1}, |s|^2 − 1)/(|s|^2 + 1) で ‖x‖ = 1 の x ∈ QQ^d を作る（d = 1 なら x = (−1)）。"""
    t = sum(a * a for a in s)
    return vector(QQ, [2 * a / (t + 1) for a in s] + [(t - 1) / (t + 1)])


def kd(i, j):
    """def_kronecker_delta の δ_ij。"""
    return 1 if i == j else 0
