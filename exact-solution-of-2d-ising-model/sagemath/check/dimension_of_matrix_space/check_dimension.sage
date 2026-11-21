# 対象ラベル: dimension_of_matrix_space（dim_ℂ Mat(m,n,ℂ) = mn、とくに dim_ℂ ℂ^m = m、dim_ℂ Mat(n,ℂ) = n^2）
# 証明: matrix_units_form_basis の族（元の個数 mn）が基底なので def_dimension より mn。
# 行列単位の族が線型独立で全体を張ること（乱数の行列が線型結合で書けること）と元の個数 mn、
# Sage の MatrixSpace(K, m, n).dimension() との一致を確かめる。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(29))
for m in range(1, 5):
    for n in range(1, 5):
        F = [matrix_unit(m, n, i, j) for i in range(m) for j in range(n)]
        ok(len(F) == m * n and is_independent(F, m, n), "元の個数 mn で線型独立")
        for _ in range(2):
            ok(in_span(rand_mat(rng, m, n), F, m, n), "張る")
        ok(MatrixSpace(K, m, n).dimension() == m * n, "Sage の次元と一致")
    ok(len(standard_basis(m)) == m and VectorSpace(K, m).dimension() == m, "ℂ^m")
    ok(MatrixSpace(K, m, m).dimension() == m ^ 2, "Mat(n,ℂ)")
print("checked", count(), "items")
print("RESULT: PASS")
