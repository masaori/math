# 対象ラベル: remark_real_logarithm, claim_real_log_one, def_finite_real_free_entropy
#
# 可算側（Z_L(t) の値・正値性）は QQ / ZZ['x'] の厳密計算で検査する。
# 実対数 log_ℝ の値は一般に超越的で厳密の閉形式比較ができないため、
# 実対数に触れる検査だけ RealBallField（区間＝ball 算術。丸め誤差を厳密に包含する）を使う。
# ball 算術は「不等式の成立」は厳密に証明できる（2 つの ball が分離していれば確定）が、
# 「等式の成立」は証明できない（差の ball が 0 を含むことは整合の確認にとどまる）。
# どの検査がどちらかを各関数に明記する。有限標本での検査であり、
# 普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# 実対数の値を包含する ball の精度（2 進桁）。
RBF = RealBallField(256)

# L の範囲。Z_L(t) の計算は分配多項式の代入だけで軽いが、正値性の前提を
# claim_partition_value_positive_at_positive_real の検査と同じ範囲で揃える。
L_RANGE = [1, 2, 3]

# t の標本（正の有理数。ι_{Q→R} を通した R の元のモデル。1 未満・1・1 超え）
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]


def check_log_multiplicative_consistency():
    # remark_real_logarithm（乗法を加法へ移す性質）の整合検査:
    # log_ℝ(u·v) − (log_ℝ(u) + log_ℝ(v)) の ball が 0 を含むこと。
    # ball 算術では等式は証明できないので、これは整合の確認である（証明ではない）。
    total = 0
    for u in T_SAMPLES:
        for v in T_SAMPLES:
            diff = RBF(u * v).log() - (RBF(u).log() + RBF(v).log())
            assert diff.contains_zero(), (u, v)
            assert diff.rad() < RealField(53)(2) ** (-200), (u, v)
            total += 1
    print(f"log(u*v) - (log(u)+log(v)) の ball が 0 を含む（整合。証明ではない）: {total} 件 OK")
    return total


def check_log_strictly_monotone():
    # remark_real_logarithm（狭義単調性）の検査:
    # u < v（QQ の厳密比較）のすべての標本対で log_ℝ(u) < log_ℝ(v)。
    # 2 つの ball の分離による比較なので、この不等式の成立は標本対について厳密である。
    total = 0
    for u in T_SAMPLES:
        for v in T_SAMPLES:
            if u < v:
                assert RBF(u).log() < RBF(v).log(), (u, v)
                total += 1
    print(f"u < v ならば log(u) < log(v)（ball の分離による厳密な比較）: {total} 件 OK")
    return total


def check_log_one_is_zero():
    # claim_real_log_one の検査。主張 log_ℝ(1) = 0 は Sage の記号計算で厳密に確かめる
    # （log(1) は記号的に 0 へ簡約される。ball 算術ではない）。
    assert log(1) == 0
    # 証明の鎖の各行のモデル。log_ℝ(1) の記号値 s := log(1) について、
    # 各行の左辺・右辺が厳密に一致すること。
    s = log(1)
    lines = [
        (s, s + 0),                    # 加法単位元
        (s + 0, s + (s + (-s))),       # 加法逆元
        (s + (s + (-s)), (s + s) + (-s)),  # 加法の結合則
        ((s + s) + (-s), log(1 * 1) + (-s)),  # 乗法を加法へ移す性質（1·1 の対数）
        (log(1 * 1) + (-s), s + (-s)),  # 乗法単位元 1·1 = 1
        (s + (-s), 0),                 # 加法逆元
    ]
    for i, (lhs, rhs) in enumerate(lines):
        assert lhs == rhs, i
    print(f"log(1) = 0 と証明の鎖 {len(lines)} 行（記号計算による厳密検査）: OK")
    return 1 + len(lines)


def check_real_free_entropy_well_defined():
    # def_finite_real_free_entropy の検査:
    # (1) Z_L(t) ∈ QQ かつ 0 < Z_L(t)（厳密比較。log_ℝ の定義域に入ること）、
    # (2) φ_L(t) = log_ℝ(Z_L(t)) の ball が有限に確定すること。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        for t in T_SAMPLES:
            value = ZL(x=t)
            assert value in QQ
            assert value > 0, (L, t)          # 厳密比較（定義域に入る）
            phi = RBF(value).log()
            assert phi.is_finite(), (L, t)    # ball が有限に確定する
            total += 1
    print(f"Z_L(t) > 0（厳密）と φ_L(t) の ball の確定: {total} 件 OK")
    return total


total = 0
total += check_log_multiplicative_consistency()
total += check_log_strictly_monotone()
total += check_log_one_is_zero()
total += check_real_free_entropy_well_defined()
print(f"合計 {total} 件 OK")
