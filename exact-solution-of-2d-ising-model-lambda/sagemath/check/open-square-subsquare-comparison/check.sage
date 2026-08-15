# 対象ラベル: claim_open_square_subsquare_comparison_le_one

from itertools import product

T_LE_ONE = [QQ(1), QQ(3) / 4, QQ(1) / 2, QQ(1) / 5]
PAIRS = [(1, 2), (1, 3), (2, 3), (1, 4), (2, 4), (3, 4)]  # (a, L) with 1 <= a < L


def vertices(a, b):
    return [(i, j) for i in range(a) for j in range(b)]


def edges(a, b):
    return ([((i, j), (i, j + 1)) for i in range(a) for j in range(b - 1)] +
            [((i, j), (i + 1, j)) for i in range(a - 1) for j in range(b)])


def broken_count(a, b, sigma):
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in edges(a, b))


def open_value(a, b, t):
    vs = vertices(a, b)
    total = QQ(0)
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vs)):
        sigma = dict(zip(vs, values))
        total += t ** broken_count(a, b, sigma)
    return total


def check_le_one():
    total = 0
    for a, L in PAIRS:
        c = L - a
        assert c >= 1 and L == a + c
        assert a * c + c * L == L ** 2 - a ** 2
        for t in T_LE_ONE:
            Zaa = open_value(a, a, t)
            ZLL = open_value(L, L, t)
            ZaL = open_value(a, L, t)
            ZcL = open_value(c, L, t)
            Zac = open_value(a, c, t)
            # 証明の各行（下からの評価）
            assert t ** (a + L) * Zaa == t ** L * t ** a * Zaa
            assert t ** L * t ** a * Zaa <= t ** L * t ** a * Zaa * Zac  # 1 <= Z_{a,c}
            assert t ** L * t ** a * Zaa * Zac <= t ** L * ZaL  # 第二座標方向の接合の下側
            assert t ** L * ZaL <= t ** L * ZaL * ZcL  # 1 <= Z_{c,L}
            assert t ** L * ZaL * ZcL <= ZLL  # 第一座標方向の接合の下側
            # 証明の各行（上からの評価）
            assert ZLL <= ZaL * ZcL
            assert ZaL * ZcL <= Zaa * Zac * ZcL
            assert Zaa * Zac * ZcL <= Zaa * 2 ** (a * c) * ZcL
            assert Zaa * 2 ** (a * c) * ZcL <= Zaa * 2 ** (a * c) * 2 ** (c * L)
            assert Zaa * 2 ** (a * c) * 2 ** (c * L) == 2 ** (L ** 2 - a ** 2) * Zaa
            # 主張
            assert t ** (a + L) * Zaa <= ZLL <= 2 ** (L ** 2 - a ** 2) * Zaa
            total += 1
    print(f"0<t<=1 の部分正方形との比較: {total} 件 OK")
    return total


n = check_le_one()
print(f"PASS: {n} 件")
