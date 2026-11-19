# 対象ラベル: claim_sum_of_squares_positive_root_plus_real_positive
R = PolynomialRing(QQ, names=('a', 'b', 'c'))
a, b, c = R.gens()
square_relation = c*c - a*a - b*b
assert (b*b - (c*c - a*a)).reduce(R.ideal(square_relation).groebner_basis()) == 0
assert (-(b*b) + (c*c - a*a)).reduce(R.ideal(square_relation).groebner_basis()) == 0
assert -(c+a) + c == -a
assert c + (-a) == c-a
assert (-(b*b) + (c+a)*(c-a)).reduce(R.ideal(square_relation).groebner_basis()) == 0
assert b*b + (-(b*b)) == 0
assert (b*b).reduce(R.ideal(square_relation, c+a).groebner_basis()) == 0
print("PASS 93731")
