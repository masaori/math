"""端点の境界方向を共通基準にした内部文字の出現回数を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

一辺二・三の有限全データについて、各実現可能な境界入射候補の境界方向を
上方向へ送る一意な正方形回転を選ぶ。その同じ回転を内部語の全ての文字へ
作用させ、回転後の文字の出現回数と、その候補の相対端点十成分を対応づける。
候補ごとの対応を保った記述が二つの正準巡回支持の係数を決めるかを判定する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-adjacent-relative-frame-decision/"
    "check.sage"
)


def incidence_relative_bits(orbit_key, incidence):
    _, endpoint_index, boundary_direction, boundary_data = incidence
    endpoints = orbit_key[2]
    aligned_endpoint = endpoints[ZZ(endpoint_index)]
    other_endpoint = endpoints[1 - ZZ(endpoint_index)]
    endpoint_bits = []
    for endpoint in (aligned_endpoint, other_endpoint):
        endpoint_bits.extend(
            boundary_data
            if endpoint is aligned_endpoint
            else endpoint_direction_data(endpoint, boundary_direction)
        )
        for _, direction_map in RELATIVE_DIRECTIONS:
            endpoint_bits.extend(endpoint_direction_data(
                endpoint,
                direction_map[ZZ(boundary_direction)],
            ))
    assert len(endpoint_bits) == 32
    return tuple(endpoint_bits[index] for index in selected)


def boundary_to_up_rotation(boundary_direction):
    rotations = tuple(
        rotation
        for rotation in square_rotations
        if rotation[0] == ZZ(boundary_direction)
    )
    assert len(rotations) == 1
    return rotations[0]


boundary_framed_letters = tuple(sorted({
    transform_letter(letter, rotation)
    for letter in alphabet
    for rotation in square_rotations
}))
boundary_framed_letter_index = {
    letter: index for index, letter in enumerate(boundary_framed_letters)
}


def boundary_framed_candidate_descriptor(arc_type):
    orbit_key = arc_cyclic_orbit_key(arc_type)
    selector = arc_cyclic_selector(arc_type)
    incidences = candidate_boundary_incidence_descriptor(orbit_key, selector)
    candidates = []
    for incidence in incidences:
        boundary_direction = incidence[2]
        rotation = boundary_to_up_rotation(boundary_direction)
        counts = Counter(
            boundary_framed_letter_index[transform_letter(letter, rotation)]
            for letter in arc_type[1]
        )
        sparse_counts = tuple(sorted(
            (index, ZZ(count)) for index, count in counts.items()
        ))
        candidates.append((
            incidence_relative_bits(orbit_key, incidence),
            sparse_counts,
        ))
    descriptor = tuple(sorted(set(candidates)))
    assert descriptor
    return descriptor


descriptors = {
    arc_type: boundary_framed_candidate_descriptor(arc_type)
    for arc_type in arc_types
}


def coefficient_summary(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = descriptors[arc_type]
        classes.setdefault(descriptor, {0: [], 1: []})[
            ZZ(arc_type in support)
        ].append(arc_type)
    mixed = {
        descriptor: coefficient_classes
        for descriptor, coefficient_classes in classes.items()
        if coefficient_classes[0] and coefficient_classes[1]
    }
    witnesses = []
    for descriptor in sorted(mixed)[:2]:
        witnesses.append({
            "candidate_count": len(descriptor),
            "candidate_descriptors": [
                {
                    "relative_endpoint_bits": list(map(int, endpoint_bits)),
                    "boundary_framed_letter_counts": [
                        {"letter_index": int(index), "count": int(count)}
                        for index, count in sparse_counts
                    ],
                }
                for endpoint_bits, sparse_counts in descriptor
            ],
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


summaries = {
    name: coefficient_summary(support)
    for name, support in supports.items()
}

assert len(arc_types) == 9739
assert len(alphabet) == 216
assert len(boundary_framed_letters) == len(alphabet)

certificate = {
    "kind": "cyclic-boundary-framed-letter-count-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "alphabet_size": len(alphabet),
    "square_rotation_count": len(square_rotations),
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "summaries": summaries,
}

if all(
    summary["mixed_coefficient_descriptor_count"] == 0
    for summary in summaries.values()
):
    certificate["conclusion"] = (
        "candidate-wise counts of internal letters expressed in the common "
        "boundary-direction frame, paired with the ten relative endpoint "
        "features, determine both canonical coefficients on the finite universe"
    )
else:
    certificate["conclusion"] = (
        "candidate-wise counts of internal letters expressed in the common "
        "boundary-direction frame do not determine both canonical coefficients "
        "on the finite universe"
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-boundary-framed-letter-count-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ARC TYPES: %d" % len(arc_types), flush=True)
print("BOUNDARY-FRAMED LETTERS: %d" % len(boundary_framed_letters), flush=True)
for name, summary in summaries.items():
    print(
        "DECISION %s: descriptors=%d mixed=%d" % (
            name,
            summary["descriptor_count"],
            summary["mixed_coefficient_descriptor_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: boundary-framed letter-count decision completed", flush=True)
