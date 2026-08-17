# 対象ラベル: claim_periodic_open_boundary_comparison_density_le_one
#
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（claim_periodic_open_boundary_comparison_density_le_one の証明の中身。L ≥ 1、0 < q ≤ 1）:
#   準備の第一: Z_L(q), Z^op_{L,L}(q) ∈ QQ_{>0}、L ≠ 0、L² ≠ 0。
#   準備の第二（下からの評価の側）: (1/L²)·ι(2L log q + log Z^op_{L,L}(q))
#               = (1/L²)·(ι(2L log q) + ι(log Z^op_{L,L}(q)))
#               = (1/L²)·ι(2L log q) + (1/L²)·ι(log Z^op_{L,L}(q))
#               = (1/L²)·(2L·ι(log q)) + (1/L²)·ι(log Z^op_{L,L}(q))
#               = ((1/L²)·2L)·ι(log q) + (1/L²)·ι(log Z^op_{L,L}(q))
#               = (2/L)·ι(log q) + (1/L²)·ι(log Z^op_{L,L}(q))
#               = (2/L)·ι(log q) + Ψ^op_L(q)
#               = Ψ^op_L(q) + (2/L)·ι(log q)（七段）。
#   本体 0<q≤1: Ψ^op_L(q) + (2/L)·ι(log q) = (1/L²)·ι(2L log q + log Z^op_{L,L}(q))
#               ≤_{Λ_Q} (1/L²)·ι(Φ_L(q)) = Ψ_L(q)、
#               Ψ_L(q) = (1/L²)·ι(Φ_L(q)) ≤_{Λ_Q} (1/L²)·ι(log Z^op_{L,L}(q)) = Ψ^op_L(q)。
#   ≤_{Λ_Q} は def_rational_log_order_group_order の決定手続きで判定し、加えて
#   claim_scaled_embedding_order_transfer の移送（N=L² を共通分母とする証人の Λ の比較＝
#   claim_periodic_open_boundary_comparison_log_le_one の Λ の比較）と一致することも各段で見る。

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
    # 各素数での値の分母の最小公倍数（def_common_denominator の意味で共通分母。どの共通分母で判定してもよい）
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
    left, right = qsmul(inv, iota(lam)), qsmul(inv, iota(mu))
    assert qsmul(N, left) == iota(lam) and qsmul(N, right) == iota(mu)
    return rational_log_order_le(left, right) == log_order_le(lam, mu)


def check_periodic_open_density(L, q):
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
    assert Z_L > 0 and Z_op > 0
    N = ZZ(L ** 2)
    assert ZZ(L) != 0 and N != 0
    inv = QQ(1) / QQ(N)                     # 1/L²
    coeff = QQ(2) / QQ(L)                   # 2/L
    checks += 1

    log_q = log_lambda(q)
    log_Zop = log_lambda(Z_op)
    Phi_L = log_lambda(Z_L)                          # def_finite_free_entropy: Φ_L(q) = log Z_L(q)
    prepared_lower = lam_add(zsmul(2 * L, log_q), log_Zop)   # Λ の鎖の下側

    psi_L = qsmul(inv, iota(Phi_L))         # Ψ_L(q)（def_finite_free_entropy_density）
    psi_op = qsmul(inv, iota(log_Zop))      # Ψ^op_L(q)（def_open_square_free_entropy_density）
    low_form = lamq_add(psi_op, qsmul(coeff, iota(log_q)))

    # 準備の第二の七段
    l0 = qsmul(inv, iota(prepared_lower))
    l1 = qsmul(inv, lamq_add(iota(zsmul(2 * L, log_q)), iota(log_Zop)))
    assert l0 == l1  # ι は加法を保つ
    l2 = lamq_add(qsmul(inv, iota(zsmul(2 * L, log_q))), qsmul(inv, iota(log_Zop)))
    assert l1 == l2  # 有理数倍の分配則
    l3 = lamq_add(qsmul(inv, qsmul(2 * L, iota(log_q))), qsmul(inv, iota(log_Zop)))
    assert l2 == l3  # n·ι(ν) = ι(nν) を右辺から左辺の向きで
    l4 = lamq_add(qsmul(inv * (2 * L), iota(log_q)), qsmul(inv, iota(log_Zop)))
    assert l3 == l4  # 有理数倍の結合則
    assert inv * (2 * L) == coeff  # QQ の約分 (1/L²)·2L = 2/L
    l5 = lamq_add(qsmul(coeff, iota(log_q)), qsmul(inv, iota(log_Zop)))
    assert l4 == l5
    l6 = lamq_add(qsmul(coeff, iota(log_q)), psi_op)
    assert l5 == l6  # def_open_square_free_entropy_density
    assert l6 == low_form  # 加法の可換性
    checks += 7

    # 本体（0<q≤1）。各段で決定手続きと順序の移送の一致を見る。
    assert scaled_transfer_matches(inv, N, prepared_lower, Phi_L)
    assert log_order_le(prepared_lower, Phi_L)           # claim_periodic_open_boundary_comparison_log_le_one の左
    assert rational_log_order_le(low_form, psi_L)        # 左の不等式
    assert scaled_transfer_matches(inv, N, Phi_L, log_Zop)
    assert log_order_le(Phi_L, log_Zop)                  # claim_periodic_open_boundary_comparison_log_le_one の右
    assert rational_log_order_le(psi_L, psi_op)          # 右の不等式
    checks += 6
    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
total = 0
for L in range(1, 4):
    for q in test_points:
        total += check_periodic_open_density(L, q)

print(f"周期境界と開境界の密度の比較（Λ_Q 版。q は 1 以下。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
