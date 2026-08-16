# 対象ラベル: claim_open_square_density_lower_set_le_upper_bound
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、下組の所属（「N ≤ L を満たすすべての L」の全称）は本文の人手証明が担う。
#
# 検査すること（claim_open_square_density_lower_set_le_upper_bound の証明の中身）:
#   所属の証人 (ε, N) を持つ μ について、L := N で読む五段
#     μ = 0 + μ（単位元）≤_{Λ_Q} ε + μ（加法単調性。0 ≤ ε）= μ + ε（交換則）
#       ≤_{Λ_Q} Ψ^op_N(q)（証人の性質）≤_{Λ_Q} ι(ℓ_2) + 2·ι(log(1+q))（密度の上からの評価）
#   と結論 μ ≤_{Λ_Q} ι(ℓ_2) + 2·ι(log(1+q)) を検査する。
#   μ の標本: 空でないことの証人 μ = −ι(ℓ_2)（ε = ι(ℓ_2)、N = 1）と、それ以下の元（下に閉じているので所属する）、
#   および N ≥ 1、正の ε について有限範囲 N ≤ L ≤ L_MAX で μ + ε ≤ Ψ^op_L(q) が成り立つ μ の標本。
#   一辺 4 の分配関数の値は行ごとの動的計画法で計算し、一辺 1..3 で全列挙と一致することを確かめる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

from itertools import product

R.<x> = PolynomialRing(ZZ)


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


def open_partition_polynomial(a, b):
    # def_open_rectangle_partition_polynomial（ZZ[x] の元）
    return sum((x ** open_broken_bond_count(a, b, sigma)
                for sigma in open_configurations(a, b)), R.zero())


def open_square_partition_polynomial_dp(L):
    # 一辺 L の開境界正方形の分配多項式を、行配位（2^L 通り）についての動的計画法で計算する。
    # 各行の内部の破れボンド数と、隣り合う行の間の破れボンド数を数え、行を順に足し込む。全列挙と同じ多項式になる。
    rows = list(product((ZZ(1), ZZ(-1)), repeat=L))
    def internal(r):
        return sum(ZZ(r[j] != r[j + 1]) for j in range(L - 1))
    def between(r, s):
        return sum(ZZ(r[j] != s[j]) for j in range(L))
    weight = {r: x ** internal(r) for r in rows}
    cur = dict(weight)
    for _ in range(L - 1):
        nxt = {}
        for s in rows:
            acc = R.zero()
            for r, w in cur.items():
                acc += w * x ** between(r, s)
            nxt[s] = acc * weight[s]
        cur = nxt
    return sum(cur.values(), R.zero())


def log_lambda(q):
    # 正の有理数の対数（def_rational_log）: 素因数分解の指数ベクトル（Λ の元）
    assert q > 0
    return {ZZ(p): ZZ(e) for p, e in QQ(q).factor() if e != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}
    return {p: QQ(z) / QQ(1) for p, z in lam.items()}


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）
    return {p: QQ(r) * a for p, a in lam_q.items() if QQ(r) * a != 0}


def zsmul(n, lam):
    # Λ の整数倍（def_log_order_group）
    return {p: ZZ(n) * z for p, z in lam.items() if n * z != 0}


def qadd(lam_q, mu_q):
    # Λ_Q の加法（def_rational_log_order_group）。素数ごとに Q の和
    out = {}
    for p in set(lam_q) | set(mu_q):
        v = lam_q.get(p, QQ(0)) + mu_q.get(p, QQ(0))
        if v != 0:
            out[p] = v
    return out


def qneg(lam_q):
    # Λ_Q の逆元（def_rational_log_order_group）
    return {p: -v for p, v in lam_q.items()}


def rat_of_log(lam):
    # rat_Λ(λ) = ∏ p^{λ(p)}（def_rational_of_log）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # def_log_order_group_order
    return rat_of_log(lam) <= rat_of_log(mu)


def rat_of_witness(lam_q, N):
    # N·λ ∈ ι(Λ) の証人 λ_N の rat_Λ（正の有理数の積。def_common_denominator）
    r = QQ(1)
    for p, v in lam_q.items():
        e = QQ(N) * v
        assert e.denominator() == 1
        r *= QQ(p) ** ZZ(e)
    return r


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き。共通分母は分母の最小公倍数で取る
    # （claim_common_denominator_multiple により結果は共通分母の取り方に依らない。分母の積で取ると
    # Ψ^op_L(q) の比較で指数が 16^10 程度になり rat_Λ の計算が実行不能になる）。
    N = ZZ(1)
    for v in list(lam_q.values()) + list(mu_q.values()):
        N = lcm(N, v.denominator())
    return rat_of_witness(lam_q, N) <= rat_of_witness(mu_q, N)


