# 対象ラベル: commuting_matrix_commutes_with_exp
# 主張 A exp(B) = exp(B) A を、exp をボールで囲んで確かめる（ℝ への脱出を含む量なので浮動小数点のボール）。
# 対照: AB ≠ BA の組では、二つのボールの行列はどこかの成分で交わらない。
load("_prelude.sage")

B1 = matrix(KG, [[1, 2], [0, i_K]])
pairs = [(B1, 2 * identity_matrix(KG, 2) + B1 - B1 * B1 / 3),
         (matrix(KG, [[0, 1, 0], [0, 0, 1], [1, 0, 0]]) * (1 + i_K) / 2, None),
         (site(2, 1, 'z') + site(2, 2, 'x'), site(2, 2, 'x'))]
for B, A in pairs:
    if A is None:
        A = B + B * B
    assert A * B == B * A
    E = exp_ball(B)
    assert balls_overlap(to_CB(A) * E, E * to_CB(A))
B = matrix(KG, [[1, 2], [0, i_K]])
A = matrix(KG, [[0, 1], [1, 0]])
assert A * B != B * A
E = exp_ball(B)
assert balls_disjoint_somewhere(to_CB(A) * E, E * to_CB(A))
print("  可換な 3 組で A exp(B) と exp(B) A のボールが重なり、可換でない組では交わらない成分がある")
print("RESULT: PASS")
