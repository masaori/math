from itertools import combinations

P = PolynomialRing(QQ, names=('l0', 'l1', 'l2', 's0', 's1', 's2'))
l = P.gens()[:3]
s = P.gens()[3:]

def tagged_sum(n):
    answer = P.zero()
    for k in range(n + 1):
        for chosen in combinations(range(n), k):
            long_product = P.one()
            short_product = P.one()
            for i in range(n):
                if i in chosen:
                    short_product *= s[i]
                else:
                    long_product *= l[i]
            answer += (-1)**k * long_product * short_product
    return answer

def pair_product(n):
    answer = P.one()
    for i in range(n):
        answer *= l[i] - s[i]
    return answer
