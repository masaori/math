# 対象ラベル: check_joint_eigenspace_decomposition
# check_joint_eigenspace_decomposition の Step 0 の R^{(1)}R^{(0)} = 0（7 行）・R^{(0)}R^{(1)} = 0（7 行）・
# R^{(0)}R^{(0)} = R^{(0)}（8 行）と、Step 3 の ε_ν = 0 の場合の ň_ν R_ν^{(0)} = 0（R^{(1)}R^{(0)} と同じ 7 行）を、
# 括弧どおりに一行ずつ厳密に確かめる（M = 2, 3, 4）。
#   R^{(1)} := n、R^{(0)} := I - n、n := ň_μ。
# 鎖が使う仮定は check_number_operator_idempotent (3) の nn = n だけなので、それを満たす具体的な行列として
# Jordan–Wigner のフェルミ演算子 c_μ から作る n_μ := c_μ^T c_μ を取る。
# 否定コントロール: 冪等でない不定元の成分の行列では、冪等性（と、それから出る R^{(1)}R^{(0)} = 0）を使う行だけが
# 等号を外れ、差の書き換え・分配・単位行列・符号の外出し・零行列を引く行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。

def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def neg(A):
    # def_matrix_negation
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: (-1) * A[r, c])


def sub(A, B):
    # def_matrix_difference
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: A[r, c] - B[r, c])


def r1r0_chain(n, Id):
    # Step 0 の R^{(1)}R^{(0)} と、Step 3 の ň_ν R_ν^{(0)}（同じ行）
    O = 0 * Id
    return [
        ("n(I-n)", n * sub(Id, n), False),
        ("n(I+(-n))", n * (Id + neg(n)), False),          # matrix_difference_is_sum_with_negation
        ("nI+n(-n)", n * Id + n * neg(n), False),         # mat_mult_distributes_over_sum_in_right_factor
        ("n+n(-n)", n + n * neg(n), False),               # identity_matrix_is_right_unit_of_mat_mult
        ("n+(-(nn))", n + neg(n * n), False),             # negation_factors_out_of_right_factor
        ("n-nn", sub(n, n * n), False),                   # matrix_difference_is_sum_with_negation を右辺から左辺へ
        ("n-n", sub(n, n), True),                         # 冪等性 (3)
        ("0", O, False),                                  # 行列の加法逆元
    ]


def r0r1_chain(n, Id):
    O = 0 * Id
    return [
        ("(I-n)n", sub(Id, n) * n, False),
        ("(I+(-n))n", (Id + neg(n)) * n, False),          # matrix_difference_is_sum_with_negation
        ("In+(-n)n", Id * n + neg(n) * n, False),         # mat_mult_distributes_over_sum_in_left_factor
        ("n+(-n)n", n + neg(n) * n, False),               # identity_matrix_is_left_unit_of_mat_mult
        ("n+(-(nn))", n + neg(n * n), False),             # negation_factors_out_of_left_factor
        ("n-nn", sub(n, n * n), False),                   # matrix_difference_is_sum_with_negation を右辺から左辺へ
        ("n-n", sub(n, n), True),                         # 冪等性 (3)
        ("0", O, False),                                  # 行列の加法逆元
    ]


def r0r0_chain(n, Id):
    O = 0 * Id
    R0 = sub(Id, n)
    return [
        ("(I-n)(I-n)", R0 * R0, False),
        ("(I+(-n))(I-n)", (Id + neg(n)) * R0, False),     # matrix_difference_is_sum_with_negation（左の因子）
        ("I(I-n)+(-n)(I-n)", Id * R0 + neg(n) * R0, False),  # mat_mult_distributes_over_sum_in_left_factor
        ("(I-n)+(-n)(I-n)", R0 + neg(n) * R0, False),     # identity_matrix_is_left_unit_of_mat_mult
        ("(I-n)+(-(n(I-n)))", R0 + neg(n * R0), False),   # negation_factors_out_of_left_factor
        ("(I-n)-n(I-n)", sub(R0, n * R0), False),         # matrix_difference_is_sum_with_negation を右辺から左辺へ
        ("(I-n)-0", sub(R0, O), True),                    # 上の R^{(1)}R^{(0)} = 0
        ("I-n", sub(Id, n), False),                       # matrix_minus_zero_matrix
        ("R^{(0)}", R0, False),                           # R^{(0)} の定義
    ]


def check_chain(lines, label, expect_all):
    global count
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, (label, a, b)
            count += 1


count = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    Id = kron([id2] * M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    for mu in range(M):
        n = c[mu].transpose() * c[mu]
        assert n * n == n and n != 0 * Id and n != Id
        for chain in (r1r0_chain, r0r1_chain, r0r0_chain):
            check_chain(chain(n, Id), (chain.__name__, M, mu), True)

# 否定コントロール: 不定元の成分の 2×2 行列（冪等でない）
R = PolynomialRing(QQ, ["x%d" % k for k in range(4)])
X = matrix(R, 2, 2, R.gens())
IdR = identity_matrix(R, 2)
neg_control = 0
for chain in (r1r0_chain, r0r1_chain, r0r0_chain):
    lines = chain(X, IdR)
    check_chain(lines, ("generic", chain.__name__), False)
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("仮定を使う行が仮定なしで成り立ってしまう", chain.__name__, a, b)
            neg_control += 1

print("PASS check_joint_eigenspace_decomposition Step 0・Step 3 の分配と単位行列の鎖: %d 段、否定コントロール %d 行" % (count, neg_control))
