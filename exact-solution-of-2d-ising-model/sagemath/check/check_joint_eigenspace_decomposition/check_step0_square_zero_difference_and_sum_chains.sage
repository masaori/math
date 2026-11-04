# 対象ラベル: check_joint_eigenspace_decomposition
# Step 0 の冒頭の ň_μň_μ = ň_μ（5 行: 単位行列を左から足す → A^0 := I → A^{m+1} := A^m A（m → 0）→ 同（m → 1）→ (3)）、
# Step 0・Step 3 の ň − ň = O の行（matrix_difference_zero_iff_equal の ⟸。3 か所とも同じ行）、
# Step 0 の和 R^{(1)} + R^{(0)} = ň + (I − ň) = I（matrix_plus_difference_cancels）を、一行ずつ厳密に確かめる。
# 冪は def_exp (1) の A^0 := I、A^{m+1} := A^m A どおりに組む。行列の積・和・差・単位行列は本文の成分の式で組む。
# ň_μ は _number_operators.sage の number_operator_settings() から取る（既定は Jordan–Wigner の模型 M = 2, 3, 4、check_with_check_psi.sage からは本文の ψ̌）。
# 否定コントロール: 冪等でない不定元の成分の 2×2 行列では、冒頭の鎖のうち (3) を使う最後の行だけが等号を外れ、
# ň − ň = O と和の行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ か本文の ψ̌ の数体 F と、その上の多項式環（否定コントロールは QQ 上）（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("_number_operators.sage")


def body_pow(A, m):
    """def_exp (1) の A^0 := I、A^{m+1} := A^m A。"""
    out = body_identity(A.base_ring(), A.nrows())
    for _ in range(m):
        out = body_product(out, A)
    return out


def square_chain(n):
    Id = body_identity(n.base_ring(), n.nrows())
    return [
        (body_product(n, n), False),                                   # ň_μň_μ
        (body_product(body_product(Id, n), n), False),                 # identity_matrix_is_left_unit_of_mat_mult を右辺から左辺へ
        (body_product(body_product(body_pow(n, 0), n), n), False),     # def_exp (1) の A^0 := I を右辺から左辺へ
        (body_product(body_pow(n, 1), n), False),                      # def_exp (1)（m → 0）を右辺から左辺へ
        (body_pow(n, 2), False),                                       # def_exp (1)（m → 1）を右辺から左辺へ
        (n, True),                                                     # check_number_operator_idempotent (3)
    ]


def zero_line(n):
    O = matrix(n.base_ring(), n.nrows(), n.ncols(), 0)                 # def_zero_matrix
    return [(body_difference(n, n), False), (O, False)]                # matrix_difference_zero_iff_equal の ⟸


def sum_chain(n):
    Id = body_identity(n.base_ring(), n.nrows())
    R1, R0 = n, body_difference(Id, n)                                 # R^{(1)}, R^{(0)} の定義（冒頭）
    return [
        (body_sum(R1, R0), False),
        (body_sum(n, body_difference(Id, n)), False),                  # R^{(1)}, R^{(0)} の定義
        (Id, False),                                                   # matrix_plus_difference_cancels（A → ň、B → I）
    ]


def check_chain(lines, label, expect_all):
    global count
    for (A, _), (B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, label
            count += 1


count = 0
for (tag, M, F, ns) in number_operator_settings():
    for mu in range(M):
        n = ns[mu]
        assert n ^ 2 == n and n != 0 and n != identity_matrix(F, 2 ^ M)    # (3) の仮定（Sage 組み込みの冪と比べる）
        for chain in (square_chain, zero_line, sum_chain):
            check_chain(chain(n), (chain.__name__, tag, mu), True)

# 否定コントロール: 不定元の成分の 2×2 行列（冪等でない）
R = PolynomialRing(QQ, ["x%d" % k for k in range(4)])
X = matrix(R, 2, 2, R.gens())
neg_control = 0
for chain in (square_chain, zero_line, sum_chain):
    lines = chain(X)
    check_chain(lines, ("generic", chain.__name__), False)
    for (A, _), (B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("仮定を使う行が仮定なしで成り立ってしまう", chain.__name__)
            neg_control += 1
assert neg_control == 1

print("PASS check_joint_eigenspace_decomposition Step 0 の冒頭の積の形・差が零行列の行・和の鎖: %d 段、否定コントロール %d 行" % (count, neg_control))
