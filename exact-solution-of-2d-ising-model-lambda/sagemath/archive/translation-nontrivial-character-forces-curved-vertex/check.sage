"""非自明な選択文字が均衡配向の曲がり型頂点を強制する論法を検算する。

一般証明で使う二つの有限的な核を一辺三で全数検査する。

* 互いに素な偶部分グラフ H,K のトーラス上の交差数の偶奇は、巻き付き
  偶奇の交代積 h_H v_K + v_H h_K に等しい。
* 次数 4 頂点が交差型に配向されているとき、H の局所的な入出差が零で
  ないのは H が水平二辺または垂直二辺を取る場合だけである。その場合は
  H と K が横断し、入出差は +2 または -2 である。

検査は有限集合と GF(2)・整数の等号だけで行う。
"""

from itertools import product

side = 3
directions = (0, 1, 2, 3)  # 東、南、西、北


def base_edges():
    return [(kind, i, j)
            for kind in ("h", "v")
            for i in range(side)
            for j in range(side)]


def endpoints(edge):
    kind, i, j = edge
    if kind == "h":
        return (i, j), (i, (j + 1) % side)
    return (i, j), ((i + 1) % side, j)


edges = base_edges()
vertices = [(i, j) for i in range(side) for j in range(side)]
edge_index = {edge: position for position, edge in enumerate(edges)}
vertex_index = {vertex: position for position, vertex in enumerate(vertices)}

boundary = matrix(GF(2), len(vertices), len(edges))
for edge in edges:
    first, second = endpoints(edge)
    boundary[vertex_index[first], edge_index[edge]] += 1
    boundary[vertex_index[second], edge_index[edge]] += 1

cycle_space = boundary.right_kernel()
even_subsets = [
    frozenset(edges[position]
              for position in range(len(edges)) if vector[position] == 1)
    for vector in cycle_space
]
assert len(even_subsets) == 1024


def winding(subset):
    return (
        sum(ZZ(kind == "h" and j == side - 1)
            for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == side - 1)
            for kind, i, j in subset) % 2,
    )


def incident_directions(subset, vertex):
    result = set()
    i, j = vertex
    candidates = {
        ("h", i, j): 0,
        ("v", i, j): 1,
        ("h", i, (j - 1) % side): 2,
        ("v", (i - 1) % side, j): 3,
    }
    for edge, direction in candidates.items():
        if edge in subset:
            result.add(direction)
    return frozenset(result)


def transverse_count(first, second):
    count = ZZ(0)
    opposite = {frozenset((0, 2)), frozenset((1, 3))}
    for vertex in vertices:
        first_directions = incident_directions(first, vertex)
        second_directions = incident_directions(second, vertex)
        if (first_directions in opposite
                and second_directions in opposite
                and first_directions != second_directions):
            count += 1
    return count


disjoint_pair_count = ZZ(0)
for first in even_subsets:
    first_h, first_v = winding(first)
    for second in even_subsets:
        if first & second:
            continue
        second_h, second_v = winding(second)
        disjoint_pair_count += 1
        assert transverse_count(first, second) % 2 == (
            first_h * second_v + first_v * second_h) % 2

assert disjoint_pair_count == 8589
print(f"disjoint even-subgraph pairs: {disjoint_pair_count}, "
      "intersection parity equals the winding pairing")


def local_balance(chosen, incoming):
    return (sum(ZZ(direction in incoming) for direction in chosen)
            - sum(ZZ(direction not in incoming) for direction in chosen))


horizontal = frozenset((0, 2))
vertical = frozenset((1, 3))
local_case_count = ZZ(0)
for incoming in (horizontal, vertical):
    for bits in product((0, 1), repeat=4):
        chosen = frozenset(direction for direction, bit in zip(directions, bits)
                           if bit)
        if len(chosen) % 2 != 0:
            continue
        complement = frozenset(set(directions) - set(chosen))
        imbalance = local_balance(chosen, incoming)
        transverse = {chosen, complement} == {horizontal, vertical}
        assert (imbalance != 0) == transverse
        if transverse:
            assert abs(imbalance) == 2
        local_case_count += 1

assert local_case_count == 16
print(f"crossing local states: {local_case_count}, "
      "only transverse splittings have imbalance +2 or -2")
print("PASS: translation-nontrivial-character-forces-curved-vertex")
