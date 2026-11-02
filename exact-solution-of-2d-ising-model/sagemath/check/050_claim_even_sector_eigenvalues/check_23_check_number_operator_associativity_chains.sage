# 対象ラベル: check_number_operator_idempotent, check_number_operators_commute
# check_number_operator_idempotent (3) の 23 行の鎖（先頭 4 行は def_exp (1) の冪を積へ運ぶ）、check_number_operators_commute Step 2 の 10 行の鎖と
# Step 3 の 7 行の鎖を、括弧どおりに一行ずつ厳密に確かめる（M = 2, 3, 4）。
#   D_μ := ψ̌_μ^†、P_μ := ψ̌_{M+1-μ}、n_μ := D_μ P_μ（def_check_number_operator）。
# 鎖が使う仮定は (1) D_μD_μ = O・P_μP_μ = O、(2) P_μD_μ = I - n_μ、Step 1 の AB = -(BA) だけなので、
# それを満たす具体的な行列として Jordan–Wigner のフェルミ演算子 c_μ を取り、D_μ := c_μ^T、P_μ := c_μ とする
# （D_μP_ν + P_νD_μ = δ_{μν}I は論文の ψ̌ の反交換関係を添字の付け替え μ ↦ M+1-μ で読んだものと同じ形）。
# 否定コントロール: 仮定を満たさない不定元の成分の行列では、仮定を使う行だけが等号を外れ、
# 結合律・分配律・単位行列・符号の外出し・二重の符号反転・差の書き換えの行は等号のまま残ることを確かめる。
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


def idempotent_chain(D, P, Id):
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


def commute_step2_chain(A, Dn, Pn):
    nn = Dn * Pn
    return [
        ("A n_ν", A * nn, False),
        ("A(D_νP_ν)", A * (Dn * Pn), False),
        ("(AD_ν)P_ν", (A * Dn) * Pn, False),
        ("(-(D_νA))P_ν", neg(Dn * A) * Pn, True),          # Step 1
        ("-((D_νA)P_ν)", neg((Dn * A) * Pn), False),
        ("-(D_ν(AP_ν))", neg(Dn * (A * Pn)), False),
        ("-(D_ν(-(P_νA)))", neg(Dn * neg(Pn * A)), True),  # Step 1
        ("-(-(D_ν(P_νA)))", neg(neg(Dn * (Pn * A))), False),
        ("D_ν(P_νA)", Dn * (Pn * A), False),
        ("(D_νP_ν)A", (Dn * Pn) * A, False),
        ("n_ν A", nn * A, False),
    ]


def commute_step3_chain(Dm, Pm, Dn, Pn):
    nm = Dm * Pm
    nn = Dn * Pn
    return [
        ("n_μ n_ν", nm * nn, False),
        ("(D_μP_μ)n_ν", (Dm * Pm) * nn, False),
        ("D_μ(P_μ n_ν)", Dm * (Pm * nn), False),
        ("D_μ(n_ν P_μ)", Dm * (nn * Pm), True),            # (1)
        ("(D_μ n_ν)P_μ", (Dm * nn) * Pm, False),
        ("(n_ν D_μ)P_μ", (nn * Dm) * Pm, True),            # (1)
        ("n_ν(D_μP_μ)", nn * (Dm * Pm), False),
        ("n_ν n_μ", nn * nm, False),
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
    D = [ck.transpose() for ck in c]
    P = c
    for i in range(M):
        for j in range(M):
            acomm = D[i] * P[j] + P[j] * D[i]
            assert acomm == (Id if i == j else 0 * Id)
            assert D[i] * D[j] + D[j] * D[i] == 0 * Id
            assert P[i] * P[j] + P[j] * P[i] == 0 * Id
    for mu in range(M):
        check_chain(idempotent_chain(D[mu], P[mu], Id), ("idem", M, mu), True)
        for nu in range(M):
            if nu == mu:
                continue
            for A in (D[mu], P[mu]):
                check_chain(commute_step2_chain(A, D[nu], P[nu]), ("step2", M, mu, nu), True)
            check_chain(commute_step3_chain(D[mu], P[mu], D[nu], P[nu]), ("step3", M, mu, nu), True)

# 否定コントロール: 不定元の成分の 2×2 行列（仮定を満たさない）
R = PolynomialRing(QQ, ["x%d" % k for k in range(16)])
xs = R.gens()
X = matrix(R, 2, 2, xs[0:4])
Y = matrix(R, 2, 2, xs[4:8])
Z = matrix(R, 2, 2, xs[8:12])
W = matrix(R, 2, 2, xs[12:16])
IdR = identity_matrix(R, 2)
neg_control = 0
for lines, label in [(idempotent_chain(X, Y, IdR), "idem"),
                     (commute_step2_chain(X, Y, Z), "step2"),
                     (commute_step3_chain(X, Y, Z, W), "step3")]:
    check_chain(lines, ("generic", label), False)
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("仮定を使う行が仮定なしで成り立ってしまう", label, a, b)
            neg_control += 1

print("PASS check_number_operator_idempotent (3)・check_number_operators_commute Step 2・Step 3 の鎖: %d 段、否定コントロール %d 行" % (count, neg_control))
