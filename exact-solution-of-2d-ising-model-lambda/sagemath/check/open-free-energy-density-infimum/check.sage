# 対象ラベル: claim_open_free_energy_density_lower_bound_le_one
# 対象ラベル: claim_open_free_energy_density_infimum_exists_le_one

from itertools import product

RBF = RealBallField(256)
T_SAMPLES = [QQ(1), QQ(3) / 4, QQ(1) / 2, QQ(1) / 5]
L_SAMPLES = [1, 2, 3, 4]


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


def density_le(L_left, L_right, t):
    return (open_value(L_left, t) ** (L_right ** 2) <=
            open_value(L_right, t) ** (L_left ** 2))


def check_countable_lower_bound():
    total = 0
    for t in T_SAMPLES:
        for L in L_SAMPLES:
            edge_count = 2 * L * (L - 1)
            z = open_value(L, t)
            assert 2 * t ** edge_count <= z, (t, L, "configuration lower bound")
            assert t ** (2 * L ** 2) <= 2 * t ** edge_count, (t, L, "power comparison")
            total += 2
    print(f"可算側の値の下界: {total} 件 OK")
    return total


def check_density_and_infimum_model():
    total = 0
    for t in T_SAMPLES:
        lower = RBF(2) * RBF(t).log()
        values = []
        for L in L_SAMPLES:
            density = RBF(QQ(1) / L ** 2) * RBF(open_value(L, t)).log()
            assert (density - lower).lower() >= 0, (t, L, "density lower bound")
            values.append(density)
            total += 1
        minimum_sides = [
            L for L in L_SAMPLES
            if all(density_le(L, other, t) for other in L_SAMPLES)
        ]
        assert minimum_sides, t
        assert all(density_le(minimum_sides[0], other, t) for other in L_SAMPLES)
        assert all((value - lower).lower() >= 0 for value in values)
        total += 2
    print(f"密度の下界と有限モデルの下限: {total} 件 OK")
    return total


n = check_countable_lower_bound() + check_density_and_infimum_model()
print(f"合計 {n} 件 OK")
