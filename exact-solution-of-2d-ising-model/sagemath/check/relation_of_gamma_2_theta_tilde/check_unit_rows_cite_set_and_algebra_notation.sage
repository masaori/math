# 対象ラベル: relation_of_gamma_2_theta_tilde
# 「0 は ℝ の加法の単位元」「1 は ℝ の乗法の単位元」（set_and_algebra_notation）を引く行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 「右辺から左辺へ」の行は、前の行が形の右辺、次の行が形の左辺を穴に入れたものになる。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<t> = QQ[]
def add_right(s): return (s + 0, s)   # x + 0 = x
def add_left(s): return (0 + s, s)    # 0 + x = x
def mul_left(s): return (1 * s, s)    # 1·x = x
def mul_right(s): return (s * 1, s)   # x·1 = x
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
# (3) の φ_polar((−r)_C) の鎖と (4) の φ_polar(r_C) の鎖の根号の中身の行。r を不定元 t に置く。
# 文脈は根号の中身の穴（偏角の成分はこの行で変わらない）。
check("(3) φ_polar((−r)_C) の鎖: √(r^2 + 0) = √(r^2)（x + 0 = x の x → r^2）",
      t^2 + 0, t^2, lambda u: u, add_right, [t^2])
check("(4) φ_polar(r_C) の鎖: √(r^2 + 0) = √(r^2)（x + 0 = x の x → r^2）",
      t^2 + 0, t^2, lambda u: u, add_right, [t^2])
# π・|γ_2(θ)| を不定元 p・g に置く（r は上と同じく t）。π の行の文脈は角度の成分の穴、ほかは対の成分の穴。
S.<p, g> = QQ[]
check("(3) φ_polar((−r)_C) の鎖の最後の行: [(r, 0 + π)] = [(r, π)]（0 + x = x の x → π）",
      0 + p, p, lambda u: u, add_left, [p])
check("(4) −γγ' の鎖の最後の行: (1·r)_C = r_C（1·x = x の x → r）",
      (1 * t, QQ(0)), (t, QQ(0)), lambda u: (u, QQ(0)), mul_left, [t])
check("(4) 主の鎖: (|γ|·1, |γ|·0) = (|γ|, |γ|·0)（x·1 = x の x → |γ|）",
      (g * 1, g * 0), (g, g * 0), lambda u: (u, g * 0), mul_right, [g])
check("(5) 主の鎖: (0·|γ| − 1·0, 1·|γ|) = (0·|γ| − 1·0, 0 + 1·|γ|)（0 + x = x の x → 1·|γ| を右辺から左辺へ）",
      (0 * g - 1 * 0, 1 * g), (0 * g - 1 * 0, 0 + 1 * g), lambda u: (0 * g - 1 * 0, u), add_left, [1 * g], rtl=True)
assert add_right(t)[0] == add_right(t)[1]
assert QQ(0) + QQ(1) != QQ(0)   # 対照: 単位元でない元を足すと変わる
print("RESULT: PASS")
