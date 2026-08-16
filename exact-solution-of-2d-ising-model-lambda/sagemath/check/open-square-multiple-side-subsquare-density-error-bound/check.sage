# 対象ラベル: claim_open_square_multiple_side_subsquare_density_error_bound
#
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
# 形は一辺 4 以上を含めない（4×4 の配位和は 10 分を超える。実測 2026-08-16）。したがって
# ka < L ≤ ka+a、a,k ≥ 1、L ≤ 3 を満たす (a,k,L) は (1,1,2)、(2,1,3)、(1,2,3) の三組である。
#
# 検査すること（claim_open_square_multiple_side_subsquare_density_error_bound の証明の中身）:
#   準備の第一: ka ≥ 1、ka < L。claim_open_square_subsquare_comparison_density_le_one を a := ka で読んだ両側の不等式。
#   準備の第二（QQ の三つの比較）: (ka+L)/L² ≤ (L+L)/L² = 2/L、
#               (L²−(ka)²)/L² ≤ 2aL/L² = 2a/L（claim_square_difference_from_multiple_side_bound）、
#               2(L²−(ka)²)/L² = 2·((L²−(ka)²)/L²) ≤ 2·(2a/L) = 4a/L。
#   準備の第三（符号）: ι(log q) ≤ ι(log 1) = ι(0) = 0（q ≤ 1）、0 = ι(0) = ι(log 1) ≤ ι(log 2) = ι(ℓ_2)、
#               0 = ι(0) = ι(log 1) ≤ ι(log(1+q))。
#   準備の第四（Λ_Q の三つの比較）: (2/L)·ι(log q) ≤ ((ka+L)/L²)·ι(log q)（非正・係数の大小）、
#               ((L²−(ka)²)/L²)·ι(ℓ_2) ≤ (2a/L)·ι(ℓ_2)、(2(L²−(ka)²)/L²)·ι(log(1+q)) ≤ (4a/L)·ι(log(1+q))（非負）。
#   本体の左: (2/L)·ι(log q) + ((ka)²/L²)·Ψ^op_{ka} ≤ ((ka+L)/L²)·ι(log q) + ((ka)²/L²)·Ψ^op_{ka} ≤ Ψ^op_L。
#   本体の右: Ψ^op_L ≤ ((L²−(ka)²)/L²)·ι(ℓ_2) + (2(L²−(ka)²)/L²)·ι(log(1+q)) + ((ka)²/L²)·Ψ^op_{ka}
#               ≤ (2a/L)·ι(ℓ_2) + (2(L²−(ka)²)/L²)·ι(log(1+q)) + ((ka)²/L²)·Ψ^op_{ka}
#               ≤ (2a/L)·ι(ℓ_2) + (4a/L)·ι(log(1+q)) + ((ka)²/L²)·Ψ^op_{ka}。
#   ≤_{Λ_Q} は def_rational_log_order_group_order の決定手続きで判定する。

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

_MULTIPLICITY_CACHE = {}


def open_multiplicities(a, b):
    # 破れボンド数 m ごとの配位の個数 Ω^op_{a,b}(m)（NN。形ごとに一度だけ数える）
    key = (a, b)
    if key not in _MULTIPLICITY_CACHE:
        counts = {}
        for sigma in open_configurations(a, b):
            m = open_broken_bond_count(a, b, sigma)
            counts[m] = counts.get(m, ZZ(0)) + 1
        _MULTIPLICITY_CACHE[key] = counts
    return _MULTIPLICITY_CACHE[key]


def open_partition_polynomial(a, b):
    # def_open_rectangle_partition_polynomial（ZZ[x] の元。配位ごとの x^m の和 = Σ_m Ω(m) x^m）
    return sum((ZZ(c) * x ** m for m, c in open_multiplicities(a, b).items()), R.zero())


