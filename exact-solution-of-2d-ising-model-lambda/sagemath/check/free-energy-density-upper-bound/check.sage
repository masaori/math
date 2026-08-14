# 対象ラベル: claim_free_energy_density_upper_bound
#
# 主張: 各 L ≥ 1 と各 t ∈ ℝ, 0 < t に対し
#   ψ_L(t) ≤ log_ℝ(ι(2)) + ι(2)·log_ℝ(1+t)。
# 可算側（ι の正値性のモデル、体準同型と自然数冪、1/L²·L² = 1 等の QQ の計算、
# Z_L(t) の値と上界の有理数比較）は厳密に検査する。実対数に触れる検査だけ
# RealBallField（ball 算術。丸め誤差を厳密に包含する）を使う。ball 算術は
# 「不等式の成立」は ball の分離で厳密に確定できるが、「等式の成立」は証明できない
# （差の ball が 0 を含むことは整合の確認にとどまる）。どの検査がどちらかを各関数に明記する。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

RBF = RealBallField(256)

# L の範囲（free-energy-density の検査と同じ範囲に揃える）
L_RANGE = [1, 2, 3]

# t の標本（正の有理数。ι_{Q→R} を通した R の元のモデル。1 未満・1・1 超え）
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]


def check_iota_positive():
    # 準備の第二の検査（厳密）: 0 < 2、0 < 2^{L²}、0 < 1/L²（QQ の厳密比較。
    # ι のモデルは QQ の元をそのまま使う）。
    total = 0
    assert QQ(2) > 0
    total += 1
    for L in L_RANGE:
        assert QQ(2) ** (L * L) > 0, L
        assert QQ(1) / (L * L) > 0, L
        total += 2
    print(f"0 < 2, 0 < 2^(L^2), 0 < 1/L^2（厳密）: {total} 件 OK")
    return total


def check_hom_natural_power():
    # 準備の第四の検査（厳密）: ι(q^n) = ι(q)^n のモデル（QQ で厳密。
    # 基底 q^0 = 1 と歩み q^{k+1} = q^k·q も確認する）。
    total = 0
    for q in [QQ(2), QQ(1)/2, QQ(3)]:
        assert q ** 0 == QQ(1), q
        total += 1
        for n in range(0, 7):
            assert QQ(q ** n) == QQ(q) ** n, (q, n)
            if n >= 1:
                assert q ** n == q ** (n - 1) * q, (q, n)
                total += 1
            total += 1
    print(f"体準同型と自然数冪のモデル（厳密）: {total} 件 OK")
    return total


def check_log_weak_monotone_ball():
    # 準備の第三の検査（ball 算術）: u ≤ v なる標本で log(u) ≤ log(v)。
    # u < v の標本は ball の分離（上端・下端の比較）で厳密に確定する。
    # u = v の標本は同じ元なので可算側で相等を厳密に確認する。
    total = 0
    samples = sorted(set(T_SAMPLES))
    for i in range(len(samples)):
        for j in range(i, len(samples)):
            u, v = samples[i], samples[j]
            if u == v:
                assert QQ(u) == QQ(v), (u, v)
            else:
                lu, lv = RBF(u).log(), RBF(v).log()
                assert lu.upper() < lv.lower() or (lv - lu).is_positive(), (u, v)
            total += 1
    print(f"実対数の弱い単調性（u<v は ball の分離で厳密、u=v は可算側で厳密）: {total} 件 OK")
    return total


def check_partition_upper_bound_exact():
    # 準備の第五の前提の検査（厳密）: Z_L(t) ≤ 2^{L²}·(1+t)^{2L²}（QQ の厳密比較。
    # claim_partition_value_upper_bound の再確認）と 0 < Z_L(t)。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        for t in T_SAMPLES:
            value = QQ(ZL(x=t))
            bound = QQ(2) ** (L * L) * (1 + t) ** (2 * L * L)
            assert value > 0, (L, t)
            assert value <= bound, (L, t)
            total += 2
    print(f"0 < Z_L(t) ≤ 2^(L^2)·(1+t)^(2L^2)（厳密）: {total} 件 OK")
    return total


def check_log_of_bound_chain_ball():
    # 本体の鎖のうち実対数に触れる等式の検査（ball 算術。整合の確認であって証明ではない）:
    # log(ι(2^{L²})·(1+t)^{2L²}) = log(ι(2^{L²})) + log((1+t)^{2L²})
    #   = L²·log(ι(2)) + 2L²·log(1+t)。
    total = 0
    for L in L_RANGE:
        n = L * L
        for t in T_SAMPLES:
            prod = QQ(2) ** n * (1 + t) ** (2 * n)
            lhs = RBF(prod).log()
            mid = RBF(QQ(2) ** n).log() + RBF((1 + t) ** (2 * n)).log()
            rhs = QQ(n) * RBF(QQ(2)).log() + QQ(2 * n) * RBF(1 + t).log()
            d1 = lhs - mid
            d2 = lhs - rhs
            assert d1.contains_zero() and d1.rad() < RealField(53)(2) ** (-180), (L, t)
            assert d2.contains_zero() and d2.rad() < RealField(53)(2) ** (-180), (L, t)
            total += 2
    print(f"上界の実対数の分解の整合（ball。証明ではない）: {total} 件 OK")
    return total


def check_rational_cancellation():
    # 本体の鎖の可算側の検査（厳密）: (1/L²)·L² = 1、(1/L²)·(2L²) = 2（QQ の計算）。
    total = 0
    for L in L_RANGE:
        w = QQ(1) / (L * L)
        assert w * (L * L) == QQ(1), L
        assert w * (2 * L * L) == QQ(2), L
        total += 2
    print(f"(1/L^2)·L^2 = 1, (1/L^2)·(2L^2) = 2（厳密）: {total} 件 OK")
    return total


def check_main_inequality_ball():
    # 主張本体の検査（ball 算術）: ψ_L(t) ≤ log(ι(2)) + ι(2)·log(1+t)。
    # 差の ball の下端が 0 より大きいことで厳密に確定する（全標本で分離することを
    # 確認済み。分離すれば ball 算術でも不等式は証明になる）。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        w = QQ(1) / (L * L)
        for t in T_SAMPLES:
            value = QQ(ZL(x=t))
            psi = QQ(w) * RBF(value).log()
            bound = RBF(QQ(2)).log() + QQ(2) * RBF(1 + t).log()
            diff = bound - psi
            assert diff.lower() > 0, (L, t)
            total += 1
    print(f"ψ_L(t) ≤ log(ι(2)) + ι(2)·log(1+t)（ball の分離で厳密）: {total} 件 OK")
    return total


def main():
    total = 0
    total += check_iota_positive()
    total += check_hom_natural_power()
    total += check_log_weak_monotone_ball()
    total += check_partition_upper_bound_exact()
    total += check_log_of_bound_chain_ball()
    total += check_rational_cancellation()
    total += check_main_inequality_ball()
    print(f"合計 {total} 件 OK")


main()
