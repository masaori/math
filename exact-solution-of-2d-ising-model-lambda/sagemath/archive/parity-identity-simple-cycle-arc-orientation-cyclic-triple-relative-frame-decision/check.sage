"""連続三文字の局所基準の回転関係を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

巡回内部語の連続三文字へ同じ四回転を同時に作用させ、その軌道の
辞書式最小代表を三文字族とする。三文字族の出現回数と相対端点
10 成分が、二つの正準巡回支持の係数を決めるかを有限全データで
判定する。記述は観測された族の非零成分だけを保存する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-adjacent-relative-frame-decision/"
    "check.sage"
)


def triple_relative_frame_family(first_letter, second_letter, third_letter):
    return min(
        (
            transform_letter(first_letter, rotation),
            transform_letter(second_letter, rotation),
            transform_letter(third_letter, rotation),
        )
        for rotation in square_rotations
    )


triple_families = tuple(sorted({
    triple_relative_frame_family(
        word[index],
        word[(index + 1) % len(word)],
        word[(index + 2) % len(word)],
    )
    for arc_type in arc_types
    for word in [arc_type[1]]
    for index in range(len(word))
}))
triple_family_index = {
    family: index for index, family in enumerate(triple_families)
}


def triple_family_sparse_count_vector(arc_type):
    word = arc_type[1]
    counts = Counter(
        triple_family_index[triple_relative_frame_family(
            word[index],
            word[(index + 1) % len(word)],
            word[(index + 2) % len(word)],
        )]
        for index in range(len(word))
    )
    return tuple(sorted((index, ZZ(count)) for index, count in counts.items()))


def sparse_count_json(sparse_counts):
    return [
        {"family_index": int(index), "count": int(count)}
        for index, count in sparse_counts
    ]


def triple_family_summary(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = (
            selected_relative_descriptor(arc_type),
            triple_family_sparse_count_vector(arc_type),
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
            "triple_relative_frame_family_counts": sparse_count_json(descriptor[1]),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


triple_summaries = {
    name: triple_family_summary(support)
    for name, support in supports.items()
}
assert len(arc_types) == 9739
assert len(alphabet) == 216

certificate = {
    "kind": "cyclic-triple-relative-frame-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "alphabet_size": len(alphabet),
    "square_rotation_count": len(square_rotations),
    "triple_relative_frame_family_count": len(triple_families),
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "summaries": triple_summaries,
}

if all(
    summary["mixed_coefficient_descriptor_count"] == 0
    for summary in triple_summaries.values()
):
    certificate["conclusion"] = (
        "cyclic counts of triple relative-frame families together with "
        "the ten relative endpoint features determine both canonical "
        "coefficients on this finite universe"
    )
else:
    certificate["conclusion"] = (
        "cyclic counts of triple relative-frame families do not determine "
        "both canonical coefficients on this finite universe"
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-triple-relative-frame-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ALPHABET SIZE: %d" % len(alphabet), flush=True)
print("TRIPLE RELATIVE-FRAME FAMILIES: %d" % len(triple_families), flush=True)
for name, summary in triple_summaries.items():
    print(
        "DECISION %s: descriptors=%d mixed=%d" % (
            name,
            summary["descriptor_count"],
            summary["mixed_coefficient_descriptor_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: triple relative-frame decision completed", flush=True)
