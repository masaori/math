"""両切断候補が連結する場合の境界方向と端点所属を分類する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import json
from collections import Counter, defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-incidence/construction.sage")


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]

records = []
membership_counts = Counter()
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
        descriptors = {
            candidate: candidate_boundary_incidence_descriptor(
                orbit_key, candidate)
            for candidate in candidates
        }
        ordered = tuple(sorted(
            candidates,
            key=lambda candidate: (
                candidate_local_boundary_descriptor(orbit_key, candidate),
                candidate)))
        selected_rank = ZZ(ordered.index(selected))
        descriptor_pair = tuple(descriptors[candidate] for candidate in ordered)
        records.append((
            support_name,
            orbit_key,
            selected_rank,
            descriptor_pair,
        ))
        for rank, descriptor in enumerate(descriptor_pair):
            for _, _, _, membership in descriptor:
                membership_counts[(ZZ(rank == selected_rank), membership)] += 1

requirements = defaultdict(set)
incidence_only_requirements = defaultdict(set)
for _, orbit_key, selected_rank, descriptor_pair in records:
    requirements[(orbit_key[2], descriptor_pair)].add(selected_rank)
    incidence_only_requirements[descriptor_pair].add(selected_rank)
conflicts = {
    key: ranks for key, ranks in requirements.items() if len(ranks) > 1
}
incidence_only_conflicts = {
    key: ranks for key, ranks in incidence_only_requirements.items()
    if len(ranks) > 1
}

print("BOTH CONNECTED RECORDS", len(records), flush=True)
print("BOUNDARY INCIDENCE KEYS", len(requirements), flush=True)
print("CONFLICTING INCIDENCE KEYS", len(conflicts), flush=True)
print("INCIDENCE-ONLY KEYS", len(incidence_only_requirements), flush=True)
print("CONFLICTING INCIDENCE-ONLY KEYS", len(incidence_only_conflicts), flush=True)
print("MEMBERSHIP COUNTS", sorted(membership_counts.items()), flush=True)

assert len(records) == 489
assert len(requirements) == 393
assert not conflicts
assert len(incidence_only_requirements) == 117
assert len(incidence_only_conflicts) == 20
assert membership_counts == Counter({
    (0, (0, 1, 0, 0)): 151,
    (0, (0, 1, 0, 1)): 106,
    (0, (0, 1, 1, 0)): 172,
    (0, (0, 1, 1, 1)): 89,
    (1, (0, 1, 0, 0)): 159,
    (1, (0, 1, 0, 1)): 117,
    (1, (0, 1, 1, 0)): 179,
    (1, (0, 1, 1, 1)): 63,
})

certificate = {
    "kind": "cyclic-selector-boundary-incidence",
    "both_connected_record_count": len(records),
    "endpoint_and_incidence_key_count": len(requirements),
    "conflicting_endpoint_and_incidence_key_count": len(conflicts),
    "incidence_only_key_count": len(incidence_only_requirements),
    "conflicting_incidence_only_key_count": len(incidence_only_conflicts),
    "boundary_direction_membership_counts": [
        {
            "selected": int(selected),
            "in_doubled": int(membership[0]),
            "in_single": int(membership[1]),
            "in_chosen": int(membership[2]),
            "wrap": int(membership[3]),
            "count": int(count),
        }
        for (selected, membership), count in sorted(membership_counts.items())
    ],
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-incidence/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE", certificate_path, flush=True)

print("PASS: boundary directions are classified by endpoint memberships", flush=True)
