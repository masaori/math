"""未被覆ファイバーに平行移動と可換な符号反転完全マッチングを構成する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の単一の偶部分グラフでは覆えない 16 ファイバーは、平行移動による
大きさ 4 の軌道を 4 本なす。全ての位相反転候補を保持した無向候補グラフで、
各軌道の代表に完全マッチングを一つ構成し、それを平行移動で残りへ運ぶ。
得られた 16 個の完全マッチングが候補辺だけを使い、全置換を一度ずつ覆い、
全ての平行移動と可換であることを有限集合の等号だけで検査する。
"""

load("sagemath/check/even-subgraph-orbit-collision-forest-context/check.sage")


def perfect_matching_pairs(fiber_key):
    keys = {permutation_key(phi): phi for phi in all_fibers[fiber_key]}
    positive = {
        key for key, phi in keys.items()
        if phase_contribution(phi, 0, 0) == K8(1)
    }
    negative = set(keys) - positive
    assert len(positive) == len(negative)

    adjacency = {key: set() for key in positive}
    for source, target in all_phase_edges_by_fiber[fiber_key]:
        if source in positive and target in negative:
            adjacency[source].add(target)
        if target in positive and source in negative:
            adjacency[target].add(source)

    matched_right = {}

    def augment(left, seen):
        for right in sorted(adjacency[left]):
            if right in seen:
                continue
            seen.add(right)
            if right not in matched_right or augment(matched_right[right], seen):
                matched_right[right] = left
                return True
        return False

    for left in sorted(positive):
        assert augment(left, set())
    assert len(matched_right) == len(positive)
    return {
        frozenset({left, right}) for right, left in matched_right.items()
    }


def translate_permutation_key(a, b, key):
    return permutation_key(translate_permutation(a, b, permutation_from_key(key)))


def translate_matching(a, b, matching):
    return {
        frozenset(translate_permutation_key(a, b, key) for key in pair)
        for pair in matching
    }


representatives = sorted(
    orbit_representatives,
    key=lambda key: (sorted(key[0]), sorted(key[1])),
)
matching_by_fiber = {}
representative_pair_count_distribution = {}
for representative in representatives:
    representative_matching = perfect_matching_pairs(representative)
    pair_count = len(representative_matching)
    representative_pair_count_distribution[pair_count] = (
        representative_pair_count_distribution.get(pair_count, 0) + 1
    )
    for a in range(L):
        for b in range(L):
            fiber_key = translate_fiber_key(a, b, representative)
            assert fiber_key not in matching_by_fiber
            matching_by_fiber[fiber_key] = translate_matching(
                a, b, representative_matching
            )


pair_count_distribution = {}
total_pairs = 0
for fiber_key, matching in matching_by_fiber.items():
    candidate_pairs = {
        frozenset({source, target})
        for source, target in all_phase_edges_by_fiber[fiber_key]
    }
    fiber_vertices = {
        permutation_key(phi) for phi in all_fibers[fiber_key]
    }
    matched_vertices = [key for pair in matching for key in pair]
    assert matching.issubset(candidate_pairs)
    assert len(matched_vertices) == len(set(matched_vertices))
    assert set(matched_vertices) == fiber_vertices
    pair_count = len(matching)
    pair_count_distribution[pair_count] = pair_count_distribution.get(pair_count, 0) + 1
    total_pairs += pair_count


covariant_matching_count = 0
for fiber_key, matching in matching_by_fiber.items():
    for a in range(L):
        for b in range(L):
            translated_fiber_key = translate_fiber_key(a, b, fiber_key)
            assert translate_matching(a, b, matching) == matching_by_fiber[translated_fiber_key]
            covariant_matching_count += 1


print(f"translation-orbit representatives: {len(representatives)}")
print(f"representative matching pair-count distribution: "
      f"{sorted(representative_pair_count_distribution.items())}")
print(f"fibers with transported perfect matching: {len(matching_by_fiber)}")
print(f"matching pair-count distribution: {sorted(pair_count_distribution.items())}")
print(f"total matched pairs: {total_pairs}")
print(f"covariant matching comparisons: {covariant_matching_count}")

assert len(representatives) == 4
assert representative_pair_count_distribution == {4: 1, 12: 2, 324: 1}
assert len(matching_by_fiber) == 16
assert pair_count_distribution == {4: 4, 12: 8, 324: 4}
assert total_pairs == 1408
assert covariant_matching_count == 64

print("PASS: even-subgraph-orbit-translation-covariant-matching")
