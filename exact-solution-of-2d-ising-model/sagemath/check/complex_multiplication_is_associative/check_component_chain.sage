# 対象ラベル: complex_multiplication_is_associative
# 証明の (z·w)·u = z·(w·u) の鎖の 9 行を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ 上の多項式環（a, b, c, d, e, f は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
load("_prelude.sage")

P.<a, b, c, d, e, f> = PolynomialRing(QQ)
z = (a, b)
w = (c, d)
u = (e, f)
chain = [
    cc_mul(cc_mul(z, w), u),                                             # (z·w)·u
    cc_mul(cc_mul((a, b), (c, d)), (e, f)),                              # z=(a,b), w=(c,d), u=(e,f)
    cc_mul((a*c - b*d, a*d + b*c), (e, f)),                              # definition_of_cc の積
    ((a*c - b*d)*e - (a*d + b*c)*f, (a*c - b*d)*f + (a*d + b*c)*e),      # definition_of_cc の積
    (a*c*e - b*d*e - a*d*f - b*c*f, a*c*f - b*d*f + a*d*e + b*c*e),      # ℝ の分配律と積の結合律
    (a*c*e - a*d*f - b*c*f - b*d*e, a*c*f + a*d*e + b*c*e - b*d*f),      # ℝ の和の可換律と結合律
    (a*(c*e - d*f) - b*(c*f + d*e), a*(c*f + d*e) + b*(c*e - d*f)),      # ℝ の分配律と積の結合律
    cc_mul((a, b), (c*e - d*f, c*f + d*e)),                              # definition_of_cc の積を右辺から左辺へ
    cc_mul((a, b), cc_mul((c, d), (e, f))),                              # definition_of_cc の積を右辺から左辺へ
    cc_mul(z, cc_mul(w, u)),                                             # z=(a,b), w=(c,d), u=(e,f)
]
for t in range(len(chain) - 1):
    assert chain[t] == chain[t + 1], t
# 対照: 積の定義の第 2 成分の符号を誤った積では、結合の仕方で値が変わる
def bad_mul(x, y):
    return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] - x[1]*y[0])
assert bad_mul(bad_mul(z, w), u) != bad_mul(z, bad_mul(w, u))
print(f"checked {len(chain) - 1} rows of the chain")
print("RESULT: PASS")
