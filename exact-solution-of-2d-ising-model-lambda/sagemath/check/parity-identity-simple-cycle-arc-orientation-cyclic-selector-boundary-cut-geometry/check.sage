"""六ビット最小集合の五切断旗を内部語の両端の切断線幾何から導く。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。
"""

import ast
import json
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-cut-geometry/construction.sage")


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]

checked_records = 0
checked_candidates = 0
checked_incidences = 0
realizable_incidences = 0
unrealizable_incidences = 0
wrong_endpoint_incidences = 0
ambiguous_option_incidences = 0
option_count_distribution = {}
first_unrealizable = None
for support_name, lift in sorted(lifts.items()):
    for arc_type in map(ast.literal_eval, lift["arc_support"]):
        if len(arc_type[1]) == 1:
            continue
        orbit_key = arc_cyclic_orbit_key(arc_type)
        candidates = endpoint_boundary_selectors(orbit_key)
        assert len(candidates) == 2
        connected = tuple(
            candidate for candidate in candidates
            if connected_word_traversals(
                decode_arc_cyclic_encoding(orbit_key, candidate)[1]))
        if len(connected) != 2:
            continue
        checked_records += 1
        for candidate in connected:
            checked_candidates += 1
            incidences = candidate_boundary_incidence_descriptor(
                orbit_key, candidate)
            checked_incidences += len(incidences)
            _, _, endpoints = orbit_key
            for incidence in incidences:
                boundary_position, endpoint_index, boundary_direction, _ = incidence
                options = incidence_other_endpoint_wrap_options(
                    orbit_key, candidate, boundary_position,
                    endpoint_index, boundary_direction)
                option_count_distribution[len(options)] = (
                    option_count_distribution.get(len(options), 0) + 1)
                if len(options) > 1:
                    ambiguous_option_incidences += 1
                actual_other_wrap = endpoints[1 - ZZ(endpoint_index)][1]
                if not options:
                    unrealizable_incidences += 1
                    if first_unrealizable is None:
                        first_unrealizable = {
                            "word_length": len(orbit_key[1]),
                            "boundary_position": int(boundary_position),
                            "boundary_direction": int(boundary_direction),
                        }
                elif actual_other_wrap in options:
                    realizable_incidences += 1
                else:
                    wrong_endpoint_incidences += 1

assert checked_records == 489
assert unrealizable_incidences > 0
assert first_unrealizable is not None

certificate = {
    "kind": "cyclic-selector-boundary-cut-geometry",
    "both_connected_record_count": int(checked_records),
    "checked_candidate_count": int(checked_candidates),
    "checked_incidence_count": int(checked_incidences),
    "realizable_incidence_count": int(realizable_incidences),
    "unrealizable_incidence_count": int(unrealizable_incidences),
    "wrong_endpoint_incidence_count": int(wrong_endpoint_incidences),
    "ambiguous_option_incidence_count": int(ambiguous_option_incidences),
    "option_count_distribution": [
        {"option_count": int(count), "incidence_count": int(frequency)}
        for count, frequency in sorted(option_count_distribution.items())
    ],
    "first_unrealizable_witness": first_unrealizable,
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-cut-geometry/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")

print("BOTH CONNECTED RECORDS", checked_records, flush=True)
print("CHECKED CANDIDATES", checked_candidates, flush=True)
print("CHECKED INCIDENCES", checked_incidences, flush=True)
print("REALIZABLE INCIDENCES", realizable_incidences, flush=True)
print("UNREALIZABLE INCIDENCES", unrealizable_incidences, flush=True)
print("WRONG-ENDPOINT INCIDENCES", wrong_endpoint_incidences, flush=True)
print("AMBIGUOUS-OPTION INCIDENCES", ambiguous_option_incidences, flush=True)
print("OPTION-COUNT DISTRIBUTION", sorted(option_count_distribution.items()), flush=True)
print("CERTIFICATE", certificate_path, flush=True)
print("PASS: direction-only connectivity contains geometrically unrealizable incidences", flush=True)
