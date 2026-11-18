# 対象ラベル: product_of_sums_of_two_squares_identity
# 証明の 2 本の鎖（準備の (ad)(bc) = (ac)(bd) の 5 行と、主張の (ac−bd)²+(ad+bc)² = (a²+b²)(c²+d²) の 28 行）を、
# 各行に書かれた式どおり（括弧も行のとおり）に組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ 上の多項式環（a, b, c, d は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
# 多項式環は可換で式を正規化するので、鎖の検査では、各行にどの等式を当てたかは区別できず、各行の式が等しいことだけを確かめる。
# 各行の根拠に書いた等式の形と代入から実例を作り、その両辺が等しいことは下の laws で別に確かめる。
P.<a, b, c, d> = PolynomialRing(QQ)
neg = lambda x: -x

prep = [
    ((a*d)*(b*c)),  # 左端
    (a*(d*(b*c))),  # massoc を 1 箇所
    (a*((d*b)*c)),  # massoc 右辺から左辺へ を 1 箇所
    (a*((b*d)*c)),  # mcomm を 1 箇所
    (a*(c*(b*d))),  # mcomm を 1 箇所
    ((a*c)*(b*d)),  # massoc 右辺から左辺へ を 1 箇所
]
for k in range(len(prep) - 1):
    assert prep[k] == prep[k + 1], ("prep", k)

