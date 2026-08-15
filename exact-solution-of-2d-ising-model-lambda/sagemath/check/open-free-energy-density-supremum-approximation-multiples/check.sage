# 対象ラベル: claim_open_free_energy_density_supremum_approximation_multiples_one_le

from itertools import product

RBF = RealBallField(256)
# 1 ≤ t の場合だけが対象。値の計算は QQ で厳密、実対数だけ ball 算術。
T_SAMPLES = [QQ(1), QQ(3) / 2, QQ(2), QQ(5)]
# 有限モデル: 一辺 1..4 の値集合（一辺 4 は 2^16 配位）
L_MODEL = [1, 2, 3, 4]


def vertices(L):
    return [(i, j) for i in range(L) for j in range(L)]


def edges(L):
    return ([((i, j), (i, j + 1)) for i in range(L) for j in range(L - 1)] +
            [((i, j), (i + 1, j)) for i in range(L - 1) for j in range(L)])


def open_value(L, t):
    vs = vertices(L)
    total = QQ.zero()
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vs)):
        sigma = dict(zip(vs, values))
        broken = sum(ZZ(sigma[u] != sigma[v]) for u, v in edges(L))
        total += t ** broken
    return total


def density(L, t):
    return RBF(QQ(1) / L ** 2) * RBF(open_value(L, t)).log()


def density_le(L_left, L_right, t):
    # log(Z_L)/L^2 の比較を、正の有理数の整数冪の比較へ戻す。
    return (open_value(L_left, t) ** (L_right ** 2) <=
            open_value(L_right, t) ** (L_left ** 2))


def check_monotone_along_multiples():
    # 証明の第二段: 1 ≤ t なら ψ_a ≤ ψ_{ka}（対数化したブロック評価の第一の不等式）
    total = 0
    pairs = [(1, 2), (1, 3), (1, 4), (2, 2)]
    for t in T_SAMPLES:
        for a, k in pairs:
            # 実対数の単調性で指数側へ戻し、有理数の厳密比較で検査する:
            # ψ_a ≤ ψ_ka  ⟺  Z_a^{(ka)^2} ≤ Z_ka^{a^2}
            za = open_value(a, t)
            zka = open_value(k * a, t)
            assert za ** ((k * a) ** 2) <= zka ** (a ** 2), (t, a, k)
            total += 1
    print(f"倍数の辺での単調性 ψ_a ≤ ψ_ka: {total} 件 OK")
    return total


def check_finite_model():
    # 有限値集合をモデルに、上限 u と ε>0 に対して u-ε < ψ_a を満たす a を取り、
    # その a の倍数 ka（モデル内）で u-ε < ψ_ka ≤ u を検査する。
    total = 0
    for t in T_SAMPLES:
        values = {L: density(L, t) for L in L_MODEL}
        maximum_sides = [
            L for L in L_MODEL
            if all(density_le(other, L, t) for other in L_MODEL)
        ]
        assert maximum_sides, t
        maximum_side = maximum_sides[0]
        u = values[maximum_side]
        for eps in [QQ(1) / 10, QQ(1) / 100]:
            eps_r = RBF(eps)
            # u - ε は上界ではない: 反例 a
            candidates = [L for L in L_MODEL if (RBF(u) - eps_r - values[L]).upper() < 0]
            assert candidates, (t, eps)
            a = candidates[0]
            for k in [1, 2, 3, 4]:
                if k * a not in values:
                    continue
                v = values[k * a]
                assert (RBF(u) - eps_r - v).upper() < 0, (t, eps, a, k)
                assert density_le(k * a, maximum_side, t), (t, eps, a, k)
                total += 1
    print(f"有限モデルでの u-ε < ψ_ka ≤ u: {total} 件 OK")
    return total


n = check_monotone_along_multiples() + check_finite_model()
print(f"合計 {n} 件 OK")
