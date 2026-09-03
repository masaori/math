"""自明文字ファイバーの置換を配向差で類別し、類和の構造を一辺二で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

選択集合が非空で文字が自明な添字 (D,E) について、ファイバーの各置換の
単純通過部分が誘導する E の均衡配向を、ファイバーの辞書式最小置換の配向と
比較する。二つの均衡配向の不一致辺集合は各頂点で偶数次数なので、常に E の
F_2 巡回空間の元である（所属は全件 assert する）。この写像による類別で

  (1) 類の個数が巡回空間の位数 2^(|E|-|V(E)|+c(E)) に一致するファイバーでは、
      四つのスピン構造それぞれで各類の位相和が共通値
      K^{a,b}_L(D,E)/2^階数 ∈ {+1,-1} に等しいこと、
  (2) 一辺二では例外がちょうど一つ（E が全 8 辺、階数 5）であり、そこでは
      類が均衡配向 18 個に対応して巡回空間 32 元を尽くさず、四つのスピン構造
      それぞれで、位相和が零の類が 16 個、K^{a,b}_L(D,E)/2 の類が 2 個あること

を検査する。従って配向差の類別は階数 2 以下の全ファイバーで巡回空間の元数の
符号付き数え上げ（共通符号 × 2^階数）を与えるが、一般には類が巡回空間を
尽くさず類和も一様でないので、一般の数え上げは均衡配向の類を単位に組む必要が
ある。有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/trivial-character-fiber-magnitude/check.sage")


def induced_orientation(phi, single):
    moved = moved_edges(phi)
    orientation = {}
    for base in single:
        forward = (base[0], base[1], base[2], 0) in moved
        backward = (base[0], base[1], base[2], 1) in moved
        assert forward != backward
        orientation[base] = 0 if forward else 1
    return orientation


rank_and_class_counts = {}
membership_checks = ZZ(0)
uniform_class_sum_checks = ZZ(0)
exceptional_fibers = []

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

    vertex_count, component_count = nonempty_vertex_and_component_counts(single)
    cycle_rank = ZZ(len(single)) - vertex_count + component_count
    cycle_space = frozenset(frozenset(item) for item in inside)
    assert ZZ(len(cycle_space)) == ZZ(2) ** cycle_rank

    reference = min(fiber, key=permutation_key)
    reference_orientation = induced_orientation(reference, single)

    classes = {}
    for phi in fiber:
        orientation = induced_orientation(phi, single)
        disagreement = frozenset(base for base in single
                                 if orientation[base]
                                 != reference_orientation[base])
        assert disagreement in cycle_space
        membership_checks += 1
        classes.setdefault(disagreement, []).append(phi)

    class_count = ZZ(len(classes))
    key = (cycle_rank, class_count)
    rank_and_class_counts[key] = rank_and_class_counts.get(key, 0) + 1

    class_sums = {}
    for a in (0, 1):
        for b in (0, 1):
            fiber_phase_sum = sum(
                (contributions[permutation_key(phi)][(a, b)] for phi in fiber),
                K8(0),
            )
            class_sums[(a, b)] = (
                fiber_phase_sum,
                [sum((contributions[permutation_key(phi)][(a, b)]
                      for phi in part), K8(0))
                 for part in classes.values()],
            )

    if class_count == ZZ(2) ** cycle_rank:
        for (a, b), (fiber_phase_sum, sums) in class_sums.items():
            common_value = fiber_phase_sum / K8(2) ** cycle_rank
            assert common_value in (K8(1), K8(-1))
            for part_sum in sums:
                assert part_sum == common_value
                uniform_class_sum_checks += 1
    else:
        exceptional_fibers.append(
            (doubled, single, cycle_rank, class_count, class_sums))

assert rank_and_class_counts == {(ZZ(0), ZZ(1)): 32, (ZZ(1), ZZ(2)): 320,
                                 (ZZ(2), ZZ(4)): 16, (ZZ(5), ZZ(18)): 1}
assert len(exceptional_fibers) == 1
doubled, single, cycle_rank, class_count, class_sums = exceptional_fibers[0]
assert doubled == frozenset()
assert single == frozenset(base_edge_set)
assert cycle_rank == 5
assert class_count == 18
for (a, b), (fiber_phase_sum, sums) in class_sums.items():
    half_value = fiber_phase_sum / K8(2)
    zero_classes = ZZ(sum(1 for part_sum in sums if part_sum == K8(0)))
    half_classes = ZZ(sum(1 for part_sum in sums if part_sum == half_value))
    assert zero_classes == 16
    assert half_classes == 2
    assert zero_classes + half_classes == class_count
    assert sum(sums, K8(0)) == fiber_phase_sum

assert membership_checks > 0
assert uniform_class_sum_checks == 4 * (32 * 1 + 320 * 2 + 16 * 4)
print("PASS: L=%d の自明文字・選択非空 369 ファイバーで、配向差の類が常に"
      "巡回空間に属し（所属検査 %d 件）、階数 2 以下の 368 ファイバーでは"
      "類が巡回空間を尽くし各類の位相和が共通符号に等しい（検査 %d 件）。"
      "全辺・階数 5 の 1 ファイバーだけは類 18 個で、零和 16 類と半値 2 類に"
      "分かれることを四スピン構造で検査"
      % (L, membership_checks, uniform_class_sum_checks))
