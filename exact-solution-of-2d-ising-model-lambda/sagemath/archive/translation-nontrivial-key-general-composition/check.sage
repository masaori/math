"""非自明文字鍵の K=U=0 を一般の辺長で閉じる合成を、一辺四・五の標本で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

一般の辺長 L の鍵 (D,E)（D,E は基底辺集合の互いに素な部分集合、E は偶部分グラフ）
で選択文字が非自明なものについて、四つのねじれ (a,b) 全てで
K^{a,b}_L(D,E) = U^{a,b}_L(D,E) = 0 を閉じる論法は、次の合成である。

(U 側) 選択和は文字評価により、非自明文字なら零になる
    （claim_selection_sum_character_evaluation。辺長に依存しない）。

(K 側) 次の五段の合成で、ファイバー全体が符号反転対へ分かれる。
  (i)   ファイバーの各置換は、各頂点での入辺から出辺への非後退全単射の積である。
        反転対辺 D は各端点へ入と出を一本ずつ与えるので、単純通過部分は
        E の均衡配向（各頂点で入次数=出次数）を誘導する（辺長に依存しない）。
  (ii)  非自明文字の E の全ての均衡配向には曲がり型の次数 4 頂点が存在する
        （translation-nontrivial-character-forces-curved-vertex の一般証明）。
  (iii) 曲がり型頂点は E の次数 4 頂点の曲がり配向に限り、D に依存しない。
        反転対辺は同じ頂点へ入方向 d と出方向 d+2 を同時に与えるが、
        曲がり二方向の対 {c, c+1} はこの二方向を同時に含めない（記号的・局所的）。
  (iv)  曲がり型頂点の非後退局所全単射はちょうど 2 つで、交換は両位置を入れ替える
        互換であり、四半回転和を保つ（記号的・局所的）。
  (v)   辞書式最小の曲がり型頂点での交換は、動辺集合を保つので曲がり型頂点集合と
        辞書式最小の選択を保ち、不動点のない対合になる。ねじれ符号の積は後続辺の
        多重集合（=動辺集合）だけで決まり保たれ、回転積は (iv) で保たれ、
        互換の合成で巡回数の偶奇だけが反転する。従って位相ベクトルは反転し、
        ファイバーの位相和は四つのねじれ全てで零になる。

(i)(iii)(iv) は辺長に依存しない記号的・局所的事実、(ii) は一般証明済みなので、
合成は全ての辺長で成立する。検査では、(iii)(iv) の局所分類を記号的に固定し、
既検査の一辺三を越える標本として一辺四（偶数辺長。偶部分グラフ 131,072 個の
文字全数調査と、非自明文字で辺数 8 以下の全て = 交差一周路対 16 個）と一辺五
（交差一周路対）について、D = 空集合と閉路状の反転対 D のファイバーを全展開し、
対合の符号反転・位相和の零・選択和の零を等号 assert で固定する。
計算は有限集合・有限写像と Q(zeta8) の等号だけで行い、浮動小数点を使わない。
"""

from itertools import combinations, permutations, product

K8 = CyclotomicField(8)
zeta8 = K8.gen()


def base_edges(side):
    return [(kind, i, j)
            for kind in ("h", "v")
            for i in range(side)
            for j in range(side)]


def edge_endpoints_base(side, edge):
    kind, i, j = edge
    if kind == "h":
        return (i, j), (i, (j + 1) % side)
    return (i, j), ((i + 1) % side, j)


def reversal(directed):
    kind, i, j, orientation = directed
    return (kind, i, j, 1 - orientation)


def endpoints(side, directed):
    kind, i, j, orientation = directed
    first, second = edge_endpoints_base(side, (kind, i, j))
    return (first, second) if orientation == 0 else (second, first)


def direction(directed):
    kind, _, _, orientation = directed
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[
        (kind, orientation)]


def quarter_turn(first_direction, second_direction):
    difference = (second_direction - first_direction) % 4
    assert difference in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[difference]


def seam_parities(side, base_edge):
    kind, i, j = base_edge
    return (ZZ(kind == "h" and j == side - 1),
            ZZ(kind == "v" and i == side - 1))


# ---------- (iii)(iv) 辺長に依存しない記号的な局所分類 ----------

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

