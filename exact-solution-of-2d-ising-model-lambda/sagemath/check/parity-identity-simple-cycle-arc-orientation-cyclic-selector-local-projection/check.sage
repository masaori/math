"""端点局所射影が有限支持上の切断候補を選べることを確かめる。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import json
from collections import Counter, defaultdict
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-local-projection/construction.sage")


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
            candidate: candidate_local_boundary_descriptor(orbit_key, candidate)
            for candidate in candidates
        }
        ordered = tuple(sorted(candidates, key=lambda candidate:
                               (descriptors[candidate], candidate)))
        rows.append((support_name, orbit_key, selected, ordered, descriptors))

requirements = defaultdict(set)
for support_name, orbit_key, selected, ordered, descriptors in rows:
    key = (
        len(orbit_key[1]),
        orbit_key[2],
        tuple(descriptors[candidate] for candidate in ordered),
    )
    rank = ordered.index(selected)
    requirements[key].add(rank)

conflicting_keys = {
    key: ranks for key, ranks in requirements.items() if len(ranks) > 1
}
conflicting_rows = sum(
    1
    for _, orbit_key, selected, ordered, descriptors in rows
    if len(requirements[(len(orbit_key[1]), orbit_key[2],
                         tuple(descriptors[candidate]
                               for candidate in ordered))]) > 1
)

print("ROWS", len(rows))
print("LOCAL KEYS", len(requirements))
print("CONFLICTING KEYS", len(conflicting_keys))
print("ROWS ON CONFLICTING KEYS", conflicting_rows)

assert len(rows) == 781
assert len(requirements) == 614
assert not conflicting_keys
assert conflicting_rows == 0
assert all(len(ranks) == 1 for ranks in requirements.values())

rank_distribution = Counter(next(iter(ranks)) for ranks in requirements.values())
certificate = {
    "kind": "cyclic-selector-local-projection",
    "longer_support_entry_count": int(len(rows)),
    "local_descriptor_count": int(len(requirements)),
    "conflicting_local_descriptor_count": int(len(conflicting_keys)),
    "rows_on_conflicting_local_descriptors": int(conflicting_rows),
    "selected_rank_distribution": {
        str(rank): int(count) for rank, count in sorted(rank_distribution.items())
    },
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-local-projection/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")
print("CERTIFICATE", certificate_path)
print("PASS: endpoint-local directed data determine the finite-support cut")
