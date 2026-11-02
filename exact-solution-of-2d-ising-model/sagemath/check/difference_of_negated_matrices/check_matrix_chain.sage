# 対象ラベル: difference_of_negated_matrices
# 証明の行列の等号の三行の鎖の四つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 差・符号反転・和は本文の定義どおり成分から組む。主張 (-A) - (-B) = -(A - B) は Sage の演算（独立な経路）とも比べる。
# 帰属: QQ 上の多項式環（A, B の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, _, (A, B) = generic_ring([("A", m, n), ("B", m, n)])
        nA, nB = body_negation(A), body_negation(B)
        chain = [
            body_difference(nA, nB),                            # (-A) - (-B)
            body_sum(nA, body_negation(nB)),                    # matrix_difference_is_sum_with_negation（A→-A, B→-B）
            body_negation(body_sum(A, nB)),                     # negation_distributes_over_matrix_sum（B→-B）
            body_negation(body_difference(A, B)),               # matrix_difference_is_sum_with_negation
        ]
        for t in range(len(chain) - 1):
            assert chain[t] == chain[t + 1], (m, n, t)
        assert (-A) - (-B) == -(A - B) == chain[0]
        # 対照: 符号を外側へ出さない A - B とは一致しない
        assert chain[0] != body_difference(A, B)
        count += 1
print(f"checked the chain over {count} shapes")
print("RESULT: PASS")
