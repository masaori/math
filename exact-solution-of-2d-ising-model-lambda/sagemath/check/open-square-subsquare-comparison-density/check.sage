# 対象ラベル: claim_open_square_subsquare_comparison_density_le_one
#
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
# 形は一辺 4 以上を含めない（4×4 の配位和は 10 分を超える。実測 2026-08-16）。
#
# 検査すること（claim_open_square_subsquare_comparison_density_le_one の証明の中身。n := L² − a²）:
#   準備の第一: Z^op_{a,a}(q), Z^op_{L,L}(q) ∈ QQ_{>0}（ZZ[x] の開境界分配多項式への代入と配位和の一致も見る）、
#               a² ≠ 0、L² ≠ 0。
#   準備の第二: (1/L²)·ι(log Z^op_{a,a}(q)) = ((a²/L²)·(1/a²))·ι(log Z^op_{a,a}(q))
#               = (a²/L²)·((1/a²)·ι(log Z^op_{a,a}(q))) = (a²/L²)·Ψ^op_a(q)（三段）。
#   準備の第三（下からの評価の側）: (1/L²)·ι((a+L) log q + log Z^op_{a,a}(q))
#               = (1/L²)·(ι((a+L) log q) + ι(log Z^op_{a,a}(q)))
#               = (1/L²)·ι((a+L) log q) + (1/L²)·ι(log Z^op_{a,a}(q))
#               = (1/L²)·((a+L)·ι(log q)) + (1/L²)·ι(log Z^op_{a,a}(q))
#               = ((1/L²)·(a+L))·ι(log q) + (1/L²)·ι(log Z^op_{a,a}(q))
#               = ((a+L)/L²)·ι(log q) + (1/L²)·ι(log Z^op_{a,a}(q))
#               = ((a+L)/L²)·ι(log q) + (a²/L²)·Ψ^op_a(q)（六段）。
#   準備の第四（上からの評価の側）: (1/L²)·ι(n ℓ_2 + 2n log(1+q) + log Z^op_{a,a}(q))
#               = (1/L²)·(ι(n ℓ_2) + ι(2n log(1+q)) + ι(log Z^op_{a,a}(q)))
#               = (1/L²)·ι(n ℓ_2) + (1/L²)·ι(2n log(1+q)) + (1/L²)·ι(log Z^op_{a,a}(q))
#               = (1/L²)·(n·ι(ℓ_2)) + (1/L²)·(2n·ι(log(1+q))) + (1/L²)·ι(log Z^op_{a,a}(q))
#               = ((1/L²)·n)·ι(ℓ_2) + ((1/L²)·2n)·ι(log(1+q)) + (1/L²)·ι(log Z^op_{a,a}(q))
#               = ((L²−a²)/L²)·ι(ℓ_2) + (2(L²−a²)/L²)·ι(log(1+q)) + (1/L²)·ι(log Z^op_{a,a}(q))
#               = ((L²−a²)/L²)·ι(ℓ_2) + (2(L²−a²)/L²)·ι(log(1+q)) + (a²/L²)·Ψ^op_a(q)（六段）。
#   本体 0<q≤1: ((a+L)/L²)·ι(log q) + (a²/L²)·Ψ^op_a(q) = (1/L²)·ι((a+L) log q + log Z^op_{a,a}(q))
#               ≤_{Λ_Q} (1/L²)·ι(log Z^op_{L,L}(q)) = Ψ^op_L(q)、
#               Ψ^op_L(q) = (1/L²)·ι(log Z^op_{L,L}(q)) ≤_{Λ_Q} (1/L²)·ι(n ℓ_2 + 2n log(1+q) + log Z^op_{a,a}(q))
#               = ((L²−a²)/L²)·ι(ℓ_2) + (2(L²−a²)/L²)·ι(log(1+q)) + (a²/L²)·Ψ^op_a(q)。
#   ≤_{Λ_Q} は def_rational_log_order_group_order の決定手続きで判定し、加えて
#   claim_scaled_embedding_order_transfer の移送（N=L² を共通分母とする証人の Λ の比較＝
#   claim_open_square_subsquare_comparison_log_le_one の Λ の比較）と一致することも各段で見る。

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


def check_block_tiling_density(a, k, q):
    checks = 0


