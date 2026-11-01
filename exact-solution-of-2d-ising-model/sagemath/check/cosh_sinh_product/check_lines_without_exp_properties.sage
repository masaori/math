# 対象ラベル: cosh_sinh_product
# 二つの鎖（各 9 行）のうち、exp の性質を使わない行（cosh・sinh の定義、分数の積、分配則、項の並べ替えとくくり、
# 1/4 = (1/2)(1/2)、分配則）を確かめる。
# 帰属: exp の 8 つの値 exp(a), exp(-a), exp(b), exp(-b), exp(a+b), exp(-(a+b)), exp(a-b), exp(-(a-b)) を
# QQ 上の多項式環の互いに独立な不定元に置く。これらの行は exp の性質を使わないので、独立な不定元で
# 成り立てば、不定元へ実数の exp の値を代入しても成り立つ（代入は環準同型である）。
# 逆に、exp の積の法則を使う行（4 行目）は、ここでは成り立たないことを対照として確かめる。
# 指数の整理の行（5 行目）は a, b を QQ[a, b] の不定元に置き、指数どうしの等号を多項式環の等号として確かめる
# （多項式環は式を正規形で持つので、これは四則の恒等式の確認である）。
R = PolynomialRing(QQ, 'Ea,Ema,Eb,Emb,Eapb,Emapb,Eamb,Emamb')
Ea, Ema, Eb, Emb, Eapb, Emapb, Eamb, Emamb = R.gens()
F = R.fraction_field()

def cosh_def(Ep, Em):   # def_cosh_sinh: cosh x = (exp(x) + exp(-x))/2
    return (F(Ep) + F(Em)) / 2

def sinh_def(Ep, Em):   # def_cosh_sinh: sinh x = (exp(x) - exp(-x))/2
    return (F(Ep) - F(Em)) / 2

ok = 0
for name, sgn in [("cosh(a)sinh(b)", -1), ("cosh(a)cosh(b)", +1)]:
    g = sinh_def if sgn == -1 else cosh_def   # sinh(b) か cosh(b) の定義
    # 1 行目: 定義を代入した形。左辺そのものとして、cosh(a) と g(b) を定義から作る。
    lhs = cosh_def(Ea, Ema) * g(Eb, Emb)
    line1 = ((F(Ea) + F(Ema)) / 2) * ((F(Eb) + sgn * F(Emb)) / 2)
    assert lhs == line1
    # 2 行目: 分数の積
    line2 = F(1) / 4 * (F(Ea) + F(Ema)) * (F(Eb) + sgn * F(Emb))
    assert line1 == line2
    # 3 行目: 分配則（4 つの積を本文の並びのまま書く）
    line3 = F(1) / 4 * (Ea * Eb + sgn * Ea * Emb + Ema * Eb + sgn * Ema * Emb)
    assert line2 == line3
    # 5 行目（積の法則と指数の整理の後）: exp(a+b) ± exp(a-b) + exp(-(a-b)) ± exp(-(a+b))
    line5 = F(1) / 4 * (Eapb + sgn * Eamb + Emamb + sgn * Emapb)
    # 対照: 3 行目と 5 行目は独立な不定元では一致しない（4 行目が exp の性質を使う行であることの確認）
    assert line3 != line5
    # 6 行目: 項の並べ替えとくくり
    X = F(Eapb) + sgn * F(Emapb)
    Y = F(Eamb) + sgn * F(Emamb)
    line6 = F(1) / 4 * (X + sgn * Y)
    assert line5 == line6
    # 7 行目: 1/4 = (1/2)(1/2)
    line7 = F(1) / 2 * (F(1) / 2) * (X + sgn * Y)
    assert line6 == line7
    # 8 行目: 分配則
    line8 = F(1) / 2 * (X / 2 + sgn * (Y / 2))
    assert line7 == line8
    # 9 行目: sinh（cosh）の定義を 2 箇所へ。右辺を定義の関数から作る
    line9 = F(1) / 2 * (g(Eapb, Emapb) + sgn * g(Eamb, Emamb))
    assert line8 == line9
    ok += 1
    print(f"{name}: 1→2→3 行目と 5→6→7→8→9 行目が QQ 上の 8 個の独立な不定元で厳密に一致し、3 行目と 5 行目は一致しない")

# 5 行目の指数の整理: a+(-b) = a-b, (-a)+b = -(a-b), (-a)+(-b) = -(a+b)
P = PolynomialRing(QQ, 'a,b')
a, b = P.gens()
assert a + (-b) == a - b and (-a) + b == -(a - b) and (-a) + (-b) == -(a + b)
print("指数の整理の三つの等号が QQ[a,b] で成り立つ")
assert ok == 2
print("RESULT: PASS")
