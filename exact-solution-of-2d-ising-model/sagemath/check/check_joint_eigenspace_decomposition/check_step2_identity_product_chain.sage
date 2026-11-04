# 対象ラベル: check_joint_eigenspace_decomposition
# Step 2 の鎖を一行ずつ厳密に確かめる。Step 1 の ε ≠ ε' の鎖は check_step1_orthogonality_step3_moving_one_factor_chains が確かめる。
#   Step 2: Σ_ε ∏_μ R_μ^{(ε_μ)} = ∏_μ (R_μ^{(1)} + R_μ^{(0)})（分配による展開）= ∏_μ I（Step 0 の和）
#                    = I（finite_product_of_identity_matrices）
# 有限積は def_finite_product_of_matrices どおり μ = 1, …, M の順に A_1 から左へ掛ける（空の積は使わない）。
# ň_μ は _number_operators.sage の number_operator_settings() から取る（既定は Jordan–Wigner の模型 M = 2, 3, 4、check_with_check_psi.sage からは本文の ψ̌）。
# 否定コントロール: finite_product_of_identity_matrices の行は因子に単位行列でないものがあれば外れる。
# 帰属: 成分は QQ か、本文の ψ̌ の数体 F（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("_number_operators.sage")


def finite_product(mats):
    acc = mats[0]                                      # def_finite_product_of_matrices の 1 項
    for A in mats[1:]:
        acc = body_product(acc, A)                     # def_finite_product_of_matrices の帰納
    return acc


count = 0
id2 = identity_matrix(QQ, 2)
for (tag, M, F, ns) in number_operator_settings():
    N = 2 ^ M
    Id = body_identity(F, N)
    O = matrix(F, N, N, 0)
    R1 = ns
    R0 = [body_difference(Id, n) for n in ns]
    epss = list(cartesian_product([[0, 1]] * M))
    R = lambda eps: [R1[mu] if eps[mu] == 1 else R0[mu] for mu in range(M)]
    Q = {tuple(eps): finite_product(R(eps)) for eps in epss}   # Q̌_ε の定義（冒頭）
    # Step 2
    lines = [
        sum(Q[tuple(eps)] for eps in epss),
        finite_product([R1[mu] + R0[mu] for mu in range(M)]),       # 分配による展開
        finite_product([Id] * M),                                   # Step 0 の和を各因子へ
        Id,                                                         # finite_product_of_identity_matrices
    ]
    for A, B in zip(lines, lines[1:]):
        assert A == B, ("step2", tag)
        count += 1

# 否定コントロール
neg = 0
J = matrix(QQ, [[1, 1], [0, 1]])
assert finite_product([id2, J, id2]) != id2                         # 単位行列でない因子があれば単位行列にならない
neg += 1

print("PASS check_joint_eigenspace_decomposition Step 2 の鎖: %d 段、否定コントロール %d 行" % (count, neg))
print("RESULT: PASS")
