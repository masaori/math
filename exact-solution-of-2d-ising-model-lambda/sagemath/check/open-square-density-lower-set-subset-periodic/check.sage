# 対象ラベル: claim_open_square_density_lower_set_subset_periodic_le_one
#
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（0 < q ≤ 1）。μ ∈ A^op(q) の証人 (ε, N) から:
#   準備の第一: ε' := (1/2)·ε について ε' + ε' = ε、0 ≤ ε'、ε' ≠ 0
#   準備の第二: δ := −ι(log q) について ι(log q) ≤ ι(log 1) = ι(0) = 0、0 ≤ δ、0 ≤ 2·δ
#   準備の第三: Archimedes 性の倍率 n（2·δ ≤ n·ε'）を有限探索で取り、N' := N + n（N' ≥ N ≥ 1、N' ≥ n）
#   準備の第四: N' ≤ L で (1/L)·(2·δ) ≤ ε' と、一続き五段
#     −ε' ≤ −((1/L)·(2·δ)) = −(((1/L)·2)·δ) = −((2/L)·δ) = −((2/L)·(−ι(log q))) = (2/L)·ι(log q)
#   本体: N' ≤ L で一続き八段
#     μ+ε' = (μ+ε')+0 = (μ+ε')+(ε'+(−ε')) = ((μ+ε')+ε')+(−ε') = (μ+(ε'+ε'))+(−ε') = (μ+ε)+(−ε')
#          ≤ Ψ^op_L(q)+(−ε') ≤ Ψ^op_L(q)+(2/L)·ι(log q) ≤ Ψ_L(q)
#     と、証人 (ε', N') で μ ∈ A^per(q)（所属）。
#   密度の列は L ≤ L_MAX までしか作れないので、密度を要する段は N' ≤ L ≤ L_MAX の L で検査し、
#   密度を要しない段（準備の第四の (1/L)·(2·δ) ≤ ε' と五段）は N' ≤ L ≤ L_CHECK まで検査する。
#   N' > L_MAX となる証人では密度を要する段が空になるので、空でなかった証人の数も数えて出力する。
#   ≤_{Λ_Q} は def_rational_log_order_group_order の決定手続きで判定する。

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


def qneg(lam_q):
    # Λ_Q の逆元（def_rational_log_order_group）。素数ごとに Q の符号反転
    return {p: -v for p, v in lam_q.items()}


L_MAX = 3   # 配位の全数え上げ 2^{L²} を行うので L は 3 まで
zero = {}



def densities(L, q):
    # Ψ_L(q)（def_finite_free_entropy_density）と Ψ^op_L(q)（def_open_square_free_entropy_density）
    assert L >= 1 and 0 < q <= 1
    configs = list(configurations(L))
    open_e = open_edges(L)
    periodic_e = open_e + boundary_edges(L)
    Z_L = QQ(partition_polynomial(configs, periodic_e)(q))
    Z_op = QQ(partition_polynomial(configs, open_e)(q))
    assert Z_L > 0 and Z_op > 0
    inv = QQ(1) / QQ(L ** 2)
    psi_L = qsmul(inv, iota(log_lambda(Z_L)))
    psi_op = qsmul(inv, iota(log_lambda(Z_op)))
    return psi_L, psi_op


def in_lower_set_with_witness(seq_values, mu, eps, N):
    # def_rational_log_order_group_sequence_lower_set の所属を、証人 (ε, N) について有限範囲で検査する
    assert rational_log_order_le(zero, eps) and eps != zero and N >= 1
    return all(rational_log_order_le(lamq_add(mu, eps), seq_values[L]) for L in range(N, L_MAX + 1))


def archimedean_multiplier(mu_q, eps_q):
    # claim_rational_log_order_group_archimedean: 0 ≤ μ、0 ≤ ε、ε ≠ 0 なら μ ≤ n·ε となる n ∈ ℕ がある。
    # 本文の証明は n を明示するが、ここでは最小の n を有限探索で取る（存在は Archimedes 性が保証する）。
    assert rational_log_order_le(zero, mu_q) and rational_log_order_le(zero, eps_q) and eps_q != zero
    n = 0
    while not rational_log_order_le(mu_q, qsmul(QQ(n), eps_q)):
        n += 1
        assert n <= 10000
    return n


L_CHECK = 60   # 密度を要しない段を検査する L の上限
test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-1", "-1/2", "0", "1/3", "2"]]
eps_candidates = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
eps_candidates = [e for e in eps_candidates if rational_log_order_le(zero, e) and e != zero]

