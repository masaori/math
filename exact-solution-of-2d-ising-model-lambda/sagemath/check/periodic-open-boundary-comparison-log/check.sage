# 対象ラベル: claim_periodic_open_boundary_comparison_log_le_one
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（claim_periodic_open_boundary_comparison_log_le_one の証明の中身。L ≥ 1、0 < q ≤ 1）:
#   準備の第一: Z_L(q), Z^op_{L,L}(q) ∈ QQ_{>0}、下端の値 q^{2L} Z^op_{L,L}(q) が QQ_{>0} の元であること。
#   準備の第二 二段: log(q^{2L} Z^op) = log q^{2L} + log Z^op   （claim_log_additive）
#                                    = 2L log q + log Z^op      （claim_log_power を k := 2L で）
#   本体: 2L log q + log Z^op = log(下端の値) ≤_Λ Φ_L(q) = log Z_L(q) ≤_Λ log Z^op_{L,L}(q)。
#   ≤_Λ は rat_Λ を通した QQ の比較（def_log_order_group_order）であり、
#   claim_rational_log_order_iff の移送（claim_periodic_open_boundary_comparison_rational の QQ の比較と一致すること）も見る。

from itertools import product


def vertices(L):
    return [(i, j) for i in range(L) for j in range(L)]


def configurations(L):
    points = vertices(L)
    for values in product((ZZ(1), ZZ(-1)), repeat=L * L):
        yield dict(zip(points, values))


def open_edges(L):
    # def_open_rectangle_edges（一辺 L の正方形）
    horizontal = [((i, j), (i, j + 1)) for i in range(L) for j in range(L - 1)]
    vertical = [((i, j), (i + 1, j)) for i in range(L - 1) for j in range(L)]
    return horizontal + vertical


def boundary_edges(L):
    # 周期境界にだけある境界横断辺（claim_periodic_open_boundary_comparison_rational の証明）
    horizontal = [((i, L - 1), (i, 0)) for i in range(L)]
    vertical = [((L - 1, j), (0, j)) for j in range(L)]
    return horizontal + vertical


def broken_count(edges, sigma):
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in edges)


R = PolynomialRing(ZZ, 'x')
x = R.gen()


def partition_polynomial(configs, edges):
    return sum((x ** broken_count(edges, sigma) for sigma in configs), R.zero())


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


def check_periodic_open_log(L, q):
    assert L >= 1 and 0 < q <= 1
    checks = 0
    configs = list(configurations(L))
    open_e = open_edges(L)
    periodic_e = open_e + boundary_edges(L)
    # 周期境界の分配多項式（def_partition_polynomial。L=1,2 では境界横断辺が重なるが多重辺として数える）
    Z_L = QQ(partition_polynomial(configs, periodic_e)(q))
    # 開境界正方形の値（def_open_rectangle_partition_value_at_positive_rational）
    Z_op = QQ(partition_polynomial(configs, open_e)(q))
    # 準備の第一
    assert Z_L > 0 and Z_op > 0                       # claim_value_at_rational_is_positive / 開境界の正値性
    lower_value = q ** (2 * L) * Z_op
    assert lower_value > 0
    checks += 1

    log_q = log_lambda(q)
    log_Zop = log_lambda(Z_op)
    Phi_L = log_lambda(Z_L)                          # def_finite_free_entropy: Φ_L(q) = log Z_L(q)

    # 準備の第二 二段
    step1 = lam_add(log_lambda(q ** (2 * L)), log_Zop)
    assert log_lambda(lower_value) == step1          # claim_log_additive
    prepared_lower = lam_add(zsmul(2 * L, log_q), log_Zop)
    assert step1 == prepared_lower                   # claim_log_power（k := 2L）
    checks += 2

    # 本体
    assert log_order_le(prepared_lower, Phi_L)
    assert lower_value <= Z_L                        # 順序の移送（claim_periodic_open_boundary_comparison_rational の下側）
    assert log_order_le(Phi_L, log_Zop)
    assert Z_L <= Z_op                               # 順序の移送（同・上側）
    checks += 4
    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
total = 0
for L in range(1, 4):
    for q in test_points:
        total += check_periodic_open_log(L, q)

print(f"周期境界と開境界の境界評価の対数化（Λ の鎖。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
