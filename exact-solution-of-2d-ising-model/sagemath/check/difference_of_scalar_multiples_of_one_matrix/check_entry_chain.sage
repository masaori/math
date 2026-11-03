# 対象ラベル: difference_of_scalar_multiples_of_one_matrix
# 証明の (i,k) 成分の九行の鎖の十の項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 aA - bA = (a - b)A を、Sage のスカラー倍と差（独立な経路）と行列全体で比べる。
# 帰属: QQ 上の多項式環（a, b と A の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, (a, b), (A,) = generic_ring([("A", m, n)], scalars=["s_a", "s_b"])
        mo = P(-1)                      # -1_C
        aA = body_scalar(a, A)
        bA = body_scalar(b, A)
        L = body_difference(aA, bA)
        Rhs = body_scalar(a - b, A)     # 係数 a - b は Sage の差で組む
        for i in range(m):
            for k in range(n):
                chain = [
                    L[i, k],                                     # (aA - bA)_ik
                    aA[i, k] - bA[i, k],                         # def_matrix_difference（複素数の差は Sage の差で組む）
                    a * A[i, k] - b * A[i, k],                   # def_matrix_scalar_multiple を 2 箇所
                    a * A[i, k] + body_neg_scalar(b * A[i, k]),  # def_complex_difference
                    a * A[i, k] + mo * (b * A[i, k]),            # multiply_by_minus_one
                    a * A[i, k] + (mo * b) * A[i, k],            # 積の結合律
                    a * A[i, k] + body_neg_scalar(b) * A[i, k],  # multiply_by_minus_one を右辺から左辺へ
                    (a + body_neg_scalar(b)) * A[i, k],          # 分配律を右辺から左辺へ
                    (a - b) * A[i, k],                           # def_complex_difference を右辺から左辺へ
                    Rhs[i, k],                                   # def_matrix_scalar_multiple
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, k, t)
                count += 1
        assert L == a * A - b * A == (a - b) * A
        # 対照: 係数の差の符号を逆にした (b - a)A とは一致しない
        assert L != (b - a) * A
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")
