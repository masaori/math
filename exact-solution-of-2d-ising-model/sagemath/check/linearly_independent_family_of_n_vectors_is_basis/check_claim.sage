# 対象ラベル: linearly_independent_family_of_n_vectors_is_basis
# 証明の論法: ℂ^n の n + 1 個の元は標準基底 (e_1, …, e_n) の線型結合なので、
# linearly_independent_family_is_no_longer_than_spanning_family により線型独立でない（乱数で確かめる。標準基底による展開も確かめる）。
# 主張: 線型独立な n 個の元（乱数の可逆行列の列）は ℂ^n を張る（乱数の x を線型結合で書けること）。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(59))
for n in [1, 2, 3, 4]:
    es = standard_basis(n)
    for _ in range(4):
        vs = [rand_mat(rng, n, 1) for _ in range(n)]
        if not is_independent(vs, n, 1):
            continue
        for _ in range(3):
            x = rand_mat(rng, n, 1)
            ok(x == lincomb([x[t, 0] for t in range(n)], es, n, 1), "標準基底の線型結合")
            ok(not is_independent(vs + [x], n, 1), "n + 1 個は線型独立でない")
            c = coefficients_in(x, vs, n, 1)
            ok(lincomb(c, vs, n, 1) == x, "主張: 張る")
# 対照: n − 1 個の線型独立な元は ℂ^n を張らない
for n in [2, 3]:
    vs = standard_basis(n)[:-1]
    ok(is_independent(vs, n, 1) and not in_span(standard_basis(n)[-1], vs, n, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
