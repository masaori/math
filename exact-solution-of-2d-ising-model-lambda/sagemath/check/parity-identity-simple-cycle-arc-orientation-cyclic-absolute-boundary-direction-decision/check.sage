"""絶対境界方向を戻した候補記述で二つの巡回係数を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

一辺二・三の有限全データについて、境界方向を上方向へ正規化した巡回三文字
頻度と相対端点十成分からなる従来の候補記述へ、正規化前の絶対境界方向を戻す。
この追加情報だけで二つの正準巡回支持の係数衝突が消えるかを判定する。
"""

import json
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-boundary-framed-triple-count-decision/"
    "check.sage"
)


def absolute_boundary_direction_candidate_descriptor(arc_type):
    orbit_key = arc_cyclic_orbit_key(arc_type)
    selector = arc_cyclic_selector(arc_type)
    incidences = candidate_boundary_incidence_descriptor(orbit_key, selector)
    candidates = []
    for incidence in incidences:
        boundary_direction = ZZ(incidence[2])
        rotation = boundary_to_up_rotation(boundary_direction)
        transformed_word = tuple(
            transform_letter(letter, rotation) for letter in arc_type[1]
        )
        counts = Counter(
            boundary_framed_triple_index[(
                transformed_word[index],
                transformed_word[(index + 1) % len(transformed_word)],
                transformed_word[(index + 2) % len(transformed_word)],
            )]
            for index in range(len(transformed_word))
        )
        sparse_counts = tuple(sorted(
            (index, ZZ(count)) for index, count in counts.items()
        ))
        candidates.append((
            boundary_direction,
            incidence_relative_bits(orbit_key, incidence),
            sparse_counts,
        ))
    descriptor = tuple(sorted(set(candidates)))
    assert descriptor
    return descriptor


absolute_descriptors = {
    arc_type: absolute_boundary_direction_candidate_descriptor(arc_type)
    for arc_type in arc_types
}


def coefficient_summary_with_absolute_direction(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = absolute_descriptors[arc_type]
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
                    "absolute_boundary_direction": int(boundary_direction),
                    "relative_endpoint_bits": list(map(int, endpoint_bits)),
                    "boundary_framed_triple_counts": [
                        {"triple_index": int(index), "count": int(count)}
                        for index, count in sparse_counts
                    ],
                }
                for boundary_direction, endpoint_bits, sparse_counts in descriptor
            ],
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


absolute_summaries = {
    name: coefficient_summary_with_absolute_direction(support)
    for name, support in supports.items()
}

for name in supports:
    assert absolute_summaries[name]["descriptor_count"] >= summaries[name]["descriptor_count"]

all_coefficients_determined = all(
    summary["mixed_coefficient_descriptor_count"] == 0
    for summary in absolute_summaries.values()
)

certificate = {
    "kind": "cyclic-absolute-boundary-direction-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "absolute_boundary_direction_count": 4,
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "baseline_summaries": summaries,
    "absolute_direction_summaries": absolute_summaries,
}
if all_coefficients_determined:
    certificate["conclusion"] = (
        "restoring the absolute boundary direction to each candidate eliminates "
        "all coefficient conflicts on the finite universe"
    )
else:
    certificate["conclusion"] = (
        "restoring the absolute boundary direction refines the candidate "
        "partition but does not eliminate all coefficient conflicts on the "
        "finite universe"
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-absolute-boundary-direction-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ARC TYPES: %d" % len(arc_types), flush=True)
for name in supports:
    print(
        "DECISION %s: baseline descriptors=%d mixed=%d; absolute descriptors=%d mixed=%d" % (
            name,
            summaries[name]["descriptor_count"],
            summaries[name]["mixed_coefficient_descriptor_count"],
            absolute_summaries[name]["descriptor_count"],
            absolute_summaries[name]["mixed_coefficient_descriptor_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: absolute-boundary-direction decision completed", flush=True)