def check_subsquare_density(a, L, q):
    assert 1 <= a < L and 0 < q <= 1
    checks = 0

    # 準備の第一
    block = open_partition_value(a, a, q)   # Z^op_{a,a}(q) ∈ QQ_{>0}
    square = open_partition_value(L, L, q)  # Z^op_{L,L}(q) ∈ QQ_{>0}
    N = ZZ(L ** 2)
    assert ZZ(a ** 2) != 0 and N != 0
    inv = QQ(1) / QQ(N)                     # 1/L²
    inv_a = QQ(1) / QQ(a ** 2)              # 1/a²
    ratio = QQ(a ** 2) / QQ(N)              # a²/L²
    n = ZZ(L ** 2 - a ** 2)                 # n := L² − a² ∈ NN
    assert n >= 0
    checks += 1

    log_q = log_lambda(q)
    log_1q = log_lambda(1 + q)
    ell_2 = log_lambda(QQ(2))               # ℓ_2 = log 2（有限台辞書 {2 ↦ 1}）
    assert ell_2 == {ZZ(2): ZZ(1)}
    log_block = log_lambda(block)
    log_square = log_lambda(square)
    prepared_lower = lam_add(zsmul(a + L, log_q), log_block)                                   # Λ の鎖の下側
    prepared_upper = lam_add(lam_add(zsmul(n, ell_2), zsmul(2 * n, log_1q)), log_block)        # Λ の鎖の上側

    psi_a = qsmul(inv_a, iota(log_block))   # Ψ^op_a(q)（def_open_square_free_entropy_density）
    psi_L = qsmul(inv, iota(log_square))    # Ψ^op_L(q)
    coeff_low = QQ(a + L) / QQ(N)           # (a+L)/L²
    coeff_up1 = QQ(n) / QQ(N)               # (L²−a²)/L²
    coeff_up2 = QQ(2 * n) / QQ(N)           # 2(L²−a²)/L²
    low_form = lamq_add(qsmul(coeff_low, iota(log_q)), qsmul(ratio, psi_a))
    up_form = lamq_add(lamq_add(qsmul(coeff_up1, iota(ell_2)), qsmul(coeff_up2, iota(log_1q))), qsmul(ratio, psi_a))

    # 準備の第二の三段
    b0 = qsmul(inv, iota(log_block))
    assert ratio * inv_a == inv  # QQ の約分 (a²/L²)·(1/a²) = 1/L²
    b1 = qsmul(ratio * inv_a, iota(log_block))
    assert b0 == b1
    b2 = qsmul(ratio, qsmul(inv_a, iota(log_block)))
    assert b1 == b2  # 有理数倍の結合則
    assert b2 == qsmul(ratio, psi_a)  # def_open_square_free_entropy_density を L := a で
    checks += 3

    # 準備の第三（下からの評価の側）の六段
    l0 = qsmul(inv, iota(prepared_lower))
    l1 = qsmul(inv, lamq_add(iota(zsmul(a + L, log_q)), iota(log_block)))
    assert l0 == l1  # ι は加法を保つ
    l2 = lamq_add(qsmul(inv, iota(zsmul(a + L, log_q))), qsmul(inv, iota(log_block)))
    assert l1 == l2  # 有理数倍の分配則
    l3 = lamq_add(qsmul(inv, qsmul(a + L, iota(log_q))), qsmul(inv, iota(log_block)))
    assert l2 == l3  # n·ι(ν) = ι(nν) を右辺から左辺の向きで
    l4 = lamq_add(qsmul(inv * (a + L), iota(log_q)), qsmul(inv, iota(log_block)))
    assert l3 == l4  # 有理数倍の結合則
    assert inv * (a + L) == coeff_low  # QQ の積 (1/L²)·(a+L) = (a+L)/L²
    l5 = lamq_add(qsmul(coeff_low, iota(log_q)), qsmul(inv, iota(log_block)))
    assert l4 == l5
    assert l5 == low_form  # 準備の第二
    checks += 6

    # 準備の第四（上からの評価の側）の六段
    u0 = qsmul(inv, iota(prepared_upper))
    u1 = qsmul(inv, lamq_add(lamq_add(iota(zsmul(n, ell_2)), iota(zsmul(2 * n, log_1q))), iota(log_block)))
    assert u0 == u1  # ι は加法を保つ（二回）
    u2 = lamq_add(lamq_add(qsmul(inv, iota(zsmul(n, ell_2))), qsmul(inv, iota(zsmul(2 * n, log_1q)))),
                  qsmul(inv, iota(log_block)))
    assert u1 == u2  # 有理数倍の分配則（二回）
    u3 = lamq_add(lamq_add(qsmul(inv, qsmul(n, iota(ell_2))), qsmul(inv, qsmul(2 * n, iota(log_1q)))),
                  qsmul(inv, iota(log_block)))
    assert u2 == u3  # n·ι(ν) = ι(nν) を二項へ同時に右辺から左辺の向きで
    u4 = lamq_add(lamq_add(qsmul(inv * n, iota(ell_2)), qsmul(inv * (2 * n), iota(log_1q))),
                  qsmul(inv, iota(log_block)))
    assert u3 == u4  # 有理数倍の結合則（二項へ同時）
    assert inv * n == coeff_up1 and inv * (2 * n) == coeff_up2  # QQ の積
    u5 = lamq_add(lamq_add(qsmul(coeff_up1, iota(ell_2)), qsmul(coeff_up2, iota(log_1q))),
                  qsmul(inv, iota(log_block)))
    assert u4 == u5
    assert u5 == up_form  # 準備の第二
    checks += 6

    # 本体（0<q≤1）。各段で決定手続きと順序の移送の一致を見る。
    assert scaled_transfer_matches(inv, N, prepared_lower, log_square)
    assert log_order_le(prepared_lower, log_square)      # claim_open_square_subsquare_comparison_log_le_one の左
    assert rational_log_order_le(low_form, psi_L)        # 左の不等式
    assert scaled_transfer_matches(inv, N, log_square, prepared_upper)
    assert log_order_le(log_square, prepared_upper)      # claim_open_square_subsquare_comparison_log_le_one の右
    assert rational_log_order_le(psi_L, up_form)         # 右の不等式
    checks += 6

    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
sizes = ((1, 2), (1, 3), (2, 3))
total = 0
for a, L in sizes:
    for q in test_points:
        total += check_subsquare_density(a, L, q)

print(f"開境界正方形と部分正方形の比較による密度の挟み込み（Λ_Q 版。q は 1 以下。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
