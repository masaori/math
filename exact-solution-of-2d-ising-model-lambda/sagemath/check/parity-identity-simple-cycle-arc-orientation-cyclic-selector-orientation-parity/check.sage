"""語長三の指示ビットを内部語の向き座標の奇偶から導く。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import json
from collections import defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-orientation-parity/construction.sage")


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
        descriptors = {
            candidate: candidate_local_boundary_descriptor(orbit_key, candidate)
            for candidate in candidates
        }
        ordered = tuple(sorted(candidates, key=lambda candidate:
                               (descriptors[candidate], candidate)))
        bits = tuple(candidate_endpoint_bits(orbit_key, candidate)
                     for candidate in ordered)
        parities = orientation_coordinate_parities(orbit_key)
        predicate = all_orientation_coordinates_odd(orbit_key)

        # 語順の巡回移動と反転は座標ごとの排他的論理和を変えない。
        key_steps = orbit_key[1]
        for shift in range(len(key_steps)):
            rotated_key = (orbit_key[0], rotate_word(key_steps, shift), orbit_key[2])
            reversed_key = (orbit_key[0], tuple(reversed(rotated_key[1])), orbit_key[2])
            assert orientation_coordinate_parities(rotated_key) == parities
            assert orientation_coordinate_parities(reversed_key) == parities

        records.append({
            "endpoint_bits": endpoint_pair_bits(orbit_key) + bits[0] + bits[1],
            "target": ZZ(ordered.index(selected)),
            "word_length": ZZ(len(key_steps)),
            "orientation_parities": parities,
            "predicate": predicate,
        })

endpoint_targets = defaultdict(set)
for record in records:
    endpoint_targets[record["endpoint_bits"]].add(record["target"])
conflicting_bits = {
    bits for bits, targets in endpoint_targets.items() if len(targets) > 1
}
conflict_records = [
    record for record in records if record["endpoint_bits"] in conflicting_bits
]

assert len(conflicting_bits) == 2
assert {record["word_length"] for record in conflict_records} == {3, 5}
assert {
    record["orientation_parities"]
    for record in conflict_records if record["word_length"] == 3
} == {(1, 1, 1, 1)}
assert all(
    record["orientation_parities"] != (1, 1, 1, 1)
    for record in conflict_records if record["word_length"] == 5
)

for bits in conflicting_bits:
    observations = [record for record in conflict_records
                    if record["endpoint_bits"] == bits]
    by_predicate = defaultdict(set)
    for record in observations:
        by_predicate[record["predicate"]].add(record["target"])
    assert set(by_predicate) == {0, 1}
    assert all(len(targets) == 1 for targets in by_predicate.values())

augmented_targets = defaultdict(set)
for record in records:
    augmented_targets[
        (record["predicate"], record["endpoint_bits"])
    ].add(record["target"])
augmented_conflicts = {
    key: targets for key, targets in augmented_targets.items()
    if len(targets) > 1
}
assert not augmented_conflicts

certificate = {
    "kind": "cyclic-selector-orientation-parity-predicate",
    "longer_support_entry_count": len(records),
    "conflicting_endpoint_pair_bit_count": len(conflicting_bits),
    "length_three_conflict_orientation_parities": [[1, 1, 1, 1]],
    "length_five_conflict_orientation_parities": [list(parities) for parities in sorted({
        record["orientation_parities"]
        for record in conflict_records if record["word_length"] == 5
    })],
    "predicate": "all four orientation-coordinate counts are odd",
    "distinct_augmented_input_count": len(augmented_targets),
    "conflicting_augmented_input_count": len(augmented_conflicts),
    "cyclic_and_reversal_invariance_checked": True,
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-orientation-parity/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"),
               default=int) + "\n")
print("LENGTH THREE PARITIES", [[1, 1, 1, 1]], flush=True)
print("LENGTH FIVE PARITIES",
      certificate["length_five_conflict_orientation_parities"], flush=True)
print("AUGMENTED INPUTS", len(augmented_targets), flush=True)
print("AUGMENTED CONFLICTS", len(augmented_conflicts), flush=True)
print("CERTIFICATE", certificate_path, flush=True)
print("PASS: orientation-coordinate parity derives the needed conflict bit", flush=True)
