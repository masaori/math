"""単純閉路 E に対する選択集合 C_L(D,E) の存在条件を検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

L >= 2、D と E は互いに素、E は空でない連結 2 正則辺集合とする。
このとき C subseteq E で D union C が偶部分グラフになるものが存在することと、
D の奇次数頂点が全て E の頂点であることが同値であり、存在するとき C は
ちょうど二つ（互いに E で補集合）であることを検査する。

一辺二では全ての互いに素な (D,E)、一辺三では |D| <= 2 の全ての互いに
素な (D,E) を調べる。有限集合と整数の厳密演算だけを使う。
"""

from itertools import combinations


def base_edges(side):
    return tuple((kind, row, column) for kind in ("h", "v")
                 for row in range(side) for column in range(side))


def endpoints(side, edge):
    kind, row, column = edge
    if kind == "h":
        return ((row, column), (row, (column + 1) % side))
    return ((row, column), ((row + 1) % side, column))


def degree(side, edges, vertex):
    return ZZ(sum(1 for edge in edges for endpoint in endpoints(side, edge)
                  if endpoint == vertex))


def boundary(side, edges):
    return frozenset((row, column)
                     for row in range(side) for column in range(side)
                     if degree(side, edges, (row, column)) % 2 == 1)


def is_simple_cycle(side, edges):
    if not edges:
        return False
    vertices = frozenset(vertex for edge in edges
                         for vertex in endpoints(side, edge))
    if any(degree(side, edges, vertex) != 2 for vertex in vertices):
        return False
    reached = {next(iter(vertices))}
    frontier = list(reached)
    while frontier:
        vertex = frontier.pop()
        for edge in edges:
            if vertex not in endpoints(side, edge):
                continue
            for neighbor in endpoints(side, edge):
                if neighbor not in reached:
                    reached.add(neighbor)
                    frontier.append(neighbor)
    return reached == set(vertices)


def subsets(items):
    items = tuple(items)
    for size in range(len(items) + 1):
        for chosen in combinations(items, size):
            yield frozenset(chosen)


def selectors(side, doubled, cycle):
    return tuple(chosen for chosen in subsets(cycle)
                 if not boundary(side, doubled.union(chosen)))


checked = {}
for side in (2, 3):
    edges = base_edges(side)
    cycles = tuple(chosen for chosen in subsets(edges)
                   if is_simple_cycle(side, chosen))
    pair_count = ZZ(0)
    selector_count = ZZ(0)
    for cycle in cycles:
        complement = tuple(edge for edge in edges if edge not in cycle)
        maximum_size = len(complement) if side == 2 else min(2, len(complement))
        for size in range(maximum_size + 1):
            for doubled_tuple in combinations(complement, size):
                doubled = frozenset(doubled_tuple)
                found = selectors(side, doubled, cycle)
                cycle_vertices = frozenset(
                    vertex for edge in cycle for vertex in endpoints(side, edge))
                condition = boundary(side, doubled).issubset(cycle_vertices)
                assert bool(found) == condition
                if condition:
                    assert len(found) == 2
                    assert found[0].symmetric_difference(found[1]) == cycle
                else:
                    assert len(found) == 0
                pair_count += 1
                selector_count += len(found)
    checked[side] = (ZZ(len(cycles)), pair_count, selector_count)
    print("L=%d: simple-cycles=%d checked-pairs=%d selectors=%d"
          % ((side,) + checked[side]))

assert checked[2][0] > 0 and checked[3][0] > 0
print("PASS: 単純閉路 E では、選択集合が非空であることと D の奇次数頂点が"
      "全て E 上にあることが同値であり、非空なら選択は補集合をなす二つ")
