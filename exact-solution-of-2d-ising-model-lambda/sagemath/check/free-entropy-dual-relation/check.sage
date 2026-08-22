# 対象ラベル: claim_free_entropy_dual_relation（および claim_partition_value_dual_factorization）
# 帰属: 有限集合、ZZ[x]、QQ、Λ（素因数分解の指数ベクトル）。浮動小数点を使わない。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

R = PolynomialRing(ZZ, 'x')
x = R.gen()


def edge_subsets(L):
    edge_list = list(range(1, 2 * L * L + 1))
    for size in range(len(edge_list) + 1):
        for subset in combinations(edge_list, size):
            yield frozenset(subset)


def incidence_count(L, subset, vertex):
    return sum(ZZ(1) for edge in subset for endpoint in endpoints(L, edge)
               if endpoint == vertex)


def is_even_subgraph(L, subset):
    return all(incidence_count(L, subset, vertex) % 2 == 0
               for vertex in vertices(L))


def winding_sector(L, subset):
    horizontal_cut = frozenset(edge_number_horizontal(L, i, -1) for i in range(L))
    vertical_cut = frozenset(edge_number_vertical(L, -1, j) for j in range(L))
    return (len(subset.intersection(horizontal_cut)) % 2,
            len(subset.intersection(vertical_cut)) % 2)


def rational_log(q):
    """def_rational_log: log: Q_{>0} → Λ を素因数分解の指数ベクトル（辞書 素数 → ZZ）で返す。"""
    assert q in QQ and q > 0
    exponents = {}
    for prime, exponent in QQ(q).factor():
        exponents[ZZ(prime)] = ZZ(exponent)
    return exponents


def lambda_add(u, v):
    """Λ の加法（def_log_order_group）: 素数ごとの ZZ の加法。零成分は落とす。"""
    total = dict(u)
    for prime, exponent in v.items():
        total[prime] = total.get(prime, ZZ(0)) + exponent
        if total[prime] == 0:
            del total[prime]
    return total


def lambda_scale(k, u):
    """Λ の整数倍（def_log_order_group）。"""
    return {prime: ZZ(k) * exponent for prime, exponent in u.items() if k != 0}


# 検査する有理点（すべて 0 < q < 1 の既約分数。QQ の厳密計算）
rational_points = [QQ(1) / 2, QQ(1) / 3, QQ(2) / 5, QQ(3) / 7, QQ(9) / 10, QQ(1) / 40]

for L in (1, 2, 3):
    # セクター生成多項式 G^{a,b}_L（def_sector_generating_polynomial）を偶部分グラフの数え上げで構成
    sector_generating_polynomials = {(a, b): R(0) for a in (0, 1) for b in (0, 1)}
    for subset in edge_subsets(L):
        if not is_even_subgraph(L, subset):
            continue
        key = winding_sector(L, subset)
        sector_generating_polynomials[key] += x ** len(subset)

    # 分配多項式 Z_L（def_partition_polynomial）を配位の数え上げで独立に構成
    Z = partition_polynomial(L)

    for q in rational_points:
        assert 0 < q < 1
        assert 1 + q != 0
        kw_value = (1 - q) * (1 + q) ** (-1)
        # claim_kw_dual_preserves_unit_interval との整合
        assert kw_value in QQ and 0 < kw_value < 1

        sector_values = {key: poly(kw_value)
                         for key, poly in sector_generating_polynomials.items()}
        S = sum(sector_values.values())

        # --- claim_partition_value_dual_factorization の式変形を一行ずつ ---
        # 1 行目: Z_L(q) = 2·G^{0,0}_L(q)（claim_low_temperature_trivial_sector_expression の代入）
        assert Z(q) == 2 * sector_generating_polynomials[(0, 0)](q)
        left = 2 ** (L * L) * Z(q)
        # 2 行目: 2^{L^2}·(2·G^{0,0}_L(q)) = (2^{L^2}·2)·G^{0,0}_L(q)
        assert left == (2 ** (L * L) * 2) * sector_generating_polynomials[(0, 0)](q)
        # 3 行目: (2^{L^2}·2)·G^{0,0}_L(q) = 2^{L^2+1}·G^{0,0}_L(q)
        assert left == 2 ** (L * L + 1) * sector_generating_polynomials[(0, 0)](q)
        # 4 行目: = H^{0,0}_L(q)+H^{0,1}_L(q)+H^{1,0}_L(q)+H^{1,1}_L(q)
        #（低温展開の自明セクター表示・高温展開の多項式恒等式・セクター分解の代入。H^{a,b}_L を独立に数え上げる）
        sector_high_values = {(a, b): QQ(0) for a in (0, 1) for b in (0, 1)}
        for subset in edge_subsets(L):
            if not is_even_subgraph(L, subset):
                continue
            key = winding_sector(L, subset)
            size = len(subset)
            sector_high_values[key] += (1 + q) ** (2 * L * L - size) * (1 - q) ** size
        assert left == sum(sector_high_values.values())
        # 5 行目: = Σ (1+q)^{2L^2}·G^{a,b}_L(KW(q))（claim_sector_value_duality の四つの適用）
        assert left == sum((1 + q) ** (2 * L * L) * sector_values[key]
                           for key in sector_values)
        # 6 行目: = (1+q)^{2L^2}·S（分配則による括り出し）
        assert left == (1 + q) ** (2 * L * L) * S

        # --- claim_free_entropy_dual_relation の準備（正値性） ---
        assert 1 + q > 0
        assert (1 + q) ** (2 * L * L) > 0
        assert 2 ** (L * L) > 0
        assert Z(q) > 0                      # claim_value_at_rational_is_positive
        assert 2 ** (L * L) * Z(q) > 0
        assert S > 0                          # 背理法の帰結と一致

        # --- claim_free_entropy_dual_relation の式変形を Λ で一行ずつ ---
        # 左辺: L^2·ℓ_2 + Φ_L(q)
        phi = rational_log(Z(q))                                  # def_finite_free_entropy
        ell2 = rational_log(QQ(2))
        assert ell2 == {ZZ(2): ZZ(1)}                             # 2 は素数なので log 2 = ℓ_2
        lhs = lambda_add(lambda_scale(L * L, ell2), phi)
        # 2 行目: L^2·log 2 = log(2^{L^2})（claim_log_power）
        assert lambda_scale(L * L, ell2) == rational_log(QQ(2) ** (L * L))
        # 3 行目: log(2^{L^2}) + log Z_L(q) = log(2^{L^2}·Z_L(q))（claim_log_additive）
        assert lhs == rational_log(QQ(2) ** (L * L) * Z(q))
        # 4 行目: log(2^{L^2}·Z_L(q)) = log((1+q)^{2L^2}·S)（claim_partition_value_dual_factorization）
        assert lhs == rational_log((1 + q) ** (2 * L * L) * S)
        # 5 行目: = log((1+q)^{2L^2}) + log S（claim_log_additive）
        assert lhs == lambda_add(rational_log((1 + q) ** (2 * L * L)), rational_log(S))
        # 6 行目: = 2L^2·log(1+q) + log S（claim_log_power）
        rhs = lambda_add(lambda_scale(2 * L * L, rational_log(1 + q)), rational_log(S))
        assert lhs == rhs

    print("L=%d: 分配多項式の値の双対分解と Λ の自由エントロピー双対関係を QQ/Λ で確認（有理点 %d 個）" %
          (L, len(rational_points)))

print("RESULT: PASS")
