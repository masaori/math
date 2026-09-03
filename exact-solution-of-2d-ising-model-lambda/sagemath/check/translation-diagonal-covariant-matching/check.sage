"""対角平行移動部分群と可換な符号反転完全マッチング族を全 64 鍵に構成する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の一様被覆検査の対象（巻き付き文字が非自明で有効な偶部分グラフ H を
持つ）全 64 ファイバー鍵の上で、対角平行移動部分群 {(0,0), (1,1)} の作用が
自由であることを確かめ、対角軌道（32 個、各大きさ 2）の代表に、四スピン構造
すべてで位相寄与を反転する全候補辺の完全マッチングを一つ構成し、(1,1) で
軌道のもう一方の鍵へ運ぶ。得られた 64 個の完全マッチングについて、

(1) 各ファイバーの全置換をちょうど一度ずつ覆うこと、
(2) 各対が移した先でも位相反転候補辺であること（候補元の置換・偶部分グラフを
    (1,1) で移した組み替え候補に像が含まれ、四位相が全反転する）、
(3) 族が対角部分群と可換であること（M の (1,1) 像が像ファイバーの M と一致）、
(4) 合成: 各ファイバーの四つのねじれ位相和（選択和の文字評価に現れる
    巻き付き文字が非自明なファイバーの寄与）が、対ごとの相殺により
    四スピン構造すべてで零になること、

を有限集合・有限写像と Q(zeta_8) の等号だけで検査する。固定部分群が非自明な
軸方向固定の 8 鍵（translation-fixed-fiber-invariant-matching で軸部分群の
不変マッチングが無いと確定したもの）も、対角部分群では自由軌道に入るので
この構成で覆われる。
"""

load("sagemath/check/even-subgraph-orbit-translation-stabilizer/check.sage")

diagonal_shift = (1, 1)


def translate_key(shift, key):
    a, b = shift
    return permutation_key(translate_permutation(a, b, permutation_from_key(key)))


def valid_translations(fiber_key):
    doubled, single = fiber_key
    return [
        subset for subset in selection_subsets
        if subset.issubset(single)
        and is_even_selection_subset(subset)
        and winding_pairing(single, subset) == 1
    ]


def translate_selection_subset(shift, subset):
    a, b = shift
    return frozenset(translate_base_edge(a, b, base) for base in subset)


scope = sorted(
    (fiber_key for fiber_key in all_fibers if valid_translations(fiber_key)),
    key=lambda key: (sorted(key[0]), sorted(key[1])),
)
assert len(scope) == 64
scope_set = set(scope)

# 対角平行移動の作用は scope の上で自由（固定鍵が零。translation-fixed-fiber-
# invariant-matching の scope_fixed_counts_by_shift[(1,1)] == 0 と同じ事実）。
for fiber_key in scope:
    image = translate_fiber_key(1, 1, fiber_key)
    assert image in scope_set
    assert image != fiber_key

orbit_representatives_diag = []
seen = set()
for fiber_key in scope:
    if fiber_key in seen:
        continue
    image = translate_fiber_key(1, 1, fiber_key)
    assert image not in seen
    seen.add(fiber_key)
    seen.add(image)
    orbit_representatives_diag.append(fiber_key)
assert len(orbit_representatives_diag) == 32
assert len(seen) == 64


def phase_flip_partners_with_witness(phi, translations):
    """全ての有効な偶部分グラフに沿う位相全反転候補の鍵と、witness の偶部分グラフ。"""
    partners = {}
    for translation in translations:
        balanced, candidates = rewiring_candidates(phi, translation)
        if not balanced:
            continue
        for candidate in candidates:
            if all(
                phase_contribution(candidate, a, b)
                == -phase_contribution(phi, a, b)
                for a in (0, 1) for b in (0, 1)
            ):
                partners.setdefault(permutation_key(candidate), translation)
    return partners


def perfect_matching_with_witness(fiber_key):
    translations = valid_translations(fiber_key)
    keys = {permutation_key(phi): phi for phi in all_fibers[fiber_key]}
    positive = {
        key for key, phi in keys.items()
        if phase_contribution(phi, 0, 0) == K8(1)
    }
    negative = set(keys) - positive
    assert len(positive) == len(negative)
    # 候補関係は非対称（候補が片側の置換からしか発見されないことがある）なので、
    # 両側から辺を集める。witness には発見元の鍵と偶部分グラフを残す。
    adjacency = {key: set() for key in positive}
    witness_translation = {}
    for key, phi in keys.items():
        partners = phase_flip_partners_with_witness(phi, translations)
        # 候補辺は正位相と負位相を結ぶ（二部性）。
        for partner_key, translation in partners.items():
            assert (key in positive) != (partner_key in positive)
            if key in positive:
                adjacency[key].add(partner_key)
                witness_translation.setdefault(
                    (key, partner_key), (translation, key)
                )
            else:
                adjacency[partner_key].add(key)
                witness_translation.setdefault(
                    (partner_key, key), (translation, key)
                )

    matched_right = {}

    def augment(left, seen_right):
        for right in sorted(adjacency[left]):
            if right in seen_right:
                continue
            seen_right.add(right)
            if right not in matched_right or augment(matched_right[right], seen_right):
                matched_right[right] = left
                return True
        return False

    for left in sorted(positive):
        assert augment(left, set())
    assert len(matched_right) == len(positive)
    return (
        {(left, right) for right, left in matched_right.items()},
        witness_translation,
    )


