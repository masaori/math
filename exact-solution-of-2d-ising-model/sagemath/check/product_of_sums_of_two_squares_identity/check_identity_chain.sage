# 対象ラベル: product_of_sums_of_two_squares_identity
# 証明の (ac−bd)²+(ad+bc)² = (a²+b²)(c²+d²) の鎖の 5 行を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ 上の多項式環（a, b, c, d は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
P.<a, b, c, d> = PolynomialRing(QQ)
chain = [
    (a*c - b*d)^2 + (a*d + b*c)^2,                                              # 主張の左辺
    (a^2*c^2 - 2*a*b*c*d + b^2*d^2) + (a^2*d^2 + 2*a*b*c*d + b^2*c^2),          # ℝ の分配律と積の結合律・可換律
    a^2*c^2 + b^2*d^2 + a^2*d^2 + b^2*c^2 + ((-2*a*b*c*d) + 2*a*b*c*d),         # ℝ の和の可換律と結合律
    a^2*c^2 + b^2*d^2 + a^2*d^2 + b^2*c^2 + 0,                                  # -2abcd は 2abcd の和の逆元
    a^2*c^2 + b^2*d^2 + a^2*d^2 + b^2*c^2,                                      # x + 0 = x（set_and_algebra_notation）
    (a^2 + b^2) * (c^2 + d^2),                                                  # ℝ の分配律と積の可換律
]
for t in range(len(chain) - 1):
    assert chain[t] == chain[t + 1], t
# 第 2・第 3 の項の括弧の中の -2abcd と 2abcd が和の逆元どうしであること（第 3 の等号の根拠）
assert (-2*a*b*c*d) + 2*a*b*c*d == 0
# 対照: 第 2 成分の符号を誤った (ad−bc) では、恒等式は成り立たない
assert (a*c - b*d)^2 + (a*d - b*c)^2 != (a^2 + b^2) * (c^2 + d^2)
print(f"checked {len(chain) - 1} rows of the chain")
print("RESULT: PASS")
