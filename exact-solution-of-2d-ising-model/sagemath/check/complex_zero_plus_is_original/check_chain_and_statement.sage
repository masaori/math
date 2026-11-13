# 対象ラベル: complex_zero_plus_is_original
# 証明の四行の鎖を、ℂ を本文どおり実数の対で持つ共通の準備（_shared/complex_as_real_pairs.sage）で確かめる。
# z = (a, b) の a, b は QQ 上の不定元（代入は環準同型なので任意の実数で成り立つ）。
# 0 を定数で置くと Sage が組んだ時点で簡約して何も確かめないので、第二行は実数の 0 を不定元 o に置いて
# 和の定義の写し方を確かめ、第三行は第二行の 2 つの和 o + x へ o = 0 を代入した値と比べる。
# あわせて主張 0_C + z = z を、Sage の QQ(i)（独立な経路）の具体の値でも確かめる。浮動小数点はない。
load("../../_shared/complex_as_real_pairs.sage")

P.<a, b, o> = PolynomialRing(QQ)
z = (a, b)

# 第一行: 0_C = ι(0) = (0, 0)
assert iota(0, P) == (P(0), P(0))

# 第二行: (o, o) + (a, b) = (o + a, o + b)。左辺は共通の準備の和、右辺は本文の行を写したもの。
second = (o + a, o + b)
assert cc_add((o, o), z) == second

# 第三行: 第二行の 2 つの和 o + a, o + b のそれぞれが o = 0 で a, b になる
third = (a, b)
assert (second[0].subs(o=0), second[1].subs(o=0)) == third

# 第四行: (a, b) = z
assert third == z

# 主張そのもの
assert cc_add(iota(0, P), z) == z

# 否定の対照: 0_C の代わりに 1_C を足すと z にならない
assert cc_add(iota(1, P), z) != z

K.<i> = QuadraticField(-1)
for w in [K(0), K(1), i, K(3) - 2 * i, K(-5) / 7 + i / 3]:
    assert K(0) + w == w
    x, y = w.vector()
    assert cc_add(iota(0, QQ), (QQ(x), QQ(y))) == (QQ(x), QQ(y))
print("RESULT: PASS")
