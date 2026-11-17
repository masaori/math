# 対象ラベル: relation_of_gamma_2_theta_tilde
# 「0 は ℝ の加法の単位元」（set_and_algebra_notation）を引く行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 「右辺から左辺へ」の行は、前の行が形の右辺、次の行が形の左辺を穴に入れたものになる。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<t> = QQ[]
def add_right(s): return (s + 0, s)   # x + 0 = x
def check(name, prev, nxt, ctx, form, subs, rtl=False):
    ls = [form(s)[0] for s in subs]
    rs = [form(s)[1] for s in subs]
    for l, r in zip(ls, rs):
        assert l == r, name
    if rtl:
        assert prev == ctx(*rs) and nxt == ctx(*ls), name
    else:
        assert prev == ctx(*ls) and nxt == ctx(*rs), name
    print("row", name)
m = QQ(-1) * 1   # (−1)·1
# 「第二に」の \bar i の鎖の 4 行目。鎖の項は ℝ の対。文脈は対の第 2 成分の穴。
check("\\bar i の鎖 4 行目: (0, (−1)·1) = (0, (−1)·1 + 0)（x + 0 = x の x → (−1)·1 を右辺から左辺へ）",
      (QQ(0), m), (QQ(0), m + 0), lambda u: (QQ(0), u), add_right, [m], rtl=True)
assert add_right(t)[0] == add_right(t)[1]
assert QQ(0) + QQ(1) != QQ(0)   # 対照: 単位元でない元を足すと変わる
print("RESULT: PASS")
