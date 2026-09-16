"""反転正規化前の向きが同値な切断候補を分けるかを確かめる。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import json
from collections import Counter, defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-directed-boundary/construction.sage")


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]

rows = []
for support_name, lift in sorted(lifts.items()):
    for arc_type in map(ast.literal_eval, lift["arc_support"]):
        if len(arc_type[1]) == 1:
            continue
        orbit_key = arc_cyclic_orbit_key(arc_type)
        selected = arc_cyclic_selector(arc_type)
        candidates = endpoint_boundary_selectors(orbit_key)
        assert len(candidates) == 2
        old_descriptors = {
            candidate: candidate_noncompressed_descriptor(orbit_key, candidate)
            for candidate in candidates
        }
        descriptors = {
            candidate: candidate_directed_boundary_descriptor(orbit_key, candidate)
            for candidate in candidates
        }
        rows.append((support_name, orbit_key, selected, candidates,
                     old_descriptors, descriptors))

old_ties = [row for row in rows
            if row[4][row[3][0]] == row[4][row[3][1]]]
remaining_ties = [row for row in old_ties
                  if row[5][row[3][0]] == row[5][row[3][1]]]
print("ROWS", len(rows))
print("OLD TIES", len(old_ties))
print("REMAINING TIES", len(remaining_ties))

requirements = defaultdict(set)
for _, orbit_key, selected, candidates, _, descriptors in rows:
    ordered = tuple(sorted(candidates, key=lambda candidate: descriptors[candidate]))
    requirements[(orbit_key[1], orbit_key[2],
                  tuple(descriptors[candidate] for candidate in ordered))].add(
                      ordered.index(selected))
conflicts = Counter(len(values) for values in requirements.values())
print("REQUIREMENT MULTIPLICITIES", conflicts)

assert len(rows) == 781
assert len(old_ties) == 162
assert len(remaining_ties) == 0
assert len(requirements) == 620
assert all(len(values) == 1 for values in requirements.values())

certificate = {
    "kind": "cyclic-selector-directed-boundary",
    "longer_support_entry_count": int(len(rows)),
    "previously_tied_entry_count": int(len(old_ties)),
    "remaining_tied_entry_count": int(len(remaining_ties)),
    "distinct_orbit_requirement_count": int(len(requirements)),
    "conflicting_shared_requirement_count": int(sum(
        len(values) != 1 for values in requirements.values())),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-directed-boundary/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE", certificate_path)
print("PASS: the pre-reversal orientation separates the tied candidates")
