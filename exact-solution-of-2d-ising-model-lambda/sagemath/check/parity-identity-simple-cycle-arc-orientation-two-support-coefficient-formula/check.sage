"""二つの正準巡回支持を F_2 で合成した係数式を検査する。

対象ラベル: claim_two_support_coefficient_formula
一般の辺長についての検算ではない。
"""

import ast
import json
from pathlib import Path

def reversal_invariant_word(word):
    return min(word, tuple(reversed(word)))


def cyclic_reversal_invariant_word(word):
    return min(
        oriented[offset:] + oriented[:offset]
        for oriented in (word, tuple(reversed(word)))
        for offset in range(len(oriented)))


def rotate_word(word, shift):
    shift %= len(word)
    return word[shift:] + word[:shift]


def arc_cyclic_orbit_key(arc_type):
    kind, steps, endpoints = arc_type
    assert kind == "arc" and steps
    return ("arc", cyclic_reversal_invariant_word(steps), endpoints)


def arc_cyclic_selector(arc_type):
    _, steps, _ = arc_type
    key_steps = arc_cyclic_orbit_key(arc_type)[1]
    return min(
        shift for shift in range(len(steps))
        if reversal_invariant_word(rotate_word(key_steps, shift)) == steps)


def decode_arc_cyclic_encoding(orbit_key, selector):
    kind, key_steps, endpoints = orbit_key
    assert kind == "arc" and key_steps
    return (
        "arc",
        reversal_invariant_word(rotate_word(key_steps, selector)),
        endpoints,
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(certificate_path.read_text())["lifts"]

supports = {
    name: frozenset(map(ast.literal_eval, lift["arc_support"]))
    for name, lift in lifts.items()
}
assert set(supports) == {"endpoint_only", "step_endpoint"}


def orbit_coefficients(support):
    result = {}
    selectors = {}
    for arc_type in support:
        orbit_key = arc_cyclic_orbit_key(arc_type)
        selector = arc_cyclic_selector(arc_type)
        assert orbit_key not in result
        result[orbit_key] = 1
        selectors[orbit_key] = selector
    return result, selectors


endpoint_coefficients, endpoint_selectors = orbit_coefficients(
    supports["endpoint_only"])
step_coefficients, step_selectors = orbit_coefficients(
    supports["step_endpoint"])

shared_orbits = set(endpoint_coefficients) & set(step_coefficients)
assert len(shared_orbits) == 227
assert all(endpoint_selectors[orbit_key] == step_selectors[orbit_key]
           for orbit_key in shared_orbits)

combined_orbits = set(endpoint_coefficients) | set(step_coefficients)
combined_support = set()
for orbit_key in combined_orbits:
    orbit_coefficient = (
        endpoint_coefficients.get(orbit_key, 0)
        + step_coefficients.get(orbit_key, 0)) % 2
    if orbit_coefficient == 0:
        continue
    selector = (endpoint_selectors[orbit_key]
                if orbit_key in endpoint_selectors
                else step_selectors[orbit_key])
    combined_support.add(decode_arc_cyclic_encoding(orbit_key, selector))

expected_support = supports["endpoint_only"].symmetric_difference(
    supports["step_endpoint"])
assert combined_support == expected_support
assert len(combined_support) == 624

certificate = {
    "kind": "two-support-coefficient-formula",
    "coefficient_ring": "F2",
    "endpoint_orbit_count": len(endpoint_coefficients),
    "step_endpoint_orbit_count": len(step_coefficients),
    "shared_orbit_count": len(shared_orbits),
    "combined_nonzero_orbit_count": len(combined_support),
    "formula": "(endpoint orbit coefficient + step-endpoint orbit coefficient) at the shared selected cut",
}
output_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-two-support-coefficient-formula/"
    "certificate.json")
output_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")

print("PASS: two canonical supports combined into 624 orbit coefficients", flush=True)
