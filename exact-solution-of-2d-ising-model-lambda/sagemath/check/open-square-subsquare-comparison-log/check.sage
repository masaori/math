# 対象ラベル: claim_open_square_subsquare_comparison_log_le_one
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（claim_open_square_subsquare_comparison_log_le_one の証明の中身。1 ≤ a < L、0 < q ≤ 1）:
#   準備の第一: Z^op_{a,a}(q), Z^op_{L,L}(q) ∈ QQ_{>0}、両端の値 q^{a+L} Z^op_{a,a}(q)、
#               2^{L²-a²}(1+q)^{2(L²-a²)} Z^op_{a,a}(q) が QQ_{>0} の元であること。
#   準備の第二: log 2 = ℓ_2（有限台辞書 {2: 1}）。
#   準備の第三（前半）二段: log(q^{a+L} Z_{a,a}) = log q^{a+L} + log Z_{a,a}   （claim_log_additive）
#                                            = (a+L) log q + log Z_{a,a}     （claim_log_power）
#   準備の第三（後半）四段: log(2^n (1+q)^{2n} Z_{a,a}) = log(2^n (1+q)^{2n}) + log Z_{a,a}   （claim_log_additive）
#                    = log 2^n + log (1+q)^{2n} + log Z_{a,a}                                （claim_log_additive）
#                    = n log 2 + 2n log(1+q) + log Z_{a,a}                                  （claim_log_power ×2）
#                    = n ℓ_2 + 2n log(1+q) + log Z_{a,a}                                    （準備の第二）、n := L²-a²
#   本体: (a+L) log q + log Z_{a,a} = log(下端の値) ≤_Λ log Z_{L,L} ≤_Λ log(上端の値) = n ℓ_2 + 2n log(1+q) + log Z_{a,a}。
#   ≤_Λ は rat_Λ を通した QQ の比較（def_log_order_group_order）であり、
#   claim_rational_log_order_iff の移送（claim_open_square_subsquare_comparison_rational_le_one の QQ の比較と一致すること）も見る。

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


ELL_2 = {ZZ(2): ZZ(1)}


def check_subsquare_log(a, L, q):
    assert 1 <= a < L and 0 < q <= 1
    checks = 0
    n = ZZ(L * L - a * a)
    Za = open_partition_value(a, a, q)
    ZL = open_partition_value(L, L, q)
    # 準備の第一
    lower_value = q ** (a + L) * Za
    upper_value = ZZ(2) ** n * (1 + q) ** (2 * n) * Za
    assert lower_value > 0 and upper_value > 0
    checks += 1
    # 準備の第二
    assert log_lambda(QQ(2)) == ELL_2
    checks += 1

    log_q = log_lambda(q)
    log_Za = log_lambda(Za)
    log_ZL = log_lambda(ZL)
    log_1q = log_lambda(1 + q)

    # 準備の第三（前半）二段
    step1 = lam_add(log_lambda(q ** (a + L)), log_Za)
    assert log_lambda(lower_value) == step1  # claim_log_additive
    prepared_lower = lam_add(zsmul(a + L, log_q), log_Za)
    assert step1 == prepared_lower  # claim_log_power
    checks += 2
    # 準備の第三（後半）四段
    u1 = lam_add(log_lambda(ZZ(2) ** n * (1 + q) ** (2 * n)), log_Za)
    assert log_lambda(upper_value) == u1  # claim_log_additive
    u2 = lam_add(lam_add(log_lambda(ZZ(2) ** n), log_lambda((1 + q) ** (2 * n))), log_Za)
    assert u1 == u2  # claim_log_additive
    u3 = lam_add(lam_add(zsmul(n, log_lambda(QQ(2))), zsmul(2 * n, log_1q)), log_Za)
    assert u2 == u3  # claim_log_power ×2
    prepared_upper = lam_add(lam_add(zsmul(n, ELL_2), zsmul(2 * n, log_1q)), log_Za)
    assert u3 == prepared_upper  # 準備の第二
    checks += 4

    # 本体
    assert log_order_le(prepared_lower, log_ZL)
    assert lower_value <= ZL  # 順序の移送（claim_open_square_subsquare_comparison_rational_le_one の下側）
    assert log_order_le(log_ZL, prepared_upper)
    assert ZL <= upper_value  # 順序の移送（同・上側）
    checks += 4
    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
# 一辺 4 以上は含めない（4×4 の配位和は 10 分を超える）
shapes = ((1, 2), (1, 3), (2, 3))
total = 0
for a, L in shapes:
    for q in test_points:
        total += check_subsquare_log(a, L, q)

print(f"開境界正方形と部分正方形の比較の対数化（Λ の鎖。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
