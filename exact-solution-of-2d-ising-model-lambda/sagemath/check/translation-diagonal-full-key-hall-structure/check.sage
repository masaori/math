"""一辺三の全辺鍵で、Hall 障害を担う対角固定置換の局所形を分類する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

前段（translation-diagonal-full-key-fixed-permutation-matching）で、対角固定置換
80 個の候補二部グラフに完全マッチングが無く、|S|=32, |N(S)|=8 の Hall 障害が
あることを固定した。ここでは障害の由来を特定するため、固定置換を
「不変氷型配向（動く辺集合）」と「位相ベクトル」で分類し、候補辺が使う
偶部分グラフ H を対角不変な辺軌道和の全列挙と突き合わせる。

さらに、位相ベクトルが二値（v0 と -v0）に退化していることを確かめ、
正側と負側の任意の全単射が位相反転対を与えること（固定点上ではどの全単射も
対角平行移動と自明に可換である）を、実際に一つ構成して検証する。

計算は有限集合・有限写像と Q(zeta8) の等号だけで行う。浮動小数点は使わない。
"""

load("sagemath/check/translation-diagonal-full-key-fixed-permutation-matching/check.sage")


def diagonal_translate_base(side, base, times):
    kind, i, j = base
    return (kind, (i + times) % side, (j + times) % side)


# 固定置換を不変氷型配向（動く辺集合）で分類する。配向は 10 個で、
# 各配向にちょうど 2^3 = 8 個の固定置換（頂点軌道ごとの対応の選択）が載る。
orientation_of = {key: frozenset(by_key[key]) for key in by_key}
orientations = sorted({orientation_of[key] for key in by_key}, key=sorted)
assert len(orientations) == 10
per_orientation = {orientation: [] for orientation in orientations}
for key in by_key:
    per_orientation[orientation_of[key]].append(key)
assert all(len(keys_on) == 8 for keys_on in per_orientation.values())

# 各配向上の正位相・負位相の個数分布。
sign_split = {}
for orientation, keys_on in per_orientation.items():
    positives = sum(1 for key in keys_on if key in positive)
    sign_split[orientation] = (positives, len(keys_on) - positives)
split_distribution = {}
for split in sign_split.values():
    split_distribution[split] = split_distribution.get(split, 0) + 1
print(f"orientation sign splits (positive, negative): {split_distribution}")
assert split_distribution == {(4, 4): 10}

# 候補辺が使える H は、対角不変（辺軌道の和）かつ偶部分グラフかつ
# 巻き付き文字が非自明なものに限る。全列挙して個数を確定する。
edge_orbits = diagonal_edge_orbits(side)
all_base_edges = frozenset(base_edge_list(side))
available_h = []
for bits in product((0, 1), repeat=len(edge_orbits)):
    subset = frozenset(
        base for bit, orbit in zip(bits, edge_orbits) if bit for base in orbit
    )
    if not subset:
        continue
    if not is_even_subset(side, subset):
        continue
    if winding_pairing(side, all_base_edges, subset) != 1:
        continue
    available_h.append(subset)
print(f"available diagonal-invariant odd-winding even H: {len(available_h)}")
assert len(available_h) == 8
assert all(len(subset) == 9 for subset in available_h)

# 候補辺が実際に使った H を分類する。全て対角不変であることも確かめる。
used_h = {}
for (left, right), (source_key, subset) in witness.items():
    shifted = frozenset(
        diagonal_translate_base(side, base, 1) for base in subset
    )
    assert shifted == subset
    assert subset in set(available_h)
    used_h[subset] = used_h.get(subset, 0) + 1
print(f"H actually used by candidate edges: "
      f"{sorted((len(subset), count) for subset, count in used_h.items())}")
assert set(used_h) == set(available_h)
used_h_counts = {}
for count in used_h.values():
    used_h_counts[count] = used_h_counts.get(count, 0) + 1
assert used_h_counts == {44: 6, 52: 2}

# 配向水準の候補グラフ: 候補辺 {u,v} は配向を H 上の反転で移すので、
# 配向対ごとに候補辺の本数を数える。
orientation_index = {orientation: index
                     for index, orientation in enumerate(orientations)}
orientation_pair_counts = {}
for (left, right) in witness:
    pair = tuple(sorted(
        (orientation_index[orientation_of[left]],
         orientation_index[orientation_of[right]])
    ))
    orientation_pair_counts[pair] = orientation_pair_counts.get(pair, 0) + 1
orientation_degrees = {index: 0 for index in range(len(orientations))}
for (first, second), count in orientation_pair_counts.items():
    orientation_degrees[first] += 1
    if second != first:
        orientation_degrees[second] += 1
