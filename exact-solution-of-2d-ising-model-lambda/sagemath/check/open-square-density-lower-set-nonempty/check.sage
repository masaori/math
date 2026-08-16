# 対象ラベル: def_open_square_density_lower_set, claim_open_square_density_lower_set_nonempty
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、「1 ≤ L を満たすすべての L」の全称そのものは本文の人手証明が担う。
#
# 検査すること（claim_open_square_density_lower_set_nonempty の証明の中身）:
#   準備の第一: 0 = ι(0) = ι(log 1) ≤_{Λ_Q} ι(log 2) = ι(ℓ_2)。
#   準備の第二: ℓ_2(2) = 1 ≠ 0、ι(ℓ_2) ≠ 0（単射性の帰結）。
#   証人 ε := ι(ℓ_2)、N := 1 について、1 ≤ L ≤ L_MAX の各 L と正の有理数 q の標本で
#   −ι(ℓ_2) + ε = 0 ≤_{Λ_Q} Ψ^op_L(q)（三段）を検査し、−ι(ℓ_2) ∈ A^op(q) の所属を有限範囲で確かめる。
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


zero_lambda = {}
zero_lambda_q = {}
count = 0

# 準備の第一: 0 = ι(0) = ι(log 1) ≤ ι(log 2) = ι(ℓ_2)
ell2 = {ZZ(2): ZZ(1)}                                  # ℓ_2（def_log_order_group の生成元）
assert iota(zero_lambda) == zero_lambda_q              # ι(0) = 0
assert log_lambda(QQ(1)) == zero_lambda                # log 1 = 0
assert rational_log_order_le(iota(log_lambda(QQ(1))), iota(log_lambda(QQ(2))))  # ι(log 1) ≤ ι(log 2)（1 ≤ 2 の移送）
assert log_lambda(QQ(2)) == ell2                       # log 2 = ℓ_2
eps = iota(ell2)
assert rational_log_order_le(zero_lambda_q, eps)       # 0 ≤_{Λ_Q} ε
count += 4

# 準備の第二: ℓ_2(2) = 1 ≠ 0、ι(ℓ_2) ≠ 0
assert ell2.get(ZZ(2), ZZ(0)) == 1 and ell2 != zero_lambda
assert eps != zero_lambda_q and eps != iota(zero_lambda)
count += 2

N_witness = 1
mu = qneg(eps)                                          # −ι(ℓ_2)
assert qadd(mu, eps) == zero_lambda_q                   # −ι(ℓ_2) + ι(ℓ_2) = 0（逆元律。素数ごとに Q の中で）
for p in [ZZ(2), ZZ(3), ZZ(5)]:
    assert mu.get(p, QQ(0)) + eps.get(p, QQ(0)) == QQ(0)
count += 4

L_MAX = 4
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]

polys = {}
for L in range(1, L_MAX + 1):
    Zdp = open_square_partition_polynomial_dp(L)
    if L <= 3:
        assert Zdp == open_partition_polynomial(L, L)   # 動的計画法と全列挙の一致
        count += 1
    polys[L] = Zdp

for q in Q_SAMPLES:
    for L in range(N_witness, L_MAX + 1):
        value = QQ(polys[L](x=q))
        assert value > 0
        psi = qsmul(QQ(1) / QQ(L * L), iota(log_lambda(value)))   # Ψ^op_L(q)
        # 一段目: −ι(ℓ_2) + ε = −ι(ℓ_2) + ι(ℓ_2)（ε の定義）
        assert qadd(mu, eps) == qadd(qneg(iota(ell2)), iota(ell2))
        # 二段目: = 0（逆元律）
        assert qadd(qneg(iota(ell2)), iota(ell2)) == zero_lambda_q
        # 三段目: 0 ≤ Ψ^op_L(q)（claim_open_square_free_entropy_density_nonnegative）
        assert rational_log_order_le(zero_lambda_q, psi)
        # 結論: μ + ε ≤ Ψ^op_L(q)
        assert rational_log_order_le(qadd(mu, eps), psi)
        count += 4

print("PASS: open-square-density-lower-set-nonempty (%d checks, L up to %d, %d values of q)" % (count, L_MAX, len(Q_SAMPLES)))