matching_by_fiber = {}
witness_by_fiber = {}
representative_pair_count_distribution = {}
for representative in orbit_representatives_diag:
    matching, witness_translation = perfect_matching_with_witness(representative)
    pair_count = len(matching)
    representative_pair_count_distribution[pair_count] = (
        representative_pair_count_distribution.get(pair_count, 0) + 1
    )
    matching_by_fiber[representative] = matching
    witness_by_fiber[representative] = {
        pair: witness_translation[pair] for pair in matching
    }
    image = translate_fiber_key(1, 1, representative)
    assert image not in matching_by_fiber
    matching_by_fiber[image] = {
        (translate_key(diagonal_shift, u), translate_key(diagonal_shift, v))
        for u, v in matching
    }
    witness_by_fiber[image] = {
        (translate_key(diagonal_shift, u), translate_key(diagonal_shift, v)): (
            translate_selection_subset(
                diagonal_shift, witness_translation[(u, v)][0]
            ),
            translate_key(diagonal_shift, witness_translation[(u, v)][1]),
        )
        for u, v in matching
    }

assert len(matching_by_fiber) == 64

pair_count_distribution = {}
total_pairs = 0
fiber_size_distribution = {}
zero_character_sum_fibers = 0
for fiber_key, matching in matching_by_fiber.items():
    keys = {permutation_key(phi): phi for phi in all_fibers[fiber_key]}
    fiber_size_distribution[len(keys)] = (
        fiber_size_distribution.get(len(keys), 0) + 1
    )
    matched_vertices = [key for pair in matching for key in pair]
    # (1) 全置換をちょうど一度ずつ覆う。
    assert len(matched_vertices) == len(set(matched_vertices))
    assert set(matched_vertices) == set(keys)
    translations = set(map(frozenset, valid_translations(fiber_key)))
    for u, v in matching:
        phi_u = keys[u]
        phi_v = keys[v]
        translation, source = witness_by_fiber[fiber_key][(u, v)]
        translation = frozenset(translation)
        # (2) witness の偶部分グラフはこのファイバーでも有効で、対は発見元の
        #     置換の組み替え候補であり、四位相が全反転する。
        assert translation in translations
        assert source in (u, v)
        other = v if source == u else u
        balanced, candidates = rewiring_candidates(keys[source], translation)
        assert balanced
        assert any(
            permutation_key(candidate) == other for candidate in candidates
        )
        assert all(
            phase_contribution(phi_v, a, b) == -phase_contribution(phi_u, a, b)
            for a in (0, 1) for b in (0, 1)
        )
    # (4) 対ごとの相殺から、四つのねじれ位相和は零。
    for a in (0, 1):
        for b in (0, 1):
            assert sum(
                phase_contribution(keys[u], a, b)
                + phase_contribution(keys[v], a, b)
                for u, v in matching
            ) == K8(0)
            assert sum(
                phase_contribution(phi, a, b) for phi in all_fibers[fiber_key]
            ) == K8(0)
    zero_character_sum_fibers += 1
    pair_count = len(matching)
    pair_count_distribution[pair_count] = (
        pair_count_distribution.get(pair_count, 0) + 1
    )
    total_pairs += pair_count

# (3) 族は対角部分群と可換。
covariant_comparisons = 0
for fiber_key, matching in matching_by_fiber.items():
    image = translate_fiber_key(1, 1, fiber_key)
    translated = {
        (translate_key(diagonal_shift, u), translate_key(diagonal_shift, v))
        for u, v in matching
    }
    assert translated == matching_by_fiber[image]
    covariant_comparisons += 1
assert covariant_comparisons == 64
assert zero_character_sum_fibers == 64
assert representative_pair_count_distribution == {
    4: 10, 12: 4, 16: 6, 24: 8, 144: 2, 324: 2,
}
assert fiber_size_distribution == {
    8: 20, 24: 8, 32: 12, 48: 16, 288: 4, 648: 4,
}
assert pair_count_distribution == {
    4: 20, 12: 8, 16: 12, 24: 16, 144: 4, 324: 4,
}
assert total_pairs == 2624

print(f"diagonal-orbit representatives: {len(orbit_representatives_diag)}")
print(f"representative matching pair-count distribution: "
      f"{sorted(representative_pair_count_distribution.items())}")
print(f"fiber size distribution: {sorted(fiber_size_distribution.items())}")
print(f"matching pair-count distribution: {sorted(pair_count_distribution.items())}")
print(f"total matched pairs: {total_pairs}")
print(f"covariant matching comparisons: {covariant_comparisons}")
print(f"fibers with vanishing twisted character sums: {zero_character_sum_fibers}")
print("PASS: translation-diagonal-covariant-matching")
