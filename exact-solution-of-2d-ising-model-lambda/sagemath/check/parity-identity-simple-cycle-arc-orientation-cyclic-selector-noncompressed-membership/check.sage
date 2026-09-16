"""端点の非圧縮所属が二つの切断候補を分けるかを確かめる。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import json
from collections import Counter, defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-noncompressed-membership/construction.sage")


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
        descriptors = {
            candidate: candidate_noncompressed_descriptor(orbit_key, candidate)
            for candidate in candidates
        }
        assert all(descriptors.values())
        rows.append((support_name, orbit_key, selected, candidates, descriptors))

print("ROWS", len(rows))
print("SELECTED MIN", sum(
    selected == min(candidates, key=lambda candidate: descriptors[candidate])
    for _, _, selected, candidates, descriptors in rows))
print("SELECTED MAX", sum(
    selected == max(candidates, key=lambda candidate: descriptors[candidate])
    for _, _, selected, candidates, descriptors in rows))
print("DESCRIPTOR TIES", sum(
    descriptors[candidates[0]] == descriptors[candidates[1]]
    for _, _, _, candidates, descriptors in rows))

# 同じ有限入力が観測済み支持の中で相反する選択を要求するかを調べる。
requirements = defaultdict(set)
for _, orbit_key, selected, candidates, descriptors in rows:
    unordered = tuple(sorted(descriptors[candidate] for candidate in candidates))
    selected_rank = tuple(sorted(
        candidates, key=lambda candidate: descriptors[candidate])).index(selected)
    requirements[(orbit_key[1], orbit_key[2], unordered)].add(selected_rank)
conflicts = Counter(len(values) for values in requirements.values())
print("REQUIREMENT MULTIPLICITIES", conflicts)

assert len(rows) == 781
assert sum(
    selected == min(candidates, key=lambda candidate: descriptors[candidate])
    for _, _, selected, candidates, descriptors in rows) == 443
assert sum(
    selected == max(candidates, key=lambda candidate: descriptors[candidate])
    for _, _, selected, candidates, descriptors in rows) == 500
assert sum(
    descriptors[candidates[0]] == descriptors[candidates[1]]
    for _, _, _, candidates, descriptors in rows) == 162
assert len(requirements) == 620
assert all(len(values) == 1 for values in requirements.values())

certificate = {
    "kind": "cyclic-selector-noncompressed-membership",
    "longer_support_entry_count": int(len(rows)),
    "distinct_orbit_requirement_count": int(len(requirements)),
    "descriptor_tie_count": int(162),
    "selected_lexicographic_minimum_count": int(443),
    "selected_lexicographic_maximum_count": int(500),
    "conflicting_shared_requirement_count": int(sum(
        len(values) != 1 for values in requirements.values())),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-noncompressed-membership/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE", certificate_path)
print("PASS: noncompressed endpoint membership is insufficient as a selector")
