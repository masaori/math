"""端点ビットの二衝突に必要な語長述語を有限支持上で切り分ける。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import json
from collections import defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-length-three-indicator/construction.sage")


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
        records.append({
            "endpoint_bits": endpoint_pair_bits(orbit_key) + bits[0] + bits[1],
            "target": ZZ(ordered.index(selected)),
            "word_length": ZZ(len(orbit_key[1])),
            "length_three": word_length_is_three(orbit_key),
            "support_name": support_name,
            "orbit_key": repr(orbit_key),
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
assert all(record["word_length"] % 2 == 1 for record in conflict_records)

for bits in conflicting_bits:
    observations = [record for record in conflict_records
                    if record["endpoint_bits"] == bits]
    assert {record["word_length"] for record in observations} == {3, 5}
    assert {record["target"] for record in observations} == {0, 1}
    by_length = defaultdict(set)
    for record in observations:
        by_length[record["word_length"]].add(record["target"])
    assert all(len(targets) == 1 for targets in by_length.values())

augmented_targets = defaultdict(set)
for record in records:
    augmented_targets[
        (record["length_three"], record["endpoint_bits"])
    ].add(record["target"])
augmented_conflicts = {
    key: targets for key, targets in augmented_targets.items()
    if len(targets) > 1
}
assert not augmented_conflicts

certificate = {
    "kind": "cyclic-selector-length-three-indicator",
    "longer_support_entry_count": len(records),
    "conflicting_endpoint_pair_bit_count": len(conflicting_bits),
    "conflict_word_lengths": sorted({
        int(record["word_length"]) for record in conflict_records
    }),
    "conflict_word_length_parities": sorted({
        int(record["word_length"] % 2) for record in conflict_records
    }),
    "predicate": "word_length == 3",
    "distinct_augmented_input_count": len(augmented_targets),
    "conflicting_augmented_input_count": len(augmented_conflicts),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-length-three-indicator/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"),
               default=int) + "\n")
print("CONFLICT WORD LENGTHS", certificate["conflict_word_lengths"], flush=True)
print("CONFLICT WORD LENGTH PARITIES",
      certificate["conflict_word_length_parities"], flush=True)
print("AUGMENTED INPUTS", len(augmented_targets), flush=True)
print("AUGMENTED CONFLICTS", len(augmented_conflicts), flush=True)
print("CERTIFICATE", certificate_path, flush=True)
print("PASS: the length-three bit separates both endpoint-bit conflicts", flush=True)
