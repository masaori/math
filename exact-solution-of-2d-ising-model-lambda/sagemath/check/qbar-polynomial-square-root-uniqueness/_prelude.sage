from itertools import product

R = PolynomialRing(QQbar, "x")
x = R.gen()
zero = R.zero()
scalar_zero = QQbar.zero()
scalar_one = QQbar.one()
scalar_two = QQbar(2)
a = QQbar(2).sqrt()
b = QQbar(-1).sqrt()
normalized = [R(1), R(1)+x, R(1)-x, R(1)+a*x,
              R(1)+b*x, R(1)+a*x+b*x**2,
              R(1)+x**3, R(1)-b*x**3+a*x**4]
assert len(normalized) == 8 and len(set(normalized)) == 8
assert all(S[0] == scalar_one for S in normalized)
general_pairs = list(product(normalized, repeat=2))
equal_square_pairs = [(S, sign*S) for S in normalized for sign in (1, -1)]
zero_sum_pairs = [(S, -S) for S in normalized]
equal_pairs = [(S, R(S.list())) for S in normalized]
assert all(S*S == T*T for S, T in equal_square_pairs)
assert all(S+T == zero for S, T in zero_sum_pairs)
assert all(S-T == zero for S, T in equal_pairs)


def check_pairs(name, pairs, left, right, expected):
    assert len(pairs) == expected
    for S, T in pairs:
        lhs, rhs = left(S, T), right(S, T)
        assert lhs.parent() is rhs.parent()
        assert lhs == rhs, (name, S, T, lhs, rhs)
    print("RESULT: PASS %s (%s exact equalities)" % (name, len(pairs)))
