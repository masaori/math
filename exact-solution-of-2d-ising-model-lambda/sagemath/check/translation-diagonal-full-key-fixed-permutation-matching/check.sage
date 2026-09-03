"""一辺三の全辺鍵で、対角固定置換だけの位相反転候補グラフを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

全辺鍵 (D,E)=(空集合,E_3) の対角固定置換について、偶部分グラフ H に沿う
頂点組み替えで互いに移る二置換を候補辺で結ぶ。H の巻き付き文字は非自明、
四つのスピン構造の位相寄与は全て反転するものに限る。固定置換だけからなる
有限二部グラフを作り、完全マッチングの有無を判定する。

二置換の動く向き付き辺集合の差から H は一意に決まる。H 外から H 外への
遷移が保たれていれば、残る遷移は各頂点で自由な到着と出発を結ぶ全単射であり、
既に非後退置換である候補置換そのものが頂点組み替えの一候補になる。
計算は有限集合・有限写像と Q(zeta8) の等号だけで行う。
"""

load("sagemath/check/translation-diagonal-full-key-fixed-permutation-phase/check.sage")


def base_edge(edge):
    return edge[:3]


def selection_edge_endpoints(side, edge):
    kind, i, j = edge
    return ((i, j),
            (i, (j + 1) % side) if kind == "h" else ((i + 1) % side, j))


def is_even_subset(side, subset):
    degree = {}
    for edge in subset:
        for vertex in selection_edge_endpoints(side, edge):
            degree[vertex] = degree.get(vertex, 0) + 1
    return all(value % 2 == 0 for value in degree.values())


def winding_parities(side, subset):
    return (
        sum(ZZ(kind == "h" and j == side - 1) for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == side - 1) for kind, i, j in subset) % 2,
    )


def winding_pairing(side, first, second):
    first_h, first_v = winding_parities(side, first)
    second_h, second_v = winding_parities(side, second)
    return ZZ((first_h * second_v + first_v * second_h) % 2)


def moved_by_base(phi):
    return {base_edge(edge): edge for edge in phi}


def rewiring_witness(side, source, target):
    """候補なら一意な H を返し、そうでなければ None を返す。"""
    source_moved = moved_by_base(source)
    target_moved = moved_by_base(target)
    assert set(source_moved) == set(target_moved) == set(base_edge_list(side))
    subset = frozenset(
        base for base in source_moved
        if target_moved[base] == reversal(source_moved[base])
    )
    if any(
        target_moved[base] not in (edge, reversal(edge))
        for base, edge in source_moved.items()
    ):
        return None
    if not is_even_subset(side, subset):
        return None
    all_edges = frozenset(base_edge_list(side))
    if winding_pairing(side, all_edges, subset) != 1:
        return None
    for edge, image in source.items():
        if base_edge(edge) not in subset and base_edge(image) not in subset:
            if target.get(edge) != image:
                return None
    return subset


side = 3
_, fixed_permutations = invariant_fixed_permutations(side)
keys = [frozenset(phi.items()) for phi in fixed_permutations]
by_key = dict(zip(keys, fixed_permutations))
positive = {
    key for key, phi in by_key.items()
    if phase_vector(side, phi)[0] == K8(1)
}
negative = set(keys) - positive
assert all(phase_vector(side, phi)[0] in (K8(1), K8(-1)) for phi in by_key.values())
assert len(positive) == len(negative)

adjacency = {key: set() for key in positive}
witness = {}
directed_candidates = 0
for source_key, source in by_key.items():
    for target_key, target in by_key.items():
        if source_key == target_key:
            continue
        subset = rewiring_witness(side, source, target)
        if subset is None:
            continue
        if phase_vector(side, target) != tuple(-value for value in phase_vector(side, source)):
            continue
        directed_candidates += 1
        assert (source_key in positive) != (target_key in positive)
        if source_key in positive:
            left, right = source_key, target_key
        else:
            left, right = target_key, source_key
        adjacency[left].add(right)
        witness.setdefault((left, right), (source_key, subset))

matched_right = {}


def augment(left, seen_right):
    for right in sorted(adjacency[left], key=sorted):
        if right in seen_right:
            continue
        seen_right.add(right)
        if right not in matched_right or augment(matched_right[right], seen_right):
            matched_right[right] = left
            return True
    return False


for left in sorted(positive, key=sorted):
    augment(left, set())

matching = {(left, right) for right, left in matched_right.items()}
matched_vertices = {key for pair in matching for key in pair}
undirected_candidates = sum(len(targets) for targets in adjacency.values())
isolated_positive = sum(not adjacency[key] for key in positive)
reached_negative = set().union(*adjacency.values()) if adjacency else set()
isolated_negative = len(negative - reached_negative)

# 未対応の正側頂点から非対応辺を正→負、対応辺を負→正に辿る。到達した
# 正側集合 S とその近傍 N(S) が |N(S)|<|S| を満たせば、Hall の必要条件により
# 完全マッチングは存在しない。
matched_left = {left: right for right, left in matched_right.items()}
hall_left = set(positive - set(matched_left))
hall_right = set()
frontier = list(hall_left)
while frontier:
    left = frontier.pop()
    for right in adjacency[left]:
        if matched_left.get(left) == right or right in hall_right:
            continue
        hall_right.add(right)
        if right in matched_right and matched_right[right] not in hall_left:
            hall_left.add(matched_right[right])
            frontier.append(matched_right[right])
assert hall_right == set().union(*(adjacency[left] for left in hall_left))

for left, right in matching:
    source_key, subset = witness[(left, right)]
    target_key = right if source_key == left else left
    assert rewiring_witness(side, by_key[source_key], by_key[target_key]) == subset
    assert phase_vector(side, by_key[right]) == tuple(
        -value for value in phase_vector(side, by_key[left])
    )

assert len(keys) == 80
assert (len(positive), len(negative)) == (40, 40)
assert directed_candidates == 416
assert undirected_candidates == 368
assert (isolated_positive, isolated_negative) == (0, 0)
assert len(matching) == 16
assert len(matched_vertices) == 32
assert (len(hall_left), len(hall_right)) == (32, 8)

print(f"L={side}: fixed vertices {len(keys)} "
      f"(positive {len(positive)}, negative {len(negative)})")
print(f"directed candidates {directed_candidates}, "
      f"undirected candidates {undirected_candidates}")
print(f"isolated vertices by side: {isolated_positive}, {isolated_negative}")
print(f"maximum matching pairs {len(matching)}, covered vertices {len(matched_vertices)}")
print(f"Hall obstruction: |S|={len(hall_left)}, |N(S)|={len(hall_right)}")
print("PASS: translation-diagonal-full-key-fixed-permutation-matching")
