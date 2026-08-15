# 対象ラベル: claim_open_free_energy_density_upper_bound,
# def_open_free_energy_density_value_set, claim_open_free_energy_density_supremum_exists

from itertools import product

RBF = RealBallField(256)
L_SAMPLES = [1, 2, 3]
T_SAMPLES = [QQ(1) / 10, QQ(1) / 2, QQ(1), QQ(2), QQ(5)]


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
        assert broken <= 2 * L * (L - 1) <= 2 * L ** 2
        total += t ** broken
    return total


def check_upper_bounds():
    total = 0
    for L in L_SAMPLES:
        assert len(vertices(L)) == L ** 2
        assert len(edges(L)) == 2 * L * (L - 1)
        assert 2 ** len(vertices(L)) == 2 ** (L ** 2)
        for t in T_SAMPLES:
            value = open_value(L, t)
            algebraic_upper = QQ(2 ** (L ** 2)) * (1 + t) ** (2 * L ** 2)
            assert value <= algebraic_upper
            density = RBF(QQ(1) / L ** 2) * RBF(value).log()
            uniform_upper = RBF(2).log() + RBF(2) * RBF(1 + t).log()
            assert (density - uniform_upper).upper() <= 0
            total += 1
    print(f"開境界の値と密度の上界: {total} 件 OK")
    return total


def check_finite_supremum_model():
    total = 0
    for t in T_SAMPLES:
        values = [RBF(QQ(1) / L ** 2) * RBF(open_value(L, t)).log() for L in L_SAMPLES]
        upper = RBF(2).log() + RBF(2) * RBF(1 + t).log()
        assert values
        assert all((value - upper).upper() <= 0 for value in values)
        finite_sup = max(value.center() for value in values)
        assert all(value.center() <= finite_sup for value in values)
        total += 1
    print(f"有限値集合による上限性のモデル: {total} 件 OK")
    return total


total = check_upper_bounds() + check_finite_supremum_model()
print(f"開境界密度の上界と上限の存在: 合計 {total} 件 OK")
