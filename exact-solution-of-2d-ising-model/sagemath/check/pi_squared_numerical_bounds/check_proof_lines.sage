# 対象ラベル: pi_squared_numerical_bounds
# 証明: 3.141592 ≤ π ≤ 3.141593 から、π² = π·π ≥ 3.141592·π ≥ 3.141592² = 9.869600294464 ≥ 9.8696、
#       π² = π·π ≤ 3.141593·π ≤ 3.141593² = 9.869606577649 ≤ 9.8697。
# 帰属: 有理数の積・大小は QQ で厳密に。前提の円周率の数値（本文が外部から持ち込む事実）と π を含む行の大小は、
# π を囲むボール（RealBallField(256) の pi()）で確かめる。
load("../../_shared/sine_cosine_by_definition.sage")
lo, hi = QQ(3141592) / 10^6, QQ(3141593) / 10^6
assert surely_ge(PI_BALL, RBF256(lo)) and surely_ge(RBF256(hi), PI_BALL) and lo > 0
print("前提 0 < 3.141592 ≤ π ≤ 3.141593 がボールで成り立つ")
assert surely_ge(PI_BALL * PI_BALL, lo * PI_BALL) and surely_ge(lo * PI_BALL, RBF256(lo * lo))      # 下の鎖 2・3 行目
assert lo * lo == QQ(9869600294464) / 10^12 and lo * lo >= QQ(98696) / 10^4                           # 4・5 行目
assert surely_ge(hi * PI_BALL, PI_BALL * PI_BALL) and surely_ge(RBF256(hi * hi), hi * PI_BALL)      # 上の鎖 2・3 行目
assert hi * hi == QQ(9869606577649) / 10^12 and hi * hi <= QQ(98697) / 10^4                           # 4・5 行目
print("二つの鎖の各行が成り立つ（有理数の行は QQ、π を含む行はボール）")
assert RBF256(QQ(98696)/10^4) < PI_BALL^2 < RBF256(QQ(98697)/10^4)
print("主張 9.8696 ≤ π² ≤ 9.8697 がボールでも成り立つ")
assert not (QQ(314159) / 10^5) ^ 2 >= QQ(98696) / 10^4
print("対照: π ≥ 3.14159 だけでは下の鎖が 9.8696 に届かない")
print("RESULT: PASS")
