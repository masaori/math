# 対象ラベル: claim_dependency_transfer
# rho^T_S(iota^T_S(x))=x を、|T|<=3 の全 S subseteq T と全 x in A^S で検査する。
# 帰属: 有限集合と 0/1 の等号だけを使う。R/C 脱出なし。

from itertools import combinations, product


def subsets(items):
    for size in range(len(items) + 1):
        yield from combinations(items, size)


def configurations(size):
    return tuple(product((0, 1), repeat=size))


def extend_input(x, subset, total_size):
    values = {u: x[position] for position, u in enumerate(subset)}
    return tuple(values.get(u, 0) for u in range(total_size))


def restrict_input(y, subset):
    return tuple(y[u] for u in subset)


tested = 0
for total_size in range(4):
    total = tuple(range(total_size))
    for subset in subsets(total):
        for x in configurations(len(subset)):
            assert restrict_input(extend_input(x, subset, total_size), subset) == x
            tested += 1

print("section identities checked: {}".format(tested))
print("RESULT: PASS")
