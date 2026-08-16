# 対象ラベル: claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one
#
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
# 形は一辺 4 以上を含めない（4×4 の配位和は 10 分を超える。実測 2026-08-16）。したがって
# a,k ≥ 1、ka < L ≤ ka+a、L ≤ 3 を満たす (a,k,L) は (1,1,2)、(2,1,3)、(1,2,3) の三組である。
#
# 検査すること（claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one の証明の中身）:
#   準備の第一（QQ の係数）: (ka)²/L² + (L²−(ka)²)/L² = 1、0 ≤ (L²−(ka)²)/L² ≤ 2a/L。
#   準備の第二（符号）: 0 ≤ C := ι(ℓ_2) + 2·ι(log(1+q))。
#   準備の第三（Λ_Q の比較と推移律）: (L²−(ka)²)/L²·Ψ^op_{ka} ≤ (L²−(ka)²)/L²·C ≤ (2a/L)·C。
#   本体: Ψ_{ka} = (ka)²/L²·Ψ_{ka} + (L²−(ka)²)/L²·Ψ_{ka} ≤ (ka)²/L²·Ψ_{ka} + (2a/L)·C、
#         両辺に −(2a/L)·C を足して Ψ_{ka} + (−(2a/L)·C) ≤ (ka)²/L²·Ψ_{ka}、
#         倍数辺の差の評価の左に −(2a/L)·C を足して推移律、(2/L)·ι(log q) を足して誤差評価の左へ推移律。
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


def lamq_neg(lam_q):
    # Λ_Q の逆元（def_rational_log_order_group。素数ごとの QQ の符号反転）
    return {p: -v for p, v in lam_q.items()}


def check_non_multiple_side_lower(a, k, L, q):
    assert a >= 1 and k >= 1 and k * a < L <= k * a + a and 0 < q <= 1
    checks = 0
    ka = ZZ(k * a)

    base = open_partition_value(a, a, q)      # Z^op_{a,a}(q)
    block = open_partition_value(ka, ka, q)   # Z^op_{ka,ka}(q)
    big = open_partition_value(L, L, q)       # Z^op_{L,L}(q)
    psi_a = qsmul(QQ(1) / QQ(a ** 2), iota(log_lambda(base)))      # Ψ^op_a(q)
    psi_ka = qsmul(QQ(1) / QQ(ka ** 2), iota(log_lambda(block)))   # Ψ^op_{ka}(q)
    psi_L = qsmul(QQ(1) / QQ(L ** 2), iota(log_lambda(big)))       # Ψ^op_L(q)

    ell2 = log_lambda(QQ(2))            # ℓ_2
    log_1q = log_lambda(QQ(1) + q)      # log(1+q)
    log_q = log_lambda(q)               # log q
    c = QQ(ka ** 2) / QQ(L ** 2)
    d = QQ(L ** 2 - ka ** 2) / QQ(L ** 2)
    e = QQ(2 * a) / QQ(L)
    C = lamq_add(iota(ell2), qsmul(QQ(2), iota(log_1q)))   # C := ι(ℓ_2) + 2·ι(log(1+q))

    # 誤差評価の左（claim_open_square_multiple_side_subsquare_density_error_bound）
    err_low = lamq_add(qsmul(QQ(2) / QQ(L), iota(log_q)), qsmul(c, psi_ka))
    assert rational_log_order_le(err_low, psi_L)
    checks += 1

    # 準備の第一: QQ の係数
    assert c + d == QQ(1)
    assert QQ(0) <= d
    assert L ** 2 - ka ** 2 <= 2 * a * L and d <= e   # claim_square_difference_from_multiple_side_bound、L² > 0 で割る
    checks += 3

    # 準備の第二: 符号 0 ≤ C（0 ≤ ι(ℓ_2)、0 ≤ ι(log(1+q))、2·ι(log(1+q)) ≥ 0、加法単調性、推移律）
    assert rational_log_order_le({}, iota(ell2))
    assert rational_log_order_le({}, iota(log_1q))
    assert rational_log_order_le(qsmul(QQ(2), {}), qsmul(QQ(2), iota(log_1q))) and qsmul(QQ(2), {}) == {}
    assert rational_log_order_le(qsmul(QQ(2), iota(log_1q)), C)   # 0 ≤ ι(ℓ_2) の両辺に 2·ι(log(1+q)) を足す（交換則で寄せる）
    assert rational_log_order_le({}, C)
    checks += 5

    # 準備の第三: Ψ_{ka} ≤ C（上からの評価を L := ka で読む）、非負有理数倍の順序保存、係数の大小、推移律
    assert rational_log_order_le(psi_ka, C)
    assert rational_log_order_le(qsmul(d, psi_ka), qsmul(d, C))
    assert rational_log_order_le(qsmul(d, C), qsmul(e, C))
    assert rational_log_order_le(qsmul(d, psi_ka), qsmul(e, C))
    checks += 4

    # 本体
    split = lamq_add(qsmul(c, psi_ka), qsmul(d, psi_ka))
    assert qsmul(QQ(1), psi_ka) == psi_ka and qsmul(c + d, psi_ka) == split == psi_ka   # 分配則
    mid = lamq_add(qsmul(c, psi_ka), qsmul(e, C))
    assert rational_log_order_le(split, mid)          # 加法単調性（交換則で末尾の項を先頭へ寄せる）
    neg = lamq_neg(qsmul(e, C))
    assert lamq_add(qsmul(e, C), neg) == {} and lamq_add(mid, neg) == qsmul(c, psi_ka)   # 逆元・単位元
    shifted = lamq_add(psi_ka, neg)
    assert rational_log_order_le(shifted, qsmul(c, psi_ka))   # 両辺に −(2a/L)·C を足す
    checks += 4

    lower_ka = lamq_add(qsmul(QQ(2) / QQ(a), iota(log_q)), psi_a)   # 倍数辺の差の評価の左
    assert rational_log_order_le(lower_ka, psi_ka)
    lower_shift = lamq_add(lower_ka, neg)
    assert rational_log_order_le(lower_shift, shifted)          # 加法単調性
    assert rational_log_order_le(lower_shift, qsmul(c, psi_ka)) # 推移律
    lhs = lamq_add(qsmul(QQ(2) / QQ(L), iota(log_q)), lower_shift)
    assert rational_log_order_le(lhs, err_low)                  # 加法単調性（交換則で先頭へ寄せる）
    assert rational_log_order_le(lhs, psi_L)                    # 主張
    checks += 5
    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
shapes = ((1, 1, 2), (2, 1, 3), (1, 2, 3))
total = 0
for a, k, L in shapes:
    for q in test_points:
        total += check_non_multiple_side_lower(a, k, L, q)

print(f"倍数でない辺の密度の基準辺の密度による下からの評価（q は 1 以下。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
