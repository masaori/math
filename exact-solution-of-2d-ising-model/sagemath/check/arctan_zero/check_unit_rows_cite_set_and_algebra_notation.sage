# 対象ラベル: arctan_zero
# 「0 は ℝ の加法の単位元」（set_and_algebra_notation）を引く行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<t> = QQ[]
def add_right(s): return (s + 0, s)   # x + 0 = x
def check(name, prev, nxt, ctx, form, subs):
    ls = [form(s)[0] for s in subs]
    rs = [form(s)[1] for s in subs]
    for l, r in zip(ls, rs):
        assert l == r, name
    assert prev == ctx(*ls) and nxt == ctx(*rs), name
    print("row", name)
# 4 行目: arcsin(0/√(1+0)) = arcsin(0/√1)。文脈は根号の中の穴（根号と arcsin は外の式なので穴の中だけを比べる）。
check("4 行目: √(1 + 0) を √1 にする 1 + 0 = 1（x + 0 = x の x → 1）",
      QQ(1) + 0, QQ(1), lambda u: u, add_right, [QQ(1)])
assert add_right(t)[0] == add_right(t)[1]
assert QQ(1) + QQ(1) != QQ(1)   # 対照: 単位元でない元を足すと変わる
print("RESULT: PASS")
