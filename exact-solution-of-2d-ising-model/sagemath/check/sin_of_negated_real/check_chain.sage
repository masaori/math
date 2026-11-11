# 対象ラベル: sin_of_negated_real
# 証明の鎖を一行ずつ確かめる。exp は引数の多項式で引く記号にし、exp(iθ_C)・exp(-(iθ_C)) を
# QQ(i) 上の有理関数体の不定元 Ep・Em に置く。各行の exp の引数は行に書かれた式どおりに組み、
# 引数の等号（i_times_negated_real_is_negation_of_i_times・negation_of_i_times_negated_real_is_i_times）は
# 多項式としての等号で exp_sym が同じ不定元を返すことで確かめる。浮動小数点なし。
# 範囲: euler_formula_cos_sin の二つの式を前提として当てはめる行の検算である（全実数上の cos・sin は本文で未整備）。
K0.<I0> = QuadraticField(-1)
Rt.<t, Ep, Em> = PolynomialRing(K0)
Ft = Rt.fraction_field()

def exp_sym(arg):
    """exp を引数の多項式で引く: 引数が iθ なら Ep、-(iθ) なら Em。それ以外は止める。"""
    if arg == I0 * t:
        return Ft(Ep)
    if arg == -(I0 * t):
        return Ft(Em)
    raise ValueError(arg)

def exp_sym_any(arg):
    """i(-θ)・-(i(-θ)) も多項式として iθ・-(iθ) に等しいので、同じ不定元を返す（引く主張の等号を多項式の等号で確かめる）。"""
    return exp_sym(Rt(arg))

assert I0 * (-t) == -(I0 * t)
assert -(I0 * (-t)) == I0 * t
chain = [
    (exp_sym_any(I0 * (-t)) - exp_sym_any(-(I0 * (-t)))) / (2 * I0),   # euler_formula_cos_sin を -θ に適用
    (exp_sym(-(I0 * t)) - exp_sym_any(-(I0 * (-t)))) / (2 * I0),      # i_times_negated_real_is_negation_of_i_times
    (exp_sym(-(I0 * t)) - exp_sym(I0 * t)) / (2 * I0),                # negation_of_i_times_negated_real_is_i_times
    (-(Ft(Ep) - Ft(Em))) / (2 * I0),                                  # b - a = -(a - b)
    (-(Ft(Ep) - Ft(Em))) * (2 * I0)**(-1),                            # def_complex_quotient
    (Ft(-1) * (Ft(Ep) - Ft(Em))) * (2 * I0)**(-1),                    # multiply_by_minus_one
    Ft(-1) * ((Ft(Ep) - Ft(Em)) * (2 * I0)**(-1)),                    # 積の結合律
    -((Ft(Ep) - Ft(Em)) * (2 * I0)**(-1)),                            # multiply_by_minus_one を右辺から左辺へ
    -((Ft(Ep) - Ft(Em)) / (2 * I0)),                                  # def_complex_quotient を右辺から左辺へ
]
sin_theta = (Ft(Ep) - Ft(Em)) / (2 * I0)                              # euler_formula_cos_sin
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
assert chain[-1] == -sin_theta                                        # 最終行 = -(sin θ)_C
assert Ft(Em) - Ft(Ep) != Ft(Ep) - Ft(Em)                             # 対照: b - a ≠ a - b
assert chain[0] != sin_theta                                          # 対照: 符号を落とすと一致しない
print("checked the 10-line chain over QQ(i)(θ, Ep, Em)")
print("RESULT: PASS")
