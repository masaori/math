# 章「合併作用の像は合併保存写像の全体である」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、有限写像表、自然数だけを使う。
# 浮動小数点と R/C 脱出はない。

from itertools import combinations, product


def subsets(cells):
    for size in range(len(cells) + 1):
        for combination in combinations(cells, size):
            yield frozenset(combination)


def neighborhood_assignments(cells):
    return tuple(product(tuple(subsets(cells)), repeat=len(cells)))


def union_map_value(N, S):
    collected = set()
    for v in S:
        collected |= set(N[v])
    return frozenset(collected)


def union_map_table(cells, N):
    domain = tuple(subsets(cells))
    return tuple(union_map_value(N, S) for S in domain)


def all_subset_maps(cells):
    domain = tuple(subsets(cells))
    for values in product(domain, repeat=len(domain)):
        yield values


def is_union_preserving(cells, table):
    domain = tuple(subsets(cells))
    index = {S: i for i, S in enumerate(domain)}
    if table[index[frozenset()]] != frozenset():
        return False
    for S in domain:
        for T in domain:
            if table[index[S | T]] != table[index[S]] | table[index[T]]:
                return False
    return True


def reconstruct_assignment(cells, table):
    domain = tuple(subsets(cells))
    index = {S: i for i, S in enumerate(domain)}
    return tuple(table[index[frozenset((v,))]] for v in cells)


def table_value(cells, table, S):
    domain = tuple(subsets(cells))
    return table[domain.index(S)]
