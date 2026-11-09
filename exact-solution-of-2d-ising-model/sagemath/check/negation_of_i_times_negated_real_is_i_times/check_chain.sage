# 対象ラベル: negation_of_i_times_negated_real_is_i_times
# 証明の二行の鎖の三つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ(i) 上の多項式環（θ は不定元）。
Ki = QuadraticField(-1, 'i')
i = Ki.gen()
R = PolynomialRing(Ki, 't')
t = R.gen()                              # θ_C

chain = [
    -(i * (-t)),                         # -(i(-θ)_C)
    -(-(i * t)),                         # -(-(iθ_C))            i_times_negated_real_is_negation_of_i_times
    i * t,                               # iθ_C                  ℂ で -(-z) = z
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
assert chain[0] != -(i * t)              # 対照: 符号を一つだけ外した形とは一致しない
print("checked the 2-line chain over QQ(i)[θ]")
print("RESULT: PASS")
