# 対象ラベル: check_joint_eigenspace_decomposition
# Step 3 の ň_ν R_ν^{(1)} と ň_ν R_ν^{(0)} の鎖を一行ずつ厳密に確かめる（全ての ň_μ）。
#   ň_ν R_ν^{(1)} = ň_νň_ν（def_check_R_factor）= ň_ν（Step 0 冒頭の ňň = ň）= R_ν^{(1)}（def_check_R_factor）
#   ň_ν R_ν^{(0)} = ň_ν(I − ň_ν)（def_check_R_factor）= O（途中の 7 行は check_step0_step3_distributivity_chains・
#                  check_step0_square_zero_difference_and_sum_chains）
# ň_νQ̌_ε の鎖（ε(ν) によらない部分と ε(ν) = 1・0 の二つの場合）は check_step1_orthogonality_step3_moving_one_factor_chains が確かめる。
# 行列の積・差・単位行列は本文の成分の式で組む。
# ň_μ は _number_operators.sage の number_operator_settings() から取る（既定は Jordan–Wigner の模型 M = 2, 3, 4、check_with_check_psi.sage からは本文の ψ̌）。
# 否定コントロール: 冪等でない不定元の 2×2 行列では、冪等性（check_number_operator_idempotent (3)）を使う行だけが等号を外れる。
# 帰属: 成分は QQ か本文の ψ̌ の数体 F と、その上の多項式環（否定コントロールは QQ 上）（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("_number_operators.sage")


def case_one_chain(n):
    R1 = n                                                             # def_check_R_factor の R^{(1)}
    return [
        (body_product(n, R1), False),
        (body_product(n, n), False),                                   # def_check_R_factor
        (n, True),                                                     # Step 0 冒頭の ňň = ň
        (R1, False),                                                   # def_check_R_factor
    ]


def case_zero_chain(n):
    Id = body_identity(n.base_ring(), n.nrows())
    R0 = body_difference(Id, n)                                        # def_check_R_factor の R^{(0)}
    O = matrix(n.base_ring(), n.nrows(), n.ncols(), 0)
    return [
        (body_product(n, R0), False),
        (body_product(n, body_difference(Id, n)), False),              # def_check_R_factor
        (O, True),                                                     # 途中の 7 行（上の二つの検算）。冪等性を使う
    ]


def check_chain(lines, label, expect_all):
    global count
    for (A, _), (B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, label
            count += 1


count = 0
for (tag, M, F, ns) in number_operator_settings():
    for n in ns:
        assert n ^ 2 == n                                              # (3) の仮定
        check_chain(case_one_chain(n), ("R1", tag), True)
        check_chain(case_zero_chain(n), ("R0", tag), True)

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

print("PASS check_joint_eigenspace_decomposition Step 3 の ň_νR_ν^{(1)}・ň_νR_ν^{(0)} の鎖: %d 段、否定コントロール %d 行" % (count, neg_control))
