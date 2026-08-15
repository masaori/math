# 対象ラベル: claim_partition_value_upper_bound_at_positive_rational
# 帰属: ZZ / QQ の厳密計算だけを使う。浮動小数点・ball 算術は使わない（主張は Q で閉じている）。
#
# 正の有理点での分配多項式の値の上からの評価 Z_L(q) ≤ 2^{L²}·(1+q)^{2L²} を検査する。
# 準備の 4 つ（冪の正値性・底の単調性・指数の単調性・定数の有限和）と、本体の式変形の各行を見る。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# L の範囲（分配多項式を全配位から組む。L=4 は 65536 配位）
L_RANGE = [1, 2, 3, 4]

# q の標本（正の有理数。1 未満・1・1 超え）
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5), QQ(11)]


def check_power_positivity():
    # 準備の第一の検査（厳密）: 0 < w のとき 0 < w^k（w は q と 1+q）。
    total = 0
    for q in Q_SAMPLES:
        for w in [q, 1 + q]:
            for k in range(0, 9):
                assert w ** k in QQ and w ** k > 0, (w, k)
                total += 1
    print(f"冪の正値性（厳密）: {total} 件 OK")
    return total


def check_base_monotonicity():
    # 準備の第二の検査（厳密）: 0 < u ≤ v のとき u^k ≤ v^k。
    # 標本の組は u = q、v = 1 + q（本体で使う組）に加え、標本どうしの順序対も見る。
    total = 0
    for u in Q_SAMPLES:
        for v in [u + 1] + [s for s in Q_SAMPLES if u <= s]:
            for k in range(0, 9):
                assert u ** k <= v ** k, (u, v, k)
                total += 1
    print(f"底の単調性（厳密）: {total} 件 OK")
    return total


def check_exponent_monotonicity():
    # 準備の第三の検査（厳密）: 1 ≤ w、m ≤ n のとき w^m ≤ w^n（途中の 1 ≤ w^k も見る）。
    # w の標本は本体で使う 1 + q（q > 0 なので 1 ≤ w）。
    total = 0
    for q in Q_SAMPLES:
        w = 1 + q
        assert w >= 1, q
        for k in range(0, 7):
            assert 1 <= w ** k, (q, k)
            total += 1
        for m in range(0, 7):
            for n in range(m, 7):
                d = n - m
                assert d in NN and w ** m * w ** d == w ** n, (q, m, n)   # 指数法則
                assert w ** m <= w ** n, (q, m, n)
                total += 2
    print(f"指数の単調性（厳密）: {total} 件 OK")
    return total


def check_constant_sum():
    # 準備の第四の検査（厳密）: Σ_{s∈S} c = |S|·c（S は配位全体、c は標本）。
    total = 0
    for L in L_RANGE:
        configs = list(configurations(L))
        for q in Q_SAMPLES:
            c = (1 + q) ** (2 * L * L)
            assert sum((c for _ in configs), QQ(0)) == len(configs) * c, (L, q)
            total += 1
    print(f"定数の有限和（厳密）: {total} 件 OK")
    return total


def check_upper_bound_chain():
    # 本体の式変形の各行の検査（厳密）:
    # Z_L(q) = Σ q^{b(σ)} ≤ Σ (1+q)^{b(σ)} ≤ Σ (1+q)^{2L²}
    #        = |Σ_L|·(1+q)^{2L²} = 2^{L²}·(1+q)^{2L²}。
    # 途中で使う事実 q ≤ 1+q、1 ≤ 1+q、b(σ) ≤ 2L² も検査する。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        configs = list(configurations(L))
        assert len(configs) == 2 ** (L * L), L                   # |Σ_L| = 2^{L²}
        bs = [broken_bond_count(L, s) for s in configs]
        assert all(b in NN and b <= 2 * L * L for b in bs), L    # b(σ) ≤ 2L²
        total += 2
        for q in Q_SAMPLES:
            assert q <= 1 + q, (L, q)                            # q ≤ 1+q
            assert 1 <= 1 + q, (L, q)                            # 1 ≤ 1+q
            sum_q = sum((q ** b for b in bs), QQ(0))
            sum_base = sum(((1 + q) ** b for b in bs), QQ(0))
            cap = (1 + q) ** (2 * L * L)
            sum_cap = sum((cap for _ in bs), QQ(0))
            value = ZL(x=q)
            assert value in QQ and value > 0, (L, q)             # Z_L(q) ∈ Q_{>0}
            assert value == sum_q, (L, q)                        # 代入は環準同型
            assert sum_q <= sum_base, (L, q)                     # 底を 1+q へ上げる
            assert sum_base <= sum_cap, (L, q)                   # 指数を 2L² へ上げる
            assert sum_cap == len(configs) * cap, (L, q)         # 定数の有限和
            assert len(configs) * cap == 2 ** (L * L) * cap, (L, q)   # |Σ_L| = 2^{L²}
            assert value <= 2 ** (L * L) * cap, (L, q)           # 主張の不等式
            total += 9
    print(f"上界の式変形の各行（厳密）: {total} 件 OK")
    return total


total = 0
total += check_power_positivity()
total += check_base_monotonicity()
total += check_exponent_monotonicity()
total += check_constant_sum()
total += check_upper_bound_chain()
print(f"合計 {total} 件 OK")
