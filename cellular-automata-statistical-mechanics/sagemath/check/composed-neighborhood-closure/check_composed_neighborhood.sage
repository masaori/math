# 対象ラベル: def_composed_neighborhood
# 合成近傍 (N*M)(v) = ∪_{u in N(v)} M(u) が V の部分集合として有限に定まり、
# u in N(v) ならば M(u) ⊆ (N*M)(v) であることを、|V| <= 3 の全ての近傍割り当ての組で検査する。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

from itertools import combinations, product


def subsets(cells):
    for size in range(len(cells) + 1):
        for combination in combinations(cells, size):
            yield frozenset(combination)


def neighborhood_assignments(cells):
    return tuple(product(tuple(subsets(cells)), repeat=len(cells)))


def composed_neighborhood(cells, outer, inner):
    """(N*M)(v) を各 v について返す。"""
    return tuple(
        frozenset().union(*[inner[u] for u in outer[v]]) if outer[v] else frozenset()
        for v in cells
    )


tested_pairs = 0
tested_inclusions = 0
for cell_count in range(1, 4):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    for outer in assignments:
        for inner in assignments:
            composed = composed_neighborhood(cells, outer, inner)
            for v in cells:
                # 合併の定義そのもの
                union = set()
                for u in outer[v]:
                    union |= set(inner[u])
                assert composed[v] == frozenset(union)
                # V の部分集合であり有限
                assert composed[v] <= frozenset(cells)
                assert len(composed[v]) <= cell_count
                # u in N(v) ならば M(u) ⊆ (N*M)(v)
                for u in outer[v]:
                    assert inner[u] <= composed[v]
                    tested_inclusions += 1
            tested_pairs += 1

print(f"PASS assignment_pairs={tested_pairs} inclusions={tested_inclusions}")
