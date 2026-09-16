"""二つの正準支持が共有軌道で同じ切断位置を選ぶことを確かめる。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import hashlib
import json
from collections import Counter, defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-consistency/construction.sage")


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]

records_by_orbit = defaultdict(list)
candidate_counts = Counter()
support_counts = {}
for support_name, lift in sorted(lifts.items()):
    support = tuple(ast.literal_eval(text) for text in lift["arc_support"])
    support_counts[support_name] = len(support)
    for arc_type in support:
        orbit_key = arc_cyclic_orbit_key(arc_type)
        selector = arc_cyclic_selector(arc_type)
        candidates = endpoint_boundary_selectors(orbit_key)
        assert selector in candidates
        expected_candidate_count = 1 if len(arc_type[1]) == 1 else 2
        assert len(candidates) == expected_candidate_count
        candidate_counts[(len(arc_type[1]), len(candidates))] += 1
        records_by_orbit[orbit_key].append((support_name, selector))

shared_records = tuple(
    records for records in records_by_orbit.values() if len(records) == 2)
assert all(len(records) <= 2 for records in records_by_orbit.values())
conflicting_records = tuple(
    records for records in shared_records
    if len({selector for _, selector in records}) != 1)

assert support_counts == {"endpoint_only": 462, "step_endpoint": 616}
assert len(records_by_orbit) == 851
assert len(shared_records) == 227
assert not conflicting_records
assert candidate_counts == Counter({
    (1, 1): 297,
    (2, 2): 162,
    (3, 2): 346,
    (5, 2): 178,
    (6, 2): 58,
    (7, 2): 37,
})

mapping_payload = tuple(sorted(
    (repr(orbit_key), tuple(sorted(records)))
    for orbit_key, records in records_by_orbit.items()))
mapping_digest = hashlib.sha256(
    repr(mapping_payload).encode("utf-8")).hexdigest()

certificate = {
    "kind": "cyclic-arc-selector-consistency",
    "support_counts": support_counts,
    "union_orbit_count": len(records_by_orbit),
    "shared_orbit_count": len(shared_records),
    "conflicting_shared_selector_count": len(conflicting_records),
    "endpoint_boundary_candidate_counts_by_length": {
        str(length): {str(count): int(multiplicity)}
        for (length, count), multiplicity in sorted(candidate_counts.items())
    },
    "selector_mapping_sha256": mapping_digest,
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-consistency/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")

print("SUPPORTS: endpoint_only=462 step_endpoint=616")
print("ORBITS: union=851 shared=227 conflicting_shared_selectors=0")
print("BOUNDARY CANDIDATES: length one has one; every longer observed word has two")
print("MAPPING SHA256: %s" % mapping_digest)
print("CERTIFICATE: %s" % certificate_path)
print("PASS: shared cyclic orbits choose consistent selectors")
