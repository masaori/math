# 対象ラベル: finite_sum_of_matrix_sums
# 証明の (i,k) 成分の五行の鎖の六つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 有限和は def_finite_sum_of_matrices（行列）・def_finite_sum_of_complex_numbers（複素数）のとおり左から順に足して組む。
# あわせて主張 Σ(X_j + Y_j) = ΣX_j + ΣY_j を、Sage の sum と行列の和（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（X_j, Y_j の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")


def fsum(zs):
    """def_finite_sum_of_complex_numbers: 左から順に足す。"""
    s = zs[0]
    for z in zs[1:]:
        s = s + z
    return s


count = 0
for m in [1, 2]:
    for n in [1, 2]:
        for r in [1, 2, 3, 4]:
            shapes = [(f"X{j}", m, n) for j in range(r)] + [(f"Y{j}", m, n) for j in range(r)]
            P, _, mats = generic_ring(shapes)
            X = mats[:r]
            Y = mats[r:]
            XY = [body_sum(X[j], Y[j]) for j in range(r)]
            L = body_finite_sum(XY)
            SX = body_finite_sum(X)
            SY = body_finite_sum(Y)
            Rhs = body_sum(SX, SY)
            for i in range(m):
                for k in range(n):
                    chain = [
                        L[i, k],                                                   # (Σ(X_j+Y_j))_ik
                        fsum([XY[j][i, k] for j in range(r)]),                     # finite_sum_of_matrices_entrywise
                        fsum([X[j][i, k] + Y[j][i, k] for j in range(r)]),         # def_matrix_sum を r 個の項へ
                        fsum([X[j][i, k] for j in range(r)]) + fsum([Y[j][i, k] for j in range(r)]),  # finite_sum_of_complex_sums
                        SX[i, k] + SY[i, k],                                       # entrywise を右辺から左辺へ 2 箇所
                        Rhs[i, k],                                                 # def_matrix_sum
                    ]
                    for t in range(len(chain) - 1):
                        assert chain[t] == chain[t + 1], (m, n, r, i, k, t)
                    count += 1
            assert L == Rhs
            assert L == sum(X) + sum(Y)
            # 対照: Y_r を落とした右辺とは一致しない
            assert L != sum(X) + sum(Y[:r - 1]) if r > 1 else L != sum(X)
print(f"checked {count} entries and the statement over 16 cases")
print("RESULT: PASS")
