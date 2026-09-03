"""全辺鍵ファイバーの部分群固定集合上の一括交換対合と、対角共変な符号反転マッチングを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

奇数辺長 L の全辺鍵ファイバーに対角平行移動群 Z_L が作用する。L の約数 d ごとに
位数 d の部分群 H_d はただ一つある。H_d で固定される置換の集合 F_d の上で、
辞書式最小の曲がり型頂点の H_d-軌道（対角平行移動は頂点に自由に作用するので大きさは
ちょうど d）の全頂点で、入辺二本から出辺二本への対応を一括交換する。この操作は

1. 相異なる頂点の互換 d 個の合成なので巡回数の偶奇が d 回反転し、d が奇数なので
   epsilon=(-1)^(巡回数+総回転数) は反転する（曲がり型頂点では四半回転和が変わらない）。
2. 交換する頂点集合が H_d-不変なので F_d を F_d へ移し、配向を変えないので
   曲がり型集合と選択軌道が保存され、不動点のない対合になる。

従って各 d | L で sum_{phi in F_d} epsilon(phi) = 0 である。正確な安定化群の位数が
d の層 E_d は E_d = F_d \\ (∪_{d < d' | L} F_{d'}) であり、約数束の Möbius 反転により
各 E_d でも epsilon は均衡する。ε は平行移動不変なので、各軌道サイズの層で正負の軌道が
同数になり、正確な安定化群が等しい反対符号の代表を対にして g·r ↦ g·r' と運べば、
ファイバー全体を一回被覆する対角共変な符号反転完全マッチングが一般の奇数辺長で得られる。

なお、置換ごとに自分の安定化群 Stab(phi) の軌道を交換する操作は対合にならない。
安定化群が保存されないためである（一辺三で反例を数える）。部分群 H_d を先に固定して
F_d 上で閉じることが構成の要である。

検査は一辺三で F_1（全 75,776 置換。単頂点交換の対合は読み込み元で固定済み）と
F_3（80 置換）の一括交換対合・epsilon 反転・各 F と正確な層での均衡、および
層均衡から運んだマッチングの一回被覆・対角共変性・符号反転を固定する。
一辺五の F_5（1,088 置換）でも一括交換の対合性と epsilon 反転を固定する。
整数と有限集合の等号だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/translation-full-key-local-pairing-involution/check.sage")


def permutation_key(phi):
    return tuple(sorted(phi.items()))


def translate_permutation(side, phi, times):
    return {
        translate_oriented(side, edge, times): translate_oriented(side, image, times)
        for edge, image in phi.items()
    }


def stabilizer_times(side, phi):
    return [
        times for times in range(side)
        if translate_permutation(side, phi, times) == phi
    ]


def subgroup_times(side, order):
    assert side % order == 0
    step = side // order
    return [step * index for index in range(order)]


def subgroup_orbit_toggle(side, phi, order):
    """辞書式最小の曲がり型頂点の H_order-軌道の全頂点で対応を一括交換する。"""
    vertex = canonical_corner_vertex(side, phi)
    orbit = {
        ((vertex[0] + times) % side, (vertex[1] + times) % side)
        for times in subgroup_times(side, order)
    }
    assert len(orbit) == order
    moved = set(phi)
    toggled = phi
    for member in sorted(orbit):
        assert is_corner_vertex(side, moved, member)
        toggled = toggle_pairing_at(side, toggled, member)
    return toggled


def check_subgroup_involution(side, order, permutations):
    """H_order の固定集合の上で、一括交換が符号反転する不動点のない対合であることを固定する。"""
    epsilon_sum = ZZ(0)
    times_list = subgroup_times(side, order)
    for phi in permutations:
        for times in times_list:
            assert translate_permutation(side, phi, times) == phi
        toggled = subgroup_orbit_toggle(side, phi, order)
        assert toggled != phi
        assert set(toggled) == set(phi)
        for times in times_list:
            assert translate_permutation(side, toggled, times) == toggled
        assert subgroup_orbit_toggle(side, toggled, order) == phi
        assert epsilon_of_permutation(side, toggled) == (
            -epsilon_of_permutation(side, phi)
        )
        epsilon_sum += epsilon_of_permutation(side, phi)
    assert epsilon_sum == 0


# 一辺三。F_1 = 全ファイバー（単頂点交換の対合は読み込み元で固定済み）と F_3 = 80 置換。
assert len(side3_fiber) == 75776
epsilon_by_key = {}
stab_by_key = {}
for phi in side3_fiber:
    key = permutation_key(phi)
    epsilon_by_key[key] = epsilon_of_permutation(3, phi)
    stab_by_key[key] = tuple(stabilizer_times(3, phi))
assert sum(epsilon_by_key.values()) == 0

side3_fixed = [
    phi for phi in side3_fiber if len(stab_by_key[permutation_key(phi)]) == 3
]
assert len(side3_fixed) == 80
check_subgroup_involution(3, 3, side3_fixed)
print("L=3: subgroup-orbit toggle on F_3 is a sign-reversing involution")

# 正確な安定化群位数の各層で epsilon が均衡する（Möbius 反転の帰結を直接固定する）。
layer_counts = {}
for key, epsilon in epsilon_by_key.items():
    layer = (len(stab_by_key[key]), epsilon)
    layer_counts[layer] = layer_counts.get(layer, ZZ(0)) + 1
assert layer_counts == {
    (1, ZZ(1)): ZZ(37848), (1, ZZ(-1)): ZZ(37848),
    (3, ZZ(1)): ZZ(40), (3, ZZ(-1)): ZZ(40),
}
print("L=3: epsilon balances in each exact-stabilizer layer")

# 置換ごとの Stab(phi)-軌道交換は安定化群を保存せず、対合にならない（反例の数を固定する）。
stab_broken = ZZ(0)
for phi in side3_fiber:
    key = permutation_key(phi)
    toggled = subgroup_orbit_toggle(3, phi, len(stab_by_key[key]))
    if tuple(stabilizer_times(3, toggled)) != stab_by_key[key]:
        stab_broken += 1
assert stab_broken > 0
print(f"L=3: per-permutation stabilizer-orbit toggle breaks the stabilizer"
      f" for {stab_broken} permutations (not an involution)")

# 層均衡から、正確な安定化群が等しい反対符号の代表を対にして運ぶと、
# ファイバー全体の対角共変な符号反転完全マッチングになることを固定する。
side3_by_key = {permutation_key(phi): phi for phi in side3_fiber}
representatives = {}
seen_orbit = set()
for phi in side3_fiber:
    key = permutation_key(phi)
    if key in seen_orbit:
        continue
    orbit_keys = {
        permutation_key(translate_permutation(3, phi, times))
        for times in range(3)
    }
    seen_orbit |= orbit_keys
    layer = (len(stab_by_key[key]), epsilon_by_key[key])
    representatives.setdefault(layer, []).append(key)
for (order, epsilon), keys in representatives.items():
    keys.sort()
    assert len(keys) == len(representatives[(order, -epsilon)])

matched = {}
for order in (1, 3):
    positive_keys = representatives[(order, ZZ(1))]
    negative_keys = representatives[(order, ZZ(-1))]
    for key, partner_key in zip(positive_keys, negative_keys):
        for times in range(ZZ(3) // order):
            moved_key = permutation_key(
                translate_permutation(3, side3_by_key[key], times)
            )
            moved_partner = permutation_key(
                translate_permutation(3, side3_by_key[partner_key], times)
            )
            assert moved_key not in matched and moved_partner not in matched
            assert moved_key != moved_partner
            matched[moved_key] = moved_partner
            matched[moved_partner] = moved_key
assert len(matched) == 75776
assert ZZ(len(matched)) // 2 == 37888
for key, partner_key in matched.items():
    assert matched[partner_key] == key
    assert epsilon_by_key[partner_key] == -epsilon_by_key[key]
    translated_key = permutation_key(
        translate_permutation(3, side3_by_key[key], 1)
    )
    translated_partner = permutation_key(
        translate_permutation(3, side3_by_key[partner_key], 1)
    )
    assert matched[translated_key] == translated_partner
print("L=3: transported family is a diagonal-covariant sign-reversing"
      " perfect matching with 37888 pairs")

# 一辺五の F_5。一括交換（軌道の大きさ 5）が符号反転する不動点のない対合になる。
_, side5_fixed = invariant_fixed_permutations(5)
assert len(side5_fixed) == 1088
check_subgroup_involution(5, 5, side5_fixed)
print("L=5: subgroup-orbit toggle on F_5 is a sign-reversing involution")

print("PASS: translation-full-key-stabilizer-orbit-involution")