chain = [
    ((((a*c) - (b*d)))^2 + (((a*d) + (b*c)))^2),  # 左端
    ((((a*c) - (b*d))*((a*c) - (b*d))) + (((a*d) + (b*c))*((a*d) + (b*c)))),  # sqprod を 2 箇所
    ((((a*c) + neg((b*d)))*((a*c) + neg((b*d)))) + (((a*d) + (b*c))*((a*d) + (b*c)))),  # diff を 2 箇所
    ((((a*c)*((a*c) + neg((b*d)))) + (neg((b*d))*((a*c) + neg((b*d))))) + (((a*d)*((a*d) + (b*c))) + ((b*c)*((a*d) + (b*c))))),  # distR を 2 箇所
    (((((a*c)*(a*c)) + ((a*c)*neg((b*d)))) + ((neg((b*d))*(a*c)) + (neg((b*d))*neg((b*d))))) + ((((a*d)*(a*d)) + ((a*d)*(b*c))) + (((b*c)*(a*d)) + ((b*c)*(b*c))))),  # distL を 4 箇所
    (((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + ((neg((b*d))*(a*c)) + (neg((b*d))*neg((b*d))))) + ((((a*d)*(a*d)) + ((a*d)*(b*c))) + (((b*c)*(a*d)) + ((b*c)*(b*c))))),  # negR を 1 箇所
    (((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + (neg(((b*d)*(a*c))) + (neg((b*d))*neg((b*d))))) + ((((a*d)*(a*d)) + ((a*d)*(b*c))) + (((b*c)*(a*d)) + ((b*c)*(b*c))))),  # negL を 1 箇所
    (((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + (neg(((b*d)*(a*c))) + ((b*d)*(b*d)))) + ((((a*d)*(a*d)) + ((a*d)*(b*c))) + (((b*c)*(a*d)) + ((b*c)*(b*c))))),  # real_negation_times_negation_is_product (-a)(-b) = ab を 1 箇所
    (((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + (neg(((a*c)*(b*d))) + ((b*d)*(b*d)))) + ((((a*d)*(a*d)) + ((a*d)*(b*c))) + (((a*d)*(b*c)) + ((b*c)*(b*c))))),  # mcomm を 2 箇所
    (((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + (neg(((a*c)*(b*d))) + ((b*d)*(b*d)))) + ((((a*d)*(a*d)) + ((a*c)*(b*d))) + (((a*c)*(b*d)) + ((b*c)*(b*c))))),  # aux を 2 箇所
    ((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + ((neg(((a*c)*(b*d))) + ((b*d)*(b*d))) + ((((a*d)*(a*d)) + ((a*c)*(b*d))) + (((a*c)*(b*d)) + ((b*c)*(b*c)))))),  # aassoc を 1 箇所
    ((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + (((neg(((a*c)*(b*d))) + ((b*d)*(b*d))) + (((a*d)*(a*d)) + ((a*c)*(b*d)))) + (((a*c)*(b*d)) + ((b*c)*(b*c))))),  # aassoc 右辺から左辺へ を 1 箇所
    ((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + (((((a*d)*(a*d)) + ((a*c)*(b*d))) + (neg(((a*c)*(b*d))) + ((b*d)*(b*d)))) + (((a*c)*(b*d)) + ((b*c)*(b*c))))),  # acomm を 1 箇所
    ((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + ((((a*d)*(a*d)) + ((a*c)*(b*d))) + ((neg(((a*c)*(b*d))) + ((b*d)*(b*d))) + (((a*c)*(b*d)) + ((b*c)*(b*c)))))),  # aassoc を 1 箇所
    (((((a*c)*(a*c)) + neg(((a*c)*(b*d)))) + (((a*d)*(a*d)) + ((a*c)*(b*d)))) + ((neg(((a*c)*(b*d))) + ((b*d)*(b*d))) + (((a*c)*(b*d)) + ((b*c)*(b*c))))),  # aassoc 右辺から左辺へ を 1 箇所
    ((((a*c)*(a*c)) + (neg(((a*c)*(b*d))) + (((a*d)*(a*d)) + ((a*c)*(b*d))))) + (neg(((a*c)*(b*d))) + (((b*d)*(b*d)) + (((a*c)*(b*d)) + ((b*c)*(b*c)))))),  # aassoc を 2 箇所
    ((((a*c)*(a*c)) + ((neg(((a*c)*(b*d))) + ((a*d)*(a*d))) + ((a*c)*(b*d)))) + (neg(((a*c)*(b*d))) + ((((b*d)*(b*d)) + ((a*c)*(b*d))) + ((b*c)*(b*c))))),  # aassoc 右辺から左辺へ を 2 箇所
    ((((a*c)*(a*c)) + ((((a*d)*(a*d)) + neg(((a*c)*(b*d)))) + ((a*c)*(b*d)))) + (neg(((a*c)*(b*d))) + ((((a*c)*(b*d)) + ((b*d)*(b*d))) + ((b*c)*(b*c))))),  # acomm を 2 箇所
    ((((a*c)*(a*c)) + (((a*d)*(a*d)) + (neg(((a*c)*(b*d))) + ((a*c)*(b*d))))) + (neg(((a*c)*(b*d))) + (((a*c)*(b*d)) + (((b*d)*(b*d)) + ((b*c)*(b*c)))))),  # aassoc を 2 箇所
    (((((a*c)*(a*c)) + ((a*d)*(a*d))) + (neg(((a*c)*(b*d))) + ((a*c)*(b*d)))) + ((neg(((a*c)*(b*d))) + ((a*c)*(b*d))) + (((b*d)*(b*d)) + ((b*c)*(b*c))))),  # aassoc 右辺から左辺へ を 2 箇所
    (((((a*c)*(a*c)) + ((a*d)*(a*d))) + (((a*c)*(b*d)) + neg(((a*c)*(b*d))))) + ((((a*c)*(b*d)) + neg(((a*c)*(b*d)))) + (((b*d)*(b*d)) + ((b*c)*(b*c))))),  # acomm を 2 箇所
    (((((a*c)*(a*c)) + ((a*d)*(a*d))) + 0) + (0 + (((b*d)*(b*d)) + ((b*c)*(b*c))))),  # ainv を 2 箇所
    ((((a*c)*(a*c)) + ((a*d)*(a*d))) + (0 + (((b*d)*(b*d)) + ((b*c)*(b*c))))),  # rzero を 1 箇所
    ((((a*c)*(a*c)) + ((a*d)*(a*d))) + (((b*d)*(b*d)) + ((b*c)*(b*c)))),  # lzero を 1 箇所
    ((((a*c)*(a*c)) + ((a*d)*(a*d))) + (((b*c)*(b*c)) + ((b*d)*(b*d)))),  # acomm を 1 箇所
    ((((a*c))^2 + ((a*d))^2) + (((b*c))^2 + ((b*d))^2)),  # sqprod 右辺から左辺へ を 4 箇所
    ((((a)^2*(c)^2) + ((a)^2*(d)^2)) + (((b)^2*(c)^2) + ((b)^2*(d)^2))),  # powprod 右辺から左辺へ を 4 箇所
    (((a)^2*((c)^2 + (d)^2)) + ((b)^2*((c)^2 + (d)^2))),  # distL 右辺から左辺へ を 2 箇所
    (((a)^2 + (b)^2)*((c)^2 + (d)^2)),  # distR 右辺から左辺へ を 1 箇所
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], ("chain", k)
assert chain[0] == (a*c - b*d)^2 + (a*d + b*c)^2      # 主張の左辺
assert chain[-1] == (a^2 + b^2) * (c^2 + d^2)          # 主張の右辺

# 各行の根拠に書いた等式の形（左辺, 右辺）。同じ代入を 2 箇所へ当てた行は 1 組に数える。
forms = {
    "sqprod":  (lambda r: r^2,                 lambda r: r*r),
    "diff":    (lambda y, t: y - t,            lambda y, t: y + neg(t)),
    "distR":   (lambda x, y, t: (x + y)*t,     lambda x, y, t: x*t + y*t),
    "distL":   (lambda x, y, t: x*(y + t),     lambda x, y, t: x*y + x*t),
    "negR":    (lambda x, t: x*neg(t),         lambda x, t: neg(x*t)),
    "negL":    (lambda x, t: neg(x)*t,         lambda x, t: neg(x*t)),
    "negneg":  (lambda p, q: neg(p)*neg(q),    lambda p, q: p*q),   # real_negation_times_negation_is_product の (-a)(-b) = ab（文字 p, q）
    "mcomm":   (lambda x, y: x*y,              lambda x, y: y*x),
    "massoc":  (lambda x, y, t: (x*y)*t,       lambda x, y, t: x*(y*t)),
    "aassoc":  (lambda x, y, t: (x + y) + t,   lambda x, y, t: x + (y + t)),
    "acomm":   (lambda x, y: x + y,            lambda x, y: y + x),
    "ainv":    (lambda z: z + neg(z),          lambda z: 0),
    "rzero":   (lambda x: x + 0,               lambda x: x),
    "lzero":   (lambda x: 0 + x,               lambda x: x),
    "powprod": (lambda p, q: p^2 * q^2,        lambda p, q: (p*q)^2),  # product_of_real_powers_is_power_of_product（m = 2、文字 p, q）
}
subs = [
    ("massoc", (a, d, (b*c))),
    ("massoc", (d, b, c)),
    ("mcomm", (d, b)),
    ("mcomm", ((b*d), c)),
    ("massoc", (a, c, (b*d))),
    ("sqprod", (((a*c) - (b*d)),)),
    ("sqprod", (((a*d) + (b*c)),)),
    ("diff", ((a*c), (b*d))),
    ("distR", ((a*c), neg((b*d)), ((a*c) + neg((b*d))))),
    ("distR", ((a*d), (b*c), ((a*d) + (b*c)))),
    ("distL", ((a*c), (a*c), neg((b*d)))),
    ("distL", (neg((b*d)), (a*c), neg((b*d)))),
    ("distL", ((a*d), (a*d), (b*c))),
    ("distL", ((b*c), (a*d), (b*c))),
    ("negR", ((a*c), (b*d))),
    ("negL", ((b*d), (a*c))),
    ("negneg", ((b*d), (b*d))),
    ("mcomm", ((b*d), (a*c))),
    ("mcomm", ((b*c), (a*d))),
    ("aassoc", ((((a*c)*(a*c)) + neg(((a*c)*(b*d)))), (neg(((a*c)*(b*d))) + ((b*d)*(b*d))), ((((a*d)*(a*d)) + ((a*c)*(b*d))) + (((a*c)*(b*d)) + ((b*c)*(b*c)))))),
    ("aassoc", ((neg(((a*c)*(b*d))) + ((b*d)*(b*d))), (((a*d)*(a*d)) + ((a*c)*(b*d))), (((a*c)*(b*d)) + ((b*c)*(b*c))))),
    ("acomm", ((neg(((a*c)*(b*d))) + ((b*d)*(b*d))), (((a*d)*(a*d)) + ((a*c)*(b*d))))),
    ("aassoc", ((((a*d)*(a*d)) + ((a*c)*(b*d))), (neg(((a*c)*(b*d))) + ((b*d)*(b*d))), (((a*c)*(b*d)) + ((b*c)*(b*c))))),
    ("aassoc", ((((a*c)*(a*c)) + neg(((a*c)*(b*d)))), (((a*d)*(a*d)) + ((a*c)*(b*d))), ((neg(((a*c)*(b*d))) + ((b*d)*(b*d))) + (((a*c)*(b*d)) + ((b*c)*(b*c)))))),
    ("aassoc", (((a*c)*(a*c)), neg(((a*c)*(b*d))), (((a*d)*(a*d)) + ((a*c)*(b*d))))),
    ("aassoc", (neg(((a*c)*(b*d))), ((b*d)*(b*d)), (((a*c)*(b*d)) + ((b*c)*(b*c))))),
    ("aassoc", (neg(((a*c)*(b*d))), ((a*d)*(a*d)), ((a*c)*(b*d)))),
    ("aassoc", (((b*d)*(b*d)), ((a*c)*(b*d)), ((b*c)*(b*c)))),
    ("acomm", (neg(((a*c)*(b*d))), ((a*d)*(a*d)))),
    ("acomm", (((b*d)*(b*d)), ((a*c)*(b*d)))),
    ("aassoc", (((a*d)*(a*d)), neg(((a*c)*(b*d))), ((a*c)*(b*d)))),
    ("aassoc", (((a*c)*(b*d)), ((b*d)*(b*d)), ((b*c)*(b*c)))),
    ("aassoc", (((a*c)*(a*c)), ((a*d)*(a*d)), (neg(((a*c)*(b*d))) + ((a*c)*(b*d))))),
    ("aassoc", (neg(((a*c)*(b*d))), ((a*c)*(b*d)), (((b*d)*(b*d)) + ((b*c)*(b*c))))),
    ("acomm", (neg(((a*c)*(b*d))), ((a*c)*(b*d)))),
    ("ainv", (((a*c)*(b*d)),)),
    ("rzero", ((((a*c)*(a*c)) + ((a*d)*(a*d))),)),
    ("lzero", ((((b*d)*(b*d)) + ((b*c)*(b*c))),)),
    ("acomm", (((b*d)*(b*d)), ((b*c)*(b*c)))),
    ("sqprod", ((a*c),)),
    ("sqprod", ((a*d),)),
    ("sqprod", ((b*c),)),
    ("sqprod", ((b*d),)),
    ("powprod", (a, c)),
    ("powprod", (a, d)),
    ("powprod", (b, c)),
    ("powprod", (b, d)),
    ("distL", ((a)^2, (c)^2, (d)^2)),
    ("distL", ((b)^2, (c)^2, (d)^2)),
    ("distR", ((a)^2, (b)^2, ((c)^2 + (d)^2))),
]
for k, (name, args) in enumerate(subs):
    lhs, rhs = forms[name]
    assert lhs(*args) == rhs(*args), (k, name)

# 対照: 第 2 成分の符号を誤った (ad−bc) では、恒等式は成り立たない
assert (a*c - b*d)^2 + (a*d - b*c)^2 != (a^2 + b^2) * (c^2 + d^2)
print(f"checked {len(prep) - 1} rows of the preparatory chain, {len(chain) - 1} rows of the main chain and {len(subs)} law instances")
print("RESULT: PASS")
