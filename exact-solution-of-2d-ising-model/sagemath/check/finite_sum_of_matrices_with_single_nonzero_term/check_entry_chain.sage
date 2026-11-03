# 対象ラベル: finite_sum_of_matrices_with_single_nonzero_term
# q 以外の項が零行列 O の有限和 Σ_a X_a = X_q の成分の 2 等号の鎖を、正方でない形を含む (m, n) ∈ {1,2,3}^2、
# r ∈ {1,…,5}、q ∈ {1,…,r} の全ての成分 (i, k) で確かめる。有限和は def_finite_sum_of_matrices のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（X_q の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
# 対照: q 以外の項を一つでも零行列でない不定元の行列にすると、和は X_q と一致しない。
load("../../_shared/matrix_operations_by_definition.sage")


def sum_left(zs):
    out = zs[0]
    for z in zs[1:]:
        out = out + z
    return out


count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, _, (A, B) = generic_ring([("A", m, n), ("B", m, n)])
        O = matrix(P, m, n, 0)
        for r in range(1, 6):
            for q in range(r):
                Xs = [A if a == q else O for a in range(r)]
                lhs = body_finite_sum(Xs)
                for i in range(m):
                    for k in range(n):
                        assert all(Xs[a][i, k] == 0 for a in range(r) if a != q)   # (X_a)_{ik} = O_{ik} = 0_C
                        lines = [
                            lhs[i, k],
                            sum_left([Xs[a][i, k] for a in range(r)]),     # finite_sum_of_matrices_entrywise
                            Xs[q][i, k],                                    # finite_sum_with_single_nonzero_term
                        ]
                        for t in range(len(lines) - 1):
                            assert lines[t] == lines[t + 1], (m, n, r, q, i, k, t)
                assert lhs == sum(Xs) == A                                   # Sage の行列演算（独立な経路）
                if r >= 2:
                    other = (q + 1) % r
                    Xbad = [A if a == q else (B if a == other else O) for a in range(r)]
                    assert body_finite_sum(Xbad) != A
                count += 1
print(f"checked the 2-equality entry chain for all entries, (m, n) in {{1,2,3}}^2, r = 1..5, every q ({count} cases)")
print("RESULT: PASS")
