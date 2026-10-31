"""非自明文字鍵の曲がり型頂点による局所符号反転対合を一辺三の全数で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

鍵 (D,E)（D,E は基底辺集合の互いに素な部分集合、E は偶部分グラフ）のファイバーの
置換について、次の三段で局所符号反転対合の存在を確定する。

(1) 記号的な局所分類。二本の像の交換で回転数を変えずに完全対合できる局所方向型は
    「二本の入方向と二本の出方向が同じ曲がり二方向」の四型に限る（前 tick の再確認）。
    さらに、反転対辺（両向きが動く辺）は同じ頂点へ入方向 d と出方向 d+2 を同時に
    与えるが、曲がり二方向の対 {c, c+1} は d と d+2 を同時に含めないので、
    反転対辺が接続する頂点はこの型になれない。従って曲がり型頂点は
    「E の次数 4 頂点で、E の配向が曲がり型のもの」に限り、D に依存しない。

(2) 存在の全数検査。一辺三の偶部分グラフ 1,024 個のうち非自明文字を持つ 346 個の
    全てについて、E の均衡配向（各頂点で入次数=出次数）を全列挙し（合計 2,956 個）、
    そのそれぞれに曲がり型の次数 4 頂点が少なくとも一つあることを検査する。
    ファイバーの各置換の単純通過部分は E の均衡配向を誘導するので、これで
    任意の D についてファイバーの全置換が曲がり型頂点を持つ。

(3) 対合の直接検証。D = ∅ の全ファイバー（全 346 鍵、置換合計 115,688 個）と、
    辞書式最小の非自明文字 E（第 0 行と第 0 列の交差一周路）に閉路状の反転対
    D（第 1 行・第 1 列・その和）を付けた鍵の全ファイバー（置換合計 696 個）で、
    辞書式最小の曲がり型頂点の二つの局所全単射を交換する写像が、動辺集合・
    総回転数を保ち、巡回数の偶奇だけを反転する不動点のない対合であることを
    置換一件ずつの展開で検査する。曲がり型頂点の集合は動辺集合だけで決まり
    交換で保たれるので、辞書式最小の選択は交換の前後で一致し、対合が閉じる。
    同じ E の全ての D ⊆ (E の補集合) についても、曲がり型頂点の集合が E の
    配向だけで決まること、有効な動辺集合が前 tick と同じ 5,768 個で、その
    局所全単射数の積が全て偶数（曲がり型頂点の因子 2 を含む）ことを検査する。
    一辺だけの反転対は孤立端で非後退全単射が無く、ファイバーは空である。

従って一辺三では、全ての非自明文字鍵 (D,E) のファイバーが符号反転対へ分かれ、
四つのねじれ全てで K^{a,b}(D,E) = 0 になる。軌道代表からの運搬は不要である。
検査は有限集合と整数の等号だけで行い、浮動小数点を使わない。
"""

from itertools import combinations, permutations, product

side = 3


def base_edges():
    return [(kind, i, j)
            for kind in ("h", "v")
            for i in range(side)
            for j in range(side)]


def edge_endpoints_base(edge):
    kind, i, j = edge
    if kind == "h":
        return (i, j), (i, (j + 1) % side)
    return (i, j), ((i + 1) % side, j)


def reversal(directed):
    kind, i, j, orientation = directed
    return (kind, i, j, 1 - orientation)


def endpoints(directed):
    kind, i, j, orientation = directed
    first, second = edge_endpoints_base((kind, i, j))
    return (first, second) if orientation == 0 else (second, first)


def direction(directed):
    kind, _, _, orientation = directed
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[
        (kind, orientation)]


def quarter_turn(first_direction, second_direction):
    difference = (second_direction - first_direction) % 4
    assert difference in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[difference]


edges = base_edges()
edge_index = {edge: position for position, edge in enumerate(edges)}
vertices = [(i, j) for i in range(side) for j in range(side)]
vertex_index = {vertex: position for position, vertex in enumerate(vertices)}


# ---------- (1) 記号的な局所分類 ----------

def perfect_matching(adjacency, remaining):
    if not remaining:
        return {}
    first = min(remaining)
    for second in sorted(adjacency[first].intersection(remaining)):
        rest = perfect_matching(adjacency, remaining - {first, second})
        if rest is not None:
            return {first: second, second: first, **rest}
    return None


