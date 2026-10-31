"""単一辺を基準に二重辺と切断旗の相対スロット配置を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

内部語の各文字は、単一辺 E、二重辺 D、切断旗の三つの四ビット列からなる。
上・下・左・右という絶対方向名を捨てる一方、E の局所向きに対する D と切断旗の
相対配置は全て保つため、三列を正方形の四つの回転で同時に移した軌道の
辞書式最小代表を局所族とする。この局所族の出現回数と相対端点 10 成分が、
二つの正準巡回支持の係数を決めるかを有限全データで判定する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-local-membership-family-decision/"
    "check.sage"
)


# スロット順は (up, down, left, right)。弧の向きが区別する時計回りと
# 反時計回りを保つため、鏡映は使わず回転四つだけを明示する。
square_rotations = (
    (0, 1, 2, 3),
    (3, 2, 0, 1),
    (1, 0, 3, 2),
    (2, 3, 1, 0),
)
assert len(set(square_rotations)) == 4


def transform_slots(bits, symmetry):
    return tuple(bits[index] for index in symmetry)


def relative_slot_family(letter):
    in_single, wraps, extras = letter
    in_doubled = extras[0]
    return min(
        (
            transform_slots(in_single, rotation),
            transform_slots(in_doubled, rotation),
            transform_slots(wraps, rotation),
        )
        for rotation in square_rotations
    )


relative_families = tuple(sorted({
    relative_slot_family(letter) for letter in alphabet
}))


def relative_family_count_vector(arc_type):
    counts = Counter(relative_slot_family(letter) for letter in arc_type[1])
    return tuple(ZZ(counts[family]) for family in relative_families)


def relative_family_summary(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = (
            selected_relative_descriptor(arc_type),
            relative_family_count_vector(arc_type),
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
            "relative_slot_family_counts": list(map(int, descriptor[1])),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


relative_summaries = {
    name: relative_family_summary(support)
    for name, support in supports.items()
}
assert len(arc_types) == 9739
assert len(alphabet) == 216
assert len(relative_families) == 55
assert relative_summaries["endpoint_only"]["descriptor_count"] == 6021
assert relative_summaries["step_endpoint"]["descriptor_count"] == 6021
assert relative_summaries["endpoint_only"]["mixed_coefficient_descriptor_count"] == 312
assert relative_summaries["step_endpoint"]["mixed_coefficient_descriptor_count"] == 381

certificate = {
    "kind": "cyclic-relative-slot-family-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "alphabet_size": len(alphabet),
    "square_rotation_count": len(square_rotations),
    "relative_slot_family_count": len(relative_families),
    "relative_slot_families": [
        [list(map(int, bits)) for bits in family]
        for family in relative_families
    ],
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "summaries": relative_summaries,
}

if all(
    summary["mixed_coefficient_descriptor_count"] == 0
    for summary in relative_summaries.values()
):
    certificate["conclusion"] = (
        "counts of the direction-name-free relative slot families together "
        "with the ten relative endpoint features determine both canonical "
        "coefficients on this finite universe"
    )
else:
    certificate["conclusion"] = (
        "counts of the direction-name-free relative slot families do not "
        "determine both canonical coefficients on this finite universe; "
        "relations between successive internal letters are still missing"
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-relative-slot-family-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ALPHABET SIZE: %d" % len(alphabet), flush=True)
print("RELATIVE SLOT FAMILIES: %d" % len(relative_families), flush=True)
for name, summary in relative_summaries.items():
    print(
        "DECISION %s: descriptors=%d mixed=%d" % (
            name,
            summary["descriptor_count"],
            summary["mixed_coefficient_descriptor_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: relative slot family decision completed", flush=True)
