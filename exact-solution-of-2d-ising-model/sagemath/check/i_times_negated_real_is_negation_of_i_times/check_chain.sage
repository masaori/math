# 対象ラベル: i_times_negated_real_is_negation_of_i_times
# 証明の六行の鎖の七つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ(i) 上の多項式環（θ は不定元）。ℝ の元 a の包含の像 a_C は、係数が QQ ⊂ QQ(i) の元として持つ。
# 不定元で成り立つ多項式の等号は、θ へ任意の実数を代入しても成り立つ（代入は環準同型である）。
Ki = QuadraticField(-1, 'i')
i = Ki.gen()
R = PolynomialRing(Ki, 't')
t = R.gen()                              # θ_C

m1 = R(-1)                               # (-1)_C = -1_C
chain = [
    i * (-t),                            # i(-θ)_C（ℝ の符号反転の像）
    i * ((-1) * t),                      # i((-1)θ)_C            ℝ で -a = (-1)a
    i * (m1 * t),                        # i((-1_C)θ_C)          real_inclusion_preserves_product
    (i * m1) * t,                        # (i(-1_C))θ_C          積の結合律
    (m1 * i) * t,                        # ((-1_C)i)θ_C          積の可換律
    m1 * (i * t),                        # (-1_C)(iθ_C)          積の結合律
    -(i * t),                            # -(iθ_C)               multiply_by_minus_one
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 対照: 符号を落とした iθ とは一致しない
assert chain[0] != i * t
print("checked the 6-line chain over QQ(i)[θ]")
print("RESULT: PASS")
