# 対象ラベル: W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice
# 主の鎖の (A + 0) + (0 + A) = A + (0 + A) = A + A = 1A + 1A = (1 + 1)A の 4 行が引く
# 「0 は ℝ の加法の単位元 x + 0 = x・0 + x = x（x → A）」「1 は ℝ の乗法の単位元 1x = x（x → A）を 2 か所へ同時に右辺から左辺へ」
# 「ℝ の分配則 (a + b)c = ac + bc（a, b → 1、c → A）を右辺から左辺へ」（set_and_algebra_notation）を、
# 行に書いた形と代入で形の両辺を作り、前の行と次の行が同じ文脈の穴に形の左辺・右辺を入れたものであることを比べる
# （浮動小数点を使わない）。A は不定元 t に置く。多項式環は式を正規化するので、形の左右と向きはこの検算では
# 区別できない（レビューの目視で確かめる）。
R.<t> = QQ[]
def add_right(s): return (s + 0, s)   # x + 0 = x
def add_left(s): return (0 + s, s)    # 0 + x = x
def mul_left(s): return (1 * s, s)    # 1·x = x
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
def distrib(abc): a, b, c = abc; return ((a + b) * c, a * c + b * c)   # (a + b)c = ac + bc
check("主の鎖 7 行目: (A + 0) + (0 + A) = A + (0 + A)（x + 0 = x の x → A）",
      (t + 0) + (0 + t), t + (0 + t), lambda u: u + (0 + t), add_right, [t])
check("主の鎖 8 行目: A + (0 + A) = A + A（0 + x = x の x → A）",
      t + (0 + t), t + t, lambda u: t + u, add_left, [t])
check("主の鎖 9 行目: A + A = 1A + 1A（1x = x の x → A を 2 か所へ同時に右辺から左辺へ）",
      t + t, 1 * t + 1 * t, lambda u, w: u + w, mul_left, [t, t], rtl=True)
check("主の鎖 10 行目: 1A + 1A = (1 + 1)A（(a + b)c = ac + bc の a, b → 1、c → A を右辺から左辺へ）",
      1 * t + 1 * t, (1 + 1) * t, lambda u: u, distrib, [(1, 1, t)], rtl=True)
assert t + 1 != t and 2 * t != t   # 対照: 単位元でない元を足す・掛けると変わる
print("RESULT: PASS")