zero_lambda = {}
zero_lambda_q = {}
count = 0

ell2 = {ZZ(2): ZZ(1)}                                  # ℓ_2
eps0 = iota(ell2)                                       # ι(ℓ_2)
assert rational_log_order_le(zero_lambda_q, eps0) and eps0 != zero_lambda_q
count += 1

L_MAX = 4
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]

polys = {}
for L in range(1, L_MAX + 1):
    Zdp = open_square_partition_polynomial_dp(L)
    if L <= 3:
        assert Zdp == open_partition_polynomial(L, L)   # 動的計画法と全列挙の一致
        count += 1
    polys[L] = Zdp


_psi_cache = {}


def psi(L, q):
    key = (L, QQ(q))
    if key not in _psi_cache:
        value = QQ(polys[L](x=q))
        assert value > 0
        _psi_cache[key] = qsmul(QQ(1) / QQ(L * L), iota(log_lambda(value)))   # Ψ^op_L(q)
    return _psi_cache[key]


def upper_bound(q):
    # ι(ℓ_2) + 2·ι(log(1+q))（claim_open_square_free_entropy_density_upper_bound の右辺）
    return qadd(iota(ell2), qsmul(QQ(2), iota(log_lambda(QQ(1) + q))))


def check_chain(q, mu, eps, N):
    global count
    # 証人の性質（有限範囲 N ≤ L ≤ L_MAX での所属）
    assert rational_log_order_le(zero_lambda_q, eps) and eps != zero_lambda_q and N >= 1
    for L in range(N, L_MAX + 1):
        assert rational_log_order_le(qadd(mu, eps), psi(L, q))
    B = upper_bound(q)
    # 一段目: μ = 0 + μ（単位元）
    assert qadd(zero_lambda_q, mu) == mu
    # 二段目: 0 + μ ≤ ε + μ（加法単調性。0 ≤ ε）
    assert rational_log_order_le(qadd(zero_lambda_q, mu), qadd(eps, mu))
    # 三段目: ε + μ = μ + ε（交換則）
    assert qadd(eps, mu) == qadd(mu, eps)
    # 四段目: μ + ε ≤ Ψ^op_N(q)（証人の性質を L := N で読む）
    assert rational_log_order_le(qadd(mu, eps), psi(N, q))
    # 五段目: Ψ^op_N(q) ≤ ι(ℓ_2) + 2·ι(log(1+q))（密度の上からの評価）
    assert rational_log_order_le(psi(N, q), B)
    # 結論
    assert rational_log_order_le(mu, B)
    count += 6


for q in Q_SAMPLES:
    # 空でないことの証人 μ = −ι(ℓ_2)（ε = ι(ℓ_2)、N = 1）と、それ以下の元
    for mu in [qneg(eps0), qneg(qsmul(QQ(2), eps0)), qneg(iota({ZZ(3): ZZ(1)})),
               qadd(qneg(eps0), qneg(iota({ZZ(5): ZZ(1)})))]:
        assert rational_log_order_le(mu, qneg(eps0))
        check_chain(q, mu, eps0, 1)
    # 別の証人: ε = (1/2)·ι(ℓ_2)、N = 2 で有限範囲の所属を満たす μ := Ψ^op_2(q) − ε − ι(ℓ_2)
    # （Ψ^op_L(q) は L ≥ 2 で L について単調とは限らないので、所属は有限範囲で直接確かめる）
    eps1 = qsmul(QQ(1) / 2, eps0)
    mu1 = qadd(qadd(psi(2, q), qneg(eps1)), qneg(eps0))
    ok = all(rational_log_order_le(qadd(mu1, eps1), psi(L, q)) for L in range(2, L_MAX + 1))
    if ok:
        check_chain(q, mu1, eps1, 2)
    else:
        count += 1   # 標本が所属しない場合は主張の前提外（検査対象外）

print("PASS: open-square-density-lower-set-le-upper-bound (%d checks, L up to %d, %d values of q)" % (count, L_MAX, len(Q_SAMPLES)))
