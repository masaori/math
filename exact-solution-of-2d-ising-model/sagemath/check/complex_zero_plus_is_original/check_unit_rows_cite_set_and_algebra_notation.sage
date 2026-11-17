# 対象ラベル: complex_zero_plus_is_original
# 「0 は ℝ の加法の単位元」「1 は ℝ の乗法の単位元」（set_and_algebra_notation）を引く行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。各行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 「右辺から左辺へ」の行は、形の右辺が前の行、左辺が次の行に入る。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<a, b> = QQ[]
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
# 2 箇所への適用: 第 1 成分に x → a、第 2 成分に x → b を当てる。
la, ra = add_left(a); lb, rb = add_left(b)
assert la == ra and lb == rb
assert (0 + a, 0 + b) == (la, lb) and (a, b) == (ra, rb)
print("row (0 + a, 0 + b) = (a, b)（0 + x = x の x → a, x → b を 2 箇所へ）")
assert QQ(0) + QQ(1) != QQ(0)   # 対照: 単位元でない元を足すと変わる
assert QQ(2) * QQ(3) != QQ(3)   # 対照: 単位元でない元を掛けると変わる
print("RESULT: PASS")
