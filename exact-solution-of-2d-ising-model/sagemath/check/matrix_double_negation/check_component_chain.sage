# 対象ラベル: matrix_double_negation
# 証明の (i,j) 成分の六行の鎖の七つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 -(-A) = A を、Sage の符号反転（独立な経路）で組んだ左辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（A の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("_prelude.sage")

count = 0
for m in DIMS:
    for n in DIMS:
        P, _, (A,) = generic_ring([("A", m, n)])
        mo = P(-1)                      # -1_C
        nA = body_negation(A)
        nnA = body_negation(nA)
        for i in range(m):
            for j in range(n):
                chain = [
                    nnA[i, j],                              # (-(-A))_ij
                    body_neg_scalar(nA[i, j]),              # def_matrix_negation
                    body_neg_scalar(body_neg_scalar(A[i, j])),  # def_matrix_negation
                    mo * (mo * A[i, j]),                    # multiply_by_minus_one（2 か所）
                    (mo * mo) * A[i, j],                    # C の積の結合律
                    P(1) * A[i, j],                         # (-1)(-1) = 1（minus_one_times_minus_one_is_one_in_cc）
                    A[i, j],                                # 1 は積の単位元
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert mo * mo == P(1)
        assert nnA == A
        assert -(-A) == A
        # 対照: 符号反転を一回だけ施したものとは一致しない（差 2A は零でない多項式）
        assert nA != A
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")
