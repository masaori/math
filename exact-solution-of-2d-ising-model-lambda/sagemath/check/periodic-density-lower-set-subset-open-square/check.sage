# 対象ラベル: def_periodic_density_lower_set, claim_periodic_density_lower_set_subset_open_square_le_one
#
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（0 < q ≤ 1）:
#   def_periodic_density_lower_set: 列 L ↦ Ψ_L(q) の所属を証人 (ε, N) について検査する。
#     「N ≤ L を満たすすべての L」は有限範囲 N ≤ L ≤ L_MAX で検査する（全称そのものは証明で示す）。
#   claim_periodic_density_lower_set_subset_open_square_le_one の証明の中身:
#     μ ∈ A^per(q) の証人 (ε, N) をそのまま使い、N ≤ L で
#       一段目: μ + ε ≤ Ψ_L(q)（証人の性質）
#       二段目: Ψ_L(q) ≤ Ψ^op_L(q)（claim_periodic_open_boundary_comparison_density_le_one の右）
#       推移律の結論: μ + ε ≤ Ψ^op_L(q)
#     と、同じ証人で μ ∈ A^op(q)（所属）を検査する。
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


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-1", "-1/2", "0", "1/3"]]
eps_candidates = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
eps_candidates = [e for e in eps_candidates if rational_log_order_le(zero, e) and e != zero]

total = 0
members = 0
for q in test_points:
    seq_per = {}
    seq_op = {}
    for L in range(1, L_MAX + 1):
        seq_per[L], seq_op[L] = densities(L, q)
    # 検査する μ: 各 L で Ψ_L(q) から正の候補 ε を引いた元（μ + ε = Ψ_L(q) ≤ Ψ_{L'}(q) が範囲で成り立てば所属）
    for L0 in range(1, L_MAX + 1):
        for eps in eps_candidates:
            mu = lamq_add(seq_per[L0], qneg(eps))
            for N in range(1, L_MAX + 1):
                if not in_lower_set_with_witness(seq_per, mu, eps, N):
                    continue   # この証人では A^per(q) の所属を示せない（有限範囲）
                members += 1
                for L in range(N, L_MAX + 1):
                    # 一段目: μ + ε ≤ Ψ_L(q)（証人の性質）
                    assert rational_log_order_le(lamq_add(mu, eps), seq_per[L])
                    # 二段目: Ψ_L(q) ≤ Ψ^op_L(q)（claim_periodic_open_boundary_comparison_density_le_one の右）
                    assert rational_log_order_le(seq_per[L], seq_op[L])
                    # 推移律の結論
                    assert rational_log_order_le(lamq_add(mu, eps), seq_op[L])
                    total += 3
                # 主張そのもの（同じ証人で A^op(q) に所属）
                assert in_lower_set_with_witness(seq_op, mu, eps, N)
                total += 1

print(f"周期境界の密度の下組は開境界正方形の密度の下組に含まれる（q は 1 以下。ZZ/QQ と素因数分解で厳密）: 所属の証人 {members} 組、{total} 検査 OK")
