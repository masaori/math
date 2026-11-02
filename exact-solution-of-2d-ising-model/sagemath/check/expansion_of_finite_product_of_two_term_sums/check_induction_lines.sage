# 対象ラベル: expansion_of_finite_product_of_two_term_sums（∏_{j=1}^r (A_j^(1) + A_j^(0)) = Σ_{ε∈{0,1}^r} ∏_{j=1}^r A_j^(ε_j)）
# 証明の帰納法の各行:
#   r = 1:   ∏_{j=1}^1 (A_j^(1) + A_j^(0)) = A_1^(1) + A_1^(0)                   (def_finite_product_of_matrices)
#                                       = A_1^((1)_1) + A_1^((0)_1)              ((1)_1 = 1, (0)_1 = 0)
#                                       = ∏_{j=1}^1 A_j^((1)_j) + ∏_{j=1}^1 A_j^((0)_j)  (def_finite_product_of_matrices を右辺から左辺へ)
#                                       = Σ_{ε∈{0,1}^1} ∏_{j=1}^1 A_j^(ε_j)      (def_sum_over_binary_words を右辺から左辺へ)
#   r → r+1: 7 行（def_finite_product_of_matrices、帰納法の仮定、sum_over_binary_words_distributes_in_left_factor、
#            mat_mult_distributes_over_sum_in_right_factor を各項へ、(ε',e)_j の定義を各項へ、def_finite_product_of_matrices を
#            右辺から左辺へ、def_sum_over_binary_words を右辺から左辺へ）
# 有限積は def_finite_product_of_matrices どおり A_1 から左へ掛け（空の積は使わない）、{0,1}^r の上の和は def_sum_over_binary_words の
# 帰納法どおりに組む。(ε', e) は ε' の末尾に e を付けたタプル。
# 帰属: QQ 上の多項式環（A_j^(e) の成分は不定元。n = 1, 2、r = 1, 2, 3）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")


def finite_product(mats):
    acc = mats[0]                                   # ∏_{j=1}^{1} A_j := A_1
    for A in mats[1:]:
        acc = body_product(acc, A)                  # ∏_{j=1}^{r+1} A_j := (∏_{j=1}^{r} A_j) A_{r+1}
    return acc


def binary_word_sum(r, B):
    """def_sum_over_binary_words: B は {0,1}^r の元（タプル）から行列への写像。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


count = 0
for n in [1, 2]:
    for r in range(1, 4):
        P, _, mats = generic_ring([("A%d_%d" % (j, e), n, n) for j in range(1, r + 1) for e in (1, 0)])
        A = {(j, e): mats[2 * (j - 1) + (0 if e == 1 else 1)] for j in range(1, r + 1) for e in (1, 0)}
        prod_word = lambda w, rr: finite_product([A[(j, w[j - 1])] for j in range(1, rr + 1)])
        lhs = finite_product([body_sum(A[(j, 1)], A[(j, 0)]) for j in range(1, r + 1)])
        rhs = binary_word_sum(r, lambda w: prod_word(w, r))
        if r == 1:
            lines = [
                lhs,
                body_sum(A[(1, 1)], A[(1, 0)]),
                body_sum(A[(1, (1,)[0])], A[(1, (0,)[0])]),
                body_sum(prod_word((1,), 1), prod_word((0,), 1)),
                rhs,
            ]
        else:
            Pw = lambda ep: prod_word(ep, r - 1)
            last = body_sum(A[(r, 1)], A[(r, 0)])
            lines = [
                lhs,
                body_product(finite_product([body_sum(A[(j, 1)], A[(j, 0)]) for j in range(1, r)]), last),
                body_product(binary_word_sum(r - 1, Pw), last),
                binary_word_sum(r - 1, lambda ep: body_product(Pw(ep), last)),
                binary_word_sum(r - 1, lambda ep: body_sum(body_product(Pw(ep), A[(r, 1)]), body_product(Pw(ep), A[(r, 0)]))),
                binary_word_sum(r - 1, lambda ep: body_sum(
                    body_product(finite_product([A[(j, (ep + (1,))[j - 1])] for j in range(1, r)]), A[(r, (ep + (1,))[r - 1])]),
                    body_product(finite_product([A[(j, (ep + (0,))[j - 1])] for j in range(1, r)]), A[(r, (ep + (0,))[r - 1])]))),
                binary_word_sum(r - 1, lambda ep: body_sum(prod_word(ep + (1,), r), prod_word(ep + (0,), r))),
                rhs,
            ]
        for X, Y in zip(lines, lines[1:]):
            assert X == Y, (n, r)
            count += 1
        # 独立な経路: Sage の積と和で、全ての語について積を足したもの
        import itertools
        assert lhs == sum(prod([A[(j, w[j - 1])] for j in range(1, r + 1)]) for w in itertools.product([1, 0], repeat=r))
# 対照: 一つの語の項を落とすと一致しない（n = 2, r = 2）
P, _, mats = generic_ring([("B%d_%d" % (j, e), 2, 2) for j in (1, 2) for e in (1, 0)])
B = {(1, 1): mats[0], (1, 0): mats[1], (2, 1): mats[2], (2, 0): mats[3]}
full = finite_product([body_sum(B[(1, 1)], B[(1, 0)]), body_sum(B[(2, 1)], B[(2, 0)])])
partial = body_sum(body_sum(finite_product([B[(1, 1)], B[(2, 1)]]), finite_product([B[(1, 1)], B[(2, 0)]])), finite_product([B[(1, 0)], B[(2, 1)]]))
assert full != partial
print(f"checked {count} lines")
print("RESULT: PASS")
