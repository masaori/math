# 対象ラベル: claim_open_square_large_sides_density_difference_lower_le_one
#
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
# 形は一辺 4 以上を含めない（4×4 の配位和は 10 分を超える。実測 2026-08-16）。したがって
# a ≥ 1、a < L、a < M、a² ≤ L、a² ≤ M、L, M ≤ 3 を満たす (a,L,M) は a = 1、L, M ∈ {2,3} の四組である。
#
# 検査すること（claim_open_square_large_sides_density_difference_lower_le_one の証明の中身）:
#   入れ替えた上端（claim_open_square_large_sides_density_difference_upper_le_one を第一の辺 M、第二の辺 L で読む）:
#     Ψ^op_M + (−Ψ^op_L) ≤ R、R := U + (−D) + (2/a)C（辺 L, M によらない）。
#   準備: −(Ψ^op_M + (−Ψ^op_L)) = Ψ^op_L + (−Ψ^op_M) を素数ごとに六段で確かめる
#     （逆元の定義・加法の定義・逆元の定義・QQ の四則 −(u+(−v)) = v+(−u)・逆元の定義・加法の定義）。
#   本体: −R ≤ −(Ψ^op_M + (−Ψ^op_L))（claim_rational_log_order_group_neg_reverses_order）、
#     準備の結論で右辺を読み替えて −R ≤ Ψ^op_L + (−Ψ^op_M)（主張）。
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


def check_difference_lower(a, L, M, q):
    assert a >= 1 and a < L and a < M and a ** 2 <= L and a ** 2 <= M and 0 < q <= 1
    checks = 0
    base = open_partition_value(a, a, q)      # Z^op_{a,a}(q)
    big_L = open_partition_value(L, L, q)     # Z^op_{L,L}(q)
    big_M = open_partition_value(M, M, q)     # Z^op_{M,M}(q)
    psi = qsmul(QQ(1) / QQ(a ** 2), iota(log_lambda(base)))        # Ψ^op_a(q)
    psi_L = qsmul(QQ(1) / QQ(L ** 2), iota(log_lambda(big_L)))     # Ψ^op_L(q)
    psi_M = qsmul(QQ(1) / QQ(M ** 2), iota(log_lambda(big_M)))     # Ψ^op_M(q)

    ell2 = iota(log_lambda(QQ(2)))            # ι(ℓ_2)
    log_1q = iota(log_lambda(QQ(1) + q))      # ι(log(1+q))
    log_q = iota(log_lambda(q))               # ι(log q)
    C = lamq_add(ell2, qsmul(QQ(2), log_1q))  # C := ι(ℓ_2) + 2·ι(log(1+q))
    U = lamq_add(qsmul(QQ(2) / QQ(a), ell2), qsmul(QQ(4) / QQ(a), log_1q))   # U
    D = qsmul(QQ(4) / QQ(a), log_q)           # D
    tC = qsmul(QQ(2) / QQ(a), C)              # (2/a)·C
    R = lamq_add(lamq_add(U, lamq_neg(D)), tC)   # R := U + (−D) + (2/a)C

    # 入れ替えた上端（既に検証済みの主張を、第一の辺 M・第二の辺 L で読み直す）
    swapped = lamq_add(psi_M, lamq_neg(psi_L))
    assert rational_log_order_le(swapped, R)
    checks += 1

    # 準備: −(Ψ^op_M + (−Ψ^op_L)) = Ψ^op_L + (−Ψ^op_M) を素数ごとに六段で
    target = lamq_add(psi_L, lamq_neg(psi_M))
    neg_swapped = lamq_neg(swapped)
    primes = set(psi_L.keys()) | set(psi_M.keys())
    for p in primes:
        vL = psi_L.get(p, QQ(0))
        vM = psi_M.get(p, QQ(0))
        s0 = neg_swapped.get(p, QQ(0))
        s1 = -swapped.get(p, QQ(0))                                    # 逆元の定義
        s2 = -(psi_M.get(p, QQ(0)) + lamq_neg(psi_L).get(p, QQ(0)))   # 加法の定義
        s3 = -(vM + (-vL))                                             # 逆元の定義
        s4 = vL + (-vM)                                                # QQ の四則 −(u+(−v)) = v+(−u)
        s5 = vL + lamq_neg(psi_M).get(p, QQ(0))                        # 逆元の定義
        s6 = target.get(p, QQ(0))                                      # 加法の定義
        assert s0 == s1 == s2 == s3 == s4 == s5 == s6
        checks += 1
    assert neg_swapped == target                                       # 準備の結論
    checks += 1

    # 本体
    assert rational_log_order_le(lamq_neg(R), neg_swapped)   # 逆元による順序の反転
    assert rational_log_order_le(lamq_neg(R), target)        # 準備の結論で読み替えた主張
    checks += 2
    return checks


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
shapes = ((1, 2, 2), (1, 2, 3), (1, 3, 2), (1, 3, 3))
total = 0
for a, L, M in shapes:
    for q in test_points:
        total += check_difference_lower(a, L, M, q)

print(f"基準辺の平方以上の二つの辺の密度の差の一様な下からの評価（q は 1 以下。ZZ/QQ と素因数分解で厳密）: {total} 検査 OK")
