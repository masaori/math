"""内部語の連結条件が切断候補と向き奇偶へ与える制約を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import json
from collections import defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-connected-cut/construction.sage")


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]

records = []
candidate_count = 0
connected_candidate_count = 0
connected_traversal_count = 0
selected_traversal_count = 0
unique_connected_cut_count = 0

for support_name, lift in sorted(lifts.items()):
    for arc_type in map(ast.literal_eval, lift["arc_support"]):
        if len(arc_type[1]) == 1:
            continue
        orbit_key = arc_cyclic_orbit_key(arc_type)
        selected = arc_cyclic_selector(arc_type)
        candidates = endpoint_boundary_selectors(orbit_key)
        assert len(candidates) == 2
        descriptors = {
            candidate: candidate_local_boundary_descriptor(orbit_key, candidate)
            for candidate in candidates
        }
        ordered = tuple(sorted(candidates, key=lambda candidate:
                               (descriptors[candidate], candidate)))
        bits = tuple(candidate_endpoint_bits(orbit_key, candidate)
                     for candidate in ordered)
        endpoint_bits = endpoint_pair_bits(orbit_key) + bits[0] + bits[1]

        connected_candidates = []
        for candidate in candidates:
            decoded_word = decode_arc_cyclic_encoding(orbit_key, candidate)[1]
            traversals = connected_word_traversals(decoded_word)
            candidate_count += 1
            connected_traversal_count += len(traversals)
            if traversals:
                connected_candidates.append(candidate)
                connected_candidate_count += 1
            for traversal in traversals:
                assert traversal_boundary_parity(traversal) == \
                    orientation_coordinate_parities(orbit_key)

        assert selected in connected_candidates
        selected_word = decode_arc_cyclic_encoding(orbit_key, selected)[1]
        selected_traversals = connected_word_traversals(selected_word)
        selected_traversal_count += len(selected_traversals)
        if len(connected_candidates) == 1:
            assert connected_candidates == [selected]
            unique_connected_cut_count += 1

        records.append({
            "endpoint_bits": endpoint_bits,
            "selected_rank": ZZ(ordered.index(selected)),
            "connected_candidate_bits": tuple(
                ZZ(candidate in connected_candidates) for candidate in ordered),
            "connected_candidate_count": ZZ(len(connected_candidates)),
            "orientation_parity": orientation_coordinate_parities(orbit_key),
            "word_length": ZZ(len(orbit_key[1])),
            "support_name": support_name,
        })

endpoint_targets = defaultdict(set)
for record in records:
    endpoint_targets[record["endpoint_bits"]].add(record["selected_rank"])
conflicting_bits = {
    bits for bits, targets in endpoint_targets.items() if len(targets) > 1
}
conflict_records = [
    record for record in records if record["endpoint_bits"] in conflicting_bits
]
connected_augmented_targets = defaultdict(set)
for record in records:
    connected_augmented_targets[
        (record["connected_candidate_bits"], record["endpoint_bits"])
    ].add(record["selected_rank"])
connected_augmented_conflicts = {
    key: targets for key, targets in connected_augmented_targets.items()
    if len(targets) > 1
}

assert len(records) == 781
assert candidate_count == 1562
assert connected_candidate_count == 1270
assert candidate_count - connected_candidate_count == 292
assert unique_connected_cut_count == 292
assert connected_traversal_count == 1429
assert selected_traversal_count == 911
assert len(conflicting_bits) == 2
assert not connected_augmented_conflicts
assert {
    record["connected_candidate_bits"]
    for record in conflict_records if record["word_length"] == 3
} == {(1, 1)}
assert all(
    sum(record["connected_candidate_bits"]) == 1
    for record in conflict_records if record["word_length"] == 5)
assert {
    record["orientation_parity"]
    for record in conflict_records if record["word_length"] == 3
} == {(1, 1, 1, 1)}
assert all(
    record["orientation_parity"] != (1, 1, 1, 1)
    for record in conflict_records if record["word_length"] == 5)

certificate = {
    "kind": "cyclic-selector-connected-cut",
    "longer_support_entry_count": len(records),
    "endpoint_boundary_candidate_count": candidate_count,
    "connected_candidate_count": connected_candidate_count,
    "disconnected_candidate_count": candidate_count - connected_candidate_count,
    "uniquely_selected_by_connectivity_count": unique_connected_cut_count,
    "connected_traversal_identity_count": connected_traversal_count,
    "selected_cut_traversal_count": selected_traversal_count,
    "endpoint_conflict_pair_bit_count": len(conflicting_bits),
    "distinct_connectivity_augmented_input_count": len(
        connected_augmented_targets),
    "conflicting_connectivity_augmented_input_count": len(
        connected_augmented_conflicts),
    "length_three_conflict_connectivity_bits": [[1, 1]],
    "length_five_conflict_has_unique_connected_candidate": True,
    "boundary_parity_identity": (
        "orientation parity = first incoming direction + last outgoing direction "
        "+ opposite-direction pairs of internal connecting edges over F2"),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-connected-cut/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"),
               default=int) + "\n")
print("CANDIDATES", candidate_count, flush=True)
print("CONNECTED CANDIDATES", connected_candidate_count, flush=True)
print("DISCONNECTED CANDIDATES", candidate_count - connected_candidate_count,
      flush=True)
print("UNIQUELY SELECTED BY CONNECTIVITY", unique_connected_cut_count, flush=True)
print("BOUNDARY PARITY IDENTITIES", connected_traversal_count, flush=True)
print("CERTIFICATE", certificate_path, flush=True)
print("PASS: connectivity constrains cuts and reconstructs orientation parity", flush=True)
