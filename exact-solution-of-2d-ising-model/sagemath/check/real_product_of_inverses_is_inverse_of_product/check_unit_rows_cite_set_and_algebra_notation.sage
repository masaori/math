# 対象ラベル: real_product_of_inverses_is_inverse_of_product
# 「0 は ℝ の加法の単位元」「1 は ℝ の乗法の単位元」（set_and_algebra_notation）を引く行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。各行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 「右辺から左辺へ」の行は、形の右辺が前の行、左辺が次の行に入る。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<a, b> = QQ[]
K = R.fraction_field(); a, b = K(a), K(b)
def add_right(t): return (t + 0, t)   # x + 0 = x（パターン変数 y の行も同じ形）
def add_left(t):  return (0 + t, t)   # 0 + x = x
def mul_right(t): return (t * 1, t)   # x·1 = x
def mul_left(t):  return (1 * t, t)   # 1·x = x
def check(name, prev, nxt, ctx, form, subs, rtl=False):
    for s in subs:
        l, r = form(s)
        if rtl: l, r = r, l
        assert l == r, name
    l, r = form(subs[0])
    if rtl: l, r = r, l
    assert prev == ctx(l) and nxt == ctx(r), name
    print("row", name)
check("a·(a^{-1}·1) = a·a^{-1}（x·1 = x の x → a^{-1}）", a*((1/a)*1), a*(1/a), lambda u: a*u, mul_right, [1/a], rtl=False)
check("a^{-1}·b^{-1} = 1·(a^{-1}·b^{-1})（1·x = x の x → a^{-1}·b^{-1} を右辺から左辺へ）", (1/a)*(1/b), 1*((1/a)*(1/b)), lambda u: u, mul_left, [(1/a)*(1/b)], rtl=True)
check("(a·b)^{-1}·1 = (a·b)^{-1}（x·1 = x の x → (a·b)^{-1}）", (1/(a*b))*1, 1/(a*b), lambda u: u, mul_right, [1/(a*b)], rtl=False)
assert QQ(0) + QQ(1) != QQ(0)   # 対照: 単位元でない元を足すと変わる
assert QQ(2) * QQ(3) != QQ(3)   # 対照: 単位元でない元を掛けると変わる
print("RESULT: PASS")
