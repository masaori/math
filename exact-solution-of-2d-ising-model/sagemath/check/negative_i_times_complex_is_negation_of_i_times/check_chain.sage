# 対象ラベル: negative_i_times_complex_is_negation_of_i_times
# 証明の三行の鎖の四つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 (-i)z = -(iz) を、Sage 組み込みの符号反転（独立な経路）で組んだ右辺と比べる。
# 帰属: QQ(i) 上の多項式環（z は不定元）。不定元で成り立つ等号は、z へ任意の複素数を代入しても成り立つ。
Ki = QuadraticField(-1, 'i')
i = Ki.gen()
R = PolynomialRing(Ki, 'zr,zi')
zr, zi = R.gens()
z = zr + i * zi                         # z ∈ ℂ を実部・虚部の不定元で表す

mo = R(-1)                              # -1_C

def neg(w):
    """multiply_by_minus_one: -w := (-1_C)·w"""
    return mo * w

chain = [
    neg(R(i)) * z,                      # (-i)z
    (mo * i) * z,                       # ((-1_C)i)z          multiply_by_minus_one (z → i)
    mo * (i * z),                       # (-1_C)(iz)          積の結合律
    neg(i * z),                         # -(iz)               multiply_by_minus_one (z → iz)
]
for t in range(len(chain) - 1):
    assert chain[t] == chain[t + 1], t
assert chain[0] == -(i * z)             # 主張（Sage 組み込みの符号反転）
# 対照: 符号を落とした iz とは一致しない（差 2iz は零でない多項式）
assert chain[0] != i * z
print("checked the 3-line chain and the statement over QQ(i)[zr, zi]")
print("RESULT: PASS")
