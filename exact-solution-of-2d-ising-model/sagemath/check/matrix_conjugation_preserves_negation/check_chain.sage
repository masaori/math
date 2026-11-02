# 対象ラベル: matrix_conjugation_preserves_negation
# T_B(-W) = -T_B(W) の証明の四行の鎖の五つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# T_B(X) = (BX)B^{-1} の B^{-1} は、鎖のどの行も B^{-1}B = I を使わないので、B と独立な不定元の行列 Bi に置いた。
# 帰属: QQ 上の多項式環（成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

count = 0
for n in [1, 2, 3]:
    P, _, (B, Bi, W) = generic_ring([("B", n, n), ("Bi", n, n), ("W", n, n)])

    def T(Y):
        """mat_conj の T_B: (BY)B^{-1}。"""
        return body_product(body_product(B, Y), Bi)

    chain = [
        T(body_negation(W)),                                    # T_B(-W)
        body_product(body_product(B, body_negation(W)), Bi),    # T_B の定義
        body_product(body_negation(body_product(B, W)), Bi),    # negation_factors_out_of_right_factor
        body_negation(body_product(body_product(B, W), Bi)),    # negation_factors_out_of_left_factor
        body_negation(T(W)),                                    # T_B の定義
    ]
    for t in range(len(chain) - 1):
        assert chain[t] == chain[t + 1], (n, t)
    assert B * (-W) * Bi == -(B * W * Bi) == chain[0]
    # 対照: 符号を落とした T_B(W) とは一致しない
    assert chain[0] != T(W)
    count += 1
print(f"checked the chain for n = 1, 2, 3 ({count} sizes)")
print("RESULT: PASS")
