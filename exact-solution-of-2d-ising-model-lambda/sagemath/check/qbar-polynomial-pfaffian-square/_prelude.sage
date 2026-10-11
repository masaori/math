from functools import lru_cache
from itertools import product

K = CyclotomicField(8)
zeta = K.gen()
R = PolynomialRing(K, "x")
x = R.gen()


@lru_cache(None)
def matchings(vertices):
    if not vertices:
        return ((),)
    first = vertices[0]
    return tuple(((first, partner),) + tail
                 for partner in vertices[1:]
                 for tail in matchings(tuple(v for v in vertices[1:] if v != partner)))


def coefficient(matching):
    word = [v for pair in matching for v in pair]
    inversions = sum(1 for i in range(len(word)) for j in range(i + 1, len(word))
                     if word[i] > word[j])
    return R((-1)**inversions)


def monomial(A, matching):
    return prod((A[i, j] for i, j in matching), R(1))


def signed_sum(A, data):
    return sum((c*b for c, b in data), R(0))


def recursive_pfaffian(A, vertices):
    if not vertices:
        return R(1)
    i = vertices[0]
    return sum(((-1)**(position + 1)*A[i, j]*recursive_pfaffian(
        A, tuple(v for v in vertices[1:] if v != j))
        for position, j in enumerate(vertices[1:], start=1)), R(0))


def fixtures():
    for n in range(9):
        for kind in ("zero", "dense", "adjacent", "rank_two", "constant"):
            A = zero_matrix(R, n)
            for i in range(n):
                for j in range(i + 1, n):
                    if kind == "zero":
                        entry = R(0)
                    elif kind == "dense":
                        entry = (i + 1)*x**2 + zeta**(i + j + 1)*x + j + 1
                    elif kind == "adjacent":
                        entry = x + zeta**(i + 1) if i % 2 == 0 and j == i + 1 else R(0)
                    elif kind == "rank_two":
                        entry = (i + 1)*(x + zeta**(j + 1)) - (j + 1)*(x + zeta**(i + 1))
                    else:
                        entry = R(1)
                    A[i, j] = entry
                    A[j, i] = -entry
            ms = matchings(tuple(range(n)))
            data = [(coefficient(m), monomial(A, m)) for m in ms]
            yield n, kind, A, ms, data


def equal(left, right):
    assert left.parent() is R and right.parent() is R
    assert left == right, (left, right)


def double_sum(data, term):
    return sum((sum((term(c, b, d, e) for d, e in data), R(0))
                for c, b in data), R(0))


def check_total(name, left, right):
    count = 0
    for n, kind, A, ms, data in fixtures():
        pf = signed_sum(A, data)
        equal(left(pf, data), right(pf, data))
        count += 1
    assert count == 45
    print(f"PASS {name}: {count} polynomial equalities")


def check_term(name, left, right):
    terms = 0
    totals = 0
    for n, kind, A, ms, data in fixtures():
        for c, b in data:
            for d, e in data:
                equal(left(c, b, d, e), right(c, b, d, e))
                terms += 1
        equal(double_sum(data, left), double_sum(data, right))
        totals += 1
    assert terms == 56305 and totals == 45
    print(f"PASS {name}: {terms} summands, {totals} sums, {terms + totals} equalities")
