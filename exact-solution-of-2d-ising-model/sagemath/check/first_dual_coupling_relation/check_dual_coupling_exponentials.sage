# 対象ラベル: first_dual_coupling_relation
# 証明の行（L := log(tanh K_1) と書く）:
#   K_1^* = -(1/2)L（def_first_dual_coupling_constant）、2K_1^* = -L（両辺を 2 倍）
#   exp(-L) tanh K_1 = exp(-L)exp(L)（exp(log y) = y）= exp(-L+L)（scalar_exp_product）= exp(0)（加法逆元）= 1（scalar_exp_zero）
#   exp(-L) = 1/tanh K_1（直前の等式の両辺を tanh K_1 ≠ 0 で割る）
#   exp(2K_1^*) = exp(-L)（2K_1^* = -L）= 1/tanh K_1（直前の等式）
#   -2K_1^* = L（符号反転）、exp(-2K_1^*) = exp(L)（等しい実数へ exp）= tanh K_1（exp(log y) = y）
# 帰属: すべて厳密。L の一次式の行は QQ[L]、代入の行と割り算の行は有理関数体、exp の積の法則と exp(0) = 1 の行は
#   QQ[l] の形式冪級数（全次数 D_SERIES まで）。ボールは使わない（使える値は log を挟む区間の作り方から決まり、何も確かめないため）。
load("_prelude.sage")

# K_1^* = -(1/2)L から 2K_1^* = -L と -2K_1^* = L（L を不定元とする QQ[L] で）。
QL = PolynomialRing(QQ, 'Ls'); Ls = QL.gen()
Kstar = -QQ(1) / 2 * Ls
assert 2 * Kstar == -Ls
assert -(2 * Kstar) == Ls

# exp(-L) tanh K_1 = exp(-L) exp(L): X = exp(-L)、Y = exp(L)、T = tanh K_1 と置き、根拠 T = exp(log T) = Y だけを代入する。
XYT = FractionField(PolynomialRing(QQ, ['X', 'Y', 'Tt']))
X, Y, Tt = XYT.gens()
assert X * Tt != X * Y
assert (X * Tt).subs({Tt: Y}) == X * Y
# exp(-L)exp(L) = exp(-L+L) = exp(0) = 1 を、L を不定元 l とした形式冪級数で（本文 scalar_exp_product・scalar_exp_zero の内容）。
lhs = exp_series(SERIES_RING, -l_var) * exp_series(SERIES_RING, l_var)
mid = exp_series(SERIES_RING, -l_var + l_var)
assert series_equal(lhs, mid)
assert mid == exp_series(SERIES_RING, SERIES_RING(0)) and mid == 1

# exp(-L) T = 1 ⇒ exp(-L) = 1/T（T ≠ 0）: X - 1/T は仮定 X T - 1 の倍元なので、仮定のもとで 0。
assert X - 1 / Tt == (X * Tt - 1) * (1 / Tt)

# exp(2K_1^*) = exp(-L) と exp(-2K_1^*) = exp(L) は、等しい実数（上の 2K_1^* = -L、-2K_1^* = L）へ exp を当てる行で、
# 計算を含まない。= 1/tanh K_1 は直前の等式の置換、= tanh K_1 は exp(log y) = y そのもの。
print("2K_1^* = -L と -2K_1^* = L を QQ[L] で、exp(-L)tanh K_1 = exp(-L)exp(L) の代入を有理関数体で、")
print("exp(-L)exp(L) = exp(0) = 1 を形式冪級数で、exp(-L)tanh K_1 = 1 ⇒ exp(-L) = 1/tanh K_1 を倍元として厳密に確かめた")
print("RESULT: PASS")
