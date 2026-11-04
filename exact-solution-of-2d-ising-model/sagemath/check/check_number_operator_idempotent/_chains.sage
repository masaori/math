# 対象ラベル: check_number_operator_idempotent の検算が共有する、証明の鎖の組み立て。
# 証明の記号: D := ψ̌_μ^†、P := ψ̌_{M_col+1-μ}、n := DP（def_check_number_operator の ň_μ）。
# 各鎖は (名前, 値, 仮定の行か) の並びで、隣り合う行の値が等しいことが証明の一つの等号に当たる。
# 「仮定の行」は、その行への等号が反交換関係（anticommutator_of_check_psi）か、それから出した (1)(2) を引く行である。
# 行列の積・和は Sage の行列演算、差・符号反転は本文の定義どおりの成分の式（def_matrix_difference・def_matrix_negation）。
# 由来: 2026-11-04 まで 050_claim_even_sector_eigenvalues/ の check_28（chain_1・chain_2・chain_2b）と
#       check_23（idempotent_chain）がそれぞれのファイルの中で定めていたもの。中身は変えていない。

def kron_tensor(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def anticomm(X, W):
    # def_matrix_anticommutator
    return X * W + W * X


def neg(A):
    # def_matrix_negation
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: (-1) * A[r, c])


def sub(A, B):
    # def_matrix_difference
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: A[r, c] - B[r, c])


def kronecker_delta(i, j):
    # def_kronecker_delta
    return 1 if i == j else 0


def chain_1(X, Id):
    """(1) の鎖: XX + XX = [X, X]_+ = O（X ∈ {ψ̌_μ^†, ψ̌_{M_col+1-μ}}）。"""
    O = 0 * Id
    return [
        ("XX+XX", X * X + X * X, False),
        ("[X,X]_+", anticomm(X, X), False),       # def_matrix_anticommutator を右辺から左辺へ
        ("O", O, True),                           # anticommutator_of_check_psi の第 1 式・第 3 式
    ]


def chain_2(D, P, Id, paired_index):
    """(2) の第一の鎖: DP + PD = [D, P]_+ = δI = 1_C I = I。"""
    delta = kronecker_delta(paired_index, paired_index)   # δ_{M+1-μ, M+1-μ} を添字から計算する
    return [
        ("DP+PD", D * P + P * D, False),
        ("[D,P]_+", anticomm(D, P), False),       # def_matrix_anticommutator を右辺から左辺へ
        ("δI", delta * Id, True),                 # anticommutator_of_check_psi の第 2 式
        ("1I", 1 * Id, False),                    # def_kronecker_delta（i = j の場合の値 1）
        ("I", Id, False),                         # scalar_multiple_by_one
    ]


def chain_2b(D, P, Id):
    """(2) の第二の鎖: PD = I - DP = I - n。"""
    n = D * P
    return [
        ("PD", P * D, False),
        ("I-DP", sub(Id, D * P), True),           # matrix_summand_from_sum_equation と直前の鎖
        ("I-n", sub(Id, n), False),               # def_check_number_operator
    ]


def idempotent_chain(D, P, Id):
    """(3) の 24 行の鎖（23 個の等号。先頭 4 個は def_exp (1) の冪を積へ運ぶ）。"""
    n = D * P
    O = 0 * Id
    lines = [
        ("n^2", n ** 2, False),
        ("n^1 n", (n ** 1) * n, False),                    # def_exp (1) の A^{m+1} := A^m A（m → 1）
        ("(n^0 n) n", ((n ** 0) * n) * n, False),          # def_exp (1) の A^{m+1} := A^m A（m → 0）
        ("(I n) n", (Id * n) * n, False),                  # def_exp (1) の A^0 := I
        ("n n", n * n, False),                             # identity_matrix_is_left_unit_of_mat_mult
        ("(DP)(DP)", (D * P) * (D * P), False),
        ("D(P(DP))", D * (P * (D * P)), False),
        ("D((PD)P)", D * ((P * D) * P), False),
        ("D((I-n)P)", D * (sub(Id, n) * P), True),        # (2)
        ("D((I+(-n))P)", D * ((Id + neg(n)) * P), False),
        ("D(IP+(-n)P)", D * (Id * P + neg(n) * P), False),
        ("D(P+(-n)P)", D * (P + neg(n) * P), False),
        ("D(P+(-(nP)))", D * (P + neg(n * P)), False),
        ("DP+D(-(nP))", D * P + D * neg(n * P), False),
        ("DP+(-(D(nP)))", D * P + neg(D * (n * P)), False),
        ("DP-D(nP)", sub(D * P, D * (n * P)), False),
        ("n-D(nP)", sub(n, D * (n * P)), False),
        ("n-D((DP)P)", sub(n, D * ((D * P) * P)), False),
        ("n-D(D(PP))", sub(n, D * (D * (P * P))), False),
        ("n-(DD)(PP)", sub(n, (D * D) * (P * P)), False),
        ("n-O(PP)", sub(n, O * (P * P)), True),            # (1) の第 1 式
        ("n-O O", sub(n, O * O), False),                   # (1) の第 2 式（左因子が O なので仮定なしでも両辺とも O になり、否定コントロールの対象にしない）
        ("n-O", sub(n, O), False),                         # zero_matrix_is_left_zero_of_mat_mult（B → O）
        ("n", n, False),                                   # matrix_minus_zero_matrix
    ]
    return lines


chain_count = 0


def check_chain_lines(lines, label, expect_all):
    """隣り合う行の等号を確かめる。expect_all が偽なら仮定の行への等号は飛ばす（否定コントロール用）。"""
    global chain_count
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if expect_all or not hyp:
            assert A == B, (label, a, b)
            chain_count += 1


def jordan_wigner_model(M):
    """D_μ := c_μ^T、P_μ := c_μ（c_μ は Jordan–Wigner のフェルミ演算子。QQ の 2^M 次の行列）。"""
    sz = matrix(QQ, [[1, 0], [0, -1]])
    lower = matrix(QQ, [[0, 1], [0, 0]])
    id2 = identity_matrix(QQ, 2)
    Id = kron_tensor([id2] * M)
    c = [kron_tensor([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    return Id, [ck.transpose() for ck in c], c
