"""偶部分グラフに沿った頂点の入出接続の組み替えが文字作用を与えるかを厳密検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の各ファイバー (D, E) のうち、E に含まれる偶部分グラフ H で
巻き付き文字が非自明（chi_E(H) = -1）になる組だけを対象にする。
各非後退置換 phi と各そのような H について、次の組み替え候補の族を全数で調べる。

- H の外どうしの遷移（e -> phi(e) で e も phi(e) も H の辺でない）はそのまま保つ。
- H 上の歩道の向き付き辺は全て逆向きへ差し替える。
- 各頂点で、残った到着（H の外から H へ入っていた到着と、逆向きになった H の出発）と
  残った出発（H から H の外へ出ていた出発と、逆向きになった H の到着)を、
  直ちに引き返さない任意の全単射で結び直す。

確かめるのは次である。

(1) 各頂点で残った到着と出発の個数が釣り合うか（釣り合わなければ候補は空）。
(2) 釣り合う組で、非後退置換になる結び直しが存在するか。
(3) 存在する組で、四つのスピン構造すべてで位相寄与の比が文字 -1 になる候補があるか。

(3) が全組で成立しなければ、この族の作用だけでは非自明文字のファイバー位相和の
消滅は構成できない。計算は有限集合・有限写像と Q(zeta_8) の等号だけで行う。
"""

from itertools import permutations as _permutations
from itertools import product as _product

load("sagemath/check/fiber-phase-character-vanishing/check.sage")


def base_edge(edge):
    kind, i, j, _ = edge
    return (kind, i, j)


def is_nonbacktracking_permutation(phi):
    return all(
        phi[edge] == edge or phi[edge] in successors(L, oriented, edge)
        for edge in oriented
    )


def rewiring_candidates(phi, subset):
    """kept 遷移と各頂点の全単射の族から得る全候補を列挙する。

    戻り値は (balanced, candidates)。balanced が False なら候補は空である。
    """
    moved = [edge for edge in oriented if phi[edge] != edge]
    kept = {}
    free_arrivals = {}
    free_departures = {}
    for edge in moved:
        image = phi[edge]
        edge_in = base_edge(edge) in subset
        image_in = base_edge(image) in subset
        if not edge_in and not image_in:
            kept[edge] = image
        else:
            vertex = endpoints(L, edge)[1]
            if not edge_in:
                free_arrivals.setdefault(vertex, []).append(edge)
            if not image_in:
                free_departures.setdefault(vertex, []).append(image)
        if edge_in:
            reversed_edge = reversal(edge)
            head = endpoints(L, reversed_edge)[1]
            tail = endpoints(L, reversed_edge)[0]
            free_arrivals.setdefault(head, []).append(reversed_edge)
            free_departures.setdefault(tail, []).append(reversed_edge)
    vertices = sorted(set(free_arrivals) | set(free_departures))
    for vertex in vertices:
        if len(free_arrivals.get(vertex, [])) != len(free_departures.get(vertex, [])):
            return False, []
    per_vertex_matchings = []
    for vertex in vertices:
        arrivals = free_arrivals.get(vertex, [])
        departures = free_departures.get(vertex, [])
        matchings = []
        for images in _permutations(departures):
            if any(image == reversal(arrival)
                   for arrival, image in zip(arrivals, images)):
                continue
            matchings.append(tuple(zip(arrivals, images)))
        if not matchings:
            return True, []
        per_vertex_matchings.append(matchings)
    candidates = []
    for choice in _product(*per_vertex_matchings):
        candidate = {edge: edge for edge in oriented}
        candidate.update(kept)
        for matching in choice:
            for arrival, image in matching:
                candidate[arrival] = image
        candidates.append(candidate)
    return True, candidates


checked = 0
unbalanced = 0
balanced_without_candidate = 0
with_candidate = 0
with_phase_matching_candidate = 0
total_candidates = 0
first_failure = None
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
    for phi in fiber:
        for translation in translations:
            checked += 1
            balanced, candidates = rewiring_candidates(phi, translation)
            if not balanced:
                unbalanced += 1
                continue
            if not candidates:
                balanced_without_candidate += 1
                continue
            with_candidate += 1
            total_candidates += len(candidates)
            found = False
            for candidate in candidates:
                assert is_nonbacktracking_permutation(candidate)
                assert doubled_and_single_sets(candidate) == (doubled, single)
                if all(
                    phase_contribution(candidate, a, b)
                    == -phase_contribution(phi, a, b)
                    for a in (0, 1) for b in (0, 1)
                ):
                    found = True
                    break
            if found:
                with_phase_matching_candidate += 1
            elif first_failure is None:
                first_failure = (doubled, single, translation, phi)

assert checked == 13568
assert unbalanced == 0
assert balanced_without_candidate == 0
assert with_candidate == 13568
assert total_candidates == 38016
assert with_phase_matching_candidate == 11904
assert first_failure is not None
print(f"checked triples (nontrivial character): {checked}")
print(f"unbalanced: {unbalanced}")
print(f"balanced without candidate: {balanced_without_candidate}")
print(f"with candidate: {with_candidate}")
print(f"total candidates: {total_candidates}")
print(f"with phase-matching candidate: {with_phase_matching_candidate}")
if first_failure is not None:
    doubled, single, translation, phi = first_failure
    print("first triple with candidates but no phase-matching candidate: "
          f"D={sorted(doubled)}, E={sorted(single)}, H={sorted(translation)}, "
          f"phi={permutation_key(phi)}")
print(f"PASS: even-subgraph-vertex-rewiring (triples={checked})")
