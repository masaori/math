# 対象ラベル: claim_open_square_free_entropy_density_nonnegative
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 検査すること（claim_open_square_free_entropy_density_nonnegative の証明の中身）:
#   準備の第一: Z^op_{L,L}(q) ∈ QQ_{>0}（ZZ[x] の開境界分配多項式への代入が配位和と一致）、1 ≤ Z^op_{L,L}(q)。
#   準備の第二: log 1 = 0（Λ の零写像）。
#   準備の第三: (1/L²)·ι(0) = 0（Λ_Q の零写像。周期境界と共有の五段の鎖）。
#   Λ の鎖: 0 = log 1 ≤_Λ log Z^op_{L,L}(q)（≤_Λ は rat_Λ を通した QQ の比較。def_log_order_group_order）。
#   Λ_Q の鎖: 0 = (1/L²)·ι(0) ≤_{Λ_Q} (1/L²)·ι(log Z^op_{L,L}(q)) = Ψ^op_L(q)
#     （≤_{Λ_Q} は def_rational_log_order_group_order の決定手続きで判定。
#       加えて、共通分母 N = L² での証人 0, log Z^op_{L,L}(q) の比較とも一致することを見る = 順序の移送）。

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


def log_lambda(q):
    # 正の有理数の対数（def_rational_log）: 素因数分解の指数ベクトル（Λ の元。値は ZZ、有限台辞書）
    assert q > 0
    return {ZZ(p): ZZ(e) for p, e in QQ(q).factor() if e != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}: 各素数の整数値を分母 1 の有理数として読む
    return {p: QQ(z) / QQ(1) for p, z in lam.items()}


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group。素数ごとに QQ の積。零になった素数は台から落とす）
    return {p: QQ(r) * a for p, a in lam_q.items() if QQ(r) * a != 0}


def zsmul(n, lam):
    # Λ の整数倍（def_log_order_group）
    return {p: ZZ(n) * z for p, z in lam.items() if n * z != 0}


def rat_of_log(lam):
    # rat_Λ(λ) = ∏ p^{λ(p)} ∈ QQ_{>0}（def_rational_of_log）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（def_log_order_group_order）
    return rat_of_log(lam) <= rat_of_log(mu)


def denominator_product(lam_q):
    # claim_common_denominator_exists の N_λ（空積は 1）
    N = ZZ(1)
    for v in lam_q.values():
        N *= v.denominator()
    return N


def witness_of_denominator_product(lam_q):
    # claim_common_denominator_exists の証人
    N = denominator_product(lam_q)
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N // v.denominator()) * ZZ(v.numerator())
        if val != 0:
            nu[p] = val
    return nu


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き: λ ≤_{Λ_Q} μ ⟺ N_μ λ_{N_λ} ≤_Λ N_λ μ_{N_μ}
    Nl, Nm = denominator_product(lam_q), denominator_product(mu_q)
    return log_order_le(zsmul(Nm, witness_of_denominator_product(lam_q)),
                        zsmul(Nl, witness_of_denominator_product(mu_q)))


L_RANGE = [1, 2, 3]
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5), QQ(11)]

zero_lambda = {}       # Λ の単位元（零写像）
zero_lambda_q = {}     # Λ_Q の単位元（零写像）

count = 0
# 準備の第二: log 1 = 0
assert log_lambda(QQ(1)) == zero_lambda
count += 1

for L in L_RANGE:
    inv = QQ(1) / QQ(L * L)
    assert inv in QQ and inv > 0
    Z = open_partition_polynomial(L, L)                            # Z^op_{L,L} ∈ ZZ[x]
    # 準備の第三: (1/L²)·ι(0) = 0（各素数での五段の鎖は、台が空なので任意の素数で 0 になることを数個の素数で確認）
    scaled_zero = qsmul(inv, iota(zero_lambda))
    assert scaled_zero == zero_lambda_q
    for p in [ZZ(2), ZZ(3), ZZ(5), ZZ(7), ZZ(353)]:
        step1 = inv * iota(zero_lambda).get(p, QQ(0))       # 有理数倍の定義
        step2 = inv * (QQ(zero_lambda.get(p, 0)) / QQ(1))   # ι の定義
        step3 = inv * (QQ(0) / QQ(1))                       # 0(p) = 0
        step4 = QQ(0)                                       # QQ の積
        assert scaled_zero.get(p, QQ(0)) == step1 == step2 == step3 == step4 == zero_lambda_q.get(p, QQ(0))
        count += 1
    for q in Q_SAMPLES:
        # 準備の第一（代入は配位ごとの和と一致する。def_open_rectangle_partition_value_at_positive_rational）
        value = QQ(Z(x=q))
        assert value == sum(q ** open_broken_bond_count(L, L, s) for s in open_configurations(L, L))
        assert value in QQ and value > 0
        assert 1 <= value
        count += 1
        # Λ の鎖
        phi = log_lambda(value)                                  # log Z^op_{L,L}(q)
        assert zero_lambda == log_lambda(QQ(1))                  # 0 = log 1
        assert log_order_le(log_lambda(QQ(1)), log_lambda(value))  # log 1 ≤_Λ log Z^op_{L,L}(q)（1 ≤ Z^op の移送）
        assert rat_of_log(log_lambda(QQ(1))) == 1 and rat_of_log(log_lambda(value)) == value
        assert log_order_le(zero_lambda, phi)                    # 0 ≤_Λ log Z^op_{L,L}(q)
        count += 1
        # Λ_Q の鎖
        psi = qsmul(inv, iota(phi))                              # Ψ^op_L(q)
        assert zero_lambda_q == qsmul(inv, iota(zero_lambda))    # 0 = (1/L²)·ι(0)
        assert rational_log_order_le(qsmul(inv, iota(zero_lambda)), qsmul(inv, iota(phi)))  # 決定手続きで ≤_{Λ_Q}
        # 順序の移送: N = L² は両方の共通分母で証人は 0, log Z^op。証人の比較と一致
        assert qsmul(L * L, qsmul(inv, iota(zero_lambda))) == iota(zero_lambda)
        assert qsmul(L * L, qsmul(inv, iota(phi))) == iota(phi)
        assert log_order_le(zero_lambda, phi) == rational_log_order_le(qsmul(inv, iota(zero_lambda)), qsmul(inv, iota(phi)))
        assert rational_log_order_le(zero_lambda_q, psi)          # 主張 0 ≤_{Λ_Q} Ψ^op_L(q)
        count += 1

print("PASS: open-square-free-entropy-density-nonnegative (%d checks)" % count)
