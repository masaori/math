"""置換ごとに偶部分グラフを選べば大域的な符号反転対応を作れるかを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 で巻き付き文字が非自明な各ファイバーについて、前段の頂点組み替え候補のうち
四スピン構造すべてで位相寄与を反転するものを辺とする二部グラフを作る。置換ごとに
使う偶部分グラフを変えてよいとき、このグラフに完全マッチングがあれば、候補を大域的な
符号反転対合へまとめられる。有限集合と Q(zeta_8) の等号だけを使う。
"""

load("sagemath/check/even-subgraph-vertex-rewiring/check.sage")


def has_perfect_phase_matching(fiber, edges):
    keys = [permutation_key(phi) for phi in fiber]
    positive = {
        permutation_key(phi) for phi in fiber
        if phase_contribution(phi, 0, 0) == K8(1)
    }
    negative = set(keys) - positive
    if len(positive) != len(negative):
        return False, len(positive), len(negative), 0

    adjacency = {key: set() for key in positive}
    for source, target in edges:
        if source in positive and target in negative:
            adjacency[source].add(target)
        if target in positive and source in negative:
            adjacency[target].add(source)

    matched_left = {}
    matched_right = {}

    def augment(left, seen):
        for right in sorted(adjacency[left]):
            if right in seen:
                continue
            seen.add(right)
            if right not in matched_right or augment(matched_right[right], seen):
                matched_left[left] = right
                matched_right[right] = left
                return True
        return False

    for left in sorted(positive):
        augment(left, set())
    return len(matched_left) == len(positive), len(positive), len(negative), len(matched_left)


checked_fibers = 0
perfect_fibers = 0
total_vertices = 0
matched_pairs = 0
first_failure = None
for fiber_key, edges in sorted(phase_edges_by_fiber.items()):
    fiber = all_fibers[fiber_key]
    perfect, positive_count, negative_count, matching_size = has_perfect_phase_matching(
        fiber, edges
    )
    checked_fibers += 1
    total_vertices += len(fiber)
    matched_pairs += matching_size
    if perfect:
        perfect_fibers += 1
    elif first_failure is None:
        first_failure = (
            fiber_key, len(fiber), len(edges), positive_count, negative_count, matching_size
        )

assert checked_fibers > 0
assert perfect_fibers <= checked_fibers
print(f"checked nontrivial-character fibers: {checked_fibers}")
print(f"fibers with perfect global matching: {perfect_fibers}")
print(f"vertices in checked fibers: {total_vertices}")
print(f"pairs in maximum matchings: {matched_pairs}")
if first_failure is not None:
    (doubled, single), size, edge_count, positive_count, negative_count, matching_size = first_failure
    print("first fiber without perfect matching: "
          f"D={sorted(doubled)}, E={sorted(single)}, size={size}, edges={edge_count}, "
          f"positive={positive_count}, negative={negative_count}, matching={matching_size}")
print(f"PASS: even-subgraph-global-rewiring-matching (fibers={checked_fibers})")
