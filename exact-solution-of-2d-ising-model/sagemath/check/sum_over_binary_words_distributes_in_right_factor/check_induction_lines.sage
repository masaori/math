# 対象ラベル: sum_over_binary_words_distributes_in_right_factor（C (Σ_{ε∈{0,1}^r} X_ε) = Σ_{ε∈{0,1}^r} C X_ε）
# 証明の帰納法の各行:
#   r = 1:   C (Σ_{ε∈{0,1}^1} X_ε) = C (X_(1) + X_(0))                       (def_sum_over_binary_words)
#                                   = C X_(1) + C X_(0)                        (mat_mult_distributes_over_sum_in_right_factor)
#                                   = Σ_{ε∈{0,1}^1} C X_ε                      (def_sum_over_binary_words を右辺から左辺へ)
#   r → r+1: C (Σ_{ε∈{0,1}^{r+1}} X_ε) = C (Σ_{ε'} (X_(ε',1) + X_(ε',0)))    (def_sum_over_binary_words)
#                                   = Σ_{ε'} C (X_(ε',1) + X_(ε',0))           (帰納法の仮定)
#                                   = Σ_{ε'} (C X_(ε',1) + C X_(ε',0))         (mat_mult_distributes_over_sum_in_right_factor を各項へ)
#                                   = Σ_{ε∈{0,1}^{r+1}} C X_ε                  (def_sum_over_binary_words を右辺から左辺へ)
# {0,1}^r の元は長さ r のタプル、(ε', e) は ε' の末尾に e を付けたタプルで表す。和は def_sum_over_binary_words の帰納法どおりに組む。
# 行列の和と積は本文の成分の式（_shared の body_sum・body_product）で組む。
# 帰属: QQ 上の多項式環（C・X_ε の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
import itertools


def words(r):
    return [tuple(w) for w in itertools.product([1, 0], repeat=r)]


def binary_word_sum(r, B):
    """def_sum_over_binary_words: B は {0,1}^r の元（タプル）から行列への写像。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


count = 0
for (m, n, p) in [(1, 1, 1), (2, 2, 2), (2, 3, 1), (1, 2, 3)]:
    for r in range(1, 4):
        W = words(r)
        P, _, mats = generic_ring([("C", m, n)] + [("X%d" % k, n, p) for k in range(len(W))])
        C = mats[0]
        X = {w: mats[k + 1] for k, w in enumerate(W)}
        Xf = lambda w: X[w]
        lhs = body_product(C, binary_word_sum(r, Xf))
        if r == 1:
            lines = [
                lhs,
                body_product(C, body_sum(X[(1,)], X[(0,)])),
                body_sum(body_product(C, X[(1,)]), body_product(C, X[(0,)])),
                binary_word_sum(1, lambda w: body_product(C, X[w])),
            ]
        else:
            Y = lambda ep: body_sum(X[ep + (1,)], X[ep + (0,)])
            lines = [
                lhs,
                body_product(C, binary_word_sum(r - 1, Y)),
                binary_word_sum(r - 1, lambda ep: body_product(C, Y(ep))),
                binary_word_sum(r - 1, lambda ep: body_sum(body_product(C, X[ep + (1,)]), body_product(C, X[ep + (0,)]))),
                binary_word_sum(r, lambda w: body_product(C, X[w])),
            ]
            # 帰納法の仮定（r - 1 での主張を族 Y に当てたもの）
            assert body_product(C, binary_word_sum(r - 1, Y)) == binary_word_sum(r - 1, lambda ep: body_product(C, Y(ep)))
        for A, B in zip(lines, lines[1:]):
            assert A == B, (m, n, p, r)
            count += 1
        # 独立な経路: Sage の和と積で、全ての語の和に左から C を掛けたもの
        assert lhs == C * sum(X[w] for w in W)
# 対照: 左から掛ける行列を項ごとに変えると一般には一致しない
P, _, (C, D, X1, X0) = generic_ring([("C", 2, 2), ("D", 2, 2), ("X1", 2, 2), ("X0", 2, 2)])
assert body_product(C, body_sum(X1, X0)) != body_sum(body_product(C, X1), body_product(D, X0))
print(f"checked {count} lines")
print("RESULT: PASS")
