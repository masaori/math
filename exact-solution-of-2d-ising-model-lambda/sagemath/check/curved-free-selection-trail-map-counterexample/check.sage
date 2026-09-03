"""曲がり型なし配向の局所選択のトレイル台写像が全単射に届かない反例を固定する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

自明文字で選択集合が非空な一辺二の各ファイバーについて、曲がり型頂点を
持たない均衡配向 o と、その直進型頂点の部分集合 S の対（重み 2^s(o) の
展開）から、E の F_2 巡回空間への候補写像を次で定めて検査した。

  (1) E の各辺を o の向きに向け、次数 2 の頂点では一意の出辺へ、
      直進型頂点では S に属せば左折（方向 +1）、属さなければ右折
      （方向 -1）の出辺へつなぐ。これは向き付き辺集合の置換であり、
      E は閉トレイルへ分割される。各トレイルの台は各頂点で偶数次数である。
  (2) 辞書式最小の辺を向き 0 で通るトレイルの台の合併を C(o,S) とする。

結果（この検査で固定する事実）:

  - C(o,S) は常に巡回空間の元である（全対で assert）。
  - 直進型頂点を持たない階数 2 以下の全 368 ファイバーでは、E は次数 2 の
    サイクルの直和で S は空に限る。トレイルは成分と一致し、C は成分ごとの
    向きの符号化として巡回空間への全単射になる。
  - 全辺・階数 5 の 1 ファイバーでは全単射に届かない。曲がり型なし配向は
    互いに逆向きの 2 個で直進型頂点は 4 個ずつあるが、S の元数が奇数だと
    E 全体が 1 本のトレイルになり、C は最小辺の向きに応じて空集合または
    E 全体へ潰れる（8 対 1 の衝突が 2 つ）。S の元数が偶数なら 2 本の
    トレイルに割れ、16 個の像は相異なる。像の総数は 18 で 32 に届かない。

従って、トレイルの台の合併は左右選択の奇偶を保存せず、重み 2^s(o) の
局所選択展開を選択集合へ写す一般の全単射としては採用できない。
一般の構成は、選択の情報を辺集合へ落とす前に保つ別の対応
（たとえば配向差と選択ビットを別々に符号化する対応）を要する。
有限集合、F_2、整数の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/trivial-character-curved-free-orientation-weight/check.sage")


def straight_vertices(single, orientation):
    result = []
    for vertex in sorted({(row, column) for row in range(L)
                          for column in range(L)}):
        incident = [base for base in single
                    if vertex in endpoints(L, base + (0,))]
        if len(incident) != 4:
            continue
        incoming = []
        for base in incident:
            edge = base + (orientation[base],)
            if endpoints(L, edge)[1] == vertex:
                incoming.append(direction(edge))
        assert len(incoming) == 2
        difference = (incoming[0] - incoming[1]) % 4
        assert difference == 2
        result.append(vertex)
    return result


def trail_partition(single, orientation, left_vertices):
    directed = {base + (orientation[base],) for base in single}
    outgoing_at = {}
    for edge in directed:
        outgoing_at.setdefault(endpoints(L, edge)[0], []).append(edge)
    successor = {}
    for edge in directed:
        head = endpoints(L, edge)[1]
        candidates = outgoing_at[head]
        if len(candidates) == 1:
            successor[edge] = candidates[0]
        else:
            assert len(candidates) == 2
            turn = 1 if head in left_vertices else -1
            target_direction = (direction(edge) + turn) % 4
            matches = [other for other in candidates
                       if direction(other) == target_direction]
            assert len(matches) == 1
            successor[edge] = matches[0]

    trails = []
    remaining = set(directed)
    while remaining:
        start = min(remaining)
        trail = [start]
        remaining.discard(start)
        edge = successor[start]
        while edge != start:
            trail.append(edge)
            remaining.discard(edge)
            edge = successor[edge]
        trails.append(trail)
    return trails


def selected_union(single, orientation, left_vertices):
    union = set()
    trail_count = ZZ(0)
    for trail in trail_partition(single, orientation, left_vertices):
        trail_count += 1
        support = frozenset(edge[:3] for edge in trail)
        assert len(support) == len(trail)
        assert is_even_edge_subset(support)
        if orientation[min(support)] == 0:
            union.symmetric_difference_update(support)
    return frozenset(union), trail_count


bijective_fibers = ZZ(0)
membership_checks = ZZ(0)
counterexample_fibers = []

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

    classes = {}
    for phi in fiber:
        orientation_key = tuple(sorted(induced_orientation(phi, single).items()))
        classes.setdefault(orientation_key, []).append(phi)

    images = {}
    for orientation_key in classes:
        orientation = dict(orientation_key)
        curved, straight = local_vertex_counts(single, orientation)
        if curved > 0:
            continue
        straight_list = straight_vertices(single, orientation)
        assert ZZ(len(straight_list)) == straight
        for size in range(len(straight_list) + 1):
            for chosen in Subsets(straight_list, size):
                image, trail_count = selected_union(
                    single, orientation, set(chosen))
                assert image in cycle_space
                membership_checks += 1
                images.setdefault(image, []).append(
                    (orientation_key, ZZ(size), trail_count))

    pair_count = ZZ(sum(len(items) for items in images.values()))
    assert pair_count == ZZ(2) ** cycle_rank
    if all(len(items) == 1 for items in images.values()):
        assert cycle_rank <= 2
        assert all(size == 0 for items in images.values()
                   for _, size, _ in items)
        assert frozenset(images) == cycle_space
        bijective_fibers += 1
    else:
        counterexample_fibers.append(
            (doubled, single, cycle_rank, images))

assert bijective_fibers == 368
assert len(counterexample_fibers) == 1
doubled, single, cycle_rank, images = counterexample_fibers[0]
assert doubled == frozenset()
assert single == frozenset(base_edge_set)
assert cycle_rank == 5
assert ZZ(len(images)) == 18
collapsed = {image: items for image, items in images.items()
             if len(items) > 1}
assert frozenset(collapsed) == frozenset(
    [frozenset(), frozenset(base_edge_set)])
for image, items in images.items():
    if image in collapsed:
        assert len(items) == 8
        for _, size, trail_count in items:
            assert size % 2 == 1
            assert trail_count == 1
    else:
        assert len(items) == 1
        for _, size, trail_count in items:
            assert size % 2 == 0
            assert trail_count == 2

assert membership_checks == 32 * 1 + 320 * 2 + 16 * 4 + 32
print("PASS: L=%d の自明文字・選択非空 369 ファイバーで、トレイル台の候補写像は"
      "階数 2 以下の %d ファイバーで巡回空間への全単射だが、全辺ファイバーでは"
      "奇数個の左折選択が 1 本のトレイルへ潰れ、像 18 個（8 対 1 の衝突 2 つ）に"
      "留まる反例を固定（所属検査 %d 件）"
      % (L, bijective_fibers, membership_checks))
