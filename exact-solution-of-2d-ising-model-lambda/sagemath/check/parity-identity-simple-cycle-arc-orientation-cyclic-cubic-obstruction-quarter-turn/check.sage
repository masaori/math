"""次数三以下の二つの左核矛盾証拠を四分の一回転で比較する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

端点だけの支持係数側の証拠に現れる巡回軌道を正方格子の正負の
四分の一回転で移し、語位置・端点の支持係数側の証拠に現れる巡回軌道との
共通部分を厳密に数える。内部語と二端点の全所属・切断旗を同時に回転する。
"""

import json
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-cubic-obstruction-structure/"
    "check.sage"
)


# スロット順は (up, down, left, right)。各置換は新しい各スロットへ
# どの古いスロットを運ぶかを表す。鏡映は含めない。
SQUARE_ROTATIONS = (
    (0, 1, 2, 3),
    (3, 2, 0, 1),
    (1, 0, 3, 2),
    (2, 3, 1, 0),
)
QUARTER_TURNS = (SQUARE_ROTATIONS[1], SQUARE_ROTATIONS[3])


def transform_slots(bits, rotation):
    assert len(bits) == 4
    return tuple(bits[index] for index in rotation)


def transform_letter_by_rotation(letter, rotation):
    in_single, wraps, extras = letter
    assert len(extras) == 1
    return (
        transform_slots(in_single, rotation),
        transform_slots(wraps, rotation),
        (transform_slots(extras[0], rotation),),
    )


def transform_endpoint_by_rotation(endpoint, rotation):
    memberships, wraps = endpoint
    by_name = {entry[0]: entry[1:] for entry in memberships}
    assert set(by_name) == set(DIRECTION_NAMES)
    transformed_memberships = tuple(
        (DIRECTION_NAMES[new_direction],) + by_name[DIRECTION_NAMES[old_direction]]
        for new_direction, old_direction in enumerate(rotation)
    )
    return (
        transformed_memberships,
        transform_slots(wraps, rotation),
    )


def transform_arc_type_by_rotation(arc_type, rotation):
    kind, word, endpoints = arc_type
    assert kind == "arc"
    transformed_word = tuple(
        transform_letter_by_rotation(letter, rotation) for letter in word
    )
    transformed_endpoints = tuple(sorted(
        transform_endpoint_by_rotation(endpoint, rotation)
        for endpoint in endpoints
    ))
    return (
        "arc",
        reversal_invariant_word(transformed_word),
        transformed_endpoints,
    )


def transform_orbit_by_rotation(orbit_key, rotation):
    return arc_cyclic_orbit_key(transform_arc_type_by_rotation(orbit_key, rotation))


first_orbits = {
    arc_cyclic_orbit_key(observations[index]["arc_type"])
    for index in witnesses[first]
}
second_orbits = {
    arc_cyclic_orbit_key(observations[index]["arc_type"])
    for index in witnesses[second]
}
all_orbits = {arc_cyclic_orbit_key(arc_type) for arc_type in arc_types}

turn_results = []
for turn_name, rotation in zip(("positive_quarter_turn", "negative_quarter_turn"), QUARTER_TURNS):
    images = {
        transform_orbit_by_rotation(orbit_key, rotation)
        for orbit_key in first_orbits
    }
    assert len(images) == len(first_orbits)
    intersection = images & second_orbits
    turn_results.append({
        "turn": turn_name,
        "rotation": list(map(int, rotation)),
        "image_orbit_count": len(images),
        "target_orbit_count": len(second_orbits),
        "intersection_count": len(intersection),
        "image_equals_target": images == second_orbits,
        "image_in_finite_universe_count": len(images & all_orbits),
        "missing_target_count": len(second_orbits - images),
        "outside_target_count": len(images - second_orbits),
    })

assert len(first_orbits) == 16
assert len(second_orbits) == 16

certificate = {
    "kind": "cyclic-cubic-obstruction-quarter-turn-comparison",
    "scope": source["scope"],
    "source_certificate": str(SOURCE),
    "support_order": list(support_order),
    "source_orbit_count": len(first_orbits),
    "target_orbit_count": len(second_orbits),
    "turn_results": turn_results,
    "conclusion": (
        "a quarter turn carries the complete first obstruction orbit set to the second"
        if any(result["image_equals_target"] for result in turn_results)
        else "neither quarter turn carries the complete first obstruction orbit set to the second"
    ),
    "no_automatic_escalation": (
        "this finite comparison does not authorize degree four or new primitive features"
    ),
}

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-cubic-obstruction-quarter-turn/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

for result in turn_results:
    print(
        "QUARTER TURN %s: intersection=%d/%d equal=%s in_universe=%d missing=%d outside=%d" % (
            result["turn"],
            result["intersection_count"],
            result["target_orbit_count"],
            result["image_equals_target"],
            result["image_in_finite_universe_count"],
            result["missing_target_count"],
            result["outside_target_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: cubic-obstruction quarter turns compared", flush=True)
