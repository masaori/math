# 対象ラベル: claim_partition_value_positive_at_positive_real, remark_real_field_escape
# QQ / ZZ['x'] の厳密計算だけを使う。浮動小数点を使わない。
# 標本点 t は正の有理数（ι_{Q→R} を通した R の元のモデル）。有限標本での検査であり、
# 「任意の正の実数」への普遍量化そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# L の範囲。配位の総当たり（2^{L^2} 個）を伴うので L <= 3 に限る
# （L = 3 で 512 配位。L = 4 は 65536 配位で総当たりが目的に対して過大）。検査内容は緩めていない。
L_RANGE = [1, 2, 3]

# t の標本（正の有理数。1 未満・1・1 超え）
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]


def all_plus_configuration(L):
    # 準備の第一のモデル: すべての頂点に +1 を割り当てる定数写像 σ_+。
    return {v: 1 for v in vertices(L)}


def check_evaluation_is_sum_over_configurations():
    # 式変形の第 1 行のモデル: Z_L(t) = Σ_{σ∈Σ_L} t^{b(σ)}（代入は環準同型）。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        for t in T_SAMPLES:
            lhs = ZL(x=t)
            rhs = sum(t ** broken_bond_count(L, sigma) for sigma in configurations(L))
            assert lhs in QQ and rhs in QQ
            assert lhs == rhs, (L, t)
            total += 1
    print(f"evaluation = sum over configurations: {total} 件 OK")
    return total


def check_each_term_positive():
    # 準備の第二のモデル: 任意の σ と正の有理点 t で t^{b(σ)} > 0（厳密比較）。
    total = 0
    for L in L_RANGE:
        for t in T_SAMPLES:
            for sigma in configurations(L):
                m = broken_bond_count(L, sigma)
                assert m in ZZ and m >= 0
                term = t ** m
                assert term in QQ
                assert term > 0, (L, t, sigma)
                total += 1
    print(f"each term positive: {total} 件 OK")
    return total


def check_one_term_separation_bound():
    # 式変形の第 2〜4 行のモデル: σ_+ ∈ Σ_L と Z_L(t) >= t^{b(σ_+)}。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        sigma_plus = all_plus_configuration(L)
        assert sigma_plus in configurations(L)
        for t in T_SAMPLES:
            lhs = ZL(x=t)
            bound = t ** broken_bond_count(L, sigma_plus)
            assert lhs in QQ and bound in QQ
            assert lhs >= bound, (L, t)
            total += 1
    print(f"one-term separation bound: {total} 件 OK")
    return total


def check_value_positive():
    # 主張のモデル: 正の有理点 t で Z_L(t) > 0（厳密比較）。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        for t in T_SAMPLES:
            value = ZL(x=t)
            assert value in QQ
            assert value > 0, (L, t)
            total += 1
    print(f"partition value positive: {total} 件 OK")
    return total


n1 = check_evaluation_is_sum_over_configurations()
n2 = check_each_term_positive()
n3 = check_one_term_separation_bound()
n4 = check_value_positive()
print(f"ALL OK: {n1 + n2 + n3 + n4} 件")
