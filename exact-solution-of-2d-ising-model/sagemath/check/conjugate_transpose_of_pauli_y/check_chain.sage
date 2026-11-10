# 対象ラベル: conjugate_transpose_of_pauli_y
# 準備の 2 本の鎖 conj i = -i（6 行）、conj(-i) = i（7 行）と、主の 6 行の鎖
#   (σ^y)^* = (conj σ_11 conj σ_21; conj σ_12 conj σ_22) = (conj 0_C conj i; conj(-i) conj 0_C) = (0_C conj i; conj(-i) 0_C)
#   = (0_C -i; conj(-i) 0_C) = (0_C -i; i 0_C) = σ^y を 1 行ずつ確かめる。
# ℂ は definition_of_cc どおり QQ の対、i := (0,1)（def_imaginary_unit）、-z := (-1_C) z（multiply_by_minus_one）、
# 共役転置は def_hermitian_positive_definite（body_star）、複素共役は def_complex_conjugate。
# body_star は Sage の conjugate_transpose（QQ(i)）と一致することを見てから使う。
# 対照: 共役を落とした転置 (σ^y)^⊤ は σ^y と異なる（-σ^y になる）。
load("../../_shared/hermitian_forms_by_definition.sage")
R = QQ
z0, z1, zm1 = iota(0, R), iota(1, R), iota(-1, R)
i_pair = (R(0), R(1))                     # def_imaginary_unit の i := (0,1)
mi_pair = cc_neg(i_pair, R)               # multiply_by_minus_one の -i := (-1_C) i


def to_sage(A):
    return matrix(KG, [[a + b * i_K for (a, b) in row] for row in A])


def check_chain(lines, label):
    for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
        assert a == b, f"{label}: 第 {k} 行と第 {k+1} 行が一致しない"

c = cc_conj
prep_i = [
    c(i_pair),
    c((R(0), R(1))),                       # i := (0,1)
    (R(0), R(-1)),                         # def_complex_conjugate
    cc_mul((R(-1), R(0)), (R(0), R(1))),   # definition_of_cc の積
    cc_mul(zm1, (R(0), R(1))),             # inclusion_rr_to_cc の (-1)_C = (-1,0)
    cc_mul(zm1, i_pair),                   # i := (0,1)
    mi_pair,                               # multiply_by_minus_one
]
check_chain(prep_i, "conjugate_transpose_of_pauli_y 準備 conj i")
prep_mi = [
    c(mi_pair),
    c(cc_mul(zm1, i_pair)),                # multiply_by_minus_one
    c(cc_mul(zm1, (R(0), R(1)))),          # i := (0,1)
    c(cc_mul((R(-1), R(0)), (R(0), R(1)))),  # inclusion_rr_to_cc の (-1)_C = (-1,0)
    c((R(0), R(-1))),                      # definition_of_cc の積
    (R(0), -R(-1)),                        # def_complex_conjugate
    (R(0), R(1)),                          # ℝ で -(-1) = 1
    i_pair,                                # i := (0,1)
]
check_chain(prep_mi, "conjugate_transpose_of_pauli_y 準備 conj(-i)")
SYp = [[z0, mi_pair], [i_pair, z0]]       # pauli_matrix_products の σ^y
S = body_star(SYp)
assert to_sage(S) == to_sage(SYp).conjugate_transpose()
lines = [
    S,
    [[c(SYp[0][0]), c(SYp[1][0])], [c(SYp[0][1]), c(SYp[1][1])]],  # def_hermitian_positive_definite（n = 2）
    [[c(z0), c(i_pair)], [c(mi_pair), c(z0)]],                     # σ^y の成分
    [[z0, c(i_pair)], [c(mi_pair), z0]],                           # complex_conjugate_of_real_inclusion（r = 0）
    [[z0, mi_pair], [c(mi_pair), z0]],                             # 準備の conj i = -i
    [[z0, mi_pair], [i_pair, z0]],                                 # 準備の conj(-i) = i
    SYp,                                                           # σ^y
]
check_chain(lines, "conjugate_transpose_of_pauli_y")
T = [[SYp[q][p] for q in range(2)] for p in range(2)]
assert T != SYp
print(f"  準備 {len(prep_i) - 1} 段・{len(prep_mi) - 1} 段と主の {len(lines) - 1} 段が成り立つ（QQ の対の厳密計算）")
print("  対照 1 件: 共役を落とした転置は σ^y と異なる")
print("RESULT: PASS")
