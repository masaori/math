"""一辺三の全辺鍵ファイバーに対角共変な位相反転完全マッチングを構成する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

対角平行移動で固定される 80 置換には、前段で構成した位相ベクトルの直接対
40 対を使う。残る置換は大きさ 3 の自由軌道に分かれる。各自由軌道の
位相ベクトルが平行移動で不変であり、その多重集合が符号反転で不変であることを
確かめ、位相ベクトルが反対の軌道を整列順に対にして軌道上へ運ぶ。

得られた対が全 75,776 置換を一度ずつ覆い、四つのスピン構造で位相を反転し、
対角平行移動で不変であることを有限集合と Q(zeta8) の等号だけで検査する。
浮動小数点は使わない。
"""

load("sagemath/check/translation-diagonal-full-key-hall-structure/check.sage")


def diagonal_translate_permutation(side, phi, times):
    return {
        translate_oriented(side, edge, times):
        translate_oriented(side, image, times)
        for edge, image in phi.items()
    }


def permutation_key(phi):
    return frozenset(phi.items())


side = 3
full_permutations = all_full_key_permutations(side)
full_by_key = {permutation_key(phi): phi for phi in full_permutations}
assert len(full_by_key) == 75776


def translate_key(key, times):
    return permutation_key(
        diagonal_translate_permutation(side, full_by_key[key], times)
    )


# 対角作用の軌道を全構成する。位数は 3 なので、軌道は固定点か三元自由軌道である。
seen = set()
fixed_keys = []
free_orbits = []
for key in sorted(full_by_key, key=sorted):
    if key in seen:
        continue
    orbit = {translate_key(key, times) for times in range(side)}
    assert len(orbit) in (1, 3)
    seen.update(orbit)
    if len(orbit) == 1:
        fixed_keys.append(key)
    else:
        free_orbits.append(tuple(sorted(orbit, key=sorted)))
assert seen == set(full_by_key)
assert set(fixed_keys) == set(by_key)
assert len(fixed_keys) == 80
assert len(free_orbits) == 25232

# 自由軌道上で位相ベクトルは一定である。
free_orbits_by_vector = {}
phase_by_key = {
    key: phase_vector(side, full_by_key[key]) for key in fixed_keys
}
for orbit in free_orbits:
    for key in orbit:
        phase_by_key[key] = phase_vector(side, full_by_key[key])
    vectors = {phase_by_key[key] for key in orbit}
    assert len(vectors) == 1
    vector = next(iter(vectors))
    free_orbits_by_vector.setdefault(vector, []).append(orbit)

# 各位相ベクトルの自由軌道数は、反対の位相ベクトルの自由軌道数と一致する。
for vector, orbits in free_orbits_by_vector.items():
    opposite = tuple(-component for component in vector)
    assert opposite != vector
    assert len(orbits) == len(free_orbits_by_vector[opposite])

# 固定点には前段の直接対を使う。自由軌道は反対位相の軌道を整列順に対にし、
# 一つの代表対を対角平行移動で三対へ運ぶ。
matching = {frozenset((left, right)) for left, right in direct_pairs}
handled_vectors = set()
free_orbit_pair_count = 0
for vector in sorted(free_orbits_by_vector, key=repr):
    if vector in handled_vectors:
        continue
    opposite = tuple(-component for component in vector)
    left_orbits = sorted(free_orbits_by_vector[vector], key=lambda orbit: sorted(orbit[0]))
    right_orbits = sorted(free_orbits_by_vector[opposite], key=lambda orbit: sorted(orbit[0]))
    for left_orbit, right_orbit in zip(left_orbits, right_orbits):
        left = left_orbit[0]
        right = right_orbit[0]
        for times in range(side):
            matching.add(frozenset((translate_key(left, times), translate_key(right, times))))
        free_orbit_pair_count += 1
    handled_vectors.add(vector)
    handled_vectors.add(opposite)

# 完全被覆・位相反転・対角共変性をそれぞれ独立に固定する。
matched_vertices = [key for pair in matching for key in pair]
assert len(matching) == 37888
assert len(matched_vertices) == len(set(matched_vertices)) == 75776
assert set(matched_vertices) == set(full_by_key)
assert free_orbit_pair_count == 12616

fixed_matching = {pair for pair in matching if next(iter(pair)) in set(fixed_keys)}
assert fixed_matching == {frozenset((left, right)) for left, right in direct_pairs}
assert len(fixed_matching) == 40

for pair in matching:
    left, right = tuple(pair)
    assert phase_by_key[right] == tuple(
        -component for component in phase_by_key[left]
    )
    translated_pair = frozenset(translate_key(key, 1) for key in pair)
    assert translated_pair in matching

phase_sums = tuple(
    sum(
        (vector[index] for vector in phase_by_key.values()),
        K8(0),
    )
    for index in range(4)
)
assert phase_sums == (K8(0), K8(0), K8(0), K8(0))

vector_orbit_count_distribution = sorted(
    (repr(vector), len(orbits))
    for vector, orbits in free_orbits_by_vector.items()
)
print(f"L={side}: full-key permutations {len(full_by_key)}")
print(f"fixed points {len(fixed_keys)}, free orbits {len(free_orbits)}")
print(f"free-orbit phase-vector counts: {vector_orbit_count_distribution}")
print(f"fixed pairs {len(fixed_matching)}, free-orbit pairs {free_orbit_pair_count}")
print(f"matching pairs {len(matching)}, phase sums {phase_sums}")
print("PASS: translation-diagonal-full-key-covariant-matching")
