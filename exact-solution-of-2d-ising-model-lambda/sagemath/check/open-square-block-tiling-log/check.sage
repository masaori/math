# 対象ラベル: claim_open_square_block_tiling_log
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（claim_open_square_block_tiling_log の証明の中身）:
#   準備の第一: Z^op_{a,a}(q), Z^op_{ka,ka}(q) ∈ QQ_{>0}（ZZ[x] の開境界分配多項式への代入と
#               配位和の一致も見る）、両側の評価の値が QQ_{>0} の元であること。
#   準備の第二: log(q^{(k-1)(ka)} (q^{(k-1)a} Z^op_{a,a}(q)^k)^k)
#               = log q^{(k-1)(ka)} + log (q^{(k-1)a} Z^op_{a,a}(q)^k)^k
#               = (k-1)(ka) log q + k log(q^{(k-1)a} Z^op_{a,a}(q)^k)
#               = (k-1)(ka) log q + k (log q^{(k-1)a} + log Z^op_{a,a}(q)^k)
#               = (k-1)(ka) log q + k ((k-1)a log q + k log Z^op_{a,a}(q))
#               = (k-1)(ka) log q + k(k-1)a log q + (k·k) log Z^op_{a,a}(q)
#               = 2k(k-1)a log q + k² log Z^op_{a,a}(q)（各段を Λ の有限台辞書の等号で）。
#   準備の第三: log((Z^op_{a,a}(q)^k)^k) = k log(Z^op_{a,a}(q)^k) = k(k log Z^op_{a,a}(q))
#               = k² log Z^op_{a,a}(q)。
#   本体 0<q≤1: 2k(k-1)a log q + k² log Z^op_{a,a}(q) = log(下からの評価の値)
#               ≤_Λ log Z^op_{ka,ka}(q) ≤_Λ log(上からの評価の値) = k² log Z^op_{a,a}(q)。
#   本体 1≤q: 向きを反転した同じ鎖。
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


def check_block_tiling_log(a, k, q):
    checks = 0

    # 準備の第一: 値の正値性と、両側の評価の値が QQ_{>0} の元であること
    block = open_partition_value(a, a, q)          # Z^op_{a,a}(q) ∈ QQ_{>0}
    square = open_partition_value(k * a, k * a, q)  # Z^op_{ka,ka}(q) ∈ QQ_{>0}
    lower_value = q ** ((k - 1) * (k * a)) * (q ** ((k - 1) * a) * block ** k) ** k
    upper_value = (block ** k) ** k
    assert lower_value > 0 and upper_value > 0
    checks += 1

    log_q = log_lambda(q)
    log_block = log_lambda(block)
    log_square = log_lambda(square)

    # 準備の第二: 下からの評価の側の値の対数を Λ の中で開く六段
    lhs = log_lambda(lower_value)
    step1 = lam_add(log_lambda(q ** ((k - 1) * (k * a))),
                    log_lambda((q ** ((k - 1) * a) * block ** k) ** k))
    assert lhs == step1  # claim_log_additive
    step2 = lam_add(zsmul((k - 1) * (k * a), log_q),
                    zsmul(k, log_lambda(q ** ((k - 1) * a) * block ** k)))
    assert step1 == step2  # claim_log_power ×2
    step3 = lam_add(zsmul((k - 1) * (k * a), log_q),
                    zsmul(k, lam_add(log_lambda(q ** ((k - 1) * a)),
                                     log_lambda(block ** k))))
    assert step2 == step3  # claim_log_additive
    step4 = lam_add(zsmul((k - 1) * (k * a), log_q),
                    zsmul(k, lam_add(zsmul((k - 1) * a, log_q),
                                     zsmul(k, log_block))))
    assert step3 == step4  # claim_log_power ×2
    step5 = lam_add(lam_add(zsmul((k - 1) * (k * a), log_q),
                            zsmul(k * (k - 1) * a, log_q)),
                    zsmul(k * k, log_block))
    assert step4 == step5  # 整数倍の分配則と結合則（素数ごとの ZZ）
    prepared_lower = lam_add(zsmul(2 * k * (k - 1) * a, log_q),
                             zsmul(k ** 2, log_block))
    assert step5 == prepared_lower  # nλ+mλ=(n+m)λ と (k-1)(ka)+k(k-1)a=2k(k-1)a、k·k=k²
    checks += 6

    # 準備の第三: 上からの評価の側の値の対数を Λ の中で開く三段
    rhs = log_lambda(upper_value)
    r_step1 = zsmul(k, log_lambda(block ** k))
    assert rhs == r_step1  # claim_log_power
    r_step2 = zsmul(k, zsmul(k, log_block))
    assert r_step1 == r_step2  # claim_log_power
    prepared_upper = zsmul(k ** 2, log_block)
    assert r_step2 == prepared_upper  # 整数倍の結合則と k·k=k²
    checks += 3

    # 本体（q = 1 は両場合に属し、両方を見る）。
    # ≤_Λ の判定と、claim_rational_log_order_iff の移送（QQ の比較と一致）を各段で見る。
    if q <= 1:
        assert log_order_le(prepared_lower, log_square)
        assert lower_value <= square  # 順序の移送
        assert log_order_le(log_square, prepared_upper)
        assert square <= upper_value  # 順序の移送
        checks += 4
    if q >= 1:
        assert log_order_le(prepared_upper, log_square)
        assert upper_value <= square  # 順序の移送
        assert log_order_le(log_square, prepared_lower)
        assert square <= lower_value  # 順序の移送
        checks += 4

    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(1),
               QQ(3) / 2, QQ(22) / 7, QQ(5), QQ(11))
sizes = ((1, 1), (1, 2), (1, 3), (2, 1), (2, 2))
total = 0
for a, k in sizes:
    for q in test_points:
        total += check_block_tiling_log(a, k, q)

print(f"開境界正方形のブロック敷き詰め評価の対数化（Λ の鎖。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
