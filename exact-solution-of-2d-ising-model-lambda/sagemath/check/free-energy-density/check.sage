# 対象ラベル: def_free_energy_density, def_free_energy_density_limit_statement
#
# 可算側（1/L² ∈ QQ の確定・正値性、t = 1 での ψ_L(1) = log 2 の記号計算）は厳密に検査する。
# 実対数の値は一般に超越的で厳密の閉形式比較ができないため、実対数に触れる検査だけ
# RealBallField（区間＝ball 算術。丸め誤差を厳密に包含する）を使う。
# ball 算術は「不等式の成立」は厳密に証明できる（2 つの ball が分離していれば確定）が、
# 「等式の成立」は証明できない（差の ball が 0 を含むことは整合の確認にとどまる）。
# どの検査がどちらかを各関数に明記する。有限標本での検査であり、
# 普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

RBF = RealBallField(256)

# L の範囲（finite-real-free-entropy の検査と同じ範囲に揃える）
L_RANGE = [1, 2, 3]

# t の標本（正の有理数。ι_{Q→R} を通した R の元のモデル。1 未満・1・1 超え）
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]


def check_rational_inverse_square_well_defined():
    # def_free_energy_density の可算側の検査（厳密）:
    # L ≥ 1 で L² ≠ 0、1/L² ∈ QQ、0 < 1/L²。
    total = 0
    for L in L_RANGE:
        assert L * L != 0, L
        w = QQ(1) / (L * L)
        assert w in QQ, L
        assert w > 0, L
        total += 1
    print(f"L² ≠ 0 と 1/L² ∈ QQ の確定・正値性（厳密）: {total} 件 OK")
    return total


def check_density_ball_well_defined():
    # def_free_energy_density の検査:
    # ψ_L(t) = ι(1/L²)·φ_L(t) の ball が有限に確定すること
    # （φ_L(t) = log_ℝ(Z_L(t))。Z_L(t) ∈ QQ と Z_L(t) > 0 は厳密比較）。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        w = QQ(1) / (L * L)
        for t in T_SAMPLES:
            value = ZL(x=t)
            assert value in QQ
            assert value > 0, (L, t)              # 厳密比較（log_ℝ の定義域に入る）
            psi = RBF(w) * RBF(value).log()
            assert psi.is_finite(), (L, t)        # ball が有限に確定する
            total += 1
    print(f"ψ_L(t) の ball の確定（Z_L(t) > 0 は厳密）: {total} 件 OK")
    return total


def check_density_times_size_consistency():
    # def_free_energy_density の整合検査:
    # ι(L²)·ψ_L(t) − φ_L(t) の ball が 0 を含むこと。
    # ball 算術では等式は証明できないので、これは整合の確認である（証明ではない）。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        w = QQ(1) / (L * L)
        for t in T_SAMPLES:
            value = ZL(x=t)
            phi = RBF(value).log()
            psi = RBF(w) * phi
            diff = RBF(L * L) * psi - phi
            assert diff.contains_zero(), (L, t)
            assert diff.rad() < RealField(53)(2) ** (-200), (L, t)
            total += 1
    print(f"L²·ψ_L(t) − φ_L(t) の ball が 0 を含む（整合。証明ではない）: {total} 件 OK")
    return total


def check_density_at_one_symbolic():
    # t = 1 の標本での検査（記号計算で厳密）:
    # Z_L(1) = 2^{L²}（多重度の総和は配位の総数）なので ψ_L(1) = (1/L²)·log(2^{L²}) = log 2。
    # L に依らない値になるこの標本は、極限の言明の定式化の具体例として使える。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        value = ZL(x=QQ(1))
        assert value == 2 ** (L * L), L           # 厳密（QQ の比較）
        assert bool(log(value) / (L * L) == log(2)), L   # 記号計算で厳密
        total += 1
    print(f"ψ_L(1) = log 2（L に依らない。記号計算で厳密）: {total} 件 OK")
    return total


def check_limit_statement_instance_at_one():
    # def_free_energy_density_limit_statement の言明の形の検査（記号計算で厳密）:
    # t = 1、f = log 2 とすると ψ_L(1) − f = 0 なので、任意の正の ε の標本について
    # −ε < 0 かつ 0 < ε が N = 1 で成り立つ（言明の内側の 2 不等式が評価できることの確認）。
    total = 0
    for eps in [QQ(1)/10, QQ(1)/100]:
        for L in L_RANGE:
            diff = log(2 ** (L * L)) / (L * L) - log(2)
            assert bool(diff == 0), (eps, L)
            assert -eps < 0 < eps, (eps, L)
        total += 1
    print(f"極限の言明の t = 1, f = log 2 での具体例（記号計算で厳密）: {total} 件 OK")
    return total


total = 0
total += check_rational_inverse_square_well_defined()
total += check_density_ball_well_defined()
total += check_density_times_size_consistency()
total += check_density_at_one_symbolic()
total += check_limit_statement_instance_at_one()
print(f"合計 {total} 件 OK")
