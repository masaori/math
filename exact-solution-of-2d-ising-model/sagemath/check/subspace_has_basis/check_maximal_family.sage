# 対象ラベル: subspace_has_basis
# 証明の論法をそのまま実装する: U（乱数の生成元の線型結合の全体。零部分空間も含む）の元から線型独立な族を作り、
# U の元 x がその線型結合でない間は extending_independent_family_by_element_outside_span で一つずつ足す。
# 確かめること: Step 1（元を持たない族は線型独立）、Step 2（U の中の線型独立な族の元の個数は N = mn 以下。
# 族が行列単位の線型結合であることも確かめる）、Step 3（足せなくなった族は U を張り、線型独立で、元の個数 ≤ mn）。
# 帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(19))
for (m, n) in [(1, 1), (2, 1), (3, 1), (2, 2), (2, 3)]:
    N = m * n
    F = [matrix_unit(m, n, i, j) for i in range(m) for j in range(n)]
    for k in range(0, N + 2):
        gens = [rand_mat(rng, m, n) for _ in range(k)]
        if k >= 2 and rng.random() < 0.5:
            gens[-1] = gens[0] + gens[1]        # 線型独立でない生成元も混ぜる
        inU = lambda x: in_span(x, gens, m, n)
        ok(is_independent([], m, n), "Step 1")
        fam = []
        candidates = gens + [lincomb(rand_vec_list(rng, k), gens, m, n) for _ in range(3)]
        for x in candidates:
            ok(inU(x), "候補は U の元")
            if not in_span(x, fam, m, n):
                fam = fam + [x]
                ok(is_independent(fam, m, n), "足しても線型独立")
            ok(len(fam) <= N, "Step 2: 個数 ≤ N")
            ok(all(in_span(u, F, m, n) for u in fam), "行列単位の線型結合")
        # Step 3: 足せなくなった族は U を張る
        ok(all(in_span(g, fam, m, n) for g in gens), "U を張る")
        for _ in range(3):
            ok(in_span(lincomb(rand_vec_list(rng, k), gens, m, n), fam, m, n), "U の元は族の線型結合")
        ok(all(inU(u) for u in fam) and is_independent(fam, m, n) and len(fam) <= N, "基底で個数 ≤ mn")
        if k == 0:
            ok(fam == [], "零部分空間の基底は元を持たない族")
# 対照: 張る族であっても線型独立でなければ基底ではない
g = [matrix(K, [[1]]), matrix(K, [[2]])]
ok(not is_independent(g, 1, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
