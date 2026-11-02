# 対象ラベル: mat_mult_distributes_over_sum_in_right_factor
# 証明の (i,k) 成分の六行の鎖の七つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 A(B+C) = AB + AC を、Sage の行列積と和（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（A, B, C の成分は不定元）。不定元で成り立つ等号は、成分へ任意の複素数を代入しても成り立つ。
load("_prelude.sage")

count = 0
for m in DIMS:
  for n in DIMS:
    for p in DIMS:
        P, _, (A, B, C) = generic_ring([("A", m, n), ("B", n, p), ("C", n, p)])
        BC = body_sum(B, C)
        L = body_product(A, BC)
        AB = body_product(A, B)
        AC = body_product(A, C)
        R = body_sum(AB, AC)
        for i in range(m):
            for k in range(p):
                chain = [
                    L[i, k],                                                          # (A(B+C))_ik
                    sum(A[i, j] * BC[j, k] for j in range(n)),                        # mat_mult
                    sum(A[i, j] * (B[j, k] + C[j, k]) for j in range(n)),             # def_matrix_sum
                    sum(A[i, j] * B[j, k] + A[i, j] * C[j, k] for j in range(n)),     # 分配律（各項）
                    sum(A[i, j] * B[j, k] for j in range(n)) + sum(A[i, j] * C[j, k] for j in range(n)),  # finite_sum_of_complex_sums
                    AB[i, k] + AC[i, k],                                              # mat_mult（2 か所）
                    R[i, k],                                                          # def_matrix_sum
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, p, i, k, t)
                count += 1
        assert L == A * B + A * C
        assert L == A * (B + C)
        # 対照: 右の項 AC を落とした AB とは一致しない（差 AC は零でない多項式の行列）
        assert L != A * B
print(f"checked {count} entries and the statement over 27 shapes")
print("RESULT: PASS")
