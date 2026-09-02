"""経路反転が非後退置換のファイバーを保つ対合であることを厳密検査する。

対象: claim_path_reversal_fiber_preserving_involution。

一辺 L=2 のトーラスの全非後退置換 phi について、経路反転
T(phi) = iota . phi^{-1} . iota を構成し、
(1) M(T(phi)) = iota(M(phi))、
(2) T(phi) が非後退置換であること、
(3) T(T(phi)) = phi、
(4) D(T(phi)) = D(phi) かつ E_1(T(phi)) = E_1(phi)（ファイバー保存）
を有限集合の等号だけで検査する。浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-nonbacktracking-sum/check.sage")


def reverse_edge(edge):
    kind, i, j, direction = edge
    return (kind, i, j, 1 - direction)


def moved_edges(phi):
    return {edge for edge in oriented if phi[edge] != edge}


def path_reversal(phi):
    inverse = {image: edge for edge, image in phi.items()}
    return {edge: reverse_edge(inverse[reverse_edge(edge)]) for edge in oriented}


def doubled_and_single_sets(phi):
    moved = moved_edges(phi)
    support = {(kind, i, j) for kind, i, j, unused_direction in moved}
    doubled = {base for base in support
               if (base[0], base[1], base[2], 0) in moved
               and (base[0], base[1], base[2], 1) in moved}
    return doubled, support.difference(doubled)


checked = 0
for phi in nonbacktracking_permutations:
    reversed_phi = path_reversal(phi)

    # (1) 動く辺の集合は反転写像による像である。
    assert moved_edges(reversed_phi) == {reverse_edge(edge) for edge in moved_edges(phi)}

    # (2) 非後退性: 動く辺の像は直ちに引き返さない後続辺に属する。
    for edge in oriented:
        if reversed_phi[edge] != edge:
            assert reversed_phi[edge] in successor_lists[edge]

    # (3) 対合性。
    assert path_reversal(reversed_phi) == phi

    # (4) 反転対の辺集合と単純通過の辺集合の保存（ファイバー保存）。
    assert doubled_and_single_sets(reversed_phi) == doubled_and_single_sets(phi)

    checked += 1

assert checked == len(nonbacktracking_permutations)
assert checked > 0
print("PASS: L=%d 非後退置換 %d 個の全数で、経路反転の非後退性・対合性・"
      "動く辺の反転像・D と E_1 の保存を検査" % (L, checked))
