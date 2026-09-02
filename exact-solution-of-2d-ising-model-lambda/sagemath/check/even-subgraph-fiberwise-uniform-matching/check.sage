"""ファイバーごとに固定した偶部分グラフだけで符号反転対合を作れるかを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

置換ごとに偶部分グラフを選ぶ大域的組み替えには完全マッチングがある
（even-subgraph-global-rewiring-matching）。その規則を一般の辺長へ持ち上げる前段として、
選択をどこまで単純化できるかを調べる。一辺 L=2 の巻き付き文字が非自明な各ファイバー
(D, E) について、E に含まれ chi_E(H) = -1 となる偶部分グラフ H を一つ固定したとき、

(1) そのファイバーの全置換が、H に沿う頂点組み替えの中に四スピン構造すべてで
    位相寄与を反転する候補を持つか（一様被覆）。
(2) 一様被覆する H があるとき、その H の候補対だけを辺とする二部グラフに
    完全マッチングがあるか。

(2) が全ファイバーで成立すれば、大域対応の規則は「ファイバーごとに H を一つ選ぶ」まで
単純化できる。成立しなければ、置換ごとに H を変える割り当てが本質的である。
計算は有限集合・有限写像と Q(zeta_8) の等号だけで行う。
"""

load("sagemath/check/even-subgraph-vertex-rewiring/check.sage")


def phase_flipping_partners(phi, translation):
    """H = translation に沿う組み替え候補のうち位相を全反転するものの鍵の集合。"""
    balanced, candidates = rewiring_candidates(phi, translation)
    if not balanced:
        return set()
    partners = set()
    for candidate in candidates:
        if all(
            phase_contribution(candidate, a, b) == -phase_contribution(phi, a, b)
            for a in (0, 1) for b in (0, 1)
        ):
            partners.add(permutation_key(candidate))
    return partners


def has_perfect_matching(positive, negative, adjacency):
    matched_right = {}

    def augment(left, seen):
        for right in sorted(adjacency[left]):
            if right in seen:
                continue
            seen.add(right)
            if right not in matched_right or augment(matched_right[right], seen):
                matched_right[right] = left
                return True
        return False

    size = 0
    for left in sorted(positive):
        if augment(left, set()):
            size += 1
    return size == len(positive) == len(negative), size


fibers_checked = 0
fibers_with_uniform_cover = 0
fibers_with_uniform_matching = 0
pairs_checked = 0
pairs_flipping = 0
first_uncovered_fiber = None
first_unmatched_fiber = None
for (doubled, single), fiber in sorted(all_fibers.items()):
    translations = sorted(
        (subset for subset in selection_subsets
         if subset.issubset(single)
         and is_even_selection_subset(subset)
         and winding_pairing(single, subset) == 1),
        key=sorted,
    )
    if not translations:
        continue
    fibers_checked += 1
    keys = {permutation_key(phi): phi for phi in fiber}
    positive = {
        key for key, phi in keys.items()
        if phase_contribution(phi, 0, 0) == K8(1)
    }
    negative = set(keys) - positive
    covering_found = False
    matching_found = False
    for translation in translations:
        partner_sets = {}
        covered = True
        for key, phi in keys.items():
            pairs_checked += 1
            partners = phase_flipping_partners(phi, translation)
            if partners:
                pairs_flipping += 1
            else:
                covered = False
            partner_sets[key] = partners
        if not covered:
            continue
        covering_found = True
        adjacency = {key: set() for key in positive}
        for key, partners in partner_sets.items():
            if key in positive:
                adjacency[key] |= partners & negative
            else:
                for partner in partners & positive:
                    adjacency[partner].add(key)
        perfect, _ = has_perfect_matching(positive, negative, adjacency)
        if perfect:
            matching_found = True
            break
    if covering_found:
        fibers_with_uniform_cover += 1
    elif first_uncovered_fiber is None:
        first_uncovered_fiber = (doubled, single)
    if matching_found:
        fibers_with_uniform_matching += 1
    elif covering_found and first_unmatched_fiber is None:
        first_unmatched_fiber = (doubled, single)

assert fibers_checked == 64
assert pairs_checked == 9088
assert pairs_flipping == 7872
assert fibers_with_uniform_cover == 48
assert fibers_with_uniform_matching == 48
assert first_uncovered_fiber is not None
assert first_unmatched_fiber is None
print(f"checked nontrivial-character fibers: {fibers_checked}")
print(f"pairs (phi, H) examined until first success per fiber: {pairs_checked}")
print(f"examined pairs with phase-flipping candidate: {pairs_flipping}")
print(f"fibers with a uniformly covering H: {fibers_with_uniform_cover}")
print(f"fibers with a uniform H and perfect matching: {fibers_with_uniform_matching}")
if first_uncovered_fiber is not None:
    doubled, single = first_uncovered_fiber
    print("first fiber without uniformly covering H: "
          f"D={sorted(doubled)}, E={sorted(single)}")
if first_unmatched_fiber is not None:
    doubled, single = first_unmatched_fiber
    print("first covered fiber without uniform perfect matching: "
          f"D={sorted(doubled)}, E={sorted(single)}")
print(f"PASS: even-subgraph-fiberwise-uniform-matching (fibers={fibers_checked})")
