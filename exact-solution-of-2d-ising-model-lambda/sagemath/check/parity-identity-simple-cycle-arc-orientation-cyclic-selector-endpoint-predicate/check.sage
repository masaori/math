"""端点ビットだけから有限支持上の切断候補を選べるか判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import hashlib
import json
from collections import Counter, defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-endpoint-predicate/construction.sage")


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]

candidate_rows = []
pair_records = []
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
        assert len(set(map(len, bits))) == 1
        rank = ordered.index(selected)
        endpoint_bits = endpoint_pair_bits(orbit_key)
        pair_records.append({
            "bits": endpoint_bits + bits[0] + bits[1],
            "target": rank,
            "word_length": len(orbit_key[1]),
            "support_name": support_name,
            "orbit_key": repr(orbit_key),
        })
        candidate_rows.extend((endpoint_bits + candidate_bits, ZZ(index == rank))
                              for index, candidate_bits in enumerate(bits))

pair_rows = [(record["bits"], record["target"]) for record in pair_records]
print("PAIR ROWS", len(pair_rows), flush=True)
print("CANDIDATE WIDTHS", Counter(len(bits) for bits, _ in candidate_rows), flush=True)

candidate_targets = defaultdict(set)
for bits, target in candidate_rows:
    candidate_targets[bits].add(target)
candidate_conflicts = {bits: targets for bits, targets in candidate_targets.items()
                       if len(targets) > 1}
print("CANDIDATE KEYS", len(candidate_targets), flush=True)
print("CANDIDATE CONFLICTS", len(candidate_conflicts), flush=True)

pair_targets = defaultdict(set)
for bits, target in pair_rows:
    pair_targets[bits].add(target)
pair_conflicts = {bits: targets for bits, targets in pair_targets.items()
                  if len(targets) > 1}
print("PAIR KEYS", len(pair_targets), flush=True)
print("PAIR CONFLICTS", len(pair_conflicts), flush=True)

pair_with_length_targets = defaultdict(set)
for record in pair_records:
    pair_with_length_targets[(record["word_length"], record["bits"])].add(
        record["target"])

assert len(pair_rows) == 781
assert Counter(len(bits) for bits, _ in candidate_rows) == {51: 1562}
assert len(candidate_targets) == 1194
assert len(candidate_conflicts) == 21
assert len(pair_targets) == 607
assert len(pair_conflicts) == 2
assert len(pair_with_length_targets) == 614
assert all(len(targets) == 1 for targets in pair_with_length_targets.values())

witnesses = []
for bits in sorted(pair_conflicts):
    observations = sorted(
        {
            (record["word_length"], record["target"], record["support_name"],
             record["orbit_key"])
            for record in pair_records if record["bits"] == bits
        })
    assert {observation[1] for observation in observations} == {0, 1}
    witnesses.append({
        "endpoint_bits": list(map(int, bits)),
        "endpoint_bits_sha256": hashlib.sha256(
            bytes(map(int, bits))).hexdigest(),
        "observations": [
            {
                "word_length": int(word_length),
                "selected_rank": int(target),
                "support_name": support_name,
                "orbit_key": orbit_key,
            }
            for word_length, target, support_name, orbit_key in observations
        ],
    })

certificate = {
    "kind": "cyclic-selector-endpoint-predicate-obstruction",
    "longer_support_entry_count": len(pair_rows),
    "candidate_bit_width": 51,
    "distinct_candidate_bit_count": len(candidate_targets),
    "conflicting_candidate_bit_count": len(candidate_conflicts),
    "distinct_candidate_pair_bit_count": len(pair_targets),
    "conflicting_candidate_pair_bit_count": len(pair_conflicts),
    "distinct_length_and_pair_bit_count": len(pair_with_length_targets),
    "conflicting_length_and_pair_bit_count": 0,
    "witnesses": witnesses,
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-endpoint-predicate/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"),
               default=int) + "\n")
print("CERTIFICATE", certificate_path, flush=True)
print("PASS: endpoint bits alone cannot determine the finite-support cut", flush=True)