# (iii) 反転対辺は同じ頂点へ入方向 d と出方向 (d+2)%4 を同時に与えるが、
#       曲がり二方向の対はこの二方向を同時に含めない。
for pair in curved_pairs:
    for d in range(4):
        assert not (d in pair and (d + 2) % 4 in pair)

# (iv) 曲がり型では非後退な局所全単射がちょうど 2 つで、交換は両位置を
#      入れ替える互換であり、四半回転和が等しい。
for pair in curved_pairs:
    choices = [
        image_tuple for image_tuple in permutations(pair)
        if all((image - source) % 4 != 2
               for source, image in zip(pair, image_tuple))
    ]
    assert len(choices) == 2
    first, second = choices
    assert first[0] != second[0] and first[1] != second[1]
    assert (sum(quarter_turn(source, image)
                for source, image in zip(pair, first))
            == sum(quarter_turn(source, image)
                   for source, image in zip(pair, second)))


# ---------- 偶部分グラフと非自明文字（既存検査と同じ判定。辺長を引数化） ----------

def winding_parities(side, subset):
    return (
        sum(ZZ(kind == "h" and j == side - 1)
            for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == side - 1)
            for kind, i, j in subset) % 2,
    )


def has_nontrivial_character(side, single):
    winding_h, winding_v = winding_parities(side, single)

    def character_edge(edge):
        kind, i, j = edge
        return ZZ((winding_v * (kind == "h" and j == side - 1)
                   + winding_h * (kind == "v" and i == side - 1)) % 2)

    adjacency = {}
    for edge in single:
        first, second = edge_endpoints_base(side, edge)
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


# ---------- 均衡配向・曲がり型頂点・位相つきのファイバー対合 ----------

