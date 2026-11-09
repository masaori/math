# 対象ラベル: euler_formula_cos_sin
# 証明の準備の、-(iθ_C) を i(-θ)_C へ書き換える 6 行の鎖（と、それを使う exp の 1 行）を、
# 各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# 帰属: QQ(i) 上の多項式環（θ は実数の不定元 t。包含の像 θ_C も同じ t）。浮動小数点なし。
Ki = QuadraticField(-1, 'i')
i = Ki.gen()
R = PolynomialRing(Ki, 't')
t = R.gen()
mo = R(-1)                               # -1_C = (-1)_C
chain = [
    mo * (i * t),                        # -(iθ_C) = (-1_C)(iθ_C)  multiply_by_minus_one（定義どおりの組み方）
    mo * (i * t),                        # (-1_C)(iθ_C)
    (mo * i) * t,                        # ((-1_C)i)θ_C            積の結合律
    (i * mo) * t,                        # (i(-1_C))θ_C            積の可換律
    i * (mo * t),                        # i((-1_C)θ_C)            積の結合律
    i * R(QQ(-1) * t),                   # i((-1)θ)_C              real_inclusion_preserves_product
    i * (-t),                            # i(-θ)_C                 ℝ で (-1)a = -a
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# exp の行: 引数が等しいので exp の値も等しい。対照: 符号を落とした iθ_C とは一致しない
assert chain[0] == i * (-t) and chain[0] != i * t
print("checked the 6-line chain -(iθ_C) = i(-θ)_C")
print("RESULT: PASS")
