"""奇数辺長の全辺鍵ファイバーの符号反転対合を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

氷型配向の頂点で、入辺二本が反対方向なら直線型、そうでなければ曲がり型と呼ぶ。
全頂点が直線型なら、各頂点は水平二辺が入る型または垂直二辺が入る型であり、隣接頂点の
型は必ず反転する。奇数周期では交互配置が閉じないので、奇数辺長のトーラスには曲がり型
頂点が少なくとも一つある。

辞書式最小の曲がり型頂点で、入辺二本から出辺二本への対応を交換する。配向を変えないので
選ぶ頂点は保存され、この操作は不動点のない対合である。置換の巡回数の偶奇は反転する。
曲がり型の六つの局所方向配置では交換前後の四半回転和が等しいため、総回転数は変わらず、
epsilon=(-1)^(巡回数+総回転数) だけが反転する。

検査は局所方向配置を全数で固定し、一辺三の全 75,776 置換について対合性・ファイバー保存・
選択頂点の保存・epsilon の反転を整数の等号だけで確認する。浮動小数点は使わない。
"""

load("sagemath/check/translation-diagonal-full-key-phase-sign-formula/check.sage")


def incoming_at(side, moved, vertex):
    return sorted(edge for edge in moved if endpoints(side, edge)[1] == vertex)


def is_corner_vertex(side, moved, vertex):
    incoming = incoming_at(side, moved, vertex)
    assert len(incoming) == 2
    first_direction, second_direction = map(direction, incoming)
    return (second_direction - first_direction) % 4 != 2


def canonical_corner_vertex(side, phi):
    moved = set(phi)
    corners = [
        vertex for vertex in product(range(side), repeat=2)
        if is_corner_vertex(side, moved, vertex)
    ]
    assert corners
    return min(corners)


def toggle_pairing_at(side, phi, vertex):
    incoming = incoming_at(side, set(phi), vertex)
    assert len(incoming) == 2
    toggled = dict(phi)
    toggled[incoming[0]], toggled[incoming[1]] = phi[incoming[1]], phi[incoming[0]]
    assert_full_key_permutation(side, toggled, set(phi))
    return toggled


def epsilon_of_permutation(side, phi):
    cycle_count, total_rotation, _ = cycle_data(side, phi)
    return epsilon_of(cycle_count, total_rotation)


# 六つの入方向集合について、曲がり型では二対応の局所四半回転和が等しく、
# 直線型でだけ差が正負 4 になることを固定する。
local_differences = {}
quarter_turn_of_directions = lambda first, second: {
    0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)
}[(second - first) % 4]
for incoming_directions in Subsets(range(4), 2):
    incoming_directions = tuple(incoming_directions)
    reversed_directions = {ZZ((value + 2) % 4) for value in incoming_directions}
    outgoing_directions = tuple(value for value in range(4) if value not in reversed_directions)
    first_sum = sum(
        quarter_turn_of_directions(incoming_directions[index], outgoing_directions[index])
        for index in range(2)
    )
    second_sum = sum(
        quarter_turn_of_directions(incoming_directions[index], outgoing_directions[1 - index])
        for index in range(2)
    )
    local_differences[incoming_directions] = second_sum - first_sum

assert sorted(local_differences.values()) == [-4, 0, 0, 0, 0, 4]
for incoming_directions, difference in local_differences.items():
    straight = (incoming_directions[1] - incoming_directions[0]) % 4 == 2
    assert (difference != 0) == straight


# 一辺三では奇数周期による曲がり型頂点の存在と、標準的な局所交換対合を全数検査する。
assert len(side3_fiber) == 75776
for phi in side3_fiber:
    vertex = canonical_corner_vertex(3, phi)
    toggled = toggle_pairing_at(3, phi, vertex)
    assert canonical_corner_vertex(3, toggled) == vertex
    assert toggle_pairing_at(3, toggled, vertex) == phi
    assert toggled != phi
    assert epsilon_of_permutation(3, toggled) == -epsilon_of_permutation(3, phi)

print("L=3: checked 75776 permutations; canonical corner pairing toggle reverses epsilon")
print("PASS: translation-full-key-local-pairing-involution")