def balanced_orientations(side, subset):
    ordered = sorted(subset)
    degree = {}
    for edge in ordered:
        for vertex in edge_endpoints_base(side, edge):
            degree[vertex] = degree.get(vertex, 0) + 1
    assert all(deg % 2 == 0 for deg in degree.values())
    half = {vertex: deg // 2 for vertex, deg in degree.items()}
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
        first, second = edge_endpoints_base(side, edge)
        for orientation in (0, 1):
            tail, head = ((first, second) if orientation == 0
                          else (second, first))
            out_count[tail] += 1
            in_count[head] += 1
            choice.append(orientation)
            if feasible(first) and feasible(second):
                yield from recurse(position + 1)
            choice.pop()
            out_count[tail] -= 1
            in_count[head] -= 1

    yield from recurse(0)


def oriented_single_edges(subset, orientation_bits):
    return frozenset(
        edge + (orientation,)
        for edge, orientation in zip(sorted(subset), orientation_bits)
    )


def curved_vertices(side, moved):
    incoming = {}
    outgoing = {}
    for directed in moved:
        tail, head = endpoints(side, directed)
        incoming.setdefault(head, []).append(direction(directed))
        outgoing.setdefault(tail, []).append(direction(directed))
    result = []
    for vertex in set(incoming) | set(outgoing):
        ins = tuple(sorted(incoming.get(vertex, [])))
        outs = tuple(sorted(outgoing.get(vertex, [])))
        if (ins, outs) in matchable_direction_types:
            result.append(vertex)
    return sorted(result)


def in_out_lists(side, moved, vertex):
    incoming = sorted(d for d in moved if endpoints(side, d)[1] == vertex)
    outgoing = sorted(d for d in moved if endpoints(side, d)[0] == vertex)
    return incoming, outgoing


def local_bijections(incoming, outgoing):
    return [
        image_tuple for image_tuple in permutations(outgoing)
        if all(image != reversal(source)
               for source, image in zip(incoming, image_tuple))
    ]


def moved_orbits(mapping):
    seen = set()
    orbits = []
    for start in sorted(mapping):
        if start in seen:
            continue
        walk = []
        current = start
        while current not in seen:
            seen.add(current)
            walk.append(current)
            current = mapping[current]
        orbits.append(walk)
    return orbits


def phase_vector(side, mapping):
    orbits = moved_orbits(mapping)
    values = []
    for a in (0, 1):
        for b in (0, 1):
            value = K8(1)
            for walk in orbits:
                orbit_product = K8(1)
                for edge in walk:
                    successor = mapping[edge]
                    assert successor != reversal(edge)
                    turn = (direction(successor) - direction(edge)) % 4
                    rotation = {0: K8(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]
                    ch, cv = seam_parities(side, successor[:3])
                    twist = K8(ZZ(-1) ** (a * ch + b * cv))
                    orbit_product *= twist * rotation
                value *= -orbit_product
            values.append(value)
    return tuple(values)


def verify_fiber_involution_with_phases(side, moved):
    """動辺集合 moved のファイバーを全展開し、辞書式最小の曲がり型頂点での
    局所交換が位相ベクトルを反転する不動点のない対合であることを検査する。
    戻り値は (置換数, 四つのねじれの位相和)。"""
    curved = curved_vertices(side, moved)
    assert len(curved) >= 1
    pivot = curved[0]

    touched = sorted({vertex
                      for directed in moved
                      for vertex in endpoints(side, directed)})
    local = []
    for vertex in touched:
        incoming, outgoing = in_out_lists(side, moved, vertex)
        assert len(incoming) == len(outgoing)
        if not incoming:
            continue
        choices = local_bijections(incoming, outgoing)
        if not choices:
            return ZZ(0), (K8(0), K8(0), K8(0), K8(0))
        local.append((vertex, incoming, choices))

    pivot_position = next(position for position, entry in enumerate(local)
                          if entry[0] == pivot)
    assert len(local[pivot_position][2]) == 2

    fiber_size = ZZ(0)
    phase_sums = [K8(0), K8(0), K8(0), K8(0)]
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
        assert partner != mapping
        assert set(partner) == set(mapping) == set(moved)
        # 動辺集合が保たれるので曲がり型頂点集合と辞書式最小の選択も保たれる。
        assert curved_vertices(side, set(partner)) == curved
        vector = phase_vector(side, mapping)
        partner_vector = phase_vector(side, partner)
        assert partner_vector == tuple(-value for value in vector)
        phase_sums = [phase_sums[index] + vector[index] for index in range(4)]
    assert fiber_size % 2 == 0
    return fiber_size, tuple(phase_sums)


def selection_sums(side, subset):
    """E = subset の鍵の選択和（H と E−H がともに偶）の四つのねじれでの値。"""

    def is_even(edge_subset):
        degrees = {}
        for edge in edge_subset:
            for vertex in edge_endpoints_base(side, edge):
                degrees[vertex] = degrees.get(vertex, 0) + 1
        return all(deg % 2 == 0 for deg in degrees.values())

    def sign(a, b, edge_subset):
        horizontal, vertical = winding_parities(side, edge_subset)
        exponent = ((1 + a) * horizontal + (1 + b) * vertical
                    + horizontal * vertical)
        return ZZ(-1) ** exponent

    parts = [frozenset(chosen)
             for chosen in Subsets(set(subset))
             if is_even(chosen) and is_even(set(subset) - set(chosen))]
    values = []
    for a in (0, 1):
        for b in (0, 1):
            values.append(sum((sign(a, b, chosen)
                               * sign(a, b, frozenset(subset) - chosen)
                               for chosen in parts), ZZ(0)))
    return tuple(values)


def crossing_pair(side, row, column):
    return frozenset(
        [("h", row, j) for j in range(side)]
        + [("v", i, column) for i in range(side)]
    )


def doubled_families(side):
    row_cycle = [("h", 1, j) for j in range(side)]
    column_cycle = [("v", i, 1) for i in range(side)]
    return [row_cycle, column_cycle, row_cycle + column_cycle]


# ---------- 一辺四: 偶部分グラフの文字全数調査と、辺数 8 以下の全数検証 ----------

side = 4
edges4 = base_edges(side)
edge_index4 = {edge: position for position, edge in enumerate(edges4)}
vertices4 = [(i, j) for i in range(side) for j in range(side)]
vertex_index4 = {vertex: position for position, vertex in enumerate(vertices4)}

boundary4 = matrix(GF(2), len(vertices4), len(edges4))
for edge in edges4:
    first, second = edge_endpoints_base(side, edge)
    boundary4[vertex_index4[first], edge_index4[edge]] += 1
    boundary4[vertex_index4[second], edge_index4[edge]] += 1

cycle_space4 = boundary4.right_kernel()
assert cycle_space4.dimension() == 17

nontrivial4_count = ZZ(0)
small_nontrivial4 = []
for vector_item in cycle_space4:
    subset = frozenset(edges4[position]
                       for position in range(len(edges4))
                       if vector_item[position] == 1)
    if has_nontrivial_character(side, subset):
        nontrivial4_count += 1
        if len(subset) <= 8:
            small_nontrivial4.append(subset)
assert nontrivial4_count == 50320

# 辺数 8 以下の非自明文字は交差一周路対 16 個に限る。
expected_pairs = {crossing_pair(side, row, column)
                  for row in range(side) for column in range(side)}
assert set(small_nontrivial4) == expected_pairs
assert len(small_nontrivial4) == 16
print(f"L=4: nontrivial-character even subgraphs {nontrivial4_count}, "
      f"|E|<=8 gives exactly the {len(small_nontrivial4)} crossing pairs")

# D = 空集合の全ファイバー: 対合と位相和零。選択和も零。
empty4_permutations = ZZ(0)
for subset in sorted(small_nontrivial4,
                     key=lambda item: tuple(sorted(item))):
    orientation_count = ZZ(0)
    for orientation_bits in balanced_orientations(side, subset):
        orientation_count += 1
        moved = oriented_single_edges(subset, orientation_bits)
        count, sums = verify_fiber_involution_with_phases(side, moved)
        empty4_permutations += count
        assert sums == (K8(0), K8(0), K8(0), K8(0))
    assert orientation_count == 4
    assert selection_sums(side, subset) == (ZZ(0), ZZ(0), ZZ(0), ZZ(0))
assert empty4_permutations == 128
print(f"L=4: D=empty fibers over the 16 crossing pairs, "
      f"{empty4_permutations} permutations, phase sums all zero")

# 辞書式最小の交差対に閉路状の反転対 D を付けたファイバー。
smallest4 = min(small_nontrivial4, key=lambda item: tuple(sorted(item)))
assert smallest4 == crossing_pair(side, 0, 0)
doubled4_permutations = ZZ(0)
for family in doubled_families(side):
    doubled_oriented = frozenset(
        base + (orientation,)
        for base in family
        for orientation in (0, 1)
    )
    for orientation_bits in balanced_orientations(side, smallest4):
        single_oriented = oriented_single_edges(smallest4, orientation_bits)
        moved = frozenset(single_oriented | doubled_oriented)
        assert (curved_vertices(side, moved)
                == curved_vertices(side, single_oriented))
        count, sums = verify_fiber_involution_with_phases(side, moved)
        doubled4_permutations += count
        assert sums == (K8(0), K8(0), K8(0), K8(0))
assert doubled4_permutations == 696
print(f"L=4: cycle-shaped doubled fibers for the smallest crossing pair, "
      f"{doubled4_permutations} permutations, phase sums all zero")

# ---------- 一辺五: 交差一周路対の標本検証 ----------

side = 5
smallest5 = crossing_pair(side, 0, 0)
assert has_nontrivial_character(side, smallest5)
empty5_permutations = ZZ(0)
orientation_count = ZZ(0)
for orientation_bits in balanced_orientations(side, smallest5):
    orientation_count += 1
    moved = oriented_single_edges(smallest5, orientation_bits)
    count, sums = verify_fiber_involution_with_phases(side, moved)
    empty5_permutations += count
    assert sums == (K8(0), K8(0), K8(0), K8(0))
assert orientation_count == 4
assert empty5_permutations == 8
assert selection_sums(side, smallest5) == (ZZ(0), ZZ(0), ZZ(0), ZZ(0))

doubled5_permutations = ZZ(0)
for family in doubled_families(side):
    doubled_oriented = frozenset(
        base + (orientation,)
        for base in family
        for orientation in (0, 1)
    )
    for orientation_bits in balanced_orientations(side, smallest5):
        single_oriented = oriented_single_edges(smallest5, orientation_bits)
        moved = frozenset(single_oriented | doubled_oriented)
        assert (curved_vertices(side, moved)
                == curved_vertices(side, single_oriented))
        count, sums = verify_fiber_involution_with_phases(side, moved)
        doubled5_permutations += count
        assert sums == (K8(0), K8(0), K8(0), K8(0))
assert doubled5_permutations == 696
print(f"L=5: crossing pair, D=empty {empty5_permutations} and cycle-shaped "
      f"doubled {doubled5_permutations} permutations, phase sums all zero")

print("PASS: translation-nontrivial-key-general-composition")
