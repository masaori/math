# 対象ラベル: i_times_i_is_minus_one_in_cc
# 「0 は ℝ の加法の単位元」「1 は ℝ の乗法の単位元」（set_and_algebra_notation）を引く行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。各行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<t> = QQ[]
def add_right(s): return (s + 0, s)   # x + 0 = x
def add_left(s):  return (0 + s, s)   # 0 + x = x
def mul_left(s):  return (1 * s, s)   # 1·x = x
def check(name, prev, nxt, ctx, form, subs):
    # 代入が複数の行（2 箇所へ当てる行）は、ctx が穴を代入の数だけ持つ
    ls = [form(s)[0] for s in subs]
    rs = [form(s)[1] for s in subs]
    for l, r in zip(ls, rs):
        assert l == r, name
    assert prev == ctx(*ls) and nxt == ctx(*rs), name
    print("row", name)
# 鎖の項は ℝ の対。文脈は対の成分の穴。
check("(0−1·1, 0·1+1·0) = (0−1, 0·1+1·0)（1·x = x の x → 1）", (0 - QQ(1)*1, 0*1 + 1*0), (0 - QQ(1), 0*1 + 1*0), lambda u: (0 - u, 0*1 + 1*0), mul_left, [QQ(1)])
check("(0−1, 0+0) = (0−1, 0)（x + 0 = x の x → 0）", (0 - QQ(1), QQ(0) + 0), (0 - QQ(1), QQ(0)), lambda u: (0 - QQ(1), u), add_right, [QQ(0)])
check("(0+(−1), 0) = (−1, 0)（0 + x = x の x → −1）", (0 + QQ(-1), QQ(0)), (QQ(-1), QQ(0)), lambda u: (u, QQ(0)), add_left, [QQ(-1)])
assert add_right(t)[0] == add_right(t)[1] and add_left(t)[0] == add_left(t)[1] and mul_left(t)[0] == mul_left(t)[1]
assert QQ(0) + QQ(1) != QQ(0)   # 対照: 単位元でない元を足すと変わる
assert QQ(2) * QQ(3) != QQ(3)   # 対照: 単位元でない元を掛けると変わる
print("RESULT: PASS")
