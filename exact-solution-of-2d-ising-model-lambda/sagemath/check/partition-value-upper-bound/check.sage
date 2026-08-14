# 対象ラベル: claim_partition_value_upper_bound
#
# 正の実数での分配多項式の値の上からの評価 Z_L(t) ≤ ι(2^{L²})·(1+t)^{2L²} を検査する。
# 標本 t は正の有理数（ι_{Q→R} を通した R の元のモデル）なので、すべて QQ の厳密比較で済む。
# 実対数に触れる検査は無く、浮動小数点は使わない。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# L の範囲（free-energy-density の検査と同じ範囲に揃える）
L_RANGE = [1, 2, 3]

# t の標本（正の有理数。1 未満・1・1 超え）
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]


def check_power_positivity():
    # 準備の第一の検査（厳密）: 0 < w のとき 0 < w^k。
    total = 0
    for w in T_SAMPLES:
        for k in range(0, 9):
            assert w ** k > 0, (w, k)
            total += 1
    print(f"冪の正値性（厳密）: {total} 件 OK")
    return total


def check_base_monotonicity():
    # 準備の第二の検査（厳密）: 0 < u ≤ v のとき u^k ≤ v^k。
    # 標本の組は u = t、v = 1 + t（本体で使う組）に加え、標本どうしの順序対も見る。
    total = 0
    for u in T_SAMPLES:
        for v in [u + 1] + [s for s in T_SAMPLES if u <= s]:
            for k in range(0, 9):
                assert u ** k <= v ** k, (u, v, k)
                total += 1
    print(f"底の単調性（厳密）: {total} 件 OK")
    return total


def check_exponent_monotonicity():
    # 準備の第三の検査（厳密）: 1 ≤ w、m ≤ n のとき w^m ≤ w^n。
    # w の標本は本体で使う 1 + t（t > 0 なので 1 ≤ w）。
    total = 0
    for t in T_SAMPLES:
        w = 1 + t
        assert w >= 1, t
        for m in range(0, 7):
            for n in range(m, 7):
                assert w ** m <= w ** n, (t, m, n)
                total += 1
    print(f"指数の単調性（厳密）: {total} 件 OK")
    return total


def check_constant_sum():
    # 準備の第四の検査（厳密）: Σ_{s∈S} c = |S|·c（S は配位全体、c は標本）。
    total = 0
    for L in L_RANGE:
        configs = list(configurations(L))
        for t in T_SAMPLES:
            c = (1 + t) ** (2 * L * L)
            assert sum(c for _ in configs) == len(configs) * c, (L, t)
            total += 1
    print(f"定数の有限和（厳密）: {total} 件 OK")
    return total


def check_upper_bound_chain():
    # 本体の式変形の各行の検査（厳密）:
    # Z_L(t) = Σ t^{b(σ)} ≤ Σ (1+t)^{b(σ)} ≤ Σ (1+t)^{2L²}
    #        = |Σ_L|·(1+t)^{2L²} = 2^{L²}·(1+t)^{2L²}。
    # 途中で使う事実 t ≤ 1+t、1 ≤ 1+t、b(σ) ≤ 2L² も検査する。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        configs = list(configurations(L))
        assert len(configs) == 2 ** (L * L), L                   # |Σ_L| = 2^{L²}
        total += 1
        for t in T_SAMPLES:
            assert t <= 1 + t, (L, t)                            # t ≤ 1+t
            assert 1 <= 1 + t, (L, t)                            # 1 ≤ 1+t
            bs = [broken_bond_count(L, s) for s in configs]
            assert all(b <= 2 * L * L for b in bs), (L, t)       # b(σ) ≤ 2L²
            sum_t = sum(t ** b for b in bs)
            sum_base = sum((1 + t) ** b for b in bs)
            cap = (1 + t) ** (2 * L * L)
            sum_cap = sum(cap for _ in bs)
            assert ZL(x=t) == sum_t, (L, t)                      # 代入は環準同型
            assert sum_t <= sum_base, (L, t)                     # 底を 1+t へ上げる
            assert sum_base <= sum_cap, (L, t)                   # 指数を 2L² へ上げる
            assert sum_cap == len(configs) * cap, (L, t)         # 定数の有限和
            assert ZL(x=t) <= 2 ** (L * L) * cap, (L, t)         # 主張の不等式
            total += 8
    print(f"上界の式変形の各行（厳密）: {total} 件 OK")
    return total


total = 0
total += check_power_positivity()
total += check_base_monotonicity()
total += check_exponent_monotonicity()
total += check_constant_sum()
total += check_upper_bound_chain()
print(f"合計 {total} 件 OK")
