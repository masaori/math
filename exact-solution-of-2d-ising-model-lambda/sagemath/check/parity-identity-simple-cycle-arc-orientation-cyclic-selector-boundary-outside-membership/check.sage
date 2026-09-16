"""20 個の境界入射衝突を分ける境界方向外の端点所属ビットを切り分ける。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import itertools
import json
from collections import defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-outside-membership/construction.sage")


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
        incidence_pair = tuple(
            candidate_boundary_incidence_descriptor(orbit_key, candidate)
            for candidate in ordered)
        outside_pair = tuple(
            candidate_boundary_outside_membership_descriptor(
                orbit_key, candidate)
            for candidate in ordered)
        records.append((selected_rank, incidence_pair, outside_pair))


def project_outside_pair(outside_pair, feature_indices):
    return tuple(
        tuple(
            incidence[:4] + (tuple(
                incidence[4][index] for index in feature_indices),)
            for incidence in candidate_descriptor)
        for candidate_descriptor in outside_pair)


def requirements_for(feature_indices):
    requirements = defaultdict(set)
    for selected_rank, incidence_pair, outside_pair in records:
        projected = project_outside_pair(outside_pair, feature_indices)
        requirements[(incidence_pair, projected)].add(selected_rank)
    return requirements


def conflict_count(feature_indices):
    return sum(
        1 for ranks in requirements_for(feature_indices).values()
        if len(ranks) > 1)


empty_conflict_count = conflict_count(())
single_feature_conflicts = {
    OUTSIDE_MEMBERSHIP_FEATURES[index]: conflict_count((index,))
    for index in range(len(OUTSIDE_MEMBERSHIP_FEATURES))
}

incidence_groups = defaultdict(lambda: {0: [], 1: []})
for selected_rank, incidence_pair, outside_pair in records:
    feature_signatures = tuple(
        project_outside_pair(outside_pair, (index,))
        for index in range(len(OUTSIDE_MEMBERSHIP_FEATURES)))
    incidence_groups[incidence_pair][selected_rank].append(feature_signatures)

opposite_rank_difference_sets = []
for rank_groups in incidence_groups.values():
    for rank_zero in rank_groups[0]:
        for rank_one in rank_groups[1]:
            difference = frozenset(
                index for index in range(len(OUTSIDE_MEMBERSHIP_FEATURES))
                if rank_zero[index] != rank_one[index])
            opposite_rank_difference_sets.append(difference)

minimal_subsets = []
if all(opposite_rank_difference_sets):
    for subset_size in range(1, len(OUTSIDE_MEMBERSHIP_FEATURES) + 1):
        for subset in itertools.combinations(
                range(len(OUTSIDE_MEMBERSHIP_FEATURES)), subset_size):
            subset_set = frozenset(subset)
            if all(subset_set & difference
                   for difference in opposite_rank_difference_sets):
                minimal_subsets.append(subset)
        if minimal_subsets:
            break

full_requirements = requirements_for(
    tuple(range(len(OUTSIDE_MEMBERSHIP_FEATURES))))
full_conflict_count = sum(
    1 for ranks in full_requirements.values() if len(ranks) > 1)

print("BOTH CONNECTED RECORDS", len(records), flush=True)
print("EMPTY FEATURE CONFLICTS", empty_conflict_count, flush=True)
print("SINGLE FEATURE CONFLICTS", single_feature_conflicts, flush=True)
print("OPPOSITE-RANK PAIRS", len(opposite_rank_difference_sets), flush=True)
print("EMPTY DIFFERENCE PAIRS", sum(
    1 for difference in opposite_rank_difference_sets if not difference), flush=True)
print("MINIMUM FEATURE COUNT", (
    len(minimal_subsets[0]) if minimal_subsets else None), flush=True)
print("MINIMAL FEATURE SUBSETS", [
    tuple(OUTSIDE_MEMBERSHIP_FEATURES[index] for index in subset)
    for subset in minimal_subsets
], flush=True)
print("FULL FEATURE KEYS", len(full_requirements), flush=True)
print("FULL FEATURE CONFLICTS", full_conflict_count, flush=True)

assert len(records) == 489
assert empty_conflict_count == 20
assert full_conflict_count == 0
assert minimal_subsets

certificate = {
    "kind": "cyclic-selector-boundary-outside-membership",
    "both_connected_record_count": int(len(records)),
    "incidence_only_conflicting_key_count": int(empty_conflict_count),
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
    "minimum_feature_count": int(len(minimal_subsets[0])),
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
    "full_feature_key_count": int(len(full_requirements)),
    "full_feature_conflicting_key_count": int(full_conflict_count),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-outside-membership/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE", certificate_path, flush=True)

print("PASS: outside endpoint membership bits separate boundary conflicts", flush=True)
