# 対象ラベル: claim_open_square_block_tiling_density
# 実測 2026-08-16: 形 (2,2)（4×4 の正方形）を含めると 10 分を超えたので外した。含める場合は計算を軽くすること。
#
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（claim_open_square_block_tiling_density の証明の中身）:
#   準備の第一: Z^op_{a,a}(q), Z^op_{ka,ka}(q) ∈ QQ_{>0}（ZZ[x] の開境界分配多項式への代入と
#               配位和の一致も見る）、(ka)² ≠ 0。
#   準備の第二（上からの評価の側）: (1/(ka)²)·ι(k² log Z^op_{a,a}(q))
#               = (1/(ka)²)·(k²·ι(log Z^op_{a,a}(q))) = ((1/(ka)²)·k²)·ι(log Z^op_{a,a}(q))
#               = (1/a²)·ι(log Z^op_{a,a}(q)) = Ψ^op_a(q)（各段を Λ_Q の有限台辞書の等号で）。
#   準備の第三（下からの評価の側）: (1/(ka)²)·ι(2k(k-1)a log q + k² log Z^op_{a,a}(q))
#               = (1/(ka)²)·(ι(2k(k-1)a log q) + ι(k² log Z^op_{a,a}(q)))
#               = (1/(ka)²)·ι(2k(k-1)a log q) + (1/(ka)²)·ι(k² log Z^op_{a,a}(q))
#               = (1/(ka)²)·(2k(k-1)a·ι(log q)) + (1/(ka)²)·ι(k² log Z^op_{a,a}(q))
#               = ((1/(ka)²)·2k(k-1)a)·ι(log q) + (1/(ka)²)·ι(k² log Z^op_{a,a}(q))
#               = (2(k-1)/(ka))·ι(log q) + (1/(ka)²)·ι(k² log Z^op_{a,a}(q))
#               = (2(k-1)/(ka))·ι(log q) + Ψ^op_a(q)。
#   本体 0<q≤1: (2(k-1)/(ka))·ι(log q) + Ψ^op_a(q) = (1/(ka)²)·ι(2k(k-1)a log q + k² log Z^op_{a,a}(q))
#               ≤_{Λ_Q} (1/(ka)²)·ι(log Z^op_{ka,ka}(q)) = Ψ^op_{ka}(q)、
#               Ψ^op_{ka}(q) = (1/(ka)²)·ι(log Z^op_{ka,ka}(q)) ≤_{Λ_Q} (1/(ka)²)·ι(k² log Z^op_{a,a}(q)) = Ψ^op_a(q)。
#   本体 1≤q: 向きを反転した同じ鎖。
#   ≤_{Λ_Q} は def_rational_log_order_group_order の決定手続きで判定し、加えて
#   claim_scaled_embedding_order_transfer の移送（N=(ka)² を共通分母とする証人の Λ の比較＝
#   claim_open_square_block_tiling_log の Λ の比較）と一致することも各段で見る。

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


def denominator_product(lam_q):
    N = ZZ(1)
    for v in lam_q.values():
        N *= v.denominator()
    return N


def witness_of_denominator_product(lam_q):
    N = denominator_product(lam_q)
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N // v.denominator()) * ZZ(v.numerator())
        if val != 0:
            nu[p] = val
    return nu


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き
    Nl, Nm = denominator_product(lam_q), denominator_product(mu_q)
    return log_order_le(zsmul(Nm, witness_of_denominator_product(lam_q)),
                        zsmul(Nl, witness_of_denominator_product(mu_q)))


def scaled_transfer_matches(inv, N, lam, mu):
    # claim_scaled_embedding_order_transfer: (1/N)·ι(λ) ≤_{Λ_Q} (1/N)·ι(μ) ⟺ λ ≤_Λ μ。
    # N は両辺の共通分母で、証人は λ, μ 自身。
    left, right = qsmul(inv, iota(lam)), qsmul(inv, iota(mu))
    assert qsmul(N, left) == iota(lam) and qsmul(N, right) == iota(mu)
    return rational_log_order_le(left, right) == log_order_le(lam, mu)


