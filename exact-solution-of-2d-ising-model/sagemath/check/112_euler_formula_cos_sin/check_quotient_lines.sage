# 対象ラベル: euler_formula_cos_sin
# 証明の二つの鎖の先頭 5 行ずつ（cos θ = (2_C cos θ)/2_C、sin θ = ((2_C i) sin θ)/(2_C i) を
# 積の単位元・multiplicative_group_of_cc の逆元・積の結合律・可換律・def_complex_quotient で開いた行）を確かめる。
# 帰属: QQ(i) 上の有理関数体。(cos θ)_C・(sin θ)_C は不定元 c・s（全実数上の cos・sin は本文で未整備なので値は組まない）。
# 逆元は体の逆元、商は def_complex_quotient どおり z * w^(-1) で組む。浮動小数点なし。
K0.<I0> = QuadraticField(-1)
Rt.<c, s> = PolynomialRing(K0)
Ft = Rt.fraction_field()
two = Ft(2)
two_i = two * Ft(I0)
assert two != 0 and Ft(I0) != 0 and two_i != 0            # 2_C, i, 2_C i ∈ C^×

def quotient(z, w):
    """def_complex_quotient: z/w := z w^(-1)。"""
    assert w != 0
    return z * w**(-1)

def check_chain(x, w):
    """x = 1_C x = (w^(-1) w) x = w^(-1)(w x) = (w x) w^(-1) = (w x)/w の各行。"""
    chain = [
        x,
        Ft(1) * x,                     # 積の単位元を右辺から左辺へ
        (w**(-1) * w) * x,             # multiplicative_group_of_cc の逆元を右辺から左辺へ
        w**(-1) * (w * x),             # 積の結合律
        (w * x) * w**(-1),             # 積の可換律
        quotient(w * x, w),            # def_complex_quotient を右辺から左辺へ
    ]
    for k in range(len(chain) - 1):
        assert chain[k] == chain[k + 1], k
    return chain[-1]

assert check_chain(Ft(c), two) == Ft(c)
assert check_chain(Ft(s), two_i) == Ft(s)
# 次の行（分子を Euler の公式の形へ書き換える行）の分子と同じ値であることも確かめる
Ep = Ft(c) + Ft(I0) * Ft(s)                                 # cos θ + i sin θ
Em = Ft(c) - Ft(I0) * Ft(s)                                 # cos θ - i sin θ
assert quotient(two * Ft(c), two) == quotient(Ep + Em, two)
assert quotient(two_i * Ft(s), two_i) == quotient(Ep - Em, two_i)
# 対照: 逆元を掛け忘れると一致しない／2_C で割る側を 2_C i にすると一致しない
assert two * Ft(c) != Ft(c)
assert quotient(two * Ft(c), two_i) != Ft(c)
print("checked the two 5-line prefixes over QQ(i)(c, s)")
print("RESULT: PASS")