def open_partition_value(a, b, q):
    # def_open_rectangle_partition_value_at_positive_rational（QQ の元）。
    # ZZ[x] の分配多項式へ q を代入した値が配位ごとの和（多重度でまとめたもの）と一致することも見る。
    value = QQ(open_partition_polynomial(a, b)(q))
    assert value == sum((ZZ(c) * q ** m for m, c in open_multiplicities(a, b).items()), QQ.zero())
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


def lamq_add(lam_q, mu_q):
    # Λ_Q の加法（def_rational_log_order_group。素数ごとの QQ の加法）
    out = dict(lam_q)
    for p, r in mu_q.items():
        out[p] = out.get(p, QQ(0)) + r
    return {p: r for p, r in out.items() if r != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}: 各素数の整数値を分母 1 の有理数として読む
    return {p: QQ(z) / QQ(1) for p, z in lam.items()}


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）
    return {p: QQ(r) * v for p, v in lam_q.items() if QQ(r) * v != 0}


def rat_of_log(lam):
    # rat_Λ（def_rational_of_log）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（def_log_order_group_order）
    return rat_of_log(lam) <= rat_of_log(mu)


def common_denominator(lam_q):
    # 両方の共通分母として、各素数での値の分母の最小公倍数を取る（def_common_denominator の意味で共通分母である。
    # def_rational_log_order_group_order は「ある共通分母で」と「すべての共通分母で」が同値なので、どの共通分母で
    # 判定してもよい。分母の積を取ると、台の素数が十数個あるとき冪の指数が 10^14 程度になり rat_Λ の計算が終わらない
    # ——実測 2026-08-16、この検査で 10 分を超えたので最小公倍数へ変えた）
    N = ZZ(1)
    for v in lam_q.values():
        N = lcm(N, v.denominator())
    return ZZ(N)


def witness_of_common_denominator(lam_q, N):
    # def_common_denominator の一意な証人 λ_N ∈ Λ（N·λ = ι(λ_N)）
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N * v)
        assert QQ(val) == N * v
        if val != 0:
            nu[p] = val
    return nu


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き（両方の共通分母 N での証人の Λ の比較）
    N = lcm(common_denominator(lam_q), common_denominator(mu_q))
    return log_order_le(witness_of_common_denominator(lam_q, N),
                        witness_of_common_denominator(mu_q, N))


def scaled_transfer_matches(inv, N, lam, mu):
    # claim_scaled_embedding_order_transfer: (1/N)·ι(λ) ≤_{Λ_Q} (1/N)·ι(μ) ⟺ λ ≤_Λ μ。
    # N は両辺の共通分母で、証人は λ, μ 自身。
    left, right = qsmul(inv, iota(lam)), qsmul(inv, iota(mu))
    assert qsmul(N, left) == iota(lam) and qsmul(N, right) == iota(mu)
    return rational_log_order_le(left, right) == log_order_le(lam, mu)


