# 対象ラベル: complex_multiplication_is_associative
# 証明の (z·w)·u = z·(w·u) の鎖の 19 行を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ 上の多項式環（a, b, c, d, e, f は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
# 多項式環は可換で式を正規化するので、鎖の検査では、各行にどの等式を当てたかは区別できず、各行の式が等しいことだけを確かめる。
# 各行の根拠に書いた等式の形と代入から実例を作り、その両辺が等しいことは下の laws で別に確かめる。
load("_prelude.sage")

P.<a, b, c, d, e, f> = PolynomialRing(QQ)
z = (a, b)
w = (c, d)
u = (e, f)
neg = lambda x: -x
chain = [
    cc_mul(cc_mul(z, w), u),                                                  # (z·w)·u
    cc_mul(cc_mul((a, b), (c, d)), (e, f)),                                   # z=(a,b), w=(c,d), u=(e,f)
    cc_mul((a*c - b*d, a*d + b*c), (e, f)),                                   # definition_of_cc の積
    ((a*c - b*d)*e - (a*d + b*c)*f, (a*c - b*d)*f + (a*d + b*c)*e),           # definition_of_cc の積
    ((a*c + neg(b*d))*e + neg((a*d + b*c)*f),
     (a*c + neg(b*d))*f + (a*d + b*c)*e),                                     # 差の定義を 3 箇所
    (((a*c)*e + neg(b*d)*e) + neg((a*d)*f + (b*c)*f),
     ((a*c)*f + neg(b*d)*f) + ((a*d)*e + (b*c)*e)),                           # 分配則 (x+y)t を 4 箇所
    (((a*c)*e + neg((b*d)*e)) + neg((a*d)*f + (b*c)*f),
     ((a*c)*f + neg((b*d)*f)) + ((a*d)*e + (b*c)*e)),                         # (-x)t = -(xt) を 2 箇所
    (((a*c)*e + neg((b*d)*e)) + (neg((a*d)*f) + neg((b*c)*f)),
     ((a*c)*f + neg((b*d)*f)) + ((a*d)*e + (b*c)*e)),                         # -(x+y) = (-x)+(-y)
    ((a*(c*e) + neg(b*(d*e))) + (neg(a*(d*f)) + neg(b*(c*f))),
     (a*(c*f) + neg(b*(d*f))) + (a*(d*e) + b*(c*e))),                         # 積の結合則を 8 箇所
    (a*(c*e) + (neg(b*(d*e)) + (neg(a*(d*f)) + neg(b*(c*f)))),
     a*(c*f) + (neg(b*(d*f)) + (a*(d*e) + b*(c*e)))),                         # 加法の結合則を 2 箇所
    (a*(c*e) + ((neg(a*(d*f)) + neg(b*(c*f))) + neg(b*(d*e))),
     a*(c*f) + ((a*(d*e) + b*(c*e)) + neg(b*(d*f)))),                         # 加法の可換則を 2 箇所
    (a*(c*e) + (neg(a*(d*f)) + (neg(b*(c*f)) + neg(b*(d*e)))),
     a*(c*f) + (a*(d*e) + (b*(c*e) + neg(b*(d*f))))),                         # 加法の結合則を 2 箇所
    ((a*(c*e) + neg(a*(d*f))) + (neg(b*(c*f)) + neg(b*(d*e))),
     (a*(c*f) + a*(d*e)) + (b*(c*e) + neg(b*(d*f)))),                         # 加法の結合則を 2 箇所へ右辺から左辺へ
    ((a*(c*e) + neg(a*(d*f))) + neg(b*(c*f) + b*(d*e)),
     (a*(c*f) + a*(d*e)) + (b*(c*e) + neg(b*(d*f)))),                         # -(x+y) = (-x)+(-y) を右辺から左辺へ
    ((a*(c*e) + a*neg(d*f)) + neg(b*(c*f) + b*(d*e)),
     (a*(c*f) + a*(d*e)) + (b*(c*e) + b*neg(d*f))),                           # x(-t) = -(xt) を 2 箇所へ右辺から左辺へ
    (a*(c*e + neg(d*f)) + neg(b*(c*f + d*e)),
     a*(c*f + d*e) + b*(c*e + neg(d*f))),                                     # 分配則 x(y+t) を 4 箇所へ右辺から左辺へ
    (a*(c*e - d*f) - b*(c*f + d*e), a*(c*f + d*e) + b*(c*e - d*f)),           # 差の定義を 3 箇所へ右辺から左辺へ
    cc_mul((a, b), (c*e - d*f, c*f + d*e)),                                   # definition_of_cc の積を右辺から左辺へ
    cc_mul((a, b), cc_mul((c, d), (e, f))),                                   # definition_of_cc の積を右辺から左辺へ
    cc_mul(z, cc_mul(w, u)),                                                  # z=(a,b), w=(c,d), u=(e,f)
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k

# 各行の根拠に書いた等式の形（左辺, 右辺）と、行に書いた代入
forms = {
    "diff":     (lambda y, t: y - t,          lambda y, t: y + neg(t)),
    "distR":    (lambda x, y, t: (x + y)*t,   lambda x, y, t: x*t + y*t),
    "negL":     (lambda x, t: neg(x)*t,       lambda x, t: neg(x*t)),
    "negsum":   (lambda x, y: neg(x + y),     lambda x, y: neg(x) + neg(y)),
    "massoc":   (lambda x, y, t: (x*y)*t,     lambda x, y, t: x*(y*t)),
    "aassoc":   (lambda x, y, t: (x + y) + t, lambda x, y, t: x + (y + t)),
    "acomm":    (lambda x, y: x + y,          lambda x, y: y + x),
    "negR":     (lambda x, t: x*neg(t),       lambda x, t: neg(x*t)),
    "distL":    (lambda x, y, t: x*(y + t),   lambda x, y, t: x*y + x*t),
}
subs = [
    ("diff", (a*c, b*d)), ("diff", ((a*c - b*d)*e, (a*d + b*c)*f)),
    ("distR", (a*c, neg(b*d), e)), ("distR", (a*d, b*c, f)), ("distR", (a*c, neg(b*d), f)), ("distR", (a*d, b*c, e)),
    ("negL", (b*d, e)), ("negL", (b*d, f)),
    ("negsum", ((a*d)*f, (b*c)*f)),
] + [("massoc", v) for v in [(a, c, e), (b, d, e), (a, d, f), (b, c, f), (a, c, f), (b, d, f), (a, d, e), (b, c, e)]] + [
    ("aassoc", (a*(c*e), neg(b*(d*e)), neg(a*(d*f)) + neg(b*(c*f)))), ("aassoc", (a*(c*f), neg(b*(d*f)), a*(d*e) + b*(c*e))),
    ("acomm", (neg(b*(d*e)), neg(a*(d*f)) + neg(b*(c*f)))), ("acomm", (neg(b*(d*f)), a*(d*e) + b*(c*e))),
    ("aassoc", (neg(a*(d*f)), neg(b*(c*f)), neg(b*(d*e)))), ("aassoc", (a*(d*e), b*(c*e), neg(b*(d*f)))),
    ("aassoc", (a*(c*e), neg(a*(d*f)), neg(b*(c*f)) + neg(b*(d*e)))), ("aassoc", (a*(c*f), a*(d*e), b*(c*e) + neg(b*(d*f)))),
    ("negsum", (b*(c*f), b*(d*e))),
    ("negR", (a, d*f)), ("negR", (b, d*f)),
    ("distL", (a, c*e, neg(d*f))), ("distL", (b, c*f, d*e)), ("distL", (a, c*f, d*e)), ("distL", (b, c*e, neg(d*f))),
    ("diff", (c*e, d*f)), ("diff", (a*(c*e - d*f), b*(c*f + d*e))),
]
for k, (name, args) in enumerate(subs):
    lhs, rhs = forms[name]
    assert lhs(*args) == rhs(*args), (k, name)

# 対照: 積の定義の第 2 成分の符号を誤った積では、結合の仕方で値が変わる
def bad_mul(x, y):
    return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] - x[1]*y[0])
assert bad_mul(bad_mul(z, w), u) != bad_mul(z, bad_mul(w, u))
print(f"checked {len(chain) - 1} rows of the chain and {len(subs)} law instances")
print("RESULT: PASS")
