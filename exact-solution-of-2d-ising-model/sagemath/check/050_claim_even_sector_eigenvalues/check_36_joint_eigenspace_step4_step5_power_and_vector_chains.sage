# 対象ラベル: check_joint_eigenspace_decomposition
# Step 4 の tr(Q̌_ε) の鎖と、Step 5 の二つの鎖を、M = 2, 3, 4 の全ての ε・ε' で一行ずつ厳密に確かめる。
#   Step 4: tr(Q̌_ε) = 2^{M−M}            （trace_of_check_number_operator_product を k = M で）
#                   = 2^0                 （M − M = 0）
#                   = 1                   （def_power_of_complex_number の z^0 := 1_ℂ）
#   Step 5（全体を張る）: x = Ix          （identity_matrix_is_left_unit_of_mat_mult（n → 1）を右辺から左辺へ）
#                          = (Σ_ε Q̌_ε)x   （Step 2 の (2) を右辺から左辺へ）
#                          = Σ_ε Q̌_ε x    （sum_over_binary_words_distributes_in_left_factor（p → 1））
#   Step 5（直和）: y_{ε'} = Σ_ε Q̌_{ε'}y_ε   （Step 1 の直交性と冪等性。y_ε = Q̌_ε x_ε で確かめる）
#                          = Q̌_{ε'}(Σ_ε y_ε)  （sum_over_binary_words_distributes_in_right_factor（p → 1）を右辺から左辺へ）
#                          = Q̌_{ε'}O_{2^M,1}  （Σ_ε y_ε = O の仮定）
#                          = O_{2^M,1}        （zero_matrix_is_right_zero_of_mat_mult（p → 1））
# 数ベクトルは 2^M 行 1 列の行列、ε で添字付けた和は def_sum_over_binary_words（最後の成分で 1 を 0 より先に足す帰納法）、
# 冪は def_power_of_complex_number（z^0 := 1、z^{m+1} := z^m z）どおりに組む。
# 直和の鎖の 2 行目の等号は Σ_ε y_ε = O を使わないので、一般の y_ε（不定元の成分）で確かめる。3・4 行目は仮定 Σ_ε y_ε = O の下の行なので、
# 零ベクトルを代入して確かめる（Q̌_ε が直和を与えるので、像の元で Σ_ε y_ε = O となるのは全て零の族だけである）。
# ň_μ は check_24・check_30〜check_35 と同じく Jordan–Wigner のフェルミ演算子 c_μ から作る n_μ := c_μ^T c_μ。
# 否定コントロール: Q̌_ε を ň_μ だけの積（R^{(0)} を使わない）に替えると、Step 5 の (Σ Q̌)x の行が外れる。
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


def power(z, m):
    """def_power_of_complex_number: z^0 := 1、z^{m+1} := z^m z。"""
    acc = z.parent()(1)
    for _ in range(m):
        acc = acc * z
    return acc


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
    Q = lambda eps: finite_product([R1[mu] if eps[mu] == 1 else R0[mu] for mu in range(M)])
    W = [tuple(w) for w in itertools.product([1, 0], repeat=M)]
    Qs = {w: Q(w) for w in W}
    two = QQ(2)
    # Step 4
    for w in W:
        lines = [Qs[w].trace(), power(two, M - M), power(two, 0), QQ(1)]
        for a, b in zip(lines, lines[1:]):
            assert a == b, ("step4", M, w)
            count += 1
    # Step 5（全体を張る）: x の成分は不定元
    P, _, (x,) = generic_ring([("x", N, 1)])
    QsP = {w: Qs[w].change_ring(P) for w in W}
    IdP = body_identity(P, N)
    lines = [
        x,
        body_product(IdP, x),
        body_product(binary_word_sum(M, lambda w: QsP[w]), x),
        binary_word_sum(M, lambda w: body_product(QsP[w], x)),
    ]
    for a, b in zip(lines, lines[1:]):
        assert a == b, ("step5-span", M)
        count += 1
    # Step 5（直和）: 2 行目は一般の y_ε で、1 行目は y_ε = Q̌_ε x_ε で、3・4 行目は零ベクトルで
    P2, _, ys = generic_ring([("y%d" % k, N, 1) for k in range(len(W))])
    Y = {w: ys[k] for k, w in enumerate(W)}
    QsP2 = {w: Qs[w].change_ring(P2) for w in W}
    for wp in W:
        a = binary_word_sum(M, lambda w: body_product(QsP2[wp], Y[w]))
        b = body_product(QsP2[wp], binary_word_sum(M, lambda w: Y[w]))
        assert a == b, ("step5-direct-line2", M, wp)
        count += 1
        YQ = {w: body_product(QsP2[w], Y[w]) for w in W}                     # y_ε := Q̌_ε x_ε（x_ε の成分は不定元）
        assert YQ[wp] == binary_word_sum(M, lambda w: body_product(QsP2[wp], YQ[w])), ("step5-direct-line1", M, wp)
        count += 1
        O = matrix(QQ, N, 1, 0)
        assert body_product(Qs[wp], O) == O, ("step5-direct-line4", M, wp)  # 3 行目は仮定の代入で、構成上一致する
        count += 1
    # 否定コントロール: R^{(0)} の代わりに R^{(1)} を使うと (Σ Q̌)x = x が外れる
    bad = binary_word_sum(M, lambda w: finite_product([R1[mu] for mu in range(M)]).change_ring(P))
    assert body_product(bad, x) != x
    neg += 1

print("PASS check_joint_eigenspace_decomposition Step 4 の冪・Step 5 の数ベクトルの鎖: %d 段、否定コントロール %d 行" % (count, neg))
print("RESULT: PASS")
