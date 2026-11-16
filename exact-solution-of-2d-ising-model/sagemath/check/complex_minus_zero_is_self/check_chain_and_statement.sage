# 対象ラベル: complex_minus_zero_is_self
# 証明の四行の鎖 z - 0_C = z + (-0_C) = z + (-1_C)0_C = z + 0_C = z を、ℂ を本文どおり実数の対で持つ
# 共通の準備（_shared/complex_as_real_pairs.sage）で確かめる。z = (a, b) の a, b は QQ 上の不定元
# （代入は環準同型なので任意の実数で成り立つ）。
# 0 を定数で置くと Sage が組んだ時点で簡約して何も確かめないので、第一行の -0_C は不定元の対 (p, q) に、
# 第二行・第四行の 0_C の 2 つの成分は別々の不定元 o1, o2 に置き、各段をその置き換えとして確かめる。
# あわせて主張 z - 0_C = z を、Sage の QQ(i)（独立な経路）の具体の値でも確かめる。浮動小数点はない。
load("../../_shared/complex_as_real_pairs.sage")

P.<a, b, p, q, o1, o2> = PolynomialRing(QQ)
z = (a, b)
zero_c = iota(0, P)
minus_one_c = iota(-1, P)

# 第一行: def_complex_difference（z → z, w → 0_C）。差 z - w := z + (-w) の -w を不定元の対 (p, q) に置くと、
# 本文の行の右辺は z + (p, q) である。(p, q) を共通の準備の -0_C に置き換えると共通の準備の差に一致する。
first = cc_add(z, (p, q))
neg_zero = cc_neg(zero_c, P)
assert (first[0].subs(p=neg_zero[0], q=neg_zero[1]), first[1].subs(p=neg_zero[0], q=neg_zero[1])) == cc_sub(z, zero_c, P)

# 第二行: multiply_by_minus_one（z → 0_C）。-0_C := (-1_C) 0_C。0_C の成分を不定元 (o1, o2) に置いて
# 積の定義を写したものが (-o1, -o2) になり、o1 = o2 = 0 で共通の準備の -0_C に一致する。
second_factor = cc_mul(minus_one_c, (o1, o2))
assert second_factor == (-o1, -o2)
assert (second_factor[0].subs(o1=0, o2=0), second_factor[1].subs(o1=0, o2=0)) == neg_zero

# 第三行: complex_times_zero_is_zero（z → -1_C）。(-1_C) 0_C = 0_C。
assert cc_mul(minus_one_c, zero_c) == zero_c
third = cc_add(z, zero_c)
assert cc_add(z, cc_mul(minus_one_c, zero_c)) == third

# 第四行: complex_numbers_form_a_field の加法の単位元。z + (o1, o2) は o1 = o2 = 0 で z になる。
fourth_open = cc_add(z, (o1, o2))
assert fourth_open == (a + o1, b + o2)
assert (fourth_open[0].subs(o1=0, o2=0), fourth_open[1].subs(o1=0, o2=0)) == z
assert third == z

# 主張そのもの
assert cc_sub(z, zero_c, P) == z

# 否定の対照: 0_C の代わりに 1_C を引くと z にならない。差の向きを取り違えた 0_C - z も z にならない。
assert cc_sub(z, iota(1, P), P) != z
assert cc_sub(zero_c, z, P) != z
# 否定の対照: 第二行で -1_C の代わりに 1_C を掛けた 1_C·(o1, o2) は (-o1, -o2) と一致しない。成分を入れ替えた (-o2, -o1) も第二行と一致しない。
assert cc_mul(iota(1, P), (o1, o2)) != (-o1, -o2)
assert second_factor != (-o2, -o1)

K.<i> = QuadraticField(-1)
for w in [K(0), K(1), i, K(3) - 2 * i, K(-5) / 7 + i / 3]:
    assert w - K(0) == w
    x, y = w.vector()
    assert cc_sub((QQ(x), QQ(y)), iota(0, QQ), QQ) == (QQ(x), QQ(y))
print("QQ[a, b, p, q, o1, o2] で鎖の四行と主張を確かめ、QQ(i) の 5 つの値でも主張を確かめた")
print("negative controls (broken lines detected): 4")
print("RESULT: PASS")
