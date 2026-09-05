"""自明文字ファイバーの均衡配向類の位相和を局所頂点型で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

一辺二の自明文字・選択非空ファイバーを、単純通過部分が誘導する
均衡配向ごとに類別する。各類について、次数 4 頂点の入方向が隣接する
曲がり型なら位相和が零であり、曲がり型が無ければ位相和の絶対値が
2^(直進型の次数 4 頂点数) に等しいことを、四つのスピン構造で検査する。
有限集合、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/trivial-character-orientation-local-factor/construction.sage")

# 構成側でも回している文をここでもう一度回すので、累算器を初期化し直す
# （初期化が構成側にしかないと、構成での実行ぶんへ二重に足し込む）。
class_checks = ZZ(0)
determinant_factorization_checks = ZZ(0)
local_type_distribution = {}
nonzero_class_checks = ZZ(0)
zero_class_checks = ZZ(0)

for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    inside = even_subgraphs_inside(single)
    character_is_trivial = all(character_value(single, item) == 1
                               for item in inside)
    if not selectors or not character_is_trivial:
        continue

    classes = {}
    for phi in fiber:
        orientation = induced_orientation(phi, single)
        orientation_key = tuple(sorted(orientation.items()))
        classes.setdefault(orientation_key, []).append(phi)

    for orientation_key, part in classes.items():
        orientation = dict(orientation_key)
        curved, straight = local_vertex_counts(single, orientation)
        local_type_distribution[(curved, straight)] = (
            local_type_distribution.get((curved, straight), ZZ(0)) + 1)
        for a in (0, 1):
            for b in (0, 1):
                part_sum = sum(
                    (contributions[permutation_key(phi)][(a, b)] for phi in part),
                    K8(0),
                )
                moved = moved_edges(part[0])
                local_product = local_determinant_product(moved, a, b)
                assert part_sum == K8((-1) ** len(moved)) * local_product
                determinant_factorization_checks += 1
                if curved > 0:
                    assert part_sum == K8(0)
                    zero_class_checks += 1
                else:
                    assert part_sum in ZZ
                    assert abs(ZZ(part_sum)) == ZZ(2) ** straight
                    nonzero_class_checks += 1
                class_checks += 1

assert class_checks == 4 * sum(local_type_distribution.values())
assert zero_class_checks > 0
assert nonzero_class_checks > 0
assert determinant_factorization_checks == class_checks
print("local type distribution %s" % sorted(local_type_distribution.items()))
print("PASS: L=%d の自明文字・選択非空ファイバーの均衡配向類 %d 件×"
      "四スピン構造を検査。曲がり型を持つ零和 %d 件、曲がり型を持たない"
      "局所積 2^(直進型頂点数) %d 件"
      % (L, sum(local_type_distribution.values()), zero_class_checks,
         nonzero_class_checks))
