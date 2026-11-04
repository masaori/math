# 対象ラベル: check_joint_eigenspace_decomposition
# Step 3 の二つの場合の鎖の末尾を一行ずつ厳密に確かめる（全ての ň_μ）。
#   ε_ν = 1: ň_ν R_ν^{(1)} = ň_νň_ν = ň_ν = R_ν^{(1)} = 1_ℂ R_ν^{(1)}（scalar_multiple_by_one を右辺から左辺へ）= ε_ν R_ν^{(ε_ν)}
#   ε_ν = 0: ň_ν R_ν^{(0)} = ň_ν(I − ň_ν) = O（途中の 7 行は check_step0_step3_distributivity_chains・check_step0_square_zero_difference_and_sum_chains）= 0_ℂ R_ν^{(0)}
#            （zero_scalar_multiple_is_zero_matrix を右辺から左辺へ）= ε_ν R_ν^{(ε_ν)}
# ň_νQ̌_ε の鎖は check_step1_orthogonality_step3_moving_one_factor_chains が確かめる。
# 行列の積・和・差・スカラー倍・単位行列は本文の成分の式で組む。
# ň_μ は _number_operators.sage の number_operator_settings() から取る（既定は Jordan–Wigner の模型 M = 2, 3, 4、check_with_check_psi.sage からは本文の ψ̌）。
# 否定コントロール: 冪等でない不定元の 2×2 行列では、冪等性（check_number_operator_idempotent (3)）を使う行だけが等号を外れる。
# 帰属: 成分は QQ か本文の ψ̌ の数体 F と、その上の多項式環（否定コントロールは QQ 上）（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("_number_operators.sage")


def body_prod(mats, R, n):
    out = body_identity(R, n)
    for A in mats:
        out = body_product(out, A)
    return out


def case_one_chain(n):
    R1 = n                                                             # R^{(1)} の定義（冒頭）
    return [
        (body_product(n, R1), False),
        (body_product(n, n), False),                                   # R^{(1)} の定義
        (n, True),                                                     # Step 0 冒頭の ňň = ň
        (R1, False),                                                   # R^{(1)} の定義
        (body_scalar(QQ(1), R1), False),                               # scalar_multiple_by_one を右辺から左辺へ
        (body_scalar(QQ(1), R1), False),                               # 場合の仮定 ε_ν = 1（ε_ν R^{(ε_ν)} を ε_ν = 1 で組む）
    ]


def case_zero_chain(n):
    Id = body_identity(n.base_ring(), n.nrows())
    R0 = body_difference(Id, n)                                        # R^{(0)} の定義（冒頭）
    O = matrix(n.base_ring(), n.nrows(), n.ncols(), 0)
    return [
        (body_product(n, R0), False),
        (body_product(n, body_difference(Id, n)), False),              # R^{(0)} の定義
        (O, True),                                                     # 途中の 7 行（上の二つの検算）。冪等性を使う
        (body_scalar(QQ(0), R0), False),                               # zero_scalar_multiple_is_zero_matrix を右辺から左辺へ
        (body_scalar(QQ(0), R0), False),                               # 場合の仮定 ε_ν = 0
    ]


def check_chain(lines, label, expect_all):
    global count
    for (A, _), (B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, label
            count += 1


count = 0
for (tag, M, F, ns) in number_operator_settings():
    N = 2 ^ M
    Id = body_identity(F, N)
    for n in ns:
        assert n ^ 2 == n                                              # (3) の仮定
        check_chain(case_one_chain(n), ("eps=1", tag), True)
        check_chain(case_zero_chain(n), ("eps=0", tag), True)

# 否定コントロール: 不定元の成分の 2×2 行列（冪等でない）
Rg = PolynomialRing(QQ, ["x%d" % k for k in range(4)])
X = matrix(Rg, 2, 2, Rg.gens())
neg_control = 0
for chain in (case_one_chain, case_zero_chain):
    lines = chain(X)
    check_chain(lines, ("generic", chain.__name__), False)
    for (A, _), (B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("仮定を使う行が仮定なしで成り立ってしまう", chain.__name__)
            neg_control += 1
assert neg_control == 2

print("PASS check_joint_eigenspace_decomposition Step 3 の二つの場合の末尾: %d 段、否定コントロール %d 行" % (count, neg_control))
