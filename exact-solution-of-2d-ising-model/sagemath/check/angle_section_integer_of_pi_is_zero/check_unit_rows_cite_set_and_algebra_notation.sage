# 対象ラベル: angle_section_integer_of_pi_is_zero
# 「0 は ℝ の加法の単位元」「1 は ℝ の乗法の単位元」（set_and_algebra_notation）を引く行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。各行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 「右辺から左辺へ」の行は、形の右辺が前の行、左辺が次の行に入る。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<p> = QQ[]   # p は π を表す不定元（π の値は使わない）
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
check("π = 0 + π（0 + x = x の x → π を右辺から左辺へ）", p, 0 + p, lambda u: u, add_left, [p], rtl=True)
check("π + π = 1·π + 1·π（1·x = x の x → π を 2 箇所へ、右辺から左辺へ）", p + p, 1*p + 1*p, lambda u: u + u, mul_left, [p], rtl=True)
assert QQ(0) + QQ(1) != QQ(0)   # 対照: 単位元でない元を足すと変わる
assert QQ(2) * QQ(3) != QQ(3)   # 対照: 単位元でない元を掛けると変わる
print("RESULT: PASS")
