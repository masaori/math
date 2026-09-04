"""標準形の並べ替え反転を作る辺対が局所的かを調べる。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

辺対ごとの終点順序・始点順序の反転指示値の和が 1 になる対について、
二辺が端点を共有するかを調べる。共有端点だけで全寄与を扱えるなら、
切断線対と内部対の対応は頂点近傍だけで組める。反例があれば、寄与する
辺対を直接対応させる規則は、少なくとも離れた辺対も扱わなければならない。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使う。
"""

load("sagemath/check/parity-identity-standard-form-statistics/check.sage")


def pair_contribution(side, left, right):
    row = ZZ(
        (endpoints(side, left)[1], left)
        > (endpoints(side, right)[1], right)
    )
    column = ZZ(
        (endpoints(side, left)[0], left)
        > (endpoints(side, right)[0], right)
    )
    return (row + column) % 2


def active_pair_counts(side, doubled, single, orientation):
    moved = sorted(frozenset(
        [base + (direction,) for base in doubled for direction in (0, 1)]
        + [base + (orientation[base],) for base in single]
    ))
    incident = ZZ(0)
    disjoint = ZZ(0)
    seam = ZZ(0)
    internal = ZZ(0)
    for left_index in range(len(moved)):
        for right_index in range(left_index + 1, len(moved)):
            left = moved[left_index]
            right = moved[right_index]
            if pair_contribution(side, left, right) == 0:
                continue
            left_vertices = set(endpoints(side, left))
            right_vertices = set(endpoints(side, right))
            if left_vertices.intersection(right_vertices):
                incident += 1
            else:
                disjoint += 1
            touches_seam = any(
                base_seam_parities(side, edge[:3]) != (0, 0)
                for edge in (left, right)
            )
            if touches_seam:
                seam += 1
            else:
                internal += 1
    return incident, disjoint, seam, internal


def collect_counts(side):
    total = [ZZ(0), ZZ(0), ZZ(0), ZZ(0)]
    if side == 2:
        keys = []
        for (doubled, single), fiber in sorted(all_fibers.items()):
            selectors = [
                selected for selected in base_edge_subsets
                if selected.issubset(single)
                and is_even_edge_subset(doubled.union(selected))
            ]
            if not selectors or not character_is_trivial_general(2, single):
                continue
            keys.append((doubled, single))
    else:
        keys = [
            (frozenset(), single)
            for single in sorted(even_subgraphs_three,
                                 key=lambda item: tuple(sorted(item)))
            if single
            and character_is_trivial_general(3, single)
            and curved_free_orientations(3, single)
        ]
    for doubled, single in keys:
        orientations = curved_free_orientations(side, single)
        standard, components = standard_orientation(side, single, orientations)
        counts = active_pair_counts(side, doubled, single, standard)
        total = [total[index] + counts[index] for index in range(4)]
    return tuple(total), len(keys)


counts_two, keys_two = collect_counts(2)
counts_three, keys_three = collect_counts(3)

assert counts_two[1] > 0
assert counts_three[1] > 0
print("L=2: active pairs incident=%d disjoint=%d seam=%d internal=%d keys=%d"
      % (counts_two + (keys_two,)))
print("L=3: active pairs incident=%d disjoint=%d seam=%d internal=%d keys=%d"
      % (counts_three + (keys_three,)))
print("PASS: 標準形の並べ替え反転には端点を共有しない辺対が現れるため、"
      "寄与する辺対の直接対応は離れた辺対も扱う必要がある")
