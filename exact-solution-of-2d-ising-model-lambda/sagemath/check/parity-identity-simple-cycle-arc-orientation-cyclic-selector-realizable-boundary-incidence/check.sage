"""実現可能な境界入射だけで選択衝突と必要な端点ビットを再計算する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import itertools
import json
from collections import defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-realizable-boundary-incidence/construction.sage")


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]

records = []
for support_name, lift in sorted(lifts.items()):
    for arc_type in map(ast.literal_eval, lift["arc_support"]):
        if len(arc_type[1]) == 1:
            continue
        orbit_key = arc_cyclic_orbit_key(arc_type)
        selected = arc_cyclic_selector(arc_type)
        candidates = endpoint_boundary_selectors(orbit_key)
        assert len(candidates) == 2
        connected = tuple(
            candidate for candidate in candidates
            if connected_word_traversals(
                decode_arc_cyclic_encoding(orbit_key, candidate)[1]))
        if len(connected) != 2:
            continue
        ordered = tuple(sorted(
            candidates,
            key=lambda candidate: (
                candidate_local_boundary_descriptor(orbit_key, candidate),
                candidate)))
        selected_rank = ZZ(ordered.index(selected))
        full_pair = tuple(
            candidate_realizable_boundary_incidence_descriptor(
                orbit_key, candidate)
            for candidate in ordered)
        records.append((selected_rank, orbit_key[2], full_pair))


def project_pair(full_pair, feature_indices):
    return tuple(
        tuple(
            incidence[:4] + (tuple(
                incidence[4][index] for index in feature_indices),)
            for incidence in candidate_descriptor)
        for candidate_descriptor in full_pair)


def requirements_for(feature_indices, include_endpoints=False):
    requirements = defaultdict(set)
    for selected_rank, endpoints, full_pair in records:
        key = project_pair(full_pair, feature_indices)
        if include_endpoints:
            key = (endpoints, key)
        requirements[key].add(selected_rank)
    return requirements


def conflicting_requirements(feature_indices, include_endpoints=False):
    return {
        key: ranks
        for key, ranks in requirements_for(
            feature_indices, include_endpoints).items()
        if len(ranks) > 1
    }


empty_conflicts = conflicting_requirements(())
endpoint_empty_conflicts = conflicting_requirements((), include_endpoints=True)
single_feature_conflicts = {
    OUTSIDE_MEMBERSHIP_FEATURES[index]: len(conflicting_requirements((index,)))
    for index in range(len(OUTSIDE_MEMBERSHIP_FEATURES))
}

base_groups = defaultdict(lambda: {0: [], 1: []})
for selected_rank, _, full_pair in records:
    base = project_pair(full_pair, ())
    feature_signatures = tuple(
        project_pair(full_pair, (index,))
        for index in range(len(OUTSIDE_MEMBERSHIP_FEATURES)))
    base_groups[base][selected_rank].append(feature_signatures)

opposite_rank_difference_sets = []
for rank_groups in base_groups.values():
    for rank_zero in rank_groups[0]:
        for rank_one in rank_groups[1]:
            opposite_rank_difference_sets.append(frozenset(
                index for index in range(len(OUTSIDE_MEMBERSHIP_FEATURES))
                if rank_zero[index] != rank_one[index]))

minimal_subsets = [()] if not opposite_rank_difference_sets else []
if opposite_rank_difference_sets and all(opposite_rank_difference_sets):
    for subset_size in range(1, len(OUTSIDE_MEMBERSHIP_FEATURES) + 1):
        for subset in itertools.combinations(
                range(len(OUTSIDE_MEMBERSHIP_FEATURES)), subset_size):
            subset_set = frozenset(subset)
            if all(subset_set & difference
                   for difference in opposite_rank_difference_sets):
                minimal_subsets.append(subset)
        if minimal_subsets:
            break

all_features = tuple(range(len(OUTSIDE_MEMBERSHIP_FEATURES)))
full_conflicts = conflicting_requirements(all_features)
empty_candidate_counts = tuple(sum(
    1 for _, _, full_pair in records if not full_pair[rank])
    for rank in (0, 1))

print("BOTH CONNECTED RECORDS", len(records), flush=True)
print("EMPTY CANDIDATE COUNTS", empty_candidate_counts, flush=True)
print("REALIZABLE-INCIDENCE KEYS", len(requirements_for(())), flush=True)
print("REALIZABLE-INCIDENCE CONFLICTS", len(empty_conflicts), flush=True)
print("ENDPOINT-AND-REALIZABLE-INCIDENCE CONFLICTS",
      len(endpoint_empty_conflicts), flush=True)
print("SINGLE FEATURE CONFLICTS", single_feature_conflicts, flush=True)
print("OPPOSITE-RANK PAIRS", len(opposite_rank_difference_sets), flush=True)
print("EMPTY DIFFERENCE PAIRS", sum(
    1 for difference in opposite_rank_difference_sets if not difference),
    flush=True)
print("MINIMUM FEATURE COUNT", (
    len(minimal_subsets[0]) if minimal_subsets else None), flush=True)
print("MINIMAL FEATURE SUBSETS", [
    tuple(OUTSIDE_MEMBERSHIP_FEATURES[index] for index in subset)
    for subset in minimal_subsets
], flush=True)
print("FULL FEATURE KEYS", len(requirements_for(all_features)), flush=True)
print("FULL FEATURE CONFLICTS", len(full_conflicts), flush=True)

assert len(records) == 489
assert sum(
    len(candidate_descriptor)
    for _, _, full_pair in records
    for candidate_descriptor in full_pair) == 651
assert empty_candidate_counts == (153, 174)
assert len(requirements_for(())) == 94
assert not empty_conflicts
assert not endpoint_empty_conflicts
assert not opposite_rank_difference_sets
assert minimal_subsets == [()]
assert len(requirements_for(all_features)) == 393
assert not full_conflicts

certificate = {
    "kind": "cyclic-selector-realizable-boundary-incidence",
    "both_connected_record_count": int(len(records)),
    "realizable_incidence_count": int(651),
    "empty_candidate_counts_by_rank": [
        int(count) for count in empty_candidate_counts],
    "realizable_incidence_key_count": int(len(requirements_for(()))),
    "realizable_incidence_conflicting_key_count": int(len(empty_conflicts)),
    "endpoint_and_realizable_incidence_conflicting_key_count": int(
        len(endpoint_empty_conflicts)),
    "single_feature_conflicting_key_counts": [
        {
            "endpoint_role": feature[0],
            "relative_direction": feature[1],
            "membership": feature[2],
            "conflicting_key_count": int(single_feature_conflicts[feature]),
        }
        for feature in OUTSIDE_MEMBERSHIP_FEATURES
    ],
    "opposite_rank_pair_count": int(len(opposite_rank_difference_sets)),
    "empty_difference_pair_count": int(sum(
        1 for difference in opposite_rank_difference_sets if not difference)),
    "minimum_feature_count": (
        int(len(minimal_subsets[0])) if minimal_subsets else None),
    "minimal_feature_subsets": [
        [
            {
                "endpoint_role": OUTSIDE_MEMBERSHIP_FEATURES[index][0],
                "relative_direction": OUTSIDE_MEMBERSHIP_FEATURES[index][1],
                "membership": OUTSIDE_MEMBERSHIP_FEATURES[index][2],
            }
            for index in subset
        ]
        for subset in minimal_subsets
    ],
    "full_feature_key_count": int(len(requirements_for(all_features))),
    "full_feature_conflicting_key_count": int(len(full_conflicts)),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-realizable-boundary-incidence/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE", certificate_path, flush=True)

print("PASS: realizable boundary incidences were reclassified", flush=True)
