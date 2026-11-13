# 対象ラベル: scalar_sum_distributes_over_matrix
# 証明の (i,j) 成分の四行の鎖の五つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 (a + b)A = aA + bA を、Sage のスカラー倍と和（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（a, b と A の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, (a, b), (A,) = generic_ring([("A", m, n)], scalars=["s_a", "s_b"])
        L = body_scalar(a + b, A)
        aA = body_scalar(a, A)
        bA = body_scalar(b, A)
        Rhs = body_sum(aA, bA)
        for i in range(m):
            for j in range(n):
                chain = [
                    L[i, j],                     # ((a+b)A)_ij
                    (a + b) * A[i, j],           # def_matrix_scalar_multiple
                    a * A[i, j] + b * A[i, j],   # C の分配律 (a+b)c = ac+bc
                    aA[i, j] + bA[i, j],         # def_matrix_scalar_multiple を 2 箇所
                    Rhs[i, j],                   # def_matrix_sum
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert L == Rhs
        assert L == a * A + b * A
        # 対照: 第 2 項の b を落とした aA + A とは一致しない
        assert L != a * A + A
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")
