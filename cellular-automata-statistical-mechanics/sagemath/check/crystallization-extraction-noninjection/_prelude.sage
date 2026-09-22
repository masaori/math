from itertools import product

Qq_polynomial = PolynomialRing(QQ, names=('q',))
q = Qq_polynomial.gen()
Qq = FractionField(Qq_polynomial)
Laurent_qz = LaurentPolynomialRing(Qq, names=('z',))
z = Laurent_qz.gen()
Laurent_z = LaurentPolynomialRing(QQ, names=('z0',))
z0 = Laurent_z.gen()

B = ('b0', 'b1')
C = ('c0', 'c1')
BC = tuple(product(B, C))
CB = tuple(product(C, B))
H = {
    ('b0', 'c0'): ZZ(-1),
    ('b0', 'c1'): ZZ(0),
    ('b1', 'c0'): ZZ(2),
    ('b1', 'c1'): ZZ(1),
}

def is_regular_at_zero(coefficient):
    coefficient = Qq(coefficient)
    return coefficient.denominator()(0) != 0

def evaluate_coefficient_at_zero(coefficient):
    coefficient = Qq(coefficient)
    assert is_regular_at_zero(coefficient)
    return QQ(coefficient.numerator()(0)) / QQ(coefficient.denominator()(0))

def evaluate_laurent_at_zero(value):
    result = Laurent_z.zero()
    for exponent, coefficient in Laurent_qz(value).dict().items():
        result += evaluate_coefficient_at_zero(coefficient) * z0**exponent
    return result

def evaluate_matrix_at_zero(operator):
    return matrix(
        Laurent_z,
        operator.nrows(),
        operator.ncols(),
        lambda row, column: evaluate_laurent_at_zero(operator[row, column]),
    )

def swapped_basis(pair):
    b, c = pair
    return (c, b)

R0 = matrix(Laurent_qz, len(CB), len(BC), 0)
for column, pair in enumerate(BC):
    row = CB.index(swapped_basis(pair))
    R0[row, column] = z**H[pair]

R1 = (1 + q) * R0
