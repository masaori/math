# 対象ラベル: matrix_plus_difference_cancels（A + (B - A) = B）
# 成分の 7 行の鎖を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 否定コントロールとして、差を逆向きに組んだ A + (A - B) は B と一致しないことを確かめる。
# 帰属: QQ 上の多項式環（成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")


def chain_of(A, B, i, k, P):
    BA = body_difference(B, A)
    S = body_sum(A, BA)
    a, b = A[i, k], B[i, k]
    return [
        S[i, k],                                           # (A + (B - A))_ik
        a + BA[i, k],                                      # def_matrix_sum
        a + (b - a),                                       # def_matrix_difference
        a + (b + body_neg_scalar(a)),                      # def_complex_difference
        a + (body_neg_scalar(a) + b),                      # C の加法の交換律
        (a + body_neg_scalar(a)) + b,                      # C の加法の結合律
        P(0) + b,                                          # 加法の逆元
        b,                                                 # 加法の単位元
    ]


count = 0
neg_control = 0
for m in [1, 2, 3]:
    for p in [1, 2, 3]:
        P, _, (A, B) = generic_ring([("A", m, p), ("B", m, p)])
        for i in range(m):
            for k in range(p):
                lines = chain_of(A, B, i, k, P)
                for x, y in zip(lines, lines[1:]):
                    assert x == y, (m, p, i, k)
                    count += 1
        assert body_sum(A, body_difference(B, A)) == B == A + (B - A)   # 主張（Sage 組み込みの和・差とも比べる）
        assert body_sum(A, body_difference(A, B)) != B                   # 否定コントロール
        neg_control += 1
print(f"checked {count} steps, negative control {neg_control} shapes over 9 shapes")
print("RESULT: PASS")
