# 対象ラベル: relation_of_gamma_2_theta_tilde
# 「第一に」の cos θ + i sin θ の鎖で complex_numbers_form_a_field の加法の逆元・加法の単位元・積の単位元を引く 4 行と、
# multiplicative_group_of_cc の逆元 z z^{-1} = 1_ℂ（z → 2_ℂ）を引く 1 行を、
# 行に書いた形と代入で形の両辺を作って比べる（浮動小数点を使わない）。行は、前の行の式と次の行の式を
# 同じ文脈 ctx の穴に形の左辺・右辺を入れたものとして写し、形の両辺を代入どおりに作って一致を見る。
# 「右辺から左辺へ」の行は、前の行が形の右辺、次の行が形の左辺を穴に入れたものになる。
# exp(iθ)・exp(−iθ) を不定元 E・F に置く（ℂ の和と積の体の公理だけを使う行なので、多項式環で足りる）。2_ℂ^{-1} は
# 逆元の行では QQ の 1/2 に、それ以外の行では不定元 h に置く。
# 多項式環は式を正規化するので、形の左右と向きはこの検算では区別できない（レビューの目視で確かめた）。
R.<E, F, h> = QQ[]
def mul_inverse(z): return (z * z^(-1), R(1))   # z z^{-1} = 1_ℂ（z ≠ 0）
def add_inverse(z): return (z + (-z), R(0))   # z + (−z) = 0_ℂ
def add_right(z): return (z + 0, z)           # z + 0_ℂ = z
def mul_left(w): return (R(1) * w, w)         # 1_ℂ·w = w
def mul_right(w): return (w * R(1), w)        # w·1_ℂ = w
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
check("加法の逆元: (E + (E + (F + (−F))))h = (E + (E + 0))h（z + (−z) = 0 の z → exp(−iθ)）",
      (E + (E + (F + (-F)))) * h, (E + (E + 0)) * h, lambda u: (E + (E + u)) * h, add_inverse, [F])
check("加法の単位元: (E + (E + 0))h = (E + E)h（z + 0 = z の z → exp(iθ)）",
      (E + (E + 0)) * h, (E + E) * h, lambda u: (E + u) * h, add_right, [E])
check("積の単位元: (E + E)h = (1·E + 1·E)h（1·w = w の w → exp(iθ) を 2 箇所へ右辺から左辺へ）",
      (E + E) * h, (R(1) * E + R(1) * E) * h, lambda u1, u2: (u1 + u2) * h, mul_left, [E, E], rtl=True)
check("逆元: E(2·2^{-1}) = E·1（z z^{-1} = 1 の z → 2_ℂ）",
      E * (QQ(2) * QQ(2)^(-1)), E * R(1), lambda u: E * u, mul_inverse, [QQ(2)])
check("積の単位元: E·1 = E（w·1 = w の w → exp(iθ)）",
      E * R(1), E, lambda u: u, mul_right, [E])
# 対照: 単位元・逆元を取り違えると等号は成り立たない。
assert (E + (E + (F + F))) * h != (E + (E + 0)) * h
assert R(2) * E != E and E + E != E and E * (QQ(2) * QQ(3)^(-1)) != E * R(1)
print("RESULT: PASS")
