# 対象ラベル: conjugate_transpose_of_pauli_x
# 人手の 4 行の鎖 (σ^x)^* = (conj σ_11 conj σ_21; conj σ_12 conj σ_22) = (conj 0_C conj 1_C; conj 1_C conj 0_C)
#   = (0_C 1_C; 1_C 0_C) = σ^x を 1 行ずつ確かめる。
# ℂ は definition_of_cc どおり QQ の対、共役転置は def_hermitian_positive_definite（body_star）、複素共役は def_complex_conjugate。
# body_star は Sage の conjugate_transpose（QQ(i)）と一致することを見てから使う。
# 対照: σ^x の (1,2) 成分を i に替えた行列は共役転置で変わる。
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

SXp = [[z0, z1], [z1, z0]]                # def_pauli_matrices の σ^x
S = body_star(SXp)
assert to_sage(S) == to_sage(SXp).conjugate_transpose()
c = cc_conj
lines = [
    S,
    [[c(SXp[0][0]), c(SXp[1][0])], [c(SXp[0][1]), c(SXp[1][1])]],  # def_hermitian_positive_definite（n = 2）
    [[c(z0), c(z1)], [c(z1), c(z0)]],                              # σ^x の成分
    [[z0, z1], [z1, z0]],                                          # complex_conjugate_of_real_inclusion（r = 0, 1）
    SXp,                                                           # σ^x
]
check_chain(lines, "conjugate_transpose_of_pauli_x")
B = [[z0, i_pair], [z1, z0]]
assert body_star(B) != B
print(f"  {len(lines) - 1} 段が成り立つ（QQ の対の厳密計算）")
print("  対照 1 件: (1,2) 成分を i に替えた行列は共役転置で変わる")
print("RESULT: PASS")
