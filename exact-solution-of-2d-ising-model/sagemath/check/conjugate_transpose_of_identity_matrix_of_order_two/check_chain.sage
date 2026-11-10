# 対象ラベル: conjugate_transpose_of_identity_matrix_of_order_two
# 人手の 6 行の鎖 I^* = (conj I_11 conj I_21; conj I_12 conj I_22) = (conj δ_11 conj δ_21; conj δ_12 conj δ_22)
#   = (conj 1_C conj 0_C; conj 0_C conj 1_C) = (1_C 0_C; 0_C 1_C) = (δ_11 δ_12; δ_21 δ_22) = I を 1 行ずつ確かめる。
# ℂ は definition_of_cc どおり QQ の対で持ち、共役転置は def_hermitian_positive_definite の (A^*)_{kl} := conj(A_{lk})
# （body_star）、複素共役は def_complex_conjugate（cc_conj）、δ は def_kronecker_delta で組む。
# body_star は Sage の conjugate_transpose（QQ(i)）と一致することを見てから使う。
# 対照: 行列単位 E_12 は同じ組み方の共役転置で変わる。
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

d = lambda a, b: z1 if a == b else z0     # def_kronecker_delta（1_C, 0_C）
Id = [[d(1, 1), d(1, 2)], [d(2, 1), d(2, 2)]]  # def_identity_matrix（n = 2）
S = body_star(Id)
assert to_sage(S) == to_sage(Id).conjugate_transpose()
c = cc_conj
lines = [
    S,
    [[c(Id[0][0]), c(Id[1][0])], [c(Id[0][1]), c(Id[1][1])]],      # def_hermitian_positive_definite（n = 2）
    [[c(d(1, 1)), c(d(2, 1))], [c(d(1, 2)), c(d(2, 2))]],          # def_identity_matrix（n = 2）
    [[c(z1), c(z0)], [c(z0), c(z1)]],                              # def_kronecker_delta
    [[z1, z0], [z0, z1]],                                          # complex_conjugate_of_real_inclusion（r = 1, 0）
    [[d(1, 1), d(1, 2)], [d(2, 1), d(2, 2)]],                      # def_kronecker_delta
    Id,                                                            # def_identity_matrix（n = 2）
]
check_chain(lines, "conjugate_transpose_of_identity_matrix_of_order_two")
E12 = [[z0, z1], [z0, z0]]
assert body_star(E12) != E12
print(f"  {len(lines) - 1} 段が成り立つ（QQ の対の厳密計算）")
print("  対照 1 件: 行列単位 E_12 は共役転置で変わる")
print("RESULT: PASS")
