# 対象ラベル: def_open_square_free_entropy_density
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない。
#
# 検査すること（def_open_square_free_entropy_density の定義の中身）:
#   1. L ≥ 1 で L² ≠ 0、1/L² ∈ QQ が定まる。
#   2. Z^op_{L,L}(q) は ZZ[x] の開境界分配多項式への代入で、配位ごとの和と一致し、QQ_{>0} に入る
#      （def_open_rectangle_partition_value_at_positive_rational・claim_open_rectangle_value_at_rational_is_positive）。
#      よって log Z^op_{L,L}(q) ∈ Λ（素因数分解の指数ベクトル）が定まる。
#   3. Ψ^op_L(q) := (1/L²)·ι(log Z^op_{L,L}(q)) の各素数での値が (log Z^op_{L,L}(q))(p)/L² に等しい（三段の鎖）。
#   4. Ψ^op_L(q) の台は log Z^op_{L,L}(q) の台に等しい（有限台）。
#   5. 具体例 L = 2、q = 1/2: Z^op_{2,2}(1/2) = 41/8、log = ℓ_41 − 3ℓ_2、
#      Ψ^op_2(1/2)(41) = 1/4、Ψ^op_2(1/2)(2) = −3/4、他は 0。
# 有限標本での検査であり、普遍量化された定義の性質そのものの証明ではない。

from itertools import product

R.<x> = PolynomialRing(ZZ)


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


def log_lambda(q):
    # 正の有理数の対数（def_rational_log）: 素因数分解の指数ベクトル（Λ の元。値は ZZ）
    assert q > 0
    return {ZZ(p): ZZ(e) for p, e in QQ(q).factor() if e != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}: 各素数の整数値を分母 1 の有理数として読む
    return {p: QQ(z) / QQ(1) for p, z in lam.items()}


def smul(c, v):
    # Λ_Q の有理数倍（素数ごとに QQ の積）
    return {p: QQ(c) * a for p, a in v.items() if QQ(c) * a != 0}


L_RANGE = [1, 2, 3]
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5), QQ(11)]

count = 0
for L in L_RANGE:
    # 1. 1/L² ∈ QQ が定まる
    assert L * L != 0
    inv = QQ(1) / QQ(L * L)
    assert inv in QQ and inv > 0
    count += 1
    Z = open_partition_polynomial(L, L)
    assert Z.parent() is R
    configs = list(open_configurations(L, L))
    counts = [open_broken_bond_count(L, L, sigma) for sigma in configs]
    for q in Q_SAMPLES:
        # 2. Z^op_{L,L}(q) は多項式への代入。配位ごとの和と一致し、正
        value = Z(q)
        assert value.parent() is QQ
        assert value == sum((q ** bc for bc in counts), QQ(0))
        assert value > 0
        lam = log_lambda(value)
        assert all(p in ZZ and z in ZZ for p, z in lam.items())
        count += 3
        # Ψ^op_L(q) := (1/L²)·ι(log Z^op_{L,L}(q))
        psi = smul(inv, iota(lam))
        # 3. 各素数での値: 三段の鎖の各段
        for p in set(lam) | set(psi):
            step1 = inv * iota(lam).get(p, QQ(0))          # 有理数倍の定義
            step2 = inv * (QQ(lam.get(p, 0)) / QQ(1))     # ι の定義
            step3 = QQ(lam.get(p, 0)) / QQ(L * L)          # QQ の積
            assert psi.get(p, QQ(0)) == step1 == step2 == step3
            count += 1
        # 4. 台の一致
        assert set(psi) == set(lam)
        count += 1

# 5. 具体例 L = 2、q = 1/2
Z2 = open_partition_polynomial(2, 2)
assert Z2 == 2 + 12 * x**2 + 2 * x**4
assert QQ(Z2(QQ(1)/2)) == QQ(41) / QQ(8)
lam2 = log_lambda(QQ(Z2(QQ(1)/2)))
assert lam2 == {ZZ(41): ZZ(1), ZZ(2): ZZ(-3)}
psi2 = smul(QQ(1)/4, iota(lam2))
assert psi2 == {ZZ(41): QQ(1)/4, ZZ(2): QQ(-3)/4}
count += 1

print("PASS: open-square-free-entropy-density (%d checks)" % count)
