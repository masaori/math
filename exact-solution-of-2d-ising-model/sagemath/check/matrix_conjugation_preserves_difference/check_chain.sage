# 対象ラベル: matrix_conjugation_preserves_difference
# T_B(X - W) = T_B(X) - T_B(W) の証明の四行の鎖の五つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# T_B(X) = (BX)B^{-1} の B^{-1} は、鎖のどの行も B^{-1}B = I を使わないので、B と独立な不定元の行列 Bi に置いた。
# 帰属: QQ 上の多項式環（成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

count = 0
for n in [1, 2, 3]:
    P, _, (B, Bi, X, W) = generic_ring([("B", n, n), ("Bi", n, n), ("X", n, n), ("W", n, n)])

    def T(Y):
        """mat_conj の T_B: (BY)B^{-1}。"""
        return body_product(body_product(B, Y), Bi)

    chain = [
        T(body_difference(X, W)),                               # T_B(X - W)
        T(body_sum(X, body_negation(W))),                       # matrix_difference_is_sum_with_negation
        body_sum(T(X), T(body_negation(W))),                    # mat_conj の和を保つこと
        body_sum(T(X), body_negation(T(W))),                    # matrix_conjugation_preserves_negation
        body_difference(T(X), T(W)),                            # matrix_difference_is_sum_with_negation
    ]
    for t in range(len(chain) - 1):
        assert chain[t] == chain[t + 1], (n, t)
    assert B * (X - W) * Bi == B * X * Bi - B * W * Bi == chain[0]
    # 対照: 差を和にした T_B(X) + T_B(W) とは一致しない
    assert chain[0] != body_sum(T(X), T(W))
    count += 1
print(f"checked the chain for n = 1, 2, 3 ({count} sizes)")
print("RESULT: PASS")
