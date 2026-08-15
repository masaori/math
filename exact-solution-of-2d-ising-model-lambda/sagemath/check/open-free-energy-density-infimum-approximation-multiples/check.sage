# 対象ラベル: claim_open_free_energy_density_infimum_approximation_multiples_le_one

from itertools import product

RBF = RealBallField(256)
T_SAMPLES = [QQ(1), QQ(3) / 4, QQ(1) / 2, QQ(1) / 5]
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
    return (open_value(L_left, t) ** (L_right ** 2) <=
            open_value(L_right, t) ** (L_left ** 2))


def check_monotone_along_multiples():
    total = 0
    pairs = [(1, 2), (1, 3), (1, 4), (2, 2)]
    for t in T_SAMPLES:
        for a, k in pairs:
            # ψ_ka ≤ ψ_a を正の有理数の整数冪の比較へ戻して厳密検査する。
            assert density_le(k * a, a, t), (t, a, k)
            total += 1
    print(f"倍数の辺での単調性 ψ_ka ≤ ψ_a: {total} 件 OK")
    return total


def check_finite_model():
    total = 0
    for t in T_SAMPLES:
        values = {L: density(L, t) for L in L_MODEL}
        minimum_sides = [
            L for L in L_MODEL
            if all(density_le(L, other, t) for other in L_MODEL)
        ]
        assert minimum_sides, t
        minimum_side = minimum_sides[0]
        v = values[minimum_side]
        for eps in [QQ(1) / 10, QQ(1) / 100]:
            eps_r = RBF(eps)
            candidates = [L for L in L_MODEL if (values[L] - (RBF(v) + eps_r)).upper() < 0]
            assert candidates, (t, eps)
            a = candidates[0]
            for k in [1, 2, 3, 4]:
                if k * a not in values:
                    continue
                multiple = values[k * a]
                assert density_le(minimum_side, k * a, t), (t, eps, a, k)
                assert (multiple - (RBF(v) + eps_r)).upper() < 0, (t, eps, a, k)
                total += 1
    print(f"有限モデルでの v ≤ ψ_ka < v+ε: {total} 件 OK")
    return total


n = check_monotone_along_multiples() + check_finite_model()
print(f"合計 {n} 件 OK")
