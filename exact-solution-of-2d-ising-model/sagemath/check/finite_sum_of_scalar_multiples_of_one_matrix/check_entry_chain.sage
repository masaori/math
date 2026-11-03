# 対象ラベル: finite_sum_of_scalar_multiples_of_one_matrix
# Σ_{j=1}^{r} (c_jA) = (Σ_{j=1}^{r} c_j)A の成分の 4 等号の鎖を、正方でない形を含む (m, n) ∈ {1,2,3}^2、
# r = 1,…,5 の全ての成分 (i, k) で確かめる。有限和は def_finite_sum_of_matrices のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（c_j と A の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")

R_MAX = 5
count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P, cs, (A,) = generic_ring([("A", m, n)], scalars=[f"c{j}" for j in range(1, R_MAX + 1)])
        for r in range(1, R_MAX + 1):
            c = cs[:r]
            lhs = body_finite_sum([body_scalar(c[j], A) for j in range(r)])   # Σ_j (c_jA)（定義どおり）
            csum = sum(c)                                                     # Σ_j c_j（ℂ の有限和）
            rhs = body_scalar(csum, A)                                        # (Σ_j c_j)A
            for i in range(m):
                for k in range(n):
                    lines = [
                        lhs[i, k],                                          # (Σ_j (c_jA))_{ik}
                        sum(body_scalar(c[j], A)[i, k] for j in range(r)),  # finite_sum_of_matrices_entrywise
                        sum(c[j] * A[i, k] for j in range(r)),              # def_matrix_scalar_multiple
                        csum * A[i, k],                                     # ℂ の有限和の分配則
                        rhs[i, k],                                          # def_matrix_scalar_multiple
                    ]
                    for t in range(len(lines) - 1):
                        assert lines[t] == lines[t + 1], (m, n, r, i, k, t)
            # 主張を Sage の行列演算（独立な経路）と比べる
            assert sum(cj * A for cj in c) == csum * A == lhs
            # 対照: 係数の和の代わりに最後の係数だけを掛けたものとは（r ≥ 2 で）一致しない
            if r >= 2:
                assert lhs != body_scalar(c[-1], A)
            count += 1
print(f"checked the 4-line entry chain for all entries, (m, n) in {{1,2,3}}^2, r = 1,...,{R_MAX} ({count} cases)")
print("RESULT: PASS")
