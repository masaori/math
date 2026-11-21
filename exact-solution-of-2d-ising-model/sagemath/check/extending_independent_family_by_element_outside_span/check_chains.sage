# 対象ラベル: extending_independent_family_by_element_outside_span
# 主張: 線型独立な u と、その線型結合でない x について (u_1, …, u_p, x) は線型独立（乱数で確かめる）。
# 証明の Step 1 の鎖（x = 1x = (βc)x = β(cx) = β(−L) = β((−1)L) = (β(−1))L = (−(β1))L = γL と、p ≥ 1 の γL の 4 行の鎖、
# p = 0 の L = O・γO = O）は、矛盾の仮定 c_{p+1} ≠ 0 の下で成り立つ式なので、x を u の線型結合に取った族
# （c := (a_1, …, a_p, −1) で Σ c_t u_t = O）で一行ずつ確かめる。Step 2 の 4 行の鎖は c_{p+1} = 0 の不定元係数で確かめる。
# 帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(13))
for (m, n) in [(1, 1), (2, 1), (2, 2), (3, 1)]:
    for p in range(0, min(m * n, 3) + 1):
        us = [rand_mat(rng, m, n) for _ in range(p)]
        if not is_independent(us, m, n):
            continue
        O = zero(m, n)
        # 主張
        if p < m * n:
            x = rand_mat(rng, m, n)
            if not in_span(x, us, m, n):
                ok(is_independent(us + [x], m, n), "主張")
        # Step 1 の鎖: x を線型結合に取る
        a = rand_vec_list(rng, p)
        x = lincomb(a, us, m, n)
        c = list(a) + [K(-1)]
        ok(lincomb(c, us + [x], m, n) == O, "Σ c_t u_t = O")
        L = lincomb(c[:p], us, m, n)
        ok(lincomb(c, us + [x], m, n) == L + c[p] * x, "splits_off_last_term")
        ok(c[p] * x + L == O and c[p] * x == -L, "c x = −L")
        beta = c[p] ^ (-1); gamma = -beta
        chain = [x, K(1) * x, (beta * c[p]) * x, beta * (c[p] * x), beta * (-L), beta * ((-K(1)) * L),
                 (beta * (-K(1))) * L, (-(beta * K(1))) * L, gamma * L]
        for t in range(len(chain) - 1):
            ok(chain[t] == chain[t + 1], ("Step1", p, t))
        if p == 0:
            ok(L == O and gamma * O == O and x == lincomb([], [], m, n), "p = 0")
        else:
            chain2 = [gamma * L, gamma * fsum([c[t] * us[t] for t in range(p)]), fsum([gamma * (c[t] * us[t]) for t in range(p)]),
                      fsum([(gamma * c[t]) * us[t] for t in range(p)]), lincomb([gamma * c[t] for t in range(p)], us, m, n)]
            for t in range(len(chain2) - 1):
                ok(chain2[t] == chain2[t + 1], ("γL", p, t))
        # Step 2 の鎖（c_{p+1} = 0）
        R = PolynomialRing(K, ["c%d" % t for t in range(1, p + 2)])
        cs = list(R.gens()[:p]) + [R(0)]
        usR = [u.change_ring(R) for u in us]; xR = rand_mat(rng, m, n).change_ring(R)
        LR = lincomb(cs[:p], usR, m, n, R)
        chain3 = [LR, LR + zero(m, n, R), LR + R(0) * xR, LR + cs[p] * xR]
        for t in range(len(chain3) - 1):
            ok(chain3[t] == chain3[t + 1], ("Step2", p, t))
# 対照: x が線型結合なら足した族は線型独立でない
us = [matrix(K, [[1], [0]])]
ok(not is_independent(us + [matrix(K, [[2], [0]])], 2, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
