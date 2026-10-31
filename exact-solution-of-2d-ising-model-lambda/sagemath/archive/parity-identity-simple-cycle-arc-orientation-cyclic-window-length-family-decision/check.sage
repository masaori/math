"""未評価の巡回窓長を有限集合として一括判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

一辺二・三の有限全データに現れる内部語の最大長を求め、既に評価済みの
長さ四を超える窓長を全て列挙する。各窓長について、連続文字へ同じ
四回転を作用させた族の巡回出現回数と相対端点十成分が二つの正準支持の
係数を決めるかを判定する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-quadruple-relative-frame-decision/"
    "check.sage"
)


evaluated_maximum_window_length = 4
maximum_internal_word_length = max(len(arc_type[1]) for arc_type in arc_types)
unevaluated_window_lengths = tuple(range(
    evaluated_maximum_window_length + 1,
    maximum_internal_word_length + 1,
))
assert unevaluated_window_lengths


def relative_frame_family(window):
    return min(
        tuple(transform_letter(letter, rotation) for letter in window)
        for rotation in square_rotations
    )


def cyclic_window(word, start, window_length):
    return tuple(word[(start + offset) % len(word)] for offset in range(window_length))


def family_data(window_length):
    families = tuple(sorted({
        relative_frame_family(cyclic_window(word, index, window_length))
        for arc_type in arc_types
        for word in [arc_type[1]]
        for index in range(len(word))
    }))
    family_index = {family: index for index, family in enumerate(families)}

    def sparse_count_vector(arc_type):
        word = arc_type[1]
        counts = Counter(
            family_index[relative_frame_family(cyclic_window(word, index, window_length))]
            for index in range(len(word))
        )
        return tuple(sorted((index, ZZ(count)) for index, count in counts.items()))

    vectors = {
        arc_type: sparse_count_vector(arc_type)
        for arc_type in arc_types
    }
    return families, vectors


def partition_and_summary(vectors, support):
    classes = {}
    for arc_type in arc_types:
        descriptor = (selected_relative_descriptor(arc_type), vectors[arc_type])
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
            "window_family_counts": [
                {"family_index": int(index), "count": int(count)}
                for index, count in descriptor[1]
            ],
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    class_index = {
        arc_type: class_number
        for class_number, descriptor in enumerate(sorted(classes))
        for coefficient_classes in [classes[descriptor]]
        for coefficient in (0, 1)
        for arc_type in coefficient_classes[coefficient]
    }
    return class_index, {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


quadruple_vectors = {
    arc_type: quadruple_family_sparse_count_vector(arc_type)
    for arc_type in arc_types
}
previous_partitions = {}
for name, support in supports.items():
    previous_partitions[name], previous_summary = partition_and_summary(
        quadruple_vectors,
        support,
    )
    assert previous_summary["descriptor_count"] == quadruple_summaries[name]["descriptor_count"]
    assert (
        previous_summary["mixed_coefficient_descriptor_count"]
        == quadruple_summaries[name]["mixed_coefficient_descriptor_count"]
    )


results_by_window_length = {}
first_strict_refinement = None
for window_length in unevaluated_window_lengths:
    families, vectors = family_data(window_length)
    summaries = {}
    current_partitions = {}
    strict_for_some_support = False
    for name, support in supports.items():
        current_partition, summary = partition_and_summary(vectors, support)
        current_partitions[name] = current_partition
        summaries[name] = summary

        previous_classes_by_current_class = {}
        for arc_type in arc_types:
            previous_classes_by_current_class.setdefault(
                current_partition[arc_type],
                set(),
            ).add(previous_partitions[name][arc_type])
        assert all(
            len(previous_classes) == 1
            for previous_classes in previous_classes_by_current_class.values()
        )
        if summary["descriptor_count"] > len(set(previous_partitions[name].values())):
            strict_for_some_support = True

    if strict_for_some_support and first_strict_refinement is None:
        first_strict_refinement = window_length
    results_by_window_length[str(window_length)] = {
        "relative_frame_family_count": len(families),
        "summaries": summaries,
        "strictly_refines_previous_length": strict_for_some_support,
    }
    previous_partitions = current_partitions


last_results = results_by_window_length[str(unevaluated_window_lengths[-1])]
all_coefficients_still_mixed = any(
    summary["mixed_coefficient_descriptor_count"] > 0
    for summary in last_results["summaries"].values()
)

certificate = {
    "kind": "cyclic-window-length-family-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "evaluated_maximum_window_length_before_this_check": evaluated_maximum_window_length,
    "maximum_internal_word_length": maximum_internal_word_length,
    "unevaluated_window_lengths": list(unevaluated_window_lengths),
    "first_strict_refinement_window_length": first_strict_refinement,
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "results_by_window_length": results_by_window_length,
}
if first_strict_refinement is None and all_coefficients_still_mixed:
    certificate["conclusion"] = (
        "no previously unevaluated cyclic window length up to the maximum "
        "observed internal-word length refines the length-four partition; "
        "both canonical coefficients remain mixed, so this local-window-frequency "
        "candidate class fails on the finite universe"
    )
elif first_strict_refinement is not None:
    certificate["conclusion"] = (
        "the recorded first window length strictly refines the preceding partition "
        "on the finite universe"
    )
else:
    certificate["conclusion"] = (
        "the complete observed window-length family determines both canonical "
        "coefficients on the finite universe"
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-window-length-family-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("MAXIMUM INTERNAL WORD LENGTH: %d" % maximum_internal_word_length, flush=True)
print("UNEVALUATED WINDOW LENGTHS: %s" % (unevaluated_window_lengths,), flush=True)
for window_length in unevaluated_window_lengths:
    result = results_by_window_length[str(window_length)]
    print(
        "WINDOW LENGTH %d: families=%d strict=%s" % (
            window_length,
            result["relative_frame_family_count"],
            result["strictly_refines_previous_length"],
        ),
        flush=True,
    )
    for name, summary in result["summaries"].items():
        print(
            "  DECISION %s: descriptors=%d mixed=%d" % (
                name,
                summary["descriptor_count"],
                summary["mixed_coefficient_descriptor_count"],
            ),
            flush=True,
        )
print("FIRST STRICT REFINEMENT: %s" % first_strict_refinement, flush=True)
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: cyclic-window-length family decision completed", flush=True)
