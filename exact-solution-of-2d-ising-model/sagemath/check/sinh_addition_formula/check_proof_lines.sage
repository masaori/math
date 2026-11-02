# 対象ラベル: sinh_addition_formula
# 複号 + の鎖の八行と、複号 - の鎖の四行を確かめる。
# 帰属:
# - exp の性質を使わない行（定義、分母と分子に 2 を掛ける、足して引く、分配則、分数の和と積、定義を 4 箇所へ）は、
#   exp の値 exp(x), exp(-x), exp(y), exp(-y) を QQ 上の独立な不定元 Ex, Emx, Ey, Emy に置き、さらに
#   exp(x+y), exp(-(x+y)) も独立な不定元 Exy, Emxy に置いて確かめる（代入は環準同型なので実数の値でも成り立つ）。
# - 引数の等号（-(x+y) = (-x)+(-y)、x-y = x+(-y)）は QQ[x,y] の等号として。
# - exp の積の法則の行（scalar_exp_product）と、複号 - の鎖の行（+ の場合を -y に当てはめる、偶奇性）は、
#   QQ[x,y] の形式冪級数として全次数 14 以下で比べる。
load("../../_shared/hyperbolic_by_definition.sage")
KIND = "sinh"
sg = -1     # cosh の鎖では E_{-x}E_{-y} の符号が +、sinh の鎖では -

R = PolynomialRing(QQ, 'Ex,Emx,Ey,Emy,Exy,Emxy'); Ex, Emx, Ey, Emy, Exy, Emxy = R.gens(); F = R.fraction_field()
own = cosh_by_definition if KIND == "cosh" else sinh_by_definition
other = sinh_by_definition if KIND == "cosh" else cosh_by_definition
# 1 行目: 定義を x+y へ
line1 = own(F(Exy), F(Emxy))
assert line1 == (F(Exy) + sg * F(Emxy)) / 2
# 2 行目は引数の書き換えだけ（下で QQ[x,y] の等号として確かめる）。3 行目: exp の積の法則を 2 箇所へ
line3 = (Ex * Ey + sg * Emx * Emy) / F(2)
assert line1 != line3      # 対照: 3 行目は exp の性質を使う唯一の行で、独立な不定元では成り立たない
# 4 行目: 分母と分子に 2
line4 = (2 * Ex * Ey + sg * 2 * Emx * Emy) / F(4)
assert line3 == line4
# 5 行目: E_x E_{-y} と E_{-x} E_y を足して引く（本文の並びのまま）
if KIND == "cosh":
    g1 = Ex*Ey + Ex*Emy + Emx*Ey + Emx*Emy
    g2 = Ex*Ey - Ex*Emy - Emx*Ey + Emx*Emy
else:
    g1 = Ex*Ey + Ex*Emy - Emx*Ey - Emx*Emy
    g2 = Ex*Ey - Ex*Emy + Emx*Ey - Emx*Emy
line5 = (g1 + g2) / F(4)
assert line4 == line5
# 6 行目: 分配則（因数分解の形を本文のまま書き、展開が 5 行目の二つの括弧に一致することも確かめる）
if KIND == "cosh":
    f1 = (Ex + Emx) * (Ey + Emy); f2 = (Ex - Emx) * (Ey - Emy)
else:
    f1 = (Ex - Emx) * (Ey + Emy); f2 = (Ex + Emx) * (Ey - Emy)
assert f1 == g1 and f2 == g2
line6 = (f1 + f2) / F(4)
assert line5 == line6
# 7 行目: 分数の和と積
if KIND == "cosh":
    line7 = (F(Ex) + Emx) / 2 * ((F(Ey) + Emy) / 2) + (F(Ex) - Emx) / 2 * ((F(Ey) - Emy) / 2)
else:
    line7 = (F(Ex) - Emx) / 2 * ((F(Ey) + Emy) / 2) + (F(Ex) + Emx) / 2 * ((F(Ey) - Emy) / 2)
assert line6 == line7
# 8 行目: 定義を 4 箇所へ（右辺を定義の関数から作る）
if KIND == "cosh":
    line8 = cosh_by_definition(F(Ex), F(Emx)) * cosh_by_definition(F(Ey), F(Emy)) + sinh_by_definition(F(Ex), F(Emx)) * sinh_by_definition(F(Ey), F(Emy))
else:
    line8 = sinh_by_definition(F(Ex), F(Emx)) * cosh_by_definition(F(Ey), F(Emy)) + cosh_by_definition(F(Ex), F(Emx)) * sinh_by_definition(F(Ey), F(Emy))
assert line7 == line8
print(f"{KIND}: 複号 + の鎖の 1・3〜8 行目のうち exp の性質を使わない行が、QQ 上の 6 個の独立な不定元で厳密に一致する")

# 引数の等号
P = PolynomialRing(QQ, 'x,y'); x, y = P.gens()
assert -(x + y) == (-x) + (-y) and x - y == x + (-y)
# 3 行目: exp(x+y) = exp(x)exp(y)、exp((-x)+(-y)) = exp(-x)exp(-y) を形式冪級数で
T = lambda p: truncate_total_degree(p, D_SERIES)
assert exp_series(P, x + y) == T(exp_series(P, x) * exp_series(P, y))
assert exp_series(P, (-x) + (-y)) == T(exp_series(P, -x) * exp_series(P, -y))
assert exp_series(P, x + y) != T(exp_series(P, x) * exp_series(P, -y))   # 対照
print(f"3 行目の exp の積の法則が QQ[x,y] の形式冪級数で全次数 {D_SERIES} 以下で成り立つ")
# 複号 + の鎖の両端
ownS = cosh_series if KIND == "cosh" else sinh_series
coshS, sinhS = cosh_series, sinh_series
plus_rhs = T(coshS(P, x) * coshS(P, y) + sinhS(P, x) * sinhS(P, y)) if KIND == "cosh" else T(sinhS(P, x) * coshS(P, y) + coshS(P, x) * sinhS(P, y))
assert ownS(P, x + y) == plus_rhs
# 複号 - の鎖: 1 行目 x-y = x+(-y)、2 行目 + の場合を -y へ、3 行目 偶奇性、4 行目 四則
m_line2 = T(coshS(P, x) * coshS(P, -y) + sinhS(P, x) * sinhS(P, -y)) if KIND == "cosh" else T(sinhS(P, x) * coshS(P, -y) + coshS(P, x) * sinhS(P, -y))
assert ownS(P, x + (-y)) == m_line2
assert coshS(P, -y) == coshS(P, y) and sinhS(P, -y) == -sinhS(P, y)
m_line3 = T(coshS(P, x) * coshS(P, y) + sinhS(P, x) * (-sinhS(P, y))) if KIND == "cosh" else T(sinhS(P, x) * coshS(P, y) + coshS(P, x) * (-sinhS(P, y)))
assert m_line2 == m_line3
m_line4 = T(coshS(P, x) * coshS(P, y) - sinhS(P, x) * sinhS(P, y)) if KIND == "cosh" else T(sinhS(P, x) * coshS(P, y) - coshS(P, x) * sinhS(P, y))
assert m_line3 == m_line4 and ownS(P, x - y) == m_line4
assert ownS(P, x - y) != plus_rhs    # 対照: 複号を取り違えると一致しない
print(f"{KIND}: 複号 + の鎖の両端と、複号 - の鎖の四行が QQ[x,y] の形式冪級数で全次数 {D_SERIES} 以下で一致し、複号を取り違えると一致しない")
print("RESULT: PASS")
