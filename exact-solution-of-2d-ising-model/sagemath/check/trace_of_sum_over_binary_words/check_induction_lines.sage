# 対象ラベル: trace_of_sum_over_binary_words（tr(Σ_{ε∈{0,1}^r} B_ε) = Σ_{ε∈{0,1}^r} tr(B_ε)）
# 証明の各行:
#   準備:    tr(A + B) = tr(1_C A + 1_C B)                                  (scalar_multiple_by_one を二つの項へ、右辺から左辺へ)
#                      = 1_C tr(A) + 1_C tr(B)                               (trace_basic_properties (1)、α, β → 1_C)
#                      = tr(A) + tr(B)                                       (1_C は乗法の単位元)
#   r = 1:   tr(Σ_{ε∈{0,1}^1} B_ε) = tr(B_(1) + B_(0))                      (def_sum_over_binary_words)
#                                   = tr(B_(1)) + tr(B_(0))                  (準備の鎖)
#                                   = Σ_{ε∈{0,1}^1} tr(B_ε)                  (def_sum_over_binary_words_of_complex_numbers を右辺から左辺へ)
#   r → r+1: tr(Σ_{ε∈{0,1}^{r+1}} B_ε) = tr(Σ_{ε'} (B_(ε',1) + B_(ε',0)))   (def_sum_over_binary_words)
#                                   = Σ_{ε'} tr(B_(ε',1) + B_(ε',0))         (帰納法の仮定)
#                                   = Σ_{ε'} (tr B_(ε',1) + tr B_(ε',0))     (準備の鎖を各項へ)
#                                   = Σ_{ε∈{0,1}^{r+1}} tr(B_ε)              (def_sum_over_binary_words_of_complex_numbers を右辺から左辺へ)
# {0,1}^r の元は長さ r のタプル、(ε', e) は ε' の末尾に e を付けたタプルで表す。
# 行列の和は本文の成分の式（_shared の body_sum）、スカラー倍は body_scalar、トレースは def_trace の対角成分の和で組む。
# 行列の和と複素数の和は、どちらも定義の帰納法どおりに（最後の成分で 1 を 0 より先に）足す別々の関数で組む。
# 帰属: QQ 上の多項式環（B_ε の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。浮動小数点はない。
load("../../_shared/matrix_operations_by_definition.sage")
import itertools


def words(r):
    return [tuple(w) for w in itertools.product([1, 0], repeat=r)]


def tr(A):
    """def_trace: 対角成分を k = 1, …, n の順に足す。"""
    total = A[0, 0]
    for k in range(1, A.nrows()):
        total = total + A[k, k]
    return total


def binary_word_matrix_sum(r, B):
    """def_sum_over_binary_words。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_matrix_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


def binary_word_complex_sum(r, z):
    """def_sum_over_binary_words_of_complex_numbers。"""
    if r == 1:
        return z((1,)) + z((0,))
    return binary_word_complex_sum(r - 1, lambda ep: z(ep + (1,)) + z(ep + (0,)))


count = 0
# 準備の鎖
for n in range(1, 5):
    P, _, (A, B) = generic_ring([("A", n, n), ("B", n, n)])
    one = P(1)
    lines = [
        tr(body_sum(A, B)),
        tr(body_sum(body_scalar(one, A), body_scalar(one, B))),
        one * tr(A) + one * tr(B),
        tr(A) + tr(B),
    ]
    for a, b in zip(lines, lines[1:]):
        assert a == b, n
        count += 1
    assert lines[0] == (A + B).trace()   # 独立な経路: Sage の和とトレース

# 帰納法の二つの鎖
for n in range(1, 4):
    for r in range(1, 4):
        W = words(r)
        P, _, mats = generic_ring([("B%d" % k, n, n) for k in range(len(W))])
        Bm = {w: mats[k] for k, w in enumerate(W)}
        lhs = tr(binary_word_matrix_sum(r, lambda w: Bm[w]))
        if r == 1:
            lines = [
                lhs,
                tr(body_sum(Bm[(1,)], Bm[(0,)])),
                tr(Bm[(1,)]) + tr(Bm[(0,)]),
                binary_word_complex_sum(1, lambda w: tr(Bm[w])),
            ]
        else:
            Y = lambda ep: body_sum(Bm[ep + (1,)], Bm[ep + (0,)])
            lines = [
                lhs,
                tr(binary_word_matrix_sum(r - 1, Y)),
                binary_word_complex_sum(r - 1, lambda ep: tr(Y(ep))),
                binary_word_complex_sum(r - 1, lambda ep: tr(Bm[ep + (1,)]) + tr(Bm[ep + (0,)])),
                binary_word_complex_sum(r, lambda w: tr(Bm[w])),
            ]
            # 帰納法の仮定（r - 1 での主張を族 Y に当てたもの）
            assert tr(binary_word_matrix_sum(r - 1, Y)) == binary_word_complex_sum(r - 1, lambda ep: tr(Y(ep)))
        for a, b in zip(lines, lines[1:]):
            assert a == b, (n, r)
            count += 1
        # 独立な経路: Sage の和とトレースで、全ての語の和のトレース
        assert lhs == sum(Bm[w] for w in W).trace()
        assert lines[-1] == sum(Bm[w].trace() for w in W)

# 対照: 和の一つの項を落とすと一致しない（右辺の和が全ての語を数えていることの確認）
P, _, mats = generic_ring([("B%d" % k, 2, 2) for k in range(4)])
W = words(2)
Bm = {w: mats[k] for k, w in enumerate(W)}
assert tr(binary_word_matrix_sum(2, lambda w: Bm[w])) != sum(tr(Bm[w]) for w in W[:-1])
print(f"checked {count} lines")
print("RESULT: PASS")
