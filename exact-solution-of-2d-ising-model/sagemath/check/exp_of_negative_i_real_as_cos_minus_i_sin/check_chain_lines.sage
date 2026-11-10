# 対象ラベル: exp_of_negative_i_real_as_cos_minus_i_sin
# 証明の主鎖（22 等号）を一行ずつ確かめる。
# (1) 一般の点: a := exp(iθ_C)、b := exp(-iθ_C)、c := (cos θ)_C、s := (sin θ)_C を QQ(i) 上の独立な不定元に置いた
#     有理関数体で、各行をその行の式の形のまま組む（商は def_complex_quotient の z w^{-1}）。体の公理・定義だけを使う行
#     （第 15・22 等号以外）は恒等的に等しく、euler_formula_cos_sin を引く行（第 15・22 等号）は、その等式（c = (a+b)/2、s = (a-b)/(2i)）を代入して初めて等しい
#     （代入しなければ差が残る）ことを確かめる。
# (2) 具体の点: θ = 2πq（q ∈ QQ）で a = E(q)、b = E(-q)、c = cos(2πq)、s = sin(2πq) を QQbar で作り、
#     euler_formula_cos_sin の二つの等式がその点で成り立つことと、鎖の各行が厳密に等しいことを確かめる。
load("../../_shared/half_integer_phase_exact.sage")

KI = QuadraticField(-1, 'i')
iK = KI.gen()
F = FractionField(PolynomialRing(KI, ['a', 'b', 'c', 's']))
a, b, c, s = F.gens()
two = F(2)

def inv(z):
    """multiplicative_group_of_cc の逆元（体の中の逆元）。"""
    return z ** -1

def quot(z, w):
    """def_complex_quotient: z/w := z w^{-1}。"""
    return z * inv(w)

m1 = F(-1)
lines = [
    ("b", b),
    ("1b", F(1) * b),
    ("(2^{-1}2)b", (inv(two) * two) * b),
    ("2^{-1}(2b)", inv(two) * (two * b)),
    ("(2b)2^{-1}", (two * b) * inv(two)),
    ("(2b)/2", quot(two * b, two)),
    ("((a+b)-(a-b))/2", quot((a + b) - (a - b), two)),
    ("((a+b)-(a-b))2^{-1}", ((a + b) - (a - b)) * inv(two)),
    ("((a+b)+(-(a-b)))2^{-1}", ((a + b) + (m1 * (a - b))) * inv(two)),
    ("(a+b)2^{-1}+(-(a-b))2^{-1}", (a + b) * inv(two) + (m1 * (a - b)) * inv(two)),
    ("(a+b)2^{-1}+((-1)(a-b))2^{-1}", (a + b) * inv(two) + (m1 * (a - b)) * inv(two)),
    ("(a+b)2^{-1}+(-1)((a-b)2^{-1})", (a + b) * inv(two) + m1 * ((a - b) * inv(two))),
    ("(a+b)2^{-1}+(-((a-b)2^{-1}))", (a + b) * inv(two) + m1 * ((a - b) * inv(two))),
    ("(a+b)2^{-1}-(a-b)2^{-1}", (a + b) * inv(two) - (a - b) * inv(two)),
    ("(a+b)/2-(a-b)/2", quot(a + b, two) - quot(a - b, two)),
    ("c-(a-b)/2", c - quot(a - b, two)),
    ("c-(a-b)2^{-1}", c - (a - b) * inv(two)),
    ("c-(a-b)(i(2i)^{-1})", c - (a - b) * (iK * inv(two * iK))),
    ("c-((a-b)i)(2i)^{-1}", c - ((a - b) * iK) * inv(two * iK)),
    ("c-(i(a-b))(2i)^{-1}", c - (iK * (a - b)) * inv(two * iK)),
    ("c-i((a-b)(2i)^{-1})", c - iK * ((a - b) * inv(two * iK))),
    ("c-i(a-b)/(2i)", c - iK * quot(a - b, two * iK)),
    ("c-is", c - iK * s),
]
assert len(lines) == 23
v = [x for _, x in lines]
EUL1, EUL2 = 14, 21   # 第 15 等号（v[14] = v[15]）と第 22 等号（v[21] = v[22]）が euler_formula_cos_sin を引く
for k in range(len(v) - 1):
    if k in (EUL1, EUL2):
        continue
    assert v[k] == v[k + 1], ("main", k)
print("  第 1〜14・16〜21 等号（積の単位元・逆元・結合律・可換律・商の定義・差の定義・分配律・-1 倍、準備の第二・第三の鎖の参照）: 恒等的に等しい")
d15 = v[EUL1] - v[EUL1 + 1]
assert d15 != 0 and d15 == quot(a + b, two) - c
assert d15.numerator().subs(c=(a + b) / two) == 0
print("  第 15 等号: 差は (a+b)/2 - c で、euler_formula_cos_sin の第 1 の等式を代入すると 0（代入しなければ 0 でない）")
d22 = v[EUL2] - v[EUL2 + 1]
assert d22 != 0 and d22 == iK * (s - quot(a - b, two * iK))
assert (s - (a - b) / (two * iK)).numerator().subs(s=(a - b) / (two * iK)) == 0
print("  第 22 等号: 差は i(s - (a-b)/(2i)) で、euler_formula_cos_sin の第 2 の等式を代入すると 0（代入しなければ 0 でない）")
# 対照: 第 2 等号の 2^{-1}2 を 2 に、第 17 等号の i(2i)^{-1} を i に替えると切れる
assert two * b != v[1] and c - (a - b) * iK != v[16]
print("  対照: 第 2 等号の 2^{-1}2 を 2、第 17 等号の i(2i)^{-1} を i に替えると等号が成り立たない")

count = 0
for den in range(1, 13):
    for num in range(-2 * den, 2 * den + 1):
        q = QQ(num) / den
        A, B = E(q), E(-q)
        C, S = to_C(cos2pi(q)), to_C(sin2pi(q))
        assert C == (A + B) / 2 and S == (A - B) / (2 * I_QQBAR)
        h, j2 = QQbar(2) ** -1, (2 * I_QQBAR) ** -1
        pt = [B, 1 * B, (h * 2) * B, h * (2 * B), (2 * B) * h, (2 * B) / 2,
              ((A + B) - (A - B)) / 2, ((A + B) - (A - B)) * h, ((A + B) + (-(A - B))) * h,
              (A + B) * h + (-(A - B)) * h, (A + B) * h + ((-1) * (A - B)) * h, (A + B) * h + (-1) * ((A - B) * h),
              (A + B) * h + (-((A - B) * h)), (A + B) * h - (A - B) * h, (A + B) / 2 - (A - B) / 2,
              C - (A - B) / 2, C - (A - B) * h, C - (A - B) * (I_QQBAR * j2), C - ((A - B) * I_QQBAR) * j2,
              C - (I_QQBAR * (A - B)) * j2, C - I_QQBAR * ((A - B) * j2), C - I_QQBAR * ((A - B) / (2 * I_QQBAR)),
              C - I_QQBAR * S]
        assert len(pt) == len(lines)
        check_adjacent(list(zip([n for n, _ in lines], pt)), f"q={q}")
        count += 1
print(f"  具体の点 θ = 2πq（分母 1..12、|q| ≤ 2 の {count} 点）: euler_formula_cos_sin の二つの等式と鎖の各行が QQbar で厳密に等しい")
print("RESULT: PASS")