matchable_direction_types = set()
for size in range(1, 5):
    for incoming_directions in combinations(range(4), size):
        for outgoing_directions in combinations(range(4), size):
            choices = [
                image_tuple for image_tuple in permutations(outgoing_directions)
                if all((image - source) % 4 != 2
                       for source, image in zip(incoming_directions,
                                                image_tuple))
            ]
            adjacency = {index: set() for index in range(len(choices))}
            for first, second in combinations(range(len(choices)), 2):
                changed = [position for position in range(size)
                           if choices[first][position]
                           != choices[second][position]]
                if len(changed) != 2:
                    continue
                left, right = changed
                if (choices[first][left] != choices[second][right]
                        or choices[first][right] != choices[second][left]):
                    continue
                before = sum(
                    quarter_turn(incoming_directions[position],
                                 choices[first][position])
                    for position in changed
                )
                after = sum(
                    quarter_turn(incoming_directions[position],
                                 choices[second][position])
                    for position in changed
                )
                if before == after:
                    adjacency[first].add(second)
                    adjacency[second].add(first)
            matching = perfect_matching(adjacency, set(adjacency))
            if choices and matching is not None:
                matchable_direction_types.add(
                    (incoming_directions, outgoing_directions)
                )

curved_pairs = [(0, 1), (0, 3), (1, 2), (2, 3)]
assert matchable_direction_types == {(pair, pair) for pair in curved_pairs}

# 反転対辺は同じ頂点へ入方向 d と出方向 (d+2)%4 を同時に与える。
# 曲がり二方向の対はこの二方向を同時に含めない。
for pair in curved_pairs:
    for d in range(4):
        assert not (d in pair and (d + 2) % 4 in pair)


# ---------- 偶部分グラフと非自明文字（既存検査と同じ判定） ----------

boundary = matrix(GF(2), len(vertices), len(edges))
for edge in edges:
    first, second = edge_endpoints_base(edge)
    boundary[vertex_index[first], edge_index[edge]] += 1
    boundary[vertex_index[second], edge_index[edge]] += 1

cycle_space = boundary.right_kernel()
assert cycle_space.dimension() == 10

even_subsets = []
for vector_item in cycle_space:
    subset = frozenset(edges[position]
                       for position in range(len(edges))
                       if vector_item[position] == 1)
    even_subsets.append(subset)
assert len(even_subsets) == 1024


def winding_parities(subset):
    return (
        sum(ZZ(kind == "h" and j == side - 1)
            for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == side - 1)
            for kind, i, j in subset) % 2,
    )


def has_nontrivial_character(single):
    winding_h, winding_v = winding_parities(single)

    def character_edge(edge):
        kind, i, j = edge
        return ZZ((winding_v * (kind == "h" and j == side - 1)
                   + winding_h * (kind == "v" and i == side - 1)) % 2)

    adjacency = {}
    for edge in single:
        first, second = edge_endpoints_base(edge)
        adjacency.setdefault(first, []).append((second, edge))
        adjacency.setdefault(second, []).append((first, edge))

    potential = {}
    for root in sorted(adjacency):
        if root in potential:
            continue
        potential[root] = ZZ(0)
        stack = [root]
        while stack:
            vertex = stack.pop()
            for neighbor, edge in adjacency[vertex]:
                required = ZZ((potential[vertex] + character_edge(edge)) % 2)
                if neighbor not in potential:
                    potential[neighbor] = required
                    stack.append(neighbor)
                elif potential[neighbor] != required:
                    return True
    return False


nontrivial = sorted(
    (subset for subset in even_subsets
     if has_nontrivial_character(subset)),
    key=lambda subset: (len(subset), tuple(sorted(subset))),
)
assert len(nontrivial) == 346


# ---------- (2) 曲がり型頂点の存在の全数検査 ----------

