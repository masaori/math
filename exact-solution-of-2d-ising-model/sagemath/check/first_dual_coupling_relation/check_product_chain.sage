# 対象ラベル: first_dual_coupling_relation
# 証明の最後の鎖:
#   sinh(2K_1)sinh(2K_1^*)
#   = 2 sinh K_1 cosh K_1 sinh(2K_1^*)                                   （sinh(2K_1) = 2 sinh K_1 cosh K_1）
#   = 2 sinh K_1 cosh K_1 · (1/2)(1/tanh K_1 - tanh K_1)                 （sinh(2K_1^*) の式）
#   = sinh K_1 cosh K_1 (1/tanh K_1 - tanh K_1)                          （2·(1/2) = 1）
#   = sinh K_1 cosh K_1 (1/(sinh K_1/cosh K_1) - sinh K_1/cosh K_1)      （def_positive_coupling_tanh）
#   = sinh K_1 cosh K_1 (cosh K_1/sinh K_1 - sinh K_1/cosh K_1)          （sinh, cosh ≠ 0）
#   = sinh K_1 cosh K_1 ((cosh K_1)² - (sinh K_1)²)/(sinh K_1 cosh K_1)  （通分）
#   = (cosh K_1)² - (sinh K_1)²                                          （sinh K_1 cosh K_1 ≠ 0）
#   = 1                                                                  （cosh_sinh_basic_properties の (2)）
# 帰属: SYM で厳密に（sh, ch は sinh K_1, cosh K_1 の不定元。最後の行だけ定義どおりの式 s1・c1 と exp(K)exp(-K) = 1 を使う）。
load("_prelude.sage")

H = FractionField(PolynomialRing(QQ, ['sh', 'ch', 'Th', 'S2h', 'S2sh']))
sh, ch, Th, S2h, S2sh = H.gens()

def step(lhs, rhs, used=None, name=""):
    used = used or {}
    assert H(lhs).subs(used) - H(rhs).subs(used) == 0, name

l1 = S2h * S2sh
l2 = 2 * sh * ch * S2sh
l3 = 2 * sh * ch * (QQ(1) / 2 * (1 / Th - Th))
l4 = sh * ch * (1 / Th - Th)
l5 = sh * ch * (1 / (sh / ch) - sh / ch)
l6 = sh * ch * (ch / sh - sh / ch)
l7 = sh * ch * ((ch^2 - sh^2) / (sh * ch))
l8 = ch^2 - sh^2
step(l1, l2, {S2h: 2 * sh * ch}, "倍角")
step(l2, l3, {S2sh: QQ(1) / 2 * (1 / Th - Th)}, "sinh(2K^*) の式")
step(l3, l4, None, "2·(1/2) = 1")
step(l4, l5, {Th: sh / ch}, "tanh の定義")
step(l5, l6, None, "1/(sh/ch) = ch/sh（sh, ch ≠ 0）")
step(l6, l7, None, "通分")
step(l7, l8, None, "sh·ch ≠ 0 で約分")
assert H(l1) != H(l2) and H(l2) != H(l3) and H(l4) != H(l5)

# 最後の行 (cosh K)² - (sinh K)² = 1: 定義どおりの式 s1・c1 では Ep·Em が残り、exp(K)exp(-K) = 1 を代入して 1 になる。
last = c1^2 - s1^2
assert last == Ep * Em
assert last.subs({Em: 1 / Ep}) == 1
assert series_equal(exp_series(SERIES_RING, k_var) * exp_series(SERIES_RING, -k_var), 1)
print("最後の鎖の 8 つの等号を厳密に確かめた（最後の行は exp(K)exp(-K) = 1 を形式冪級数で）")
print("RESULT: PASS")
