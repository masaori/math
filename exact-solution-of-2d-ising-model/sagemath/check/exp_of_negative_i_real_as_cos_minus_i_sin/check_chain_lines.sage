# 対象ラベル: exp_of_negative_i_real_as_cos_minus_i_sin
# 証明の 6 等号の鎖を一行ずつ確かめる。
# (1) 一般の点: a := exp(iθ_C)、b := exp(-iθ_C)、c := (cos θ)_C、s := (sin θ)_C を QQ(i) 上の独立な不定元に置いた
#     有理関数体で、各行をその行の式の形のまま組む。体の四則だけを使う行（第 1・2・3・5 行）は恒等的に等しく、
#     euler_formula_cos_sin を引く行（第 4・6 行）は、その等式（c = (a+b)/2、s = (a-b)/(2i)）を代入して初めて等しい
#     （代入しなければ差が残る）ことを確かめる。
# (2) 具体の点: θ = 2πq（q ∈ QQ）で a = E(q)、b = E(-q)、c = cos(2πq)、s = sin(2πq) を QQbar で作り、
#     euler_formula_cos_sin の二つの等式がその点で成り立つことと、鎖の各行が厳密に等しいことを確かめる。
load("../../_shared/half_integer_phase_exact.sage")

KI = QuadraticField(-1, 'i')
iK = KI.gen()
F = FractionField(PolynomialRing(KI, ['a', 'b', 'c', 's']))
a, b, c, s = F.gens()
two = F(2)

lines = [
    ("b", b),
    ("(2b)/2", (two * b) / two),
    ("((a+b)-(a-b))/2", ((a + b) - (a - b)) / two),
    ("(a+b)/2 - (a-b)/2", (a + b) / two - (a - b) / two),
    ("c - (a-b)/2", c - (a - b) / two),
    ("c - i(a-b)/(2i)", c - iK * ((a - b) / (two * iK))),
    ("c - is", c - iK * s),
]
v = [x for _, x in lines]
assert v[0] == v[1] and v[1] == v[2] and v[2] == v[3]
print("  第 1〜3 等号（2b/2、四則、分配法則）: 恒等的に等しい")
d4 = v[3] - v[4]
assert d4 != 0 and d4 == (a + b) / two - c
assert d4.numerator().subs(c=(a + b) / two) == 0
print("  第 4 等号: 差は (a+b)/2 - c で、euler_formula_cos_sin の第 1 の等式を代入すると 0（代入しなければ 0 でない）")
assert v[4] == v[5]
print("  第 5 等号（i ≠ 0 で i を掛けて割る）: 恒等的に等しい")
d6 = v[5] - v[6]
assert d6 != 0 and d6 == iK * (s - (a - b) / (two * iK))
assert (s - (a - b) / (two * iK)).numerator().subs(s=(a - b) / (two * iK)) == 0
print("  第 6 等号: 差は i(s - (a-b)/(2i)) で、euler_formula_cos_sin の第 2 の等式を代入すると 0（代入しなければ 0 でない）")

count = 0
for den in range(1, 13):
    for num in range(-2 * den, 2 * den + 1):
        q = QQ(num) / den
        A, B = E(q), E(-q)
        C, S = to_C(cos2pi(q)), to_C(sin2pi(q))
        assert C == (A + B) / 2 and S == (A - B) / (2 * I_QQBAR)
        pt = [B, (2 * B) / 2, ((A + B) - (A - B)) / 2, (A + B) / 2 - (A - B) / 2,
              C - (A - B) / 2, C - I_QQBAR * ((A - B) / (2 * I_QQBAR)), C - I_QQBAR * S]
        check_adjacent(list(zip([n for n, _ in lines], pt)), f"q={q}")
        count += 1
print(f"  具体の点 θ = 2πq（分母 1..12、|q| ≤ 2 の {count} 点）: euler_formula_cos_sin の二つの等式と鎖の各行が QQbar で厳密に等しい")
print("RESULT: PASS")
