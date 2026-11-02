# 対象ラベル: check_number_operator_idempotent
# (1) の 2 本の鎖 ψ̌_μ^†ψ̌_μ^† + ψ̌_μ^†ψ̌_μ^† = [ψ̌_μ^†, ψ̌_μ^†]_+ = O（ψ̌_{M+1-μ} も同じ）と
# matrix_sum_with_itself_zero_implies_zero による ψ̌ψ̌ = O、
# (2) の鎖 ψ̌_μ^†ψ̌_{M+1-μ} + ψ̌_{M+1-μ}ψ̌_μ^† = [ψ̌_μ^†, ψ̌_{M+1-μ}]_+ = δ I = 1_C I = I と、
# matrix_summand_from_sum_equation による ψ̌_{M+1-μ}ψ̌_μ^† = I - ψ̌_μ^†ψ̌_{M+1-μ} = I - ň_μ を一行ずつ確かめる（M = 2, 3, 4）。
#   D_μ := ψ̌_μ^†、P_μ := ψ̌_{M+1-μ}、n_μ := D_μ P_μ（def_check_number_operator）。
# 反交換関係を満たす具体的な行列として Jordan–Wigner のフェルミ演算子 c_μ を取り、D_μ := c_μ^T、P_μ := c_μ とする（check_23 と同じ）。
# 否定コントロール: 不定元の成分の行列では、反交換関係を使う行だけが等号を外れることを確かめる。
# 「XX+XX = [X,X]_+」「DP+PD = [D,P]_+」の行は反交換子の定義を写した比較なので、構成上かならず一致する（本文の写し間違いだけを検出する）。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。

def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def anticomm(X, W):
    # def_matrix_anticommutator
    return X * W + W * X


def sub(A, B):
    # def_matrix_difference
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: A[r, c] - B[r, c])


def chain_1(X, Id):
    O = 0 * Id
    return [
        ("XX+XX", X * X + X * X, False),
        ("[X,X]_+", anticomm(X, X), False),       # def_matrix_anticommutator を右辺から左辺へ
        ("O", O, True),                           # anticommutator_of_check_psi の第 1 式・第 3 式
    ]


def kronecker_delta(i, j):
    # def_kronecker_delta
    return 1 if i == j else 0


def chain_2(D, P, Id, paired_index):
    delta = kronecker_delta(paired_index, paired_index)   # δ_{M+1-μ, M+1-μ} を添字から計算する
    return [
        ("DP+PD", D * P + P * D, False),
        ("[D,P]_+", anticomm(D, P), False),       # def_matrix_anticommutator を右辺から左辺へ
        ("δI", delta * Id, True),                 # anticommutator_of_check_psi の第 2 式
        ("1I", 1 * Id, False),                    # def_kronecker_delta（i = j の場合の値 1）
        ("I", Id, False),                         # scalar_multiple_by_one
    ]


def chain_2b(D, P, Id):
    n = D * P
    return [
        ("PD", P * D, False),
        ("I-DP", sub(Id, D * P), True),           # matrix_summand_from_sum_equation と直前の鎖
        ("I-n", sub(Id, n), False),               # def_check_number_operator
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
    for mu in range(M):
        for X in (D[mu], P[mu]):
            check_chain(chain_1(X, Id), ("(1)", M, mu), True)
            # matrix_sum_with_itself_zero_implies_zero（X → XX）
            assert X * X == 0 * Id
        check_chain(chain_2(D[mu], P[mu], Id, M + 1 - (mu + 1)), ("(2)", M, mu), True)
        # matrix_summand_from_sum_equation の仮定 A + B = C（A → DP, B → PD, C → I）
        assert D[mu] * P[mu] + P[mu] * D[mu] == Id
        check_chain(chain_2b(D[mu], P[mu], Id), ("(2b)", M, mu), True)

# 否定コントロール: 不定元の成分の 2×2 行列（反交換関係を満たさない）
R = PolynomialRing(QQ, ["x%d" % k for k in range(8)])
xs = R.gens()
X = matrix(R, 2, 2, xs[0:4])
Y = matrix(R, 2, 2, xs[4:8])
IdR = identity_matrix(R, 2)
neg_control = 0
for lines, label in [(chain_1(X, IdR), "(1)"), (chain_2(X, Y, IdR, 1), "(2)"), (chain_2b(X, Y, IdR), "(2b)")]:
    check_chain(lines, ("generic", label), False)
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("反交換関係を使う行が仮定なしで成り立ってしまう", label, a, b)
            neg_control += 1

print("PASS check_number_operator_idempotent (1)・(2) の反交換子の鎖: %d 段、否定コントロール %d 行" % (count, neg_control))
