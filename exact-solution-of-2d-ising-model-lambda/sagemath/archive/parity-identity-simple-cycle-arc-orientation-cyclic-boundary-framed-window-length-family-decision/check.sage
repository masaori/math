"""境界方向を共通基準にした未評価の巡回窓長を一括判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

一辺二・三の有限全データについて、各実現可能な境界入射候補の境界方向を
上方向へ送る一意な正方形回転を選ぶ。その同じ回転を巡回内部語の連続する
四文字から八文字へ作用させ、各窓長の出現回数と、その候補の相対端点十成分を
対応づける。候補ごとの対応を保った記述が二つの正準巡回支持の係数を
決めるかを、現有限データに実在する未評価窓長について一括判定する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-boundary-framed-triple-count-decision/"
    "check.sage"
)


evaluated_maximum_window_length = 3
maximum_internal_word_length = max(len(arc_type[1]) for arc_type in arc_types)
unevaluated_window_lengths = tuple(range(
    evaluated_maximum_window_length + 1,
    maximum_internal_word_length + 1,
))
assert unevaluated_window_lengths == (4, 5, 6, 7, 8)


def cyclic_window(word, start, window_length):
    return tuple(
        word[(start + offset) % len(word)]
        for offset in range(window_length)
    )


def boundary_framed_window_data(window_length):
    windows = tuple(sorted({
        tuple(transform_letter(letter, rotation) for letter in window)
        for arc_type in arc_types
        for word in [arc_type[1]]
        for index in range(len(word))
        for window in [cyclic_window(word, index, window_length)]
        for rotation in square_rotations
    }))
    window_index = {window: index for index, window in enumerate(windows)}

    def candidate_descriptor(arc_type):
        orbit_key = arc_cyclic_orbit_key(arc_type)
        selector = arc_cyclic_selector(arc_type)
        incidences = candidate_boundary_incidence_descriptor(orbit_key, selector)
        word = arc_type[1]
        candidates = []
        for incidence in incidences:
            boundary_direction = incidence[2]
            rotation = boundary_to_up_rotation(boundary_direction)
            transformed_word = tuple(
                transform_letter(letter, rotation) for letter in word
            )
            counts = Counter(
                window_index[cyclic_window(
                    transformed_word,
                    index,
                    window_length,
                )]
                for index in range(len(transformed_word))
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

    descriptors_for_length = {
        arc_type: candidate_descriptor(arc_type)
        for arc_type in arc_types
    }
    return windows, descriptors_for_length


def partition_and_summary(descriptors_for_length, support):
    classes = {}
    for arc_type in arc_types:
        descriptor = descriptors_for_length[arc_type]
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
                    "boundary_framed_window_counts": [
                        {"window_index": int(index), "count": int(count)}
                        for index, count in sparse_counts
                    ],
                }
                for endpoint_bits, sparse_counts in descriptor
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


previous_partitions = {}
for name, support in supports.items():
    previous_partitions[name], previous_summary = partition_and_summary(
        descriptors,
        support,
    )
    assert previous_summary["descriptor_count"] == summaries[name]["descriptor_count"]
    assert (
        previous_summary["mixed_coefficient_descriptor_count"]
        == summaries[name]["mixed_coefficient_descriptor_count"]
    )


results_by_window_length = {}
first_strict_refinement = None
for window_length in unevaluated_window_lengths:
    windows, descriptors_for_length = boundary_framed_window_data(window_length)
    current_partitions = {}
    current_summaries = {}
    strict_for_some_support = False
    for name, support in supports.items():
        current_partition, summary = partition_and_summary(
            descriptors_for_length,
            support,
        )
        current_partitions[name] = current_partition
        current_summaries[name] = summary

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
        "boundary_framed_window_count": len(windows),
        "summaries": current_summaries,
        "strictly_refines_previous_length": strict_for_some_support,
    }
    previous_partitions = current_partitions


last_results = results_by_window_length[str(unevaluated_window_lengths[-1])]
all_coefficients_still_mixed = any(
    summary["mixed_coefficient_descriptor_count"] > 0
    for summary in last_results["summaries"].values()
)

certificate = {
    "kind": "cyclic-boundary-framed-window-length-family-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "evaluated_maximum_window_length_before_this_check": (
        evaluated_maximum_window_length
    ),
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
        "observed internal-word length refines the boundary-framed length-three "
        "partition; both canonical coefficients remain mixed, so this "
        "boundary-framed local-window-frequency candidate class fails on the "
        "finite universe"
    )
elif first_strict_refinement is not None:
    certificate["conclusion"] = (
        "the recorded first boundary-framed window length strictly refines the "
        "preceding partition on the finite universe"
    )
else:
    certificate["conclusion"] = (
        "the complete observed boundary-framed window-length family determines "
        "both canonical coefficients on the finite universe"
    )

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-boundary-framed-window-length-family-decision/"
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
        "BOUNDARY-FRAMED WINDOW LENGTH %d: windows=%d strict=%s" % (
            window_length,
            result["boundary_framed_window_count"],
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
print("PASS: boundary-framed window-length family decision completed", flush=True)