print(f"orientation-level candidate pairs: {len(orientation_pair_counts)}")
print(f"orientation-level degrees: {sorted(orientation_degrees.values())}")
assert len(orientation_pair_counts) == 16
assert sorted(orientation_degrees.values()) == [2] * 8 + [8, 8]
hub_orientations = {
    orientations[index] for index, degree in orientation_degrees.items()
    if degree == 8
}
assert len(hub_orientations) == 2

# Hall 集合 S と近傍 N(S) の配向・位相の内訳。
hall_orientations = {orientation_of[key] for key in hall_left}
neighbor_orientations = {orientation_of[key] for key in hall_right}
matched_orientations = {orientation_of[key] for key in matched_vertices}
print(f"orientations touched by S: {len(hall_orientations)}, "
      f"by N(S): {len(neighbor_orientations)}, "
      f"by matched vertices: {len(matched_orientations)}")
assert len(hall_orientations) == 8
assert hall_orientations == set(orientations) - hub_orientations
assert neighbor_orientations == hub_orientations
assert len(matched_orientations) == 5

hall_left_per_orientation = {}
for key in hall_left:
    orientation = orientation_of[key]
    hall_left_per_orientation[orientation] = (
        hall_left_per_orientation.get(orientation, 0) + 1
    )
print(f"S per orientation: {sorted(hall_left_per_orientation.values())}")
assert sorted(hall_left_per_orientation.values()) == [4] * 8

hall_right_per_orientation = {}
for key in hall_right:
    orientation = orientation_of[key]
    hall_right_per_orientation[orientation] = (
        hall_right_per_orientation.get(orientation, 0) + 1
    )
print(f"N(S) per orientation: {sorted(hall_right_per_orientation.values())}")
assert sorted(hall_right_per_orientation.values()) == [4, 4]

# 位相ベクトルの内訳。
vector_counts = {}
for key in by_key:
    vector = phase_vector(side, by_key[key])
    vector_counts[vector] = vector_counts.get(vector, 0) + 1
print(f"distinct phase vectors: {len(vector_counts)}, "
      f"counts: {sorted(vector_counts.values())}")
hall_left_vectors = {}
for key in hall_left:
    vector = phase_vector(side, by_key[key])
    hall_left_vectors[vector] = hall_left_vectors.get(vector, 0) + 1
hall_right_vectors = {}
for key in hall_right:
    vector = phase_vector(side, by_key[key])
    hall_right_vectors[vector] = hall_right_vectors.get(vector, 0) + 1
print(f"phase vectors in S: {len(hall_left_vectors)} "
      f"({sorted(hall_left_vectors.values())}), "
      f"in N(S): {len(hall_right_vectors)} "
      f"({sorted(hall_right_vectors.values())})")
assert sorted(vector_counts.values()) == [40, 40]
assert sorted(hall_left_vectors.values()) == [32]
assert sorted(hall_right_vectors.values()) == [8]

# 位相ベクトルは二値 {v0, -v0} に退化している。正側は全員 v0、負側は全員 -v0。
positive_vectors = {phase_vector(side, by_key[key]) for key in positive}
negative_vectors = {phase_vector(side, by_key[key]) for key in negative}
assert len(positive_vectors) == 1
assert len(negative_vectors) == 1
base_vector = next(iter(positive_vectors))
assert next(iter(negative_vectors)) == tuple(
    -component for component in base_vector
)
print(f"two-valued phase vector: v0 = {base_vector}")

# 従って、正側と負側の任意の全単射が位相反転対を与える。固定点上では
# どの全単射も対角平行移動と自明に可換である（両端が固定点だから、
# 平行移動で対を運んでも同じ対に戻る）。整列順の全単射を一つ構成して検証する。
direct_pairs = list(zip(sorted(positive, key=sorted), sorted(negative, key=sorted)))
assert len(direct_pairs) == 40
for left, right in direct_pairs:
    assert phase_vector(side, by_key[right]) == tuple(
        -component for component in phase_vector(side, by_key[left])
    )
print(f"direct phase-reversing bijection on fixed points: {len(direct_pairs)} pairs")

# 正側・負側の次数分布。
positive_degrees = {}
for key in positive:
    degree = len(adjacency[key])
    positive_degrees[degree] = positive_degrees.get(degree, 0) + 1
negative_degree_of = {key: 0 for key in negative}
for targets in adjacency.values():
    for key in targets:
        negative_degree_of[key] += 1
negative_degrees = {}
for degree in negative_degree_of.values():
    negative_degrees[degree] = negative_degrees.get(degree, 0) + 1
print(f"positive degree distribution: {sorted(positive_degrees.items())}")
print(f"negative degree distribution: {sorted(negative_degrees.items())}")
assert sorted(positive_degrees.items()) == [(4, 12), (6, 12), (8, 8), (14, 2), (26, 6)]
assert sorted(negative_degrees.items()) == [(4, 12), (6, 12), (8, 8), (14, 2), (26, 6)]

print("PASS: translation-diagonal-full-key-hall-structure")