def check_error_bound(a, k, L, q):
    assert a >= 1 and k >= 1 and k * a < L <= k * a + a and 0 < q <= 1
    checks = 0
    ka = ZZ(k * a)
    N = ZZ(L ** 2)

    # 準備の第一: ka ≥ 1、ka < L。部分正方形比較を a := ka で読む
    assert ka >= 1 and ka < L
    block = open_partition_value(ka, ka, q)   # Z^op_{ka,ka}(q)
    square = open_partition_value(L, L, q)    # Z^op_{L,L}(q)
    log_q, log_1q, ell_2 = log_lambda(q), log_lambda(1 + q), log_lambda(QQ(2))
    psi_ka = qsmul(QQ(1) / QQ(ka ** 2), iota(log_lambda(block)))   # Ψ^op_{ka}(q)
    psi_L = qsmul(QQ(1) / QQ(N), iota(log_lambda(square)))         # Ψ^op_L(q)
    ratio = QQ(ka ** 2) / QQ(N)                                    # (ka)²/L²
    n = ZZ(L ** 2 - ka ** 2)
    c_low, c_up1, c_up2 = QQ(ka + L) / QQ(N), QQ(n) / QQ(N), QQ(2 * n) / QQ(N)
    low_form = lamq_add(qsmul(c_low, iota(log_q)), qsmul(ratio, psi_ka))
    up_form = lamq_add(lamq_add(qsmul(c_up1, iota(ell_2)), qsmul(c_up2, iota(log_1q))), qsmul(ratio, psi_ka))
    assert rational_log_order_le(low_form, psi_L)   # 第一の左
    assert rational_log_order_le(psi_L, up_form)    # 第一の右
    checks += 3

    # 準備の第二: QQ の三つの比較
    two_L, two_a_L, four_a_L = QQ(2) / QQ(L), QQ(2 * a) / QQ(L), QQ(4 * a) / QQ(L)
    assert ka + L <= L + L and c_low <= QQ(L + L) / QQ(N) and QQ(L + L) / QQ(N) == two_L
    assert n <= 2 * a * L and c_up1 <= QQ(2 * a * L) / QQ(N) and QQ(2 * a * L) / QQ(N) == two_a_L  # 倍数辺との平方の差
    assert c_up2 == 2 * c_up1 and 2 * c_up1 <= 2 * two_a_L and 2 * two_a_L == four_a_L
    checks += 3

    # 準備の第三: 符号
    zero = {}
    assert log_lambda(QQ(1)) == {} and iota({}) == zero            # log 1 = 0、ι(0) = 0
    assert rational_log_order_le(iota(log_q), iota(log_lambda(QQ(1))))   # q ≤ 1 を移す
    assert rational_log_order_le(iota(log_q), zero)
    assert rational_log_order_le(iota(log_lambda(QQ(1))), iota(log_lambda(QQ(2)))) and log_lambda(QQ(2)) == ell_2
    assert rational_log_order_le(zero, iota(ell_2))
    assert 1 <= 1 + q and rational_log_order_le(iota(log_lambda(QQ(1))), iota(log_1q))
    assert rational_log_order_le(zero, iota(log_1q))
    checks += 3

    # 準備の第四: Λ_Q の三つの比較
    assert rational_log_order_le(qsmul(two_L, iota(log_q)), qsmul(c_low, iota(log_q)))          # 非正: s·ν ≤ r·ν
    assert rational_log_order_le(qsmul(c_up1, iota(ell_2)), qsmul(two_a_L, iota(ell_2)))        # 非負: r·ν ≤ s·ν
    assert rational_log_order_le(qsmul(c_up2, iota(log_1q)), qsmul(four_a_L, iota(log_1q)))
    checks += 3

    # 本体の左（二段）と右（三段）
    lower = lamq_add(qsmul(two_L, iota(log_q)), qsmul(ratio, psi_ka))
    assert rational_log_order_le(lower, low_form)   # 加法単調性
    assert rational_log_order_le(low_form, psi_L)
    assert rational_log_order_le(lower, psi_L)      # 推移律の結論
    mid = lamq_add(lamq_add(qsmul(two_a_L, iota(ell_2)), qsmul(c_up2, iota(log_1q))), qsmul(ratio, psi_ka))
    upper = lamq_add(lamq_add(qsmul(two_a_L, iota(ell_2)), qsmul(four_a_L, iota(log_1q))), qsmul(ratio, psi_ka))
    assert rational_log_order_le(psi_L, up_form)
    assert rational_log_order_le(up_form, mid)      # 加法単調性（第一項）
    assert rational_log_order_le(mid, upper)        # 加法単調性（第二項）
    assert rational_log_order_le(psi_L, upper)      # 推移律の結論
    checks += 7
    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
sizes = ((1, 1, 2), (2, 1, 3), (1, 2, 3))
total = 0
for a, k, L in sizes:
    for q in test_points:
        total += check_error_bound(a, k, L, q)

print(f"倍数辺の部分正方形による密度の挟み込みの誤差評価（q は 1 以下。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
