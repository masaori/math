# 対象ラベル: sine_bound_constant_numerical_bounds
# 証明: 準備 9.8696/24 ≤ π²/24 ≤ 9.8697/24、-9.8697/24 ≤ -π²/24 ≤ -9.8696/24、1-9.8697/24 ≤ 1-π²/24 ≤ 1-9.8696/24。
#       c0 = 1 - π²/24 ≥ 1 - 9.8697/24 = 14.1303/24 ≥ 14.1288/24 = 0.5887、
#       c0 = 1 - π²/24 ≤ 1 - 9.8696/24 = 14.1304/24 ≤ 14.1312/24 = 0.5888。
# 帰属: 有理数の行は QQ で厳密に。π² を含む行は π のボールで。
load("../../_shared/sine_cosine_by_definition.sage")
c0 = 1 - PI_BALL^2 / 24
a, b = QQ(98697) / 10^4, QQ(98696) / 10^4
p2 = PI_BALL^2
assert surely_ge(p2 / 24, RBF256(b / 24)) and surely_ge(RBF256(a / 24), p2 / 24)       # 準備 1（24 で割る）
assert surely_ge(-p2 / 24, RBF256(-a / 24)) and surely_ge(RBF256(-b / 24), -p2 / 24)   # 準備 2（-1 を掛ける）
assert surely_ge(1 - p2 / 24, RBF256(1 - a / 24)) and surely_ge(RBF256(1 - b / 24), 1 - p2 / 24)   # 準備 3（1 を足す）
assert surely_ge(c0, RBF256(1 - a / 24)) and surely_ge(RBF256(1 - b / 24), c0)   # 2 行目
assert 1 - a / 24 == QQ(141303) / 10^4 / 24 and 1 - b / 24 == QQ(141304) / 10^4 / 24   # 3 行目
assert QQ(141303) / 10^4 / 24 >= QQ(141288) / 10^4 / 24                            # 4 行目（下）
assert QQ(141288) / 10^4 / 24 == QQ(5887) / 10^4                                   # 5 行目（下）
assert QQ(141304) / 10^4 / 24 <= QQ(141312) / 10^4 / 24                            # 4 行目（上）
assert QQ(141312) / 10^4 / 24 == QQ(5888) / 10^4                                   # 5 行目（上）
print("二つの鎖の各行が成り立つ（有理数の行は QQ、π² を含む行はボール）")
assert RBF256(QQ(5887)/10^4) < c0 < RBF256(QQ(5888)/10^4)
print(f"主張 0.5887 ≤ c0 ≤ 0.5888 がボールでも成り立つ（c0 ∈ {c0.numerical_approx(30)}）")
print("RESULT: PASS")
