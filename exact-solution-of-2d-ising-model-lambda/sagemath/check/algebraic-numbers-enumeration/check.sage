# 対象ラベル: claim_algebraic_numbers_enumeration
# 有限個の整係数多項式について、各根集合が有限であり、
# それらの根が自然数で番号付けできることを厳密計算で確認する。
# 任意の多項式を覆うことは Lean と本文の論証が担う。
R = PolynomialRing(ZZ, 'x')
x = R.gen()
polynomials = [x, x - 1, x + 1, x*x - 2, x*x + 1, x*x + x + 1]
roots_by_polynomial = []
for p in polynomials:
    roots = [z for z, _ in QQbar['x'](p).roots()]
    assert len(roots) <= p.degree()
    assert all(QQbar['x'](p)(z) == 0 for z in roots)
    roots_by_polynomial.append(roots)

enumerated = [z for roots in roots_by_polynomial for z in roots]
assert len(enumerated) > 0
for z in enumerated:
    assert any(z == w for roots in roots_by_polynomial for w in roots)

assert QQbar(0) in enumerated
assert QQbar(1) in enumerated
assert QQbar(-1) in enumerated
assert QQbar(2).sqrt() in enumerated
print('PASS: six exact integer polynomials, finite root sets, finite enumeration')
