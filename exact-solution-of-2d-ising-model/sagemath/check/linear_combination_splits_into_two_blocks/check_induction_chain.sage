# 対象ラベル: linear_combination_splits_into_two_blocks
#   Σ_{t=1}^{r+s} c_t v_t = (Σ_{t=1}^{r} c_t v_t) + (Σ_{t=1}^{s} c_{r+t} v_{r+t})
# 証明の s = 0 の 2 行の鎖と、帰納法の段の 4 行の鎖を式どおりに組んで隣り合う項が等しいことを確かめる。
# 帰納法の仮定の行は、仮定そのもの（s での主張）を別に確かめてから使う。係数は不定元、v_t は QQ(i) の乱数行列。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(7))


def split_rhs(cs, vs, r, s, m, n, R):
    return lincomb(cs[:r], vs[:r], m, n, R) + lincomb(cs[r:r + s], vs[r:r + s], m, n, R)


for (m, n) in [(1, 1), (2, 1), (2, 2), (1, 3)]:
    for r in range(0, 4):
        for s in range(0, 4):
            R = PolynomialRing(K, ["c%d" % t for t in range(1, r + s + 2)])
            cs = list(R.gens())
            vs = [rand_mat(rng, m, n).change_ring(R) for _ in range(r + s + 1)]
            Z = zero(m, n, R)
            if s == 0:
                chain = [lincomb(cs[:r], vs[:r], m, n, R), lincomb(cs[:r], vs[:r], m, n, R) + Z,
                         lincomb(cs[:r], vs[:r], m, n, R) + lincomb([], [], m, n, R)]
                for t in range(len(chain) - 1):
                    ok(chain[t] == chain[t + 1], ("base", m, n, r, t))
            # s → s+1
            ok(lincomb(cs[:r + s], vs[:r + s], m, n, R) == split_rhs(cs, vs, r, s, m, n, R), ("仮定", m, n, r, s))
            last = cs[r + s] * vs[r + s]
            chain = [
                lincomb(cs[:r + s + 1], vs[:r + s + 1], m, n, R),
                lincomb(cs[:r + s], vs[:r + s], m, n, R) + last,
                (lincomb(cs[:r], vs[:r], m, n, R) + lincomb(cs[r:r + s], vs[r:r + s], m, n, R)) + last,
                lincomb(cs[:r], vs[:r], m, n, R) + (lincomb(cs[r:r + s], vs[r:r + s], m, n, R) + last),
                split_rhs(cs, vs, r, s + 1, m, n, R),
            ]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("step", m, n, r, s, t))
# 対照: 後ろの部分の係数を c_t（ずらさない）にすると崩れる
R = PolynomialRing(K, ["c1", "c2"]); c1, c2 = R.gens()
v = [matrix(R, [[1]]), matrix(R, [[2]])]
ok(lincomb([c1, c2], v, 1, 1, R) != lincomb([c1], v[:1], 1, 1, R) + lincomb([c1], v[1:], 1, 1, R), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
