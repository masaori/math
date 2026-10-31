"""隣接文字間の局所基準の回転関係を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

各内部文字を別々に回転正規化すると、隣接する文字の局所基準が互いに
どれだけ回っているかを失う。そこで巡回内部語の隣接二文字へ同じ四回転を
同時に作用させ、その軌道の辞書式最小代表を隣接族とする。隣接族の出現回数と
相対端点 10 成分が、二つの正準巡回支持の係数を決めるかを有限全データで判定する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-relative-slot-family-decision/"
    "check.sage"
)


def transform_letter(letter, rotation):
    in_single, wraps, extras = letter
    assert len(extras) == 1
    in_doubled = extras[0]
    return (
        transform_slots(in_single, rotation),
        transform_slots(wraps, rotation),
        (transform_slots(in_doubled, rotation),),
    )


def adjacent_relative_frame_family(left_letter, right_letter):
    return min(
        (
            transform_letter(left_letter, rotation),
            transform_letter(right_letter, rotation),
        )
        for rotation in square_rotations
    )


adjacent_families = tuple(sorted({
    adjacent_relative_frame_family(word[index], word[(index + 1) % len(word)])
    for arc_type in arc_types
    for word in [arc_type[1]]
    for index in range(len(word))
}))


def adjacent_family_count_vector(arc_type):
    word = arc_type[1]
    counts = Counter(
        adjacent_relative_frame_family(word[index], word[(index + 1) % len(word)])
        for index in range(len(word))
    )
    return tuple(ZZ(counts[family]) for family in adjacent_families)


def adjacent_family_summary(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = (
            selected_relative_descriptor(arc_type),
            adjacent_family_count_vector(arc_type),
        )
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
            "relative_endpoint_descriptor": repr(descriptor[0]),
            "adjacent_relative_frame_family_counts": list(map(int, descriptor[1])),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


adjacent_summaries = {
    name: adjacent_family_summary(support)
    for name, support in supports.items()
}
assert len(arc_types) == 9739
assert len(alphabet) == 216

certificate = {
    "kind": "cyclic-adjacent-relative-frame-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "alphabet_size": len(alphabet),
    "square_rotation_count": len(square_rotations),
    "adjacent_relative_frame_family_count": len(adjacent_families),
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "summaries": adjacent_summaries,
}

if all(
    summary["mixed_coefficient_descriptor_count"] == 0
    for summary in adjacent_summaries.values()
):
    certificate["conclusion"] = (
        "cyclic counts of adjacent relative-frame families together with "
        "the ten relative endpoint features determine both canonical "
        "coefficients on this finite universe"
    )
else:
    certificate["conclusion"] = (
        "cyclic counts of adjacent relative-frame families do not determine "
        "both canonical coefficients on this finite universe"
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-adjacent-relative-frame-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ALPHABET SIZE: %d" % len(alphabet), flush=True)
print("ADJACENT RELATIVE-FRAME FAMILIES: %d" % len(adjacent_families), flush=True)
for name, summary in adjacent_summaries.items():
    print(
        "DECISION %s: descriptors=%d mixed=%d" % (
            name,
            summary["descriptor_count"],
            summary["mixed_coefficient_descriptor_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: adjacent relative-frame decision completed", flush=True)
