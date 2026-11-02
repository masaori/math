# 対象ラベル: matrix_summand_from_sum_equation（A + B = C ⇒ B = C - A）
# 成分の 8 行の鎖を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 仮定を満たす C := A + B（成分は不定元の和）で全行を確かめ、否定コントロールとして、
# 不定元の C では仮定を使う行（(A+B)_ik → C_ik）だけが等号を外れることを確かめる。
# 帰属: QQ 上の多項式環（成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")


def chain_of(A, B, C, i, k, P):
    AB = body_sum(A, B)
    CA = body_difference(C, A)
    a, b, c = A[i, k], B[i, k], C[i, k]
    return [
        (b, False),
        (P(0) + b, False),                                 # 加法の単位元
        ((body_neg_scalar(a) + a) + b, False),             # 加法の逆元
        (body_neg_scalar(a) + (a + b), False),             # 加法の結合律
        (body_neg_scalar(a) + AB[i, k], False),            # def_matrix_sum
        (body_neg_scalar(a) + c, True),                    # 仮定 A + B = C
        (c + body_neg_scalar(a), False),                   # 加法の交換律
        (c - a, False),                                    # def_complex_difference を右辺から左辺へ
        (CA[i, k], False),                                 # def_matrix_difference
    ]


count = 0
neg_control = 0
for m in [1, 2, 3]:
    for p in [1, 2, 3]:
        P, _, (A, B, Cfree) = generic_ring([("A", m, p), ("B", m, p), ("C", m, p)])
        C = body_sum(A, B)
        for i in range(m):
            for k in range(p):
                lines = chain_of(A, B, C, i, k, P)
                for (x, _), (y, _) in zip(lines, lines[1:]):
                    assert x == y, (m, p, i, k)
                    count += 1
                lines = chain_of(A, B, Cfree, i, k, P)
                for (x, _), (y, hyp) in zip(lines, lines[1:]):
                    if hyp:
                        assert x != y
                        neg_control += 1
                    else:
                        assert x == y
        assert B == body_difference(C, A) == C - A
print(f"checked {count} steps, negative control {neg_control} lines over 9 shapes")
print("RESULT: PASS")
