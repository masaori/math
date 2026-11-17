# 対象ラベル: zero_in_closed_interval_from_minus_half_pi_to_half_pi
# 「0 は ℝ の加法の単位元」（set_and_algebra_notation）を引く行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 「右辺から左辺へ」の行は、前の行が形の右辺、次の行が形の左辺を穴に入れたものになる。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
# π は記号のまま扱う: 不定元 p を π に置き、−π/2 を −p/2 として QQ[p] で比べる（π の値は使わない）。
R.<p> = QQ[]
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
m = -(p / 2)   # −π/2 は −(π/2)
# −π/2 < 0 の鎖の 1 行目。文脈は式全体の穴。
check("−π/2 の鎖: −π/2 = −π/2 + 0（x + 0 = x の x → −π/2 を右辺から左辺へ）",
      m, m + 0, lambda u: u, add_right, [m], rtl=True)
assert add_right(p)[0] == add_right(p)[1]
assert m + 1 != m   # 対照: 単位元でない元を足すと変わる
print("RESULT: PASS")
