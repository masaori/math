"""連続四文字の局所基準の回転関係を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

巡回内部語の連続四文字へ同じ四回転を同時に作用させ、その軌道の
辞書式最小代表を四文字族とする。四文字族の出現回数と相対端点
10 成分が、二つの正準巡回支持の係数を決めるかを有限全データで
判定する。記述は観測された族の非零成分だけを保存する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-triple-relative-frame-decision/"
    "check.sage"
)


def quadruple_relative_frame_family(
    first_letter,
    second_letter,
    third_letter,
    fourth_letter,
):
    return min(
        (
            transform_letter(first_letter, rotation),
            transform_letter(second_letter, rotation),
            transform_letter(third_letter, rotation),
            transform_letter(fourth_letter, rotation),
        )
        for rotation in square_rotations
    )


quadruple_families = tuple(sorted({
    quadruple_relative_frame_family(
        word[index],
        word[(index + 1) % len(word)],
        word[(index + 2) % len(word)],
        word[(index + 3) % len(word)],
    )
    for arc_type in arc_types
    for word in [arc_type[1]]
    for index in range(len(word))
}))
quadruple_family_index = {
    family: index for index, family in enumerate(quadruple_families)
}


def quadruple_family_sparse_count_vector(arc_type):
    word = arc_type[1]
    counts = Counter(
        quadruple_family_index[quadruple_relative_frame_family(
            word[index],
            word[(index + 1) % len(word)],
            word[(index + 2) % len(word)],
            word[(index + 3) % len(word)],
        )]
        for index in range(len(word))
    )
    return tuple(sorted((index, ZZ(count)) for index, count in counts.items()))


def quadruple_sparse_count_json(sparse_counts):
    return [
        {"family_index": int(index), "count": int(count)}
        for index, count in sparse_counts
    ]


def quadruple_family_summary(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = (
            selected_relative_descriptor(arc_type),
            quadruple_family_sparse_count_vector(arc_type),
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
            "quadruple_relative_frame_family_counts":
                quadruple_sparse_count_json(descriptor[1]),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


quadruple_summaries = {
    name: quadruple_family_summary(support)
    for name, support in supports.items()
}
assert len(arc_types) == 9739
assert len(alphabet) == 216

certificate = {
    "kind": "cyclic-quadruple-relative-frame-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "alphabet_size": len(alphabet),
    "square_rotation_count": len(square_rotations),
    "quadruple_relative_frame_family_count": len(quadruple_families),
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "summaries": quadruple_summaries,
}

if all(
    summary["mixed_coefficient_descriptor_count"] == 0
    for summary in quadruple_summaries.values()
):
    certificate["conclusion"] = (
        "cyclic counts of quadruple relative-frame families together with "
        "the ten relative endpoint features determine both canonical "
        "coefficients on this finite universe"
    )
else:
    certificate["conclusion"] = (
        "cyclic counts of quadruple relative-frame families do not determine "
        "both canonical coefficients on this finite universe"
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-quadruple-relative-frame-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ALPHABET SIZE: %d" % len(alphabet), flush=True)
print(
    "QUADRUPLE RELATIVE-FRAME FAMILIES: %d" % len(quadruple_families),
    flush=True,
)
for name, summary in quadruple_summaries.items():
    print(
        "DECISION %s: descriptors=%d mixed=%d" % (
            name,
            summary["descriptor_count"],
            summary["mixed_coefficient_descriptor_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: quadruple relative-frame decision completed", flush=True)
