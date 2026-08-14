# 対象ラベル: claim_real_log_natural_power
#
# 主張: 各 u ∈ ℝ, 0 < u と各 n ∈ ℕ に対し log_ℝ(u^n) = ι_{ℚ→ℝ}(n)·log_ℝ(u)。
# 可算側（u^n の値・正値性、ι の加法保存のモデル、スカラーの分配則）は QQ と
# 記号計算の厳密検査で行う。実対数 log_ℝ の値は一般に超越的で厳密な閉形式比較が
# できないため、実対数に触れる検査だけ RealBallField（区間＝ball 算術。丸め誤差を
# 厳密に包含する）を使う。ball 算術は「不等式の成立」は厳密に証明できるが、
# 「等式の成立」は証明できない（差の ball が 0 を含むことは整合の確認にとどまる）。
# どの検査がどちらかを各関数に明記する。有限標本での検査であり、
# 普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# 実対数の値を包含する ball の精度（2 進桁）。
RBF = RealBallField(256)

# u の標本（正の有理数。ι_{Q→R} を通した R の元のモデル。1 未満・1・1 超え）
U_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]

# n の標本（0 を含める。主張の帰納法の基底と歩みの両方に触れるため）
N_SAMPLES = [0, 1, 2, 3, 4, 5, 6]


def check_power_positive():
    # 準備の検査: 0 < u^n（QQ の厳密比較。log_ℝ の定義域に入ること）。
    total = 0
    for u in U_SAMPLES:
        for n in N_SAMPLES:
            assert u ** n > 0, (u, n)
            total += 1
    print(f"0 < u^n（QQ の厳密比較）: {total} 件 OK")
    return total


def check_main_identity_consistency():
    # 主張の整合検査: log_ℝ(u^n) − ι(n)·log_ℝ(u) の ball が 0 を含み半径が小さいこと。
    # ball 算術では等式は証明できないので、これは整合の確認である（証明ではない）。
    total = 0
    for u in U_SAMPLES:
        for n in N_SAMPLES:
            diff = RBF(u ** n).log() - QQ(n) * RBF(u).log()
            assert diff.contains_zero(), (u, n)
            assert diff.rad() < RealField(53)(2) ** (-200), (u, n)
            total += 1
    print(f"log(u^n) - n·log(u) の ball が 0 を含む（整合。証明ではない）: {total} 件 OK")
    return total


def check_base_case_chain():
    # 帰納法の基底（指数 0）の鎖 4 行の検査。
    # 行 1: u^0 = 1（QQ で厳密）。行 2: log(1) = 0（記号計算で厳密）。
    # 行 3: 0 = 0·log(u)（記号計算で厳密）。行 4: ι(0) = 0 のモデル QQ(0) = 0（厳密）。
    total = 0
    x = SR.var('x_log_u')
    for u in U_SAMPLES:
        assert u ** 0 == QQ(1), u
        total += 1
    assert log(1) == 0
    total += 1
    assert bool(0 == 0 * x)
    total += 1
    assert QQ(0) == 0
    total += 1
    print(f"基底の鎖（u^0=1、log(1)=0、0=0·log(u)、ι(0)=0 のモデル）: {total} 件 OK")
    return total


def check_step_chain():
    # 帰納法の歩み（指数 k → k+1）の鎖 7 行の検査。標本 (u, k) ごとに:
    # 行 1: u^{k+1} = u^k·u（QQ で厳密）。
    # 行 2: log(u^k·u) と log(u^k)+log(u) の差の ball が 0 を含む（整合。証明ではない）。
    # 行 3: 帰納法の仮定のモデル log(u^k) と k·log(u) の差の ball が 0 を含む（整合）。
    # 行 4: 乗法単位元 y = 1·y（記号計算で厳密）。
    # 行 5: 分配則 k·y + 1·y = (k+1)·y（記号計算で厳密）。
    # 行 6: ι(1) = 1 のモデル QQ(1) = 1（厳密）。
    # 行 7: ι の加法保存のモデル QQ(k) + QQ(1) = QQ(k+1)（厳密）。
    total = 0
    y = SR.var('y_log_u')
    for u in U_SAMPLES:
        for k in N_SAMPLES:
            assert u ** (k + 1) == (u ** k) * u, (u, k)
            diff2 = RBF((u ** k) * u).log() - (RBF(u ** k).log() + RBF(u).log())
            assert diff2.contains_zero() and diff2.rad() < RealField(53)(2) ** (-200), (u, k)
            diff3 = RBF(u ** k).log() - QQ(k) * RBF(u).log()
            assert diff3.contains_zero() and diff3.rad() < RealField(53)(2) ** (-200), (u, k)
            assert bool(y == 1 * y)
            assert bool(QQ(k) * y + 1 * y == (QQ(k) + 1) * y)
            assert QQ(1) == 1
            assert QQ(k) + QQ(1) == QQ(k + 1), (u, k)
            total += 7
    print(f"歩みの鎖 7 行（可算側は厳密、実対数の行は ball の整合）: {total} 件 OK")
    return total


total = 0
total += check_power_positive()
total += check_main_identity_consistency()
total += check_base_case_chain()
total += check_step_chain()
print(f"合計 {total} 件の検査がすべて通過")
