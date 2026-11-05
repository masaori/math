# 対象ラベル: real_log_of_power
# a ∈ ℝ_{>0}、n ∈ Z_{≥1} について a^n ∈ ℝ_{>0} と log(a^n) = n log a を、n の帰納法の二つの鎖で確かめる。
# 帰属:
# - 冪 a^n は def_power_of_real_number（a^0 := 1、a^{m+1} := a^m a）のとおり再帰で作る。a は QQ_{>0} と AA_{>0}（実代数的数）の元で、
#   a^n ∈ ℝ_{>0} と a^{n+1} = a^n a は QQ・AA の厳密な比較で確かめる。Sage 組み込みの a**n とも一致することを見る。
# - log の値は QQ・AA に入らないので RealBallField(512) へ脱出する（log は Arb の log。本文の log は exp の逆写像で、
#   本文の exp は標準の実数の exp に等しい）。両辺は別々に計算する（左辺は冪の値の log、右辺は log a の整数倍）。
#   判定は差のボールが 0 を含み半径が 2^-200 未満であること（等号）で行い、許容誤差は置かない。
load("../../_shared/log_integral_by_balls.sage")


def power_by_definition(a, n):
    """def_power_of_real_number の冪: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(n):
        p = p * a
    return p


NMAX = 40
POINTS = [QQ(1), QQ(2), QQ(1)/3, QQ(10)^-6, QQ(123)/7, AA(2).sqrt(), AA(2).sqrt() + AA(3).sqrt(), AA(5).sqrt() - 2]
lines = 0
for a in POINTS:
    assert a > 0
    la = log_ball(a)
    # n = 1 の一つ目の鎖: a^1 = a^0 a = 1·a = a
    assert power_by_definition(a, 0) == 1
    assert power_by_definition(a, 1) == power_by_definition(a, 0) * a and power_by_definition(a, 0) * a == 1 * a and 1 * a == a
    lines += 3
    # n = 1 の二つ目の鎖: log(a^1) = log a = 1·log a
    assert surely_equal(log_ball(power_by_definition(a, 1)), la)
    assert surely_equal(la, 1 * la)
    lines += 2
    for n in range(1, NMAX):
        an = power_by_definition(a, n)
        an1 = power_by_definition(a, n + 1)
        # 帰納法の仮定（前の n で示したもの）: a^n > 0、log(a^n) = n log a
        assert an > 0 and surely_equal(log_ball(an), n * la)
        assert an1 == an * a and an1 == a**(n + 1)                       # a^{n+1} := a^n a（組み込みの冪とも一致）
        assert an1 > 0                                                   # 正の数の積は正
        assert surely_equal(log_ball(an1), log_ball(an * a))             # 1 行目
        assert surely_equal(log_ball(an * a), log_ball(an) + la)         # 2 行目（real_log_of_product）
        assert surely_equal(log_ball(an) + la, n * la + la)              # 3 行目（帰納法の仮定）
        assert surely_equal(n * la + la, (n + 1) * la)                   # 4 行目（分配法則）
        assert surely_equal(log_ball(an1), (n + 1) * la)                 # 鎖の両端（主張の n + 1）
        lines += 5
print(f"{len(POINTS)} 個の a（QQ と AA）と n = 1..{NMAX} で、n = 1 の二つの鎖と帰納の鎖の全ての行（{lines} 個）が成り立つ")
# 否定コントロール: 指数を一つずらした式、log の冪と取り違えた式は成り立たない
for a in [QQ(2), QQ(1)/3, AA(2).sqrt() + AA(3).sqrt()]:
    for n in range(2, 6):
        assert not surely_equal(log_ball(power_by_definition(a, n)), (n + 1) * log_ball(a))
        assert not surely_equal(log_ball(power_by_definition(a, n)), log_ball(a)**n)
print("否定コントロール: log(a^n) は (n+1)log a とも (log a)^n とも一致しない（a = 2, 1/3, √2+√3、n = 2..5）")
print("RESULT: PASS")
