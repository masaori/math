# 対象ラベル: c_plus_le_c（証明が引く「R_+ は空でない」。def_sector_rayleigh_sup の後半の構成のノルムの鎖）
# 「1 は ℝ の乗法の単位元」（set_and_algebra_notation）を引く 4 行を、行に書いた形 1·x = x と代入で形の両辺を作って比べる
# （浮動小数点を使わない）。各行は、前の行の式と次の行の式を同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、
# 形の両辺を代入どおりに作って一致を見る。「右辺から左辺へ」の行は、前の行が形の右辺、次の行が形の左辺を穴に入れたものになる。
# √2^{-1}・(√2·√2)^{-1}・2_ℝ^{-1} は不定元 s・q・h、2_ℝ は不定元 two で置き、冪 M_col は 2〜6 で回す。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<s, q, h, two> = QQ[]
def mul_left(x): return (1 * x, x)   # 1·x = x
def check(name, prev, nxt, ctx, form, subs, rtl=False):
    ls = [form(x)[0] for x in subs]
    rs = [form(x)[1] for x in subs]
    for l, r in zip(ls, rs):
        assert l == r, name
    if rtl:
        assert prev == ctx(*rs) and nxt == ctx(*ls), name
    else:
        assert prev == ctx(*ls) and nxt == ctx(*rs), name
    print("row", name)
for M in range(2, 7):
    # ノルムの鎖: 2^M((1·√2^{-1})(1·√2^{-1}))^M = 2^M(√2^{-1}√2^{-1})^M（x → √2^{-1} を 2 つの因子へ同時に適用）
    check(f"M_col={M}: 2^M((1·√2^{{-1}})(1·√2^{{-1}}))^M = 2^M(√2^{{-1}}√2^{{-1}})^M（1·x = x の x → √2^{{-1}} を 2 つの因子へ）",
          two^M * ((1*s) * (1*s))^M, two^M * (s * s)^M, lambda u, v: two^M * (u * v)^M, mul_left, [s, s])
    # 2^M((√2√2)^{-1})^M = 2^M(1·(√2√2)^{-1})^M（x → (√2√2)^{-1} を右辺から左辺へ）
    check(f"M_col={M}: 2^M((√2√2)^{{-1}})^M = 2^M(1·(√2√2)^{{-1}})^M（1·x = x の x → (√2√2)^{{-1}} を右辺から左辺へ）",
          two^M * q^M, two^M * (1*q)^M, lambda u: two^M * u^M, mul_left, [q], rtl=True)
    # (2_ℝ·(1·2_ℝ^{-1}))^M = (2_ℝ·2_ℝ^{-1})^M（x → 2_ℝ^{-1}）
    check(f"M_col={M}: (2·(1·2^{{-1}}))^M = (2·2^{{-1}})^M（1·x = x の x → 2^{{-1}}）",
          (two * (1*h))^M, (two * h)^M, lambda u: (two * u)^M, mul_left, [h])
# ‖x^{(+)}‖^2 = 1 = 1·1 = 1^2 の 2 つ目の等号: 1 = 1·1（x → 1 を右辺から左辺へ）。文脈は式全体の穴。
check("1 = 1·1（1·x = x の x → 1 を右辺から左辺へ）", R(1), R(1) * R(1), lambda u: u, mul_left, [R(1)], rtl=True)
assert mul_left(s)[0] == mul_left(s)[1]
assert 2 * s != s   # 対照: 単位元でない元を掛けると変わる
print("RESULT: PASS")
