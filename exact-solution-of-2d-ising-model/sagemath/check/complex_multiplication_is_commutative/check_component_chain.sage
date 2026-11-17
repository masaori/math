# 対象ラベル: complex_multiplication_is_commutative
# 証明の w·z = z·w の鎖の 7 つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ 上の多項式環（a, b, c, d は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
load("_prelude.sage")

P.<a, b, c, d> = PolynomialRing(QQ)
z = (a, b)
w = (c, d)
chain = [
    cc_mul(w, z),                    # w·z
    cc_mul((c, d), (a, b)),          # w = (c,d), z = (a,b)
    (c * a - d * b, c * b + d * a),  # definition_of_cc の積
    (a * c - b * d, c * b + d * a),  # ℝ の積の可換律 (x→c, y→a), (x→d, y→b)
    (a * c - b * d, b * c + a * d),  # ℝ の積の可換律 (x→c, y→b), (x→d, y→a)
    (a * c - b * d, a * d + b * c),  # ℝ の和の可換律 (x→bc, y→ad)
    cc_mul((a, b), (c, d)),          # definition_of_cc の積を右辺から左辺へ
    cc_mul(z, w),                    # z = (a,b), w = (c,d)
]
for t in range(len(chain) - 1):
    assert chain[t] == chain[t + 1], t
# 対照: 積の定義の第 2 成分の符号を誤った (ac - bd, ad - bc) とは一致しない
assert chain[0] != (a * c - b * d, a * d - b * c)
# 0_C を含む元でも成り立つ（主張は C^× に限らない）: z = (0, 0) を代入
zero = {a: 0, b: 0}
assert tuple(x.subs(zero) for x in cc_mul(w, z)) == tuple(x.subs(zero) for x in cc_mul(z, w))
print(f"checked {len(chain) - 1} rows of the chain")
print("RESULT: PASS")
