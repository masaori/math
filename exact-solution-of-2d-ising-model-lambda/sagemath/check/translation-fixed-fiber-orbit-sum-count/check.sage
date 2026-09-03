"""平行移動で固定されるファイバー鍵が辺軌道の和で尽くされることと、その個数を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

ファイバー鍵は (D, E)（D, E は基底辺集合の互いに素な部分集合で E は偶部分グラフ）。
一辺 L の非零平行移動 t で固定される鍵は、D と E がともに t の辺軌道の和で
E が偶部分グラフになるものに全数一致する（一辺 2 の全 881 鍵で比較する）。
固定鍵の個数は軌道の割当の列挙で数えられ、可除条件だけを満たす鍵の個数より
真に少ない。計算は有限集合の等号と整数の数え上げだけで行う。
"""

from math import gcd, lcm
from itertools import combinations, product


def translation_order(side, shift):
    a, b = shift
    return lcm(side // gcd(side, a), side // gcd(side, b))


def base_edges(side):
    return [(kind, i, j)
            for kind in ("h", "v")
            for i in range(side)
            for j in range(side)]


def translate_edge(side, shift, edge):
    kind, i, j = edge
    a, b = shift
    return (kind, (i + a) % side, (j + b) % side)


def edge_endpoints(side, edge):
    kind, i, j = edge
    if kind == "h":
        return (i, j), (i, (j + 1) % side)
    return (i, j), ((i + 1) % side, j)


def is_even_subset(side, subset):
    degrees = {}
    for edge in subset:
        for vertex in edge_endpoints(side, edge):
            degrees[vertex] = degrees.get(vertex, 0) + 1
    return all(degree % 2 == 0 for degree in degrees.values())


def edge_orbits(side, shift):
    order = translation_order(side, shift)
    unseen = set(base_edges(side))
    orbits = []
    while unseen:
        first = min(unseen)
        orbit = frozenset(
            translate_edge(side, (k * shift[0], k * shift[1]), first)
            for k in range(order)
        )
        assert len(orbit) == order
        orbits.append(orbit)
        unseen -= orbit
    return orbits


def orbit_sum_fixed_keys(side, shift):
    """D, E をともに軌道の和とする割当のうち E が偶部分グラフになる鍵の集合。"""
    orbits = edge_orbits(side, shift)
    keys = set()
    for assignment in product((0, 1, 2), repeat=len(orbits)):
        doubled = frozenset().union(
            *(orbit for orbit, slot in zip(orbits, assignment) if slot == 1),
        ) if 1 in assignment else frozenset()
        single = frozenset().union(
            *(orbit for orbit, slot in zip(orbits, assignment) if slot == 2),
        ) if 2 in assignment else frozenset()
        if is_even_subset(side, single):
            keys.add((doubled, single))
    return keys


def binomial(n, k):
    if k < 0 or k > n:
        return 0
    result = 1
    for index in range(k):
        result = result * (n - index) // (index + 1)
    return result


# 一辺 2: ファイバー鍵の全数（D, E 互いに素・E 偶部分グラフ）を列挙し、
# 固定鍵と軌道和鍵の全数一致、および可除条件だけを満たす鍵との真の差を確認する。
L = 2
edges2 = base_edges(L)
even_subsets2 = [
    frozenset(subset)
    for size in range(len(edges2) + 1)
    for subset in combinations(edges2, size)
    if is_even_subset(L, frozenset(subset))
]
assert len(even_subsets2) == 32

all_keys2 = set()
for single in even_subsets2:
    rest = [edge for edge in edges2 if edge not in single]
    for size in range(len(rest) + 1):
        for doubled in combinations(rest, size):
            all_keys2.add((frozenset(doubled), single))
assert len(all_keys2) == 881

expected_fixed2 = {(0, 1): 45, (1, 0): 45, (1, 1): 41}
for shift, expected_count in sorted(expected_fixed2.items()):
    order = translation_order(L, shift)
    assert order == 2
    fixed_keys = {
        (doubled, single) for doubled, single in all_keys2
        if frozenset(translate_edge(L, shift, edge) for edge in doubled) == doubled
        and frozenset(translate_edge(L, shift, edge) for edge in single) == single
    }
    orbit_sum_keys = orbit_sum_fixed_keys(L, shift)
    assert fixed_keys == orbit_sum_keys
    assert len(fixed_keys) == expected_count
    divisible_keys = {
        (doubled, single) for doubled, single in all_keys2
        if len(doubled) % order == 0 and len(single) % order == 0
    }
    assert fixed_keys.issubset(divisible_keys)
    assert len(divisible_keys) == 441
    print(f"L=2, shift={shift}: fixed keys {len(fixed_keys)} "
          f"= orbit-sum keys, divisible keys {len(divisible_keys)}")

# 一般の辺長: 軌道の割当が列挙できる平行移動について固定鍵を数える。
# 個数は平行移動の方向にも依存する（一辺 5 の (1,1) と (1,2) は同じ位数 5 で個数が違う）。
expected_fixed_counts = {
    (3, (1, 1)): 189,
    (4, (1, 1)): 881,
    (5, (1, 1)): 4149,
    (5, (1, 2)): 3969,
}
observed_fixed_counts = {}
for side, shift in sorted(expected_fixed_counts):
    order = translation_order(side, shift)
    orbits = edge_orbits(side, shift)
    assert len(orbits) * order == 2 * side * side
    fixed_keys = orbit_sum_fixed_keys(side, shift)
    observed_fixed_counts[(side, shift)] = len(fixed_keys)
    for doubled, single in fixed_keys:
        assert len(doubled) % order == 0
        assert len(single) % order == 0
    print(f"L={side}, shift={shift}, order={order}: fixed keys {len(fixed_keys)}")
assert observed_fixed_counts == expected_fixed_counts

# 可除条件だけを満たす鍵の個数との比較（一辺 3 は偶部分集合を全列挙できる）。
L3 = 3
edges3 = base_edges(L3)
even_size_counts3 = {}
even_total3 = 0
for bits in range(1 << len(edges3)):
    subset = frozenset(
        edge for index, edge in enumerate(edges3) if bits >> index & 1
    )
    if is_even_subset(L3, subset):
        even_size_counts3[len(subset)] = even_size_counts3.get(len(subset), 0) + 1
        even_total3 += 1
assert even_total3 == 1 << (L3 * L3 + 1)

shift3 = (1, 1)
order3 = translation_order(L3, shift3)
assert order3 == 3
divisible_count3 = 0
for single_size, size_count in even_size_counts3.items():
    if single_size % order3 != 0:
        continue
    rest = len(edges3) - single_size
    doubled_choices = sum(
        binomial(rest, doubled_size)
        for doubled_size in range(0, rest + 1, order3)
    )
    divisible_count3 += size_count * doubled_choices
assert divisible_count3 == 299187
assert expected_fixed_counts[(3, (1, 1))] < divisible_count3
print(f"L=3, shift=(1,1): divisible keys {divisible_count3} "
      f"> fixed keys {expected_fixed_counts[(3, (1, 1))]}")

print("PASS: translation-fixed-fiber-orbit-sum-count")