def check_block_tiling_density(a, k, q):
    checks = 0

    # 準備の第一
    block = open_partition_value(a, a, q)           # Z^op_{a,a}(q) ∈ QQ_{>0}
    square = open_partition_value(k * a, k * a, q)  # Z^op_{ka,ka}(q) ∈ QQ_{>0}
    N = ZZ((k * a) ** 2)
    assert N != 0
    inv = QQ(1) / QQ(N)                              # 1/(ka)²
    inv_a = QQ(1) / QQ(a ** 2)                       # 1/a²
    checks += 1

    log_q = log_lambda(q)
    log_block = log_lambda(block)
    log_square = log_lambda(square)
    prepared_lower = lam_add(zsmul(2 * k * (k - 1) * a, log_q), zsmul(k ** 2, log_block))  # Λ の鎖の下側
    prepared_upper = zsmul(k ** 2, log_block)                                              # Λ の鎖の上側

    psi_a = qsmul(inv_a, iota(log_block))     # Ψ^op_a(q)（def_open_square_free_entropy_density）
    psi_ka = qsmul(inv, iota(log_square))     # Ψ^op_{ka}(q)
    coeff = QQ(2 * (k - 1)) / QQ(k * a)       # 2(k-1)/(ka)
    low_form = lamq_add(qsmul(coeff, iota(log_q)), psi_a)

    # 準備の第二（上からの評価の側）の四段
    u0 = qsmul(inv, iota(prepared_upper))
    u1 = qsmul(inv, qsmul(k ** 2, iota(log_block)))
    assert u0 == u1  # n·ι(ν) = ι(nν) を右辺から左辺の向きで
    u2 = qsmul(inv * (k ** 2), iota(log_block))
    assert u1 == u2  # 有理数倍の結合則
    assert inv * (k ** 2) == inv_a  # QQ の約分 (1/(k²a²))·k² = 1/a²
    u3 = qsmul(inv_a, iota(log_block))
    assert u2 == u3
    assert u3 == psi_a  # def_open_square_free_entropy_density
    checks += 4

    # 準備の第三（下からの評価の側）の六段
    l0 = qsmul(inv, iota(prepared_lower))
    l1 = qsmul(inv, lamq_add(iota(zsmul(2 * k * (k - 1) * a, log_q)), iota(zsmul(k ** 2, log_block))))
    assert l0 == l1  # ι は加法を保つ
    l2 = lamq_add(qsmul(inv, iota(zsmul(2 * k * (k - 1) * a, log_q))), qsmul(inv, iota(zsmul(k ** 2, log_block))))
    assert l1 == l2  # 有理数倍の分配則
    l3 = lamq_add(qsmul(inv, qsmul(2 * k * (k - 1) * a, iota(log_q))), qsmul(inv, iota(zsmul(k ** 2, log_block))))
    assert l2 == l3  # n·ι(ν) = ι(nν) を右辺から左辺の向きで（第一項）
    l4 = lamq_add(qsmul(inv * (2 * k * (k - 1) * a), iota(log_q)), qsmul(inv, iota(zsmul(k ** 2, log_block))))
    assert l3 == l4  # 有理数倍の結合則
    assert inv * (2 * k * (k - 1) * a) == coeff  # QQ の約分 2k(k-1)a/(k²a²) = 2(k-1)/(ka)
    l5 = lamq_add(qsmul(coeff, iota(log_q)), qsmul(inv, iota(zsmul(k ** 2, log_block))))
    assert l4 == l5
    assert l5 == low_form  # 準備の第二
    checks += 6

    # 本体（q = 1 は両場合に属し、両方を見る）。各段で決定手続きと順序の移送の一致を見る。
    if q <= 1:
        assert scaled_transfer_matches(inv, N, prepared_lower, log_square)
        assert rational_log_order_le(low_form, psi_ka)     # 左の不等式
        assert scaled_transfer_matches(inv, N, log_square, prepared_upper)
        assert rational_log_order_le(psi_ka, psi_a)        # 右の不等式
        checks += 4
    if q >= 1:
        assert scaled_transfer_matches(inv, N, prepared_upper, log_square)
        assert rational_log_order_le(psi_a, psi_ka)        # 左の不等式
        assert scaled_transfer_matches(inv, N, log_square, prepared_lower)
        assert rational_log_order_le(psi_ka, low_form)     # 右の不等式
        checks += 4

    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(1),
               QQ(3) / 2, QQ(22) / 7, QQ(5), QQ(11))
sizes = ((1, 1), (1, 2), (1, 3), (2, 1))
total = 0
for a, k in sizes:
    for q in test_points:
        total += check_block_tiling_density(a, k, q)

print(f"開境界正方形のブロック敷き詰めによる密度の挟み込み（Λ_Q 版。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
