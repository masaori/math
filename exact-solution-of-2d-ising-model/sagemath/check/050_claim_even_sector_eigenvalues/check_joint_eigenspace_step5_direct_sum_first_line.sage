# 対象ラベル: check_joint_eigenspace_decomposition
# Step 5 の直和の鎖の 1 行目と、その根拠の二つの鎖を、M = 2, 3, 4 の全ての ε・ε' で一行ずつ厳密に確かめる。
#   ε ≠ ε': Q̌_{ε'}y_ε = Q̌_{ε'}(Q̌_ε x_ε)      （x_ε の取り方 y_ε = Q̌_ε x_ε）
#                     = (Q̌_{ε'}Q̌_ε)x_ε      （mat_mult_associative（q → 1）を右辺から左辺へ）
#                     = O_{2^M,2^M} x_ε      （Step 1 の (1)）
#                     = O_{2^M,1}            （zero_matrix_is_left_zero_of_mat_mult（p → 1））
#   Q̌_{ε'}y_{ε'} = Q̌_{ε'}(Q̌_{ε'}x_{ε'}) = (Q̌_{ε'}Q̌_{ε'})x_{ε'} = Q̌_{ε'}x_{ε'} = y_{ε'}
#   y_{ε'} = Q̌_{ε'}y_{ε'}                     （Q̌_{ε'}y_{ε'} の鎖を右辺から左辺へ）
#          = Σ_ε Q̌_{ε'}y_ε                    （sum_over_binary_words_with_one_nonzero_term を右辺から左辺へ。前提は ε ≠ ε' の Q̌_{ε'}y_ε の鎖）
# また Step 5 の全体を張る段の Q̌_ε x ∈ im Q̌_ε は im の定義そのもの（x を取れば Q̌_ε x の形）なので検算の対象にしない。
# 数ベクトルは 2^M 行 1 列の行列、ε で添字付けた和は def_sum_over_binary_words（最後の成分で 1 を 0 より先に足す帰納法）、
# 積は mat_mult の成分の式（_shared の body_product）で組む。x_ε の成分は不定元。
# ň_μ は check_24・check_30〜check_36 と同じく Jordan–Wigner のフェルミ演算子 c_μ から作る n_μ := c_μ^T c_μ。
# 否定コントロール: R^{(0)}_μ を単位行列に替えた族では、ε ≠ ε' の鎖の 3 行目（Q̌_{ε'}Q̌_ε = O）が外れる。
# 帰属: 成分は QQ と QQ 上の多項式環（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
import itertools


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def finite_product(mats):
    acc = mats[0]
    for A in mats[1:]:
        acc = body_product(acc, A)
    return acc


def binary_word_sum(r, B):
    """def_sum_over_binary_words: B は {0,1}^r の元（タプル）から行列への写像。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


count = 0
neg = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    N = 2 ^ M
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    ns = [c[mu].transpose() * c[mu] for mu in range(M)]
    Id = body_identity(QQ, N)
    R1 = ns
    R0 = [body_difference(Id, n) for n in ns]
    W = [tuple(w) for w in itertools.product([1, 0], repeat=M)]
    P, _, xs = generic_ring([("x%d" % k, N, 1) for k in range(len(W))])
    X = {w: xs[k] for k, w in enumerate(W)}
    Qs = {w: finite_product([R1[mu] if w[mu] == 1 else R0[mu] for mu in range(M)]).change_ring(P) for w in W}
    Y = {w: body_product(Qs[w], X[w]) for w in W}                          # y_ε := Q̌_ε x_ε
    Onn = matrix(P, N, N, 0)
    On1 = matrix(P, N, 1, 0)
    for wp in W:
        for w in W:
            if w == wp:
                continue
            lines = [
                body_product(Qs[wp], Y[w]),
                body_product(Qs[wp], body_product(Qs[w], X[w])),
                body_product(body_product(Qs[wp], Qs[w]), X[w]),
                body_product(Onn, X[w]),
                On1,
            ]
            assert body_product(Qs[wp], Qs[w]) == Onn                      # Step 1 の (1)
            for a, b in zip(lines, lines[1:]):
                assert a == b, ("orth", M, wp, w)
                count += 1
        lines = [
            body_product(Qs[wp], Y[wp]),
            body_product(Qs[wp], body_product(Qs[wp], X[wp])),
            body_product(body_product(Qs[wp], Qs[wp]), X[wp]),
            body_product(Qs[wp], X[wp]),
            Y[wp],
        ]
        for a, b in zip(lines, lines[1:]):
            assert a == b, ("idem", M, wp)
            count += 1
        lines = [Y[wp], body_product(Qs[wp], Y[wp]), binary_word_sum(M, lambda w: body_product(Qs[wp], Y[w]))]
        for a, b in zip(lines, lines[1:]):
            assert a == b, ("first-line", M, wp)
            count += 1
    # 否定コントロール: R^{(0)}_μ を I に替えた族では、ε = (1,…,1)・ε' = (0,…,0) の ε ≠ ε' の鎖の 3 行目（Q̌_{ε'}Q̌_ε = O）が外れる
    badQ = {w: finite_product([R1[mu] if w[mu] == 1 else Id for mu in range(M)]) for w in W}
    ones, zeros = tuple([1] * M), tuple([0] * M)
    assert body_product(badQ[zeros], badQ[ones]) != matrix(QQ, N, N, 0)
    neg += 1

print("PASS check_joint_eigenspace_decomposition Step 5 の直和の鎖の 1 行目と前提の鎖: %d 段、否定コントロール %d 行" % (count, neg))
print("RESULT: PASS")
