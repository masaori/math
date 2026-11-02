# 対象ラベル: check_joint_eigenspace_decomposition
# Step 1 の ε ≠ ε' の鎖と Step 2 の鎖を一行ずつ厳密に確かめる（M = 2, 3, 4、全ての ε, ε' ∈ {0,1}^M）。
#   Step 1: Q̌_εQ̌_ε' = (∏_{μ≠ν} R_μ^{(ε_μ)}R_μ^{(ε'_μ)}) R_ν^{(ε_ν)}R_ν^{(ε'_ν)}（因子の可換性）
#                    = (∏_{μ≠ν} R_μ^{(ε_μ)}R_μ^{(ε'_μ)}) O（Step 0 の異なる上付き添字の積）
#                    = O（zero_matrix_is_right_zero_of_mat_mult）
#   Step 2: Σ_ε ∏_μ R_μ^{(ε_μ)} = ∏_μ (R_μ^{(1)} + R_μ^{(0)})（分配による展開）= ∏_μ I（Step 0 の和）
#                    = I（finite_product_of_identity_matrices）
# 有限積は def_finite_product_of_matrices どおり μ = 1, …, M の順に A_1 から左へ掛ける（空の積は使わない）。
# ∏_{μ≠ν} は μ ≠ ν の μ を小さい順に並べた有限積で組む（M ≥ 2 なので因子は 1 個以上）。
# ň_μ は check_24・check_30・check_31 と同じく Jordan–Wigner のフェルミ演算子 c_μ から作る n_μ := c_μ^T c_μ。
# 否定コントロール: zero_matrix_is_right_zero_of_mat_mult の行は右の因子が零行列でなければ外れ、
#   finite_product_of_identity_matrices の行は因子に単位行列でないものがあれば外れる。
# 帰属: 成分は QQ（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def finite_product(mats):
    acc = mats[0]                                      # def_finite_product_of_matrices の 1 項
    for A in mats[1:]:
        acc = body_product(acc, A)                     # def_finite_product_of_matrices の帰納
    return acc


count = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    N = 2 ^ M
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    ns = [c[mu].transpose() * c[mu] for mu in range(M)]
    Id = body_identity(QQ, N)
    O = matrix(QQ, N, N, 0)
    R1 = ns
    R0 = [body_difference(Id, n) for n in ns]
    epss = list(cartesian_product([[0, 1]] * M))
    R = lambda eps: [R1[mu] if eps[mu] == 1 else R0[mu] for mu in range(M)]
    Q = {tuple(eps): finite_product(R(eps)) for eps in epss}   # Q̌_ε の定義（冒頭）
    # Step 1（ε ≠ ε'）
    for eps in epss:
        for epsp in epss:
            if eps == epsp:
                continue
            nu = min(mu for mu in range(M) if eps[mu] != epsp[mu])
            Re, Rp = R(eps), R(epsp)
            rest = finite_product([body_product(Re[mu], Rp[mu]) for mu in range(M) if mu != nu])
            lines = [
                body_product(Q[tuple(eps)], Q[tuple(epsp)]),
                body_product(rest, body_product(Re[nu], Rp[nu])),   # 因子の可換性で添字 ν の二因子を末尾へ
                body_product(rest, O),                              # Step 0 の異なる上付き添字の積
                O,                                                  # zero_matrix_is_right_zero_of_mat_mult
            ]
            assert body_product(Re[nu], Rp[nu]) == O
            for A, B in zip(lines, lines[1:]):
                assert A == B, ("step1", M, tuple(eps), tuple(epsp))
                count += 1
    # Step 2
    lines = [
        sum(Q[tuple(eps)] for eps in epss),
        finite_product([R1[mu] + R0[mu] for mu in range(M)]),       # 分配による展開
        finite_product([Id] * M),                                   # Step 0 の和を各因子へ
        Id,                                                         # finite_product_of_identity_matrices
    ]
    for A, B in zip(lines, lines[1:]):
        assert A == B, ("step2", M)
        count += 1

# 否定コントロール
neg = 0
J = matrix(QQ, [[1, 1], [0, 1]])
assert body_product(J, J) != matrix(QQ, 2, 2, 0)                    # 右の因子が零行列でなければ零にならない
neg += 1
assert finite_product([id2, J, id2]) != id2                         # 単位行列でない因子があれば単位行列にならない
neg += 1

print("PASS check_joint_eigenspace_decomposition Step 1 の ε ≠ ε' の鎖と Step 2 の鎖: %d 段、否定コントロール %d 行" % (count, neg))
print("RESULT: PASS")
