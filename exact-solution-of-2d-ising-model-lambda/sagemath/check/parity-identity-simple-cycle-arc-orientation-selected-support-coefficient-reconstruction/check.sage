"""二つの正準巡回支持を軌道係数と実現可能な最小切断から再構成する。

対象ラベル: claim_selected_support_coefficient_reconstruction
一般の辺長・全語長についての検算ではない。
"""

import ast
import json
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-realizable-boundary-incidence/construction.sage")


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]

summaries = {}
total_reconstructed_orbits = 0

for support_name, lift in sorted(lifts.items()):
    support = tuple(map(ast.literal_eval, lift["arc_support"]))
    actual_coefficients = {}
    orbit_coefficients = {}
    minimum_realizable_selectors = {}

    for arc_type in support:
        if len(arc_type[1]) == 1:
            continue
        orbit_key = arc_cyclic_orbit_key(arc_type)
        selector = arc_cyclic_selector(arc_type)

        candidates = endpoint_boundary_selectors(orbit_key)
        if len(candidates) != 2:
            continue
        connected = tuple(
            candidate for candidate in candidates
            if connected_word_traversals(
                decode_arc_cyclic_encoding(orbit_key, candidate)[1]))
        if len(connected) != 2:
            continue
        assert orbit_key not in orbit_coefficients
        realizable = tuple(
            candidate for candidate in candidates
            if candidate_realizable_boundary_incidence_descriptor(
                orbit_key, candidate))
        assert realizable
        selected = min(realizable)
        assert selector == selected

        for candidate in candidates:
            actual_coefficients[(orbit_key, candidate)] = ZZ(
                candidate == selector)
        orbit_coefficient = sum(
            actual_coefficients[(orbit_key, candidate)]
            for candidate in candidates) % 2
        orbit_coefficients[orbit_key] = orbit_coefficient
        minimum_realizable_selectors[orbit_key] = selected

    reconstructed_count = 0
    for orbit_key, orbit_coefficient in orbit_coefficients.items():
        selected = minimum_realizable_selectors[orbit_key]
        for candidate in endpoint_boundary_selectors(orbit_key):
            reconstructed = orbit_coefficient if candidate == selected else 0
            assert reconstructed == actual_coefficients[(orbit_key, candidate)]
            reconstructed_count += 1

    total_reconstructed_orbits += len(orbit_coefficients)
    summaries[support_name] = {
        "ambiguous_connected_orbit_count": int(len(orbit_coefficients)),
        "reconstructed_candidate_coefficient_count": int(reconstructed_count),
    }

assert total_reconstructed_orbits == 489

certificate = {
    "kind": "selected-support-coefficient-reconstruction",
    "coefficient_ring": "F2",
    "selector_rule": "least realizable cut candidate",
    "ambiguous_connected_orbit_count": int(total_reconstructed_orbits),
    "summaries": summaries,
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-selected-support-coefficient-reconstruction/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")

print("PASS: both canonical cyclic supports were reconstructed", flush=True)
