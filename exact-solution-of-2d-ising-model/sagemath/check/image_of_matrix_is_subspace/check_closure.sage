# 対象ラベル: image_of_matrix_is_subspace（im Q := {Qx | x ∈ ℂ^n} は ℂ^m の部分空間）
# 証明の 3 項: (i) O_{m,1} = Q O_{n,1}、(ii) Qx + Qy = Q(x + y)、(iii) a(Qx) = Q(ax) を乱数の Q, x, y, a で確かめる
# （不定元の x, y, a でも確かめる）。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(31))
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        for _ in range(3):
            Q = rand_mat(rng, m, n)
            ok(zero(m, 1) == Q * zero(n, 1), "(i)")
            x = rand_mat(rng, n, 1); y = rand_mat(rng, n, 1); a = small_K(rng)
            ok(Q * x + Q * y == Q * (x + y), "(ii)")
            ok(a * (Q * x) == Q * (a * x), "(iii)")
        R = PolynomialRing(K, ["x%d" % j for j in range(n)] + ["y%d" % j for j in range(n)] + ["a"])
        g = R.gens(); x = matrix(R, n, 1, g[:n]); y = matrix(R, n, 1, g[n:2 * n]); a = g[-1]
        Q = rand_mat(rng, m, n).change_ring(R)
        ok(Q * x + Q * y == Q * (x + y) and a * (Q * x) == Q * (a * x), "不定元")
# 対照: 像を平行移動した集合 {Qx + b}（b ∉ im Q）は O を含まない
Q = matrix(K, [[1, 0], [0, 0]]); b = matrix(K, [[0], [1]])
ok(not in_span(b, [Q.column(j).column() for j in range(2)], 2, 1), "対照: O ∉ {Qx + b}")
print("checked", count(), "items")
print("RESULT: PASS")
