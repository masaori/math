# 対象ラベル: mat_conj
# 証明の和の鎖（4 行）とスカラー倍の鎖（4 行）の項を、各行に書かれた式どおりに本文の定義の成分の式で組み、隣り合う項が等しいことを確かめる。
# T_B(A) = (BA)B^{-1} の B^{-1} は、鎖のどの行も B^{-1}B = I を使わないので、B と独立な不定元の行列 Bi に置いた。
# 帰属: QQ 上の多項式環（B, Bi, A, C の成分と α は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

count = 0
for n in [1, 2, 3]:
    P, (al,), (B, Bi, A, C) = generic_ring([("B", n, n), ("Bi", n, n), ("A", n, n), ("C", n, n)], scalars=("alpha",))

    def T(X):
        """T_B の定義: (BX)B^{-1}。"""
        return body_product(body_product(B, X), Bi)

    # 和の鎖
    BA = body_product(B, A)
    BC = body_product(B, C)
    add_chain = [
        T(body_sum(A, C)),                                                        # T_B(A+C)
        body_product(body_product(B, body_sum(A, C)), Bi),                        # T_B の定義
        body_product(body_sum(BA, BC), Bi),                                       # mat_mult_distributes_over_sum_in_right_factor
        body_sum(body_product(BA, Bi), body_product(BC, Bi)),                     # mat_mult_distributes_over_sum_in_left_factor
        body_sum(T(A), T(C)),                                                     # T_B の定義（2 か所）
    ]
    for t in range(len(add_chain) - 1):
        assert add_chain[t] == add_chain[t + 1], ("add", n, t)
    # スカラー倍の鎖
    smul_chain = [
        T(body_scalar(al, A)),                                                    # T_B(αA)
        body_product(body_product(B, body_scalar(al, A)), Bi),                    # T_B の定義
        body_product(body_scalar(al, BA), Bi),                                    # scalar_multiple_factors_out_of_right_factor
        body_scalar(al, body_product(BA, Bi)),                                    # scalar_multiple_factors_out_of_left_factor
        body_scalar(al, T(A)),                                                    # T_B の定義
    ]
    for t in range(len(smul_chain) - 1):
        assert smul_chain[t] == smul_chain[t + 1], ("smul", n, t)
    # 主張を Sage の行列演算（独立な経路）と比べる
    assert T(A + C) == B * A * Bi + B * C * Bi
    assert T(al * A) == al * (B * A * Bi)
    # 対照: 和の右の項を落とすと一致しない
    assert T(A + C) != B * A * Bi
    count += 1
print(f"checked both chains for n = 1, 2, 3 ({count} sizes)")
print("RESULT: PASS")
