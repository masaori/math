# 対象ラベル: linearly_independent_family_has_no_zero_element
# 証明の論法: u_s = O のとき c_t := δ_{ts} で Σ c_t u_t = O（t ≠ s の 2 行の鎖、t = s の 2 行の鎖、和の 3 行の鎖）、c_s = 1 ≠ 0。
# 零行列を含む族でこれらの鎖を一行ずつ確かめ、その族が線型独立でない（平らにした行列の階数 < p）ことを確かめる。
# 主張そのもの: 線型独立な乱数の族の元はどれも O でない。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(3))
for (m, n) in [(1, 1), (2, 1), (2, 2), (1, 3)]:
    for p in range(1, 5):
        for s in range(p):
            us = [rand_mat(rng, m, n) for _ in range(p)]
            us[s] = zero(m, n)
            cs = [K(1) if t == s else K(0) for t in range(p)]
            for t in range(p):
                if t != s:
                    ok(cs[t] * us[t] == K(0) * us[t] == zero(m, n), ("t≠s", t))
                else:
                    ok(cs[s] * us[s] == cs[s] * zero(m, n) == zero(m, n), "t=s")
            chain = [lincomb(cs, us, m, n), fsum([cs[t] * us[t] for t in range(p)]), fsum([zero(m, n)] * p), zero(m, n)]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("和の鎖", t))
            ok(cs[s] == K(1) and K(1) != K(0), "c_s = 1 ≠ 0")
            ok(not is_independent(us, m, n), "零行列を含む族は線型独立でない")
        # 主張: 線型独立な族は零行列を含まない
        if p <= m * n:
            us = [rand_mat(rng, m, n) for _ in range(p)]
            if is_independent(us, m, n):
                ok(all(u != zero(m, n) for u in us), "主張")
print("checked", count(), "items")
print("RESULT: PASS")
