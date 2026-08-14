# 対象ラベル: claim_no_dependency_on_redundant_element
# w in T\S の一点反転後も S への制限が変わらないことを、|T|<=3 の全入力で検査する。
# 帰属: 有限集合と 0/1 の等号だけを使う。R/C 脱出なし。

from itertools import combinations, product


def subsets(items):
    for size in range(len(items) + 1):
        yield from combinations(items, size)


def configurations(size):
    return tuple(product((0, 1), repeat=size))


def restrict_input(y, subset):
    return tuple(y[u] for u in subset)


def flip(y, w):
    changed = list(y)
    changed[w] = 1 - changed[w]
    return tuple(changed)


tested = 0
for total_size in range(4):
    total = tuple(range(total_size))
    for subset in subsets(total):
        added = set(total).difference(subset)
        for y in configurations(total_size):
            for w in added:
                assert restrict_input(flip(y, w), subset) == restrict_input(y, subset)
                tested += 1

print("restriction identities checked: {}".format(tested))
print("RESULT: PASS")
