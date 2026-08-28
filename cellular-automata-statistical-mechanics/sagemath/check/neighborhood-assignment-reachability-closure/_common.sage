# 章「近傍割り当ての反射推移閉包」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、有限写像表、自然数だけを使う。R/C 脱出はない。

from itertools import combinations, product

def subsets(cells):
    for size in range(len(cells) + 1):
        for combination in combinations(cells, size):
            yield frozenset(combination)

def neighborhood_assignments(cells):
    return tuple(product(tuple(subsets(cells)), repeat=len(cells)))

def identity_assignment(cells):
    return tuple(frozenset((v,)) for v in cells)

def pointwise_union(left, right):
    return tuple(left[v] | right[v] for v in range(len(left)))

def included(left, right):
    return all(left[v] <= right[v] for v in range(len(left)))

def compose(first, second):
    return tuple(
        frozenset().union(*(second[u] for u in first[v])) if first[v] else frozenset()
        for v in range(len(first))
    )

def power(cells, assignment, exponent):
    result = identity_assignment(cells)
    for _ in range(exponent):
        result = compose(result, assignment)
    return result

def approximation(cells, assignment, bound):
    result = tuple(frozenset() for _ in cells)
    for exponent in range(bound + 1):
        result = pointwise_union(result, power(cells, assignment, exponent))
    return result

def closure(cells, assignment):
    return approximation(cells, assignment, len(cells) ** 2)

def is_reflexive(cells, assignment):
    return all(v in assignment[v] for v in cells)

def is_transitive(cells, assignment):
    return all(w in assignment[v] for v in cells for u in assignment[v] for w in assignment[u])
