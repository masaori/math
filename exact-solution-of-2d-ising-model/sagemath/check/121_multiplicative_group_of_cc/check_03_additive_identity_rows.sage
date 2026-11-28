# 対象ラベル: multiplicative_group_of_cc
# 証明の 7 行の「0 は ℝ の加法の単位元（set_and_algebra_notation）」を、行に書いた形と代入どおりに
# QQ[a, b, c, d] の多項式として一行ずつ比べる（浮動小数点を使わない）。
R.<a, b, c, d> = PolynomialRing(QQ)
zero = R(0)

def left_id(x):   # 0 + x = x
    return (zero + x, x)

def right_id(x):  # x + 0 = x
    return (x + zero, x)

rows = [
    left_id(b),                                   # 積の単位元の鎖の最後の行: (a, 0 + b) = (a, b) の第 2 成分
    left_id(b^2),                                 # 平方和の非負の鎖: 0 + b² = b²
    right_id(a^2),                                # a² = a² + 0（右辺から左辺へ）
    left_id(-b^2),                                # 0 + (−b²) = −b²
    left_id(zero),                                # a = b = 0 の平方和の鎖: 0 + 0 = 0
    right_id(a^2*c^2 + b^2*d^2 + a^2*d^2 + b^2*c^2),  # 閉性の恒等式
    right_id(R(1)),                               # 1_C の平方和の鎖: 1 + 0 = 1
]
assert all(lhs == rhs for lhs, rhs in rows)

# 置き換えた行が属する鎖の前後の段と合わせて、鎖の両端が変わっていないこと
assert (a, zero + b) == (a, b)
assert (a^2 + zero) + (b^2 + (-b^2)) == a^2
# a² の鎖（仮定 a² + b² = 0 の下）: 両端 a² と −b² が商環 QQ[a, b, c, d]/(a² + b²) で一致する
Q = R.quotient(R.ideal(a^2 + b^2))
assert Q(a^2) == Q(-b^2) and a^2 != -b^2
# a = b = 0 の平方和の鎖: 両端 a² + b² と 0
assert (a^2 + b^2).subs({a: 0, b: 0}) == 0
assert (a*c - b*d)^2 + (a*d + b*c)^2 == (a^2 + b^2) * (c^2 + d^2)
assert R(1)^2 + R(0)^2 == 1
# 対照: 単位元でない元を足すと一致しない
assert R(1) + b != b

print("7 additive-identity rows as identities in QQ[a, b, c, d]")
print("RESULT: PASS")
