# 対象ラベル: claim_open_rectangle_gluing_inequality_log
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（claim_open_rectangle_gluing_inequality_log の証明の中身。第一の座標の向き）:
#   準備の第一: Z^op_{a,b}(q), Z^op_{c,b}(q), Z^op_{a+c,b}(q) ∈ QQ_{>0}、両端の値が QQ_{>0} の元であること。
#   準備の第二（前半）: log(q^b Z^op_{a,b}(q) Z^op_{c,b}(q))
#               = log q^b + log(Z^op_{a,b}(q) Z^op_{c,b}(q))          （claim_log_additive）
#               = b log q + log(Z^op_{a,b}(q) Z^op_{c,b}(q))          （claim_log_power）
#               = b log q + log Z^op_{a,b}(q) + log Z^op_{c,b}(q)      （claim_log_additive）
#   準備の第二（後半）: log(Z^op_{a,b}(q) Z^op_{c,b}(q)) = log Z^op_{a,b}(q) + log Z^op_{c,b}(q)
#   本体 0<q≤1: b log q + log Z_{a,b} + log Z_{c,b} = log(下端の値) ≤_Λ log Z_{a+c,b} ≤_Λ log(上端の値)
#               = log Z_{a,b} + log Z_{c,b}。
#   本体 1≤q: 向きを反転した同じ鎖。
#   第二の座標の向き: b→a、Z_{c,b}→Z_{a,c}、Z_{a+c,b}→Z_{a,b+c} と置き換えた同じ段。
#   ≤_Λ は rat_Λ を通した QQ の比較（def_log_order_group_order）であり、
#   claim_rational_log_order_iff の移送（QQ の比較と一致すること）も見る。

from itertools import product



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


R = PolynomialRing(ZZ, 'x')
x = R.gen()


def open_partition_polynomial(a, b):
    # def_open_rectangle_partition_polynomial（ZZ[x] の元）
    return sum((x ** open_broken_bond_count(a, b, sigma)
                for sigma in open_configurations(a, b)), R.zero())


def open_partition_value(a, b, q):
    # def_open_rectangle_partition_value_at_positive_rational（QQ の元）。
    # ZZ[x] の分配多項式へ q を代入した値が配位ごとの和と一致することも見る。
    value = QQ(open_partition_polynomial(a, b)(q))
    assert value == sum((q ** open_broken_bond_count(a, b, sigma)
                         for sigma in open_configurations(a, b)), QQ.zero())
    # claim_open_rectangle_value_at_rational_is_positive
    assert value > 0
    return value


def log_lambda(q):
    # 正の有理数の対数（def_rational_log）: 素因数分解の指数ベクトル（Λ の有限台辞書）
    assert q > 0
    return {ZZ(p): ZZ(e) for p, e in QQ(q).factor() if e != 0}


def lam_add(lam, mu):
    # Λ の加法（def_log_order_group。素数ごとの ZZ の加法）
    out = dict(lam)
    for p, z in mu.items():
        out[p] = out.get(p, ZZ(0)) + z
    return {p: z for p, z in out.items() if z != 0}


def zsmul(n, lam):
    # Λ の整数倍（def_log_order_group。素数ごとの ZZ の積）
    return {p: ZZ(n) * z for p, z in lam.items() if n * z != 0}


def rat_of_log(lam):
    # rat_Λ（def_rational_of_log）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（def_log_order_group_order）
    return rat_of_log(lam) <= rat_of_log(mu)


def check_gluing_log(a, b, c, q, direction):
    # direction 'first': (a,b),(c,b) → (a+c,b)、係数 b。 'second': (a,b),(a,c) → (a,b+c)、係数 a。
    checks = 0
    if direction == 'first':
        left = open_partition_value(a, b, q)
        right = open_partition_value(c, b, q)
        glued = open_partition_value(a + c, b, q)
        coeff = b
    else:
        left = open_partition_value(a, b, q)
        right = open_partition_value(a, c, q)
        glued = open_partition_value(a, b + c, q)
        coeff = a
    # 準備の第一
    lower_value = q ** coeff * left * right
    upper_value = left * right
    assert lower_value > 0 and upper_value > 0
    checks += 1

    log_q = log_lambda(q)
    log_left = log_lambda(left)
    log_right = log_lambda(right)
    log_glued = log_lambda(glued)

    # 準備の第二（前半）三段
    lhs = log_lambda(lower_value)
    step1 = lam_add(log_lambda(q ** coeff), log_lambda(left * right))
    assert lhs == step1  # claim_log_additive
    step2 = lam_add(zsmul(coeff, log_q), log_lambda(left * right))
    assert step1 == step2  # claim_log_power
    prepared_lower = lam_add(lam_add(zsmul(coeff, log_q), log_left), log_right)
    assert step2 == prepared_lower  # claim_log_additive
    checks += 3
    # 準備の第二（後半）一段
    prepared_upper = lam_add(log_left, log_right)
    assert log_lambda(upper_value) == prepared_upper  # claim_log_additive
    checks += 1

    # 本体（q = 1 は両場合に属し、両方を見る）
    if q <= 1:
        assert log_order_le(prepared_lower, log_glued)
        assert lower_value <= glued  # 順序の移送
        assert log_order_le(log_glued, prepared_upper)
        assert glued <= upper_value  # 順序の移送
        checks += 4
    if q >= 1:
        assert log_order_le(prepared_upper, log_glued)
        assert upper_value <= glued  # 順序の移送
        assert log_order_le(log_glued, prepared_lower)
        assert glued <= lower_value  # 順序の移送
        checks += 4
    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(1),
               QQ(3) / 2, QQ(22) / 7, QQ(5), QQ(11))
# 接いだ側の一辺が 4 以上にならない形（4×3 までは秒で終わる。4×4 は 10 分超）
shapes = ((1, 1, 1), (1, 1, 2), (1, 2, 1), (2, 1, 1), (1, 2, 2), (2, 2, 1),
          (1, 3, 1), (2, 1, 2), (1, 3, 2), (2, 3, 1))
total = 0
for a, b, c in shapes:
    for q in test_points:
        total += check_gluing_log(a, b, c, q, 'first')
        total += check_gluing_log(a, b, c, q, 'second')

print(f"開境界長方形の接合不等式の対数化（Λ の鎖。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
