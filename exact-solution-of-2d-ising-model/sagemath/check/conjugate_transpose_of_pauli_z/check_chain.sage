# 対象ラベル: conjugate_transpose_of_pauli_z
# 人手の 4 行の鎖 (σ^z)^* = (conj σ_11 conj σ_21; conj σ_12 conj σ_22) = (conj 1_C conj 0_C; conj 0_C conj (-1)_C)
#   = (1_C 0_C; 0_C (-1)_C) = σ^z を 1 行ずつ確かめる。
# ℂ は definition_of_cc どおり QQ の対、σ^z の -1 は inclusion_rr_to_cc の略記 (-1)_C、共役転置は def_hermitian_positive_definite
# （body_star）、複素共役は def_complex_conjugate。body_star は Sage の conjugate_transpose（QQ(i)）と一致することを見てから使う。
# 対照: σ^z の (2,2) 成分を -i に替えた行列は共役転置で変わる。
load("../../_shared/hermitian_forms_by_definition.sage")
R = QQ
z0, z1, zm1 = iota(0, R), iota(1, R), iota(-1, R)
i_pair = (R(0), R(1))                     # antiperiodic_exp_sum の前置きの i := (0,1)
mi_pair = cc_neg(i_pair, R)               # multiply_by_minus_one の -i := (-1_C) i


def to_sage(A):
    return matrix(KG, [[a + b * i_K for (a, b) in row] for row in A])


def check_chain(lines, label):
    for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
        assert a == b, f"{label}: 第 {k} 行と第 {k+1} 行が一致しない"

SZp = [[z1, z0], [z0, zm1]]               # pauli_matrix_products の σ^z
S = body_star(SZp)
assert to_sage(S) == to_sage(SZp).conjugate_transpose()
c = cc_conj
lines = [
    S,
    [[c(SZp[0][0]), c(SZp[1][0])], [c(SZp[0][1]), c(SZp[1][1])]],  # def_hermitian_positive_definite（n = 2）
    [[c(z1), c(z0)], [c(z0), c(zm1)]],                             # σ^z の成分
    [[z1, z0], [z0, zm1]],                                         # complex_conjugate_of_real_inclusion（r = 1, 0, -1）
    SZp,                                                           # σ^z
]
check_chain(lines, "conjugate_transpose_of_pauli_z")
B = [[z1, z0], [z0, mi_pair]]
assert body_star(B) != B
print(f"  {len(lines) - 1} 段が成り立つ（QQ の対の厳密計算）")
print("  対照 1 件: (2,2) 成分を -i に替えた行列は共役転置で変わる")
print("RESULT: PASS")
