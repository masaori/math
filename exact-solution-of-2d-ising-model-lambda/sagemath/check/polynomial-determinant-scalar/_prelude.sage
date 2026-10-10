from itertools import permutations

K = CyclotomicField(8)
zeta = K.gen()
R = PolynomialRing(K, "x")
x = R.gen()


def inputs():
    for n in range(1, 5):
        dense = matrix(R, n, n, lambda i, j:
                       (x**2 if i == j else 0) + (i + 1)*x + zeta**(i + j + 1))
        repeated = matrix(R, n, n, lambda i, j: x + zeta**(j + 1))
        matrices = [zero_matrix(R, n), identity_matrix(R, n),
                    matrix(R, n, n, lambda i, j: 0 if i > j else x + zeta + i + j),
                    dense, repeated]
        for A in matrices:
            for c in [R(0), R(1), R(-1), x, x**2 + zeta]:
                yield n, A, c


def terms(n, A, c):
    for sigma in permutations(range(n)):
        inversions = sum(1 for i in range(n) for j in range(i + 1, n)
                         if sigma[i] > sigma[j])
        w = R((-1)**inversions)
        P = prod((A[i, sigma[i]] for i in range(n)), R(1))
        yield sigma, w, P


def assert_polynomial_equal(left, right):
    assert left.parent() is R and right.parent() is R
    assert left == right


def check_line(name, left, right, termwise=False):
    sums = 0
    summands = 0
    for n, A, c in inputs():
        data = list(terms(n, A, c))
        if termwise:
            left_terms = []
            right_terms = []
            for sigma, w, P in data:
                lhs = left(n, A, c, sigma, w, P)
                rhs = right(n, A, c, sigma, w, P)
                assert_polynomial_equal(lhs, rhs)
                left_terms.append(lhs)
                right_terms.append(rhs)
                summands += 1
            assert_polynomial_equal(sum(left_terms, R(0)), sum(right_terms, R(0)))
        else:
            assert_polynomial_equal(left(n, A, c, data), right(n, A, c, data))
        sums += 1
    assert sums == 100
    if termwise:
        assert summands == 825
    print(f"PASS {name}: {sums} sums, {summands} summands, {sums + summands} equalities")