total = 0
members = 0
nonvacuous = 0
for q in test_points:
    seq_per = {}
    seq_op = {}
    for L in range(1, L_MAX + 1):
        seq_per[L], seq_op[L] = densities(L, q)
    # 準備の第二（誤差の元の符号）は q だけで決まる
    log_q = iota(log_lambda(q))
    log_one = iota(log_lambda(QQ(1)))
    assert rational_log_order_le(log_q, log_one)          # ι(log q) ≤ ι(log 1)（claim_rational_embedded_log_order_iff、q ≤ 1）
    assert log_one == iota({})                              # ι(log 1) = ι(0)（log 1 = 0）
    assert iota({}) == zero                                 # ι(0) = 0
    delta = qneg(log_q)
    assert qneg(zero) == zero                               # 0 = −0
    assert rational_log_order_le(zero, delta)               # 0 ≤ δ（claim_rational_log_order_group_neg_reverses_order）
    two_delta = qsmul(QQ(2), delta)
    assert qsmul(QQ(0), delta) == zero                      # 0 = 0·δ
    assert rational_log_order_le(zero, two_delta)           # 0 ≤ 2·δ（claim_rational_log_order_group_scalar_compare_nonneg）
    total += 6
    # 検査する μ: 各 L で Ψ^op_L(q) から正の候補 ε を引いた元
    for L0 in range(1, L_MAX + 1):
        for eps in eps_candidates:
            mu = lamq_add(seq_op[L0], qneg(eps))
            for N in range(1, L_MAX + 1):
                if not in_lower_set_with_witness(seq_op, mu, eps, N):
                    continue   # この証人では A^op(q) の所属を示せない（有限範囲）
                members += 1
                # 準備の第一（証人の半分）
                eps_h = qsmul(QQ(1) / 2, eps)
                assert lamq_add(eps_h, eps_h) == qsmul(QQ(1) / 2 + QQ(1) / 2, eps)   # 分配則
                assert qsmul(QQ(1) / 2 + QQ(1) / 2, eps) == qsmul(QQ(1), eps)      # 1/2 + 1/2 = 1
                assert qsmul(QQ(1), eps) == eps                                     # 1·λ = λ
                assert qsmul(QQ(0), eps) == zero                                    # 0 = 0·ε
                assert rational_log_order_le(qsmul(QQ(0), eps), eps_h)              # 0·ε ≤ (1/2)·ε（scalar_compare_nonneg）
                assert eps_h != zero                                                # ε' ≠ 0
                total += 6
                # 準備の第三（Archimedes 性と N'）
                n = archimedean_multiplier(two_delta, eps_h)
                assert rational_log_order_le(two_delta, qsmul(QQ(n), eps_h))
                Np = N + n
                assert Np >= N >= 1 and Np >= n
                total += 2
                # 準備の第四（密度を要しない。L_CHECK まで）
                for L in range(Np, L_CHECK + 1):
                    assert L >= 1 and n <= L
                    scaled = qsmul(QQ(1) / L, two_delta)
                    assert rational_log_order_le(scaled, eps_h)                                  # (1/L)·(2δ) ≤ ε'（div_ge_multiplier_le）
                    assert rational_log_order_le(qneg(eps_h), qneg(scaled))                      # −ε' ≤ −((1/L)·(2δ))（neg_reverses_order）
                    assert qneg(scaled) == qneg(qsmul(QQ(1) / L * QQ(2), delta))                # 結合則
                    assert qneg(qsmul(QQ(1) / L * QQ(2), delta)) == qneg(qsmul(QQ(2) / L, delta))  # (1/L)·2 = 2/L
                    assert qneg(qsmul(QQ(2) / L, delta)) == qneg(qsmul(QQ(2) / L, qneg(log_q)))    # δ の定義
                    err = qsmul(QQ(2) / L, log_q)
                    assert qneg(qsmul(QQ(2) / L, qneg(log_q))) == err                             # −(r·(−λ)) = r·λ
                    assert rational_log_order_le(qneg(eps_h), err)                                # 結論 −ε' ≤ (2/L)·ι(log q)
                    total += 7
                # 本体（密度を要する。L_MAX まで）
                if Np <= L_MAX:
                    nonvacuous += 1
                for L in range(Np, L_MAX + 1):
                    err = qsmul(QQ(2) / L, log_q)
                    s0 = lamq_add(mu, eps_h)
                    s1 = lamq_add(lamq_add(mu, eps_h), zero)
                    s2 = lamq_add(lamq_add(mu, eps_h), lamq_add(eps_h, qneg(eps_h)))
                    s3 = lamq_add(lamq_add(lamq_add(mu, eps_h), eps_h), qneg(eps_h))
                    s4 = lamq_add(lamq_add(mu, lamq_add(eps_h, eps_h)), qneg(eps_h))
                    s5 = lamq_add(lamq_add(mu, eps), qneg(eps_h))
                    assert s0 == s1 == s2 == s3 == s4 == s5                                       # 一続きの等号五段
                    s6 = lamq_add(seq_op[L], qneg(eps_h))
                    assert rational_log_order_le(lamq_add(mu, eps), seq_op[L])                    # 証人の性質（N ≤ L）
                    assert rational_log_order_le(s5, s6)                                          # add_monotone
                    s7 = lamq_add(seq_op[L], err)
                    assert rational_log_order_le(s6, s7)                                          # add_monotone（準備の第四）
                    assert rational_log_order_le(s7, seq_per[L])                                  # comparison_density の左
                    assert rational_log_order_le(s0, seq_per[L])                                  # 推移律の結論
                    total += 10
                # 主張そのもの（証人 (ε', N') で A^per(q) に所属。有限範囲）
                if Np <= L_MAX:
                    assert in_lower_set_with_witness(seq_per, mu, eps_h, Np)
                    total += 1

print(f"開境界正方形の密度の下組は周期境界の密度の下組に含まれる（Archimedes 性。q は 1 以下。ZZ/QQ と素因数分解で厳密）: 所属の証人 {members} 組（うち密度の段が空でない証人 {nonvacuous} 組）、{total} 検査 OK")
