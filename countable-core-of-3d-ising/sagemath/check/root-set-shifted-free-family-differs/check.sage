import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "..", "..", "_shared", "defs.sage"))


def distinct_irreducible_factor_degrees(poly):
    # 非零多項式の、相異なる既約因子（原始的・最高次係数正）の次数の集合
    degrees = set()
    for (f, m) in poly.factor():
        if f.degree() > 0:
            assert f.is_irreducible()
            degrees.add(f.degree())
    return degrees


R = PolynomialRing(QQ, "x")
x = R.gen()

# 段 1: Z_2 は次数 2 の既約因子 X^2+1 を持つ（したがって最小多項式次数 2 の零点を持つ）
Z2 = R(partition_polynomial_by_layer_transfer(2, free_box_edges(2), False))
quotient, remainder = Z2.quo_rem(x**2 + 1)
assert remainder == 0
print("PASS: (X^2+1) divides Z_2")
assert (x**2 + 1).is_irreducible()
print("PASS: X^2+1 is irreducible over QQ (its roots have minimal polynomial degree 2)")

# 段 2: Z'_2 = Z_3 の相異なる既約因子の次数は 1 と 40 だけ
Z3 = R(partition_polynomial_by_layer_transfer(3, free_box_edges(3), False))
degrees_Z3 = distinct_irreducible_factor_degrees(Z3)
assert degrees_Z3 == {1, 40}, degrees_Z3
print("PASS: distinct irreducible factor degrees of Z'_2 = Z_3 are exactly {1, 40}")

# 段 3: X^2+1 は Z_3 を割らない（Z_3 は最小多項式次数 2 の零点を持たない）ので零点集合は異なる
assert Z3.gcd(x**2 + 1) == 1
print("PASS: gcd(Z_3, X^2+1) = 1, so no root of X^2+1 is a root of Z'_2")
print("PASS: the distinct-root sets of Z_2 and Z'_2 = Z_3 differ")
