# 対象ラベル: complex_zero_times_is_zero
# 証明の六行の鎖を、ℂ を本文どおり実数の対で持つ共通の準備（_shared/complex_as_real_pairs.sage）で確かめる。
# z = (a, b) の a, b は QQ 上の不定元（代入は環準同型なので任意の実数で成り立つ）。
# 0 を定数で置くと Sage が組んだ時点で簡約して何も確かめないので、第一・第二行は実数の 0 を不定元 o に置いて
# 積の定義の写し方を確かめ、第三行は第二行の 4 つの積 o·x へ o = 0 を代入した値と比べる。
# あわせて主張 0_C z = 0_C を、Sage の QQ(i)（独立な経路）の具体の値でも確かめる。浮動小数点はない。
load("../../_shared/complex_as_real_pairs.sage")

P.<a, b, o> = PolynomialRing(QQ)
z = (a, b)

# 第一行: 0_C = ι(0) = (0, 0)
assert iota(0, P) == (P(0), P(0))

# 第二行: (o, o)(a, b) = (o·a − o·b, o·b + o·a)。左辺は共通の準備の積、右辺は本文の行を写したもの。
second = (o * a - o * b, o * b + o * a)
assert cc_mul((o, o), z) == second

# 第三行: 第二行の 4 つの積 o·a, o·b, o·b, o·a のそれぞれが o = 0 で 0 になり、(0 − 0, 0 + 0) になる
products = [o * a, o * b, o * b, o * a]
assert all(t.subs(o=0) == 0 for t in products)
third = (P(0) - P(0), P(0) + P(0))
assert (second[0].subs(o=0), second[1].subs(o=0)) == third

# 第四行から第六行: (0 − 0, 0 + 0) = (0, 0 + 0) = (0, 0) = 0_C。実数の定数の計算で、組んだ時点で一致する
# （確かめているのは本文の対の写し間違いだけである）。
chain = [third, (P(0), P(0) + P(0)), (P(0), P(0)), iota(0, P)]
for t in range(len(chain) - 1):
    assert chain[t] == chain[t + 1], t

# 主張そのもの
assert cc_mul(iota(0, P), z) == iota(0, P)

K.<i> = QuadraticField(-1)
for w in [K(0), K(1), i, K(3) - 2 * i, K(-5) / 7 + i / 3]:
    assert K(0) * w == K(0)
    x, y = w.vector()
    assert cc_mul(iota(0, QQ), (QQ(x), QQ(y))) == (QQ(0), QQ(0))
print("RESULT: PASS")