def balanced_orientations(subset):
    """subset の各辺の向き（0: first->second, 1: second->first）を、
    全頂点で入次数=出次数となるように DFS で全列挙する。"""
    ordered = sorted(subset)
    degree = {}
    for edge in ordered:
        for vertex in edge_endpoints_base(edge):
            degree[vertex] = degree.get(vertex, 0) + 1
    assert all(deg % 2 == 0 for deg in degree.values())
    half = {vertex: deg // 2 for vertex, deg in degree.items()}
    remaining = dict(degree)
    in_count = {vertex: 0 for vertex in degree}
    out_count = {vertex: 0 for vertex in degree}
    choice = []

    def feasible(vertex):
        return (in_count[vertex] <= half[vertex]
                and out_count[vertex] <= half[vertex])

    def recurse(position):
        if position == len(ordered):
            yield tuple(choice)
            return
        edge = ordered[position]
        first, second = edge_endpoints_base(edge)
        for orientation in (0, 1):
            tail, head = ((first, second) if orientation == 0
                          else (second, first))
            out_count[tail] += 1
            in_count[head] += 1
            remaining[first] -= 1
            remaining[second] -= 1
            choice.append(orientation)
            if feasible(first) and feasible(second):
                yield from recurse(position + 1)
            choice.pop()
            out_count[tail] -= 1
            in_count[head] -= 1
            remaining[first] += 1
            remaining[second] += 1

    yield from recurse(0)


def oriented_single_edges(subset, orientation_bits):
    return frozenset(
        edge + (orientation,)
        for edge, orientation in zip(sorted(subset), orientation_bits)
    )


def curved_vertices(moved):
    """動辺集合の曲がり型頂点: 入方向二・出方向二が同じ曲がり二方向の頂点。"""
    incoming = {}
    outgoing = {}
    for directed in moved:
        tail, head = endpoints(directed)
        incoming.setdefault(head, []).append(direction(directed))
        outgoing.setdefault(tail, []).append(
            (direction(directed) + 2) % 4)
    result = []
    for vertex in set(incoming) | set(outgoing):
        ins = tuple(sorted(incoming.get(vertex, [])))
        outs_into = outgoing.get(vertex, [])
        outs = tuple(sorted((value + 2) % 4 for value in outs_into))
        if (ins, outs) in matchable_direction_types:
            result.append(vertex)
    return sorted(result)


total_orientation_count = ZZ(0)
for subset in nontrivial:
    orientation_count = ZZ(0)
    for orientation_bits in balanced_orientations(subset):
        orientation_count += 1
        moved = oriented_single_edges(subset, orientation_bits)
        assert len(curved_vertices(moved)) >= 1
    assert orientation_count >= 1
    total_orientation_count += orientation_count
assert total_orientation_count == 2956
print(f"nontrivial-character E: {len(nontrivial)}, "
      f"balanced orientations: {total_orientation_count}, "
      "all with a curved vertex")


# ---------- (3) 辞書式最小の曲がり型頂点での対合の直接検証 ----------

def in_out_lists(moved, vertex):
    incoming = sorted(d for d in moved if endpoints(d)[1] == vertex)
    outgoing = sorted(d for d in moved if endpoints(d)[0] == vertex)
    return incoming, outgoing


def local_bijections(incoming, outgoing):
    return [
        image_tuple for image_tuple in permutations(outgoing)
        if all(image != reversal(source)
               for source, image in zip(incoming, image_tuple))
    ]


def cycle_count(mapping):
    seen = set()
    count = ZZ(0)
    for start in mapping:
        if start in seen:
            continue
        count += 1
        current = start
        while current not in seen:
            seen.add(current)
            current = mapping[current]
    return count


def total_turning(mapping):
    return sum(quarter_turn(direction(source), direction(mapping[source]))
               for source in mapping)


def verify_fiber_involution(moved):
    """動辺集合 moved のファイバーを全展開し、辞書式最小の曲がり型頂点での
    局所交換が符号反転対合であることを検査する。戻り値は置換数。"""
    curved = curved_vertices(moved)
    assert len(curved) >= 1
    pivot = curved[0]

    local = []
    for vertex in vertices:
        incoming, outgoing = in_out_lists(moved, vertex)
        assert len(incoming) == len(outgoing)
        if not incoming:
            continue
        choices = local_bijections(incoming, outgoing)
        if not choices:
            return ZZ(0)
        local.append((vertex, incoming, choices))

    pivot_position = next(position for position, entry in enumerate(local)
                          if entry[0] == pivot)
    assert len(local[pivot_position][2]) == 2

    fiber_size = ZZ(0)
    for selection in product(*[range(len(entry[2])) for entry in local]):
        fiber_size += 1
        mapping = {}
        for (vertex, incoming, choices), chosen in zip(local, selection):
            for source, image in zip(incoming, choices[chosen]):
                mapping[source] = image
        partner_selection = list(selection)
        partner_selection[pivot_position] = 1 - selection[pivot_position]
        partner = {}
        for (vertex, incoming, choices), chosen in zip(local,
                                                       partner_selection):
            for source, image in zip(incoming, choices[chosen]):
                partner[source] = image
        # 不動点なし・対合・動辺集合の保存
        assert partner != mapping
        assert set(partner) == set(mapping) == set(moved)
        # 曲がり型頂点の集合は動辺集合だけで決まるので、交換後も pivot は同じ。
        # 総回転数を保ち、巡回数の偶奇だけが反転する。
        assert total_turning(partner) == total_turning(mapping)
        assert (cycle_count(partner) - cycle_count(mapping)) % 2 == 1
    assert fiber_size % 2 == 0
    return fiber_size


# (3a) D = ∅ の全ファイバー。
empty_key_permutation_count = ZZ(0)
for subset in nontrivial:
    for orientation_bits in balanced_orientations(subset):
        moved = oriented_single_edges(subset, orientation_bits)
        empty_key_permutation_count += verify_fiber_involution(moved)
assert empty_key_permutation_count == 115688
print(f"D=empty fibers: {empty_key_permutation_count} permutations, "
      "all split into sign-reversing pairs")

# (3b) 辞書式最小の非自明文字 E（第 0 行と第 0 列の交差一周路）について、
#      全ての D ⊆ (E の補集合) で曲がり型頂点の集合が E の配向だけで決まること。
#      前 tick（translation-crossing-cycles-local-involution）と同じ鍵族である。
smallest = nontrivial[0]
assert len(smallest) == 6
complement = sorted(set(edges) - set(smallest))
assert len(complement) == 12


def local_bijection_count(moved, vertex):
    incoming, outgoing = in_out_lists(moved, vertex)
    assert len(incoming) == len(outgoing)
    return ZZ(len(local_bijections(incoming, outgoing)))


valid_moved_set_count = ZZ(0)
for doubled_bits in product((0, 1), repeat=len(complement)):
    doubled_oriented = frozenset(
        base + (orientation,)
        for base, included in zip(complement, doubled_bits) if included
        for orientation in (0, 1)
    )
    for orientation_bits in balanced_orientations(smallest):
        single_oriented = oriented_single_edges(smallest, orientation_bits)
        moved = frozenset(single_oriented | doubled_oriented)
        assert curved_vertices(moved) == curved_vertices(single_oriented)
        count = prod(local_bijection_count(moved, vertex)
                     for vertex in vertices)
        if count != 0:
            valid_moved_set_count += 1
            assert count % 2 == 0
assert valid_moved_set_count == 5768
print(f"all D for the smallest E: curved vertices depend only on the "
      f"orientation of E, valid moved sets {valid_moved_set_count}")

# (3c) 反転対 D を持つファイバーの全展開検証。一辺だけの反転対は孤立端で
#      非後退全単射が無くファイバーが空なので、閉路状の D を使う。
for doubled_edge in complement:
    doubled_oriented = {doubled_edge + (0,), doubled_edge + (1,)}
    for orientation_bits in balanced_orientations(smallest):
        moved = frozenset(
            oriented_single_edges(smallest, orientation_bits)
            | doubled_oriented
        )
        count = prod(local_bijection_count(moved, vertex)
                     for vertex in vertices)
        assert count == 0

row_cycle = [("h", 1, j) for j in range(side)]
column_cycle = [("v", i, 1) for i in range(side)]
doubled_families = [row_cycle, column_cycle, row_cycle + column_cycle]
doubled_permutation_count = ZZ(0)
for family in doubled_families:
    doubled_oriented = frozenset(
        base + (orientation,)
        for base in family
        for orientation in (0, 1)
    )
    for orientation_bits in balanced_orientations(smallest):
        single_oriented = oriented_single_edges(smallest, orientation_bits)
        moved = frozenset(single_oriented | doubled_oriented)
        assert curved_vertices(moved) == curved_vertices(single_oriented)
        doubled_permutation_count += verify_fiber_involution(moved)
assert doubled_permutation_count == 696
print(f"cycle-shaped doubled fibers for the smallest E: "
      f"{doubled_permutation_count} permutations, "
      "all split into sign-reversing pairs")

print("PASS: translation-nontrivial-key-curved-vertex-involution")
