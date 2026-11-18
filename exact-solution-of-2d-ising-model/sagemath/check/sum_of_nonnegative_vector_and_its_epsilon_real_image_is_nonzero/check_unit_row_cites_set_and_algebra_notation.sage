# 対象ラベル: sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero
# 主張の鎖の u_{k_0} + 0 = u_{k_0} の行が引く「0 は ℝ の加法の単位元 x + 0 = x（x → u_{k_0}）」（set_and_algebra_notation）を、
# 行に書いた形と代入で形の両辺を作り、前の行と次の行が同じ文脈の穴に形の左辺・右辺を入れたものであることを比べる
# （浮動小数点を使わない）。u_{k_0} は不定元 t に置く。多項式環は式を正規化するので、形の左右と向きはこの検算では
# 区別できない（レビューの目視で確かめる）。
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
check("主張の鎖 3 行目: u_{k_0} + 0 = u_{k_0}（x + 0 = x の x → u_{k_0}）",
      t + 0, t, lambda u: u, add_right, [t])
assert t + 1 != t   # 対照: 単位元でない元を足すと変わる
print("RESULT: PASS")
