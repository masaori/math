# 対象ラベル: negation_is_scalar_multiple_by_minus_one
# 証明の (i,j) 成分の三行の鎖の四つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 -A = (-1)A を、Sage の符号反転とスカラー倍（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（A の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("_prelude.sage")

count = 0
for m in DIMS:
    for n in DIMS:
        P, _, (A,) = generic_ring([("A", m, n)])
        mo = P(-1)                      # -1_C
        nA = body_negation(A)
        moA = body_scalar(mo, A)
        for i in range(m):
            for j in range(n):
                chain = [
                    nA[i, j],                               # (-A)_ij
                    body_neg_scalar(A[i, j]),               # def_matrix_negation
                    mo * A[i, j],                           # multiply_by_minus_one
                    moA[i, j],                              # def_matrix_scalar_multiple
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert nA == (-1) * A
        assert nA == -A
        # 対照: (+1)A とは一致しない（差 2A は零でない多項式）
        assert nA != A
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")
