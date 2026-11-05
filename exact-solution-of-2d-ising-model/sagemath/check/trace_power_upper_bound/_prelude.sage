# 対象ラベル: trace_power_upper_bound
# 共通の準備。本文の W の厳密な作り方（K_1 := 2 log y、K_2 := log x で QQ の行列になる）、def_matrix_norm のノルム、
# def_real_bilinear_value の x^⊤Py、mat_mult の成分の式の行列・ベクトル積、def_exp (1) の冪、上限 c(M_col) の厳密な作り方は、
# 直前の主張 rayleigh_bounds_operator_norm の検算の準備をそのまま使う（W_exact・norm_exact・bil・matvec・power_by_def_exp・
# is_real_symmetric・real_rooted_with_signs・rayleigh_sup_exact）。c は特性多項式の最大の実根（AA）で、上限であることを
# cI − W の半正定値性と固有ベクトルでの到達で、その場で確かめる。
load("../rayleigh_bounds_operator_norm/_prelude.sage")
