# 対象ラベル: def_open_rectangle_partition_value_at_positive_rational claim_open_rectangle_value_at_rational_is_positive
# 帰属: ZZ / QQ の厳密計算だけを使う。浮動小数点・ball 算術は使わない（定義と主張は Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

from itertools import product

R.<x> = PolynomialRing(ZZ)

# 長方形の形（a, b ≥ 1）
SHAPES = [(1, 1), (1, 2), (2, 1), (2, 2), (2, 3), (3, 2), (3, 3), (1, 4), (4, 1), (3, 4)]

# q の標本（正の有理数。1 未満・1・1 超え）
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5), QQ(11)]


def open_vertices(a, b):
    # def_open_rectangle_vertices
    return [(i, j) for i in range(a) for j in range(b)]


def open_edges(a, b):
    # def_open_rectangle_edges（向きの印つき）
    horizontal = [('h', i, j) for i in range(a) for j in range(b - 1)]
    vertical = [('v', i, j) for i in range(a - 1) for j in range(b)]
    return horizontal + vertical


def endpoints(edge):
    direction, i, j = edge
    if direction == 'h':
        return (i, j), (i, j + 1)
    return (i, j), (i + 1, j)


def open_configurations(a, b):
    # def_open_rectangle_configuration
    vertices = open_vertices(a, b)
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vertices)):
        yield dict(zip(vertices, values))


def open_broken_bond_count(a, b, sigma):
    # def_open_rectangle_broken_bond_count
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in map(endpoints, open_edges(a, b)))


def open_partition_polynomial(a, b):
    # def_open_rectangle_partition_polynomial（ZZ[x] の元）
    return sum((x ** open_broken_bond_count(a, b, sigma)
                for sigma in open_configurations(a, b)), R.zero())


def check_definition_and_positivity():
    total = 0
    for (a, b) in SHAPES:
        configs = list(open_configurations(a, b))
        polynomial = open_partition_polynomial(a, b)
        assert polynomial.parent() is R
        assert len(configs) == 2 ** (a * b) and len(configs) >= 1   # |Σ^op_{a,b}| = 2^{ab} ≥ 1
        total += 2
        counts = [open_broken_bond_count(a, b, sigma) for sigma in configs]
        for q in Q_SAMPLES:
            # 準備: 各項 0 < q^{b^op(σ)}（QQ の厳密比較）、b^op(σ) = 0 のとき q^0 = 1
            terms = []
            for bc in counts:
                assert bc in NN, (a, b, bc)
                term = q ** bc
                assert term.parent() is QQ
                assert term > 0, (a, b, q, bc)
                if bc == 0:
                    assert term == 1
                terms.append(term)
                total += 1
            # 定義: Z^op_{a,b}(q) は多項式への代入。二つ目の等号（代入は和と冪を保つ）
            value = polynomial(q)
            assert value.parent() is QQ
            assert value == sum(terms, QQ(0)), (a, b, q)
            total += 2
            # 主張: Z^op_{a,b}(q) ∈ Q_{>0}（正の有理数を 1 個以上足したものは正）
            assert value > 0, (a, b, q)
            total += 1
            # 整合: q = 1 では配位数
            if q == 1:
                assert value == 2 ** (a * b)
                total += 1
    return total


total = check_definition_and_positivity()
print("PASS open-rectangle-partition-value-at-positive-rational: %d checks" % total)
