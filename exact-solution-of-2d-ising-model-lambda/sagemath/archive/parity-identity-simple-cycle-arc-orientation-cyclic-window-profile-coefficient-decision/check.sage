"""巡回窓の多重集合が二つの軌道係数を決める最小窓長を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

前段で選んだ相対端点 10 成分に、内部語の長さ k の巡回窓の
多重集合を加える。窓の開始位置を忘れることで巡回移動に不変とし、
語を反転した場合との辞書式最小を取ることで反転にも不変とする。
有限全データ上で両係数を決める最小の共通窓長を判定する。
"""

import json
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-relative-endpoint-boolean-formula/"
    "check.sage"
)


def cyclic_window_multiset(word, window_length):
    word_length = len(word)
    assert word_length > 0
    return tuple(sorted(
        tuple(word[(start + offset) % word_length]
              for offset in range(window_length))
        for start in range(word_length)
    ))


def reversal_invariant_cyclic_window_profile(word, window_length):
    forward = cyclic_window_multiset(word, window_length)
    backward = cyclic_window_multiset(tuple(reversed(word)), window_length)
    return min(forward, backward)


def coefficient_collisions(support, window_length):
    classes = {}
    for arc_type in arc_types:
        descriptor = (
            selected_relative_descriptor(arc_type),
            reversal_invariant_cyclic_window_profile(
                arc_type[1], window_length),
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
            "cyclic_window_profile": repr(descriptor[1]),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


maximum_word_length = max(len(arc_type[1]) for arc_type in arc_types)
baseline_summaries = {
    name: boolean_formula_obstruction(support)
    for name, support in supports.items()
}
results_by_window_length = {}
minimum_window_length = None
for window_length in range(1, maximum_word_length + 1):
    summaries = {
        name: coefficient_collisions(support, window_length)
        for name, support in supports.items()
    }
    results_by_window_length[str(window_length)] = summaries
    if all(summary["mixed_coefficient_descriptor_count"] == 0
           for summary in summaries.values()):
        minimum_window_length = window_length
        break

assert len(arc_types) == 9739
assert minimum_window_length is not None
assert all(
    results_by_window_length[str(minimum_window_length)][name][
        "mixed_coefficient_descriptor_count"
    ] == 0
    for name in supports
)
if minimum_window_length == 1:
    assert all(
        summary["mixed_coefficient_descriptor_count"] > 0
        for summary in baseline_summaries.values()
    )
else:
    assert any(
        results_by_window_length[str(minimum_window_length - 1)][name][
            "mixed_coefficient_descriptor_count"
        ] > 0
        for name in supports
    )

certificate = {
    "kind": "cyclic-window-profile-coefficient-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "maximum_internal_word_length": maximum_word_length,
    "minimum_common_cyclic_window_length": minimum_window_length,
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "endpoint_only_baseline": baseline_summaries,
    "results_by_window_length": results_by_window_length,
    "conclusion": (
        "among reversal-invariant multisets of cyclic windows, the recorded "
        "minimum common window length, together with the ten relative endpoint "
        "components, determines both canonical coefficients on this finite universe"
    ),
}

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-window-profile-coefficient-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ARC TYPES: %d" % len(arc_types), flush=True)
print("MAXIMUM INTERNAL WORD LENGTH: %d" % maximum_word_length, flush=True)
for window_length_text, summaries in results_by_window_length.items():
    for name, summary in summaries.items():
        print(
            "WINDOW %s %s: descriptors=%d mixed=%d" % (
                window_length_text,
                name,
                summary["descriptor_count"],
                summary["mixed_coefficient_descriptor_count"],
            ),
            flush=True,
        )
print("MINIMUM COMMON WINDOW LENGTH: %d" % minimum_window_length, flush=True)
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: cyclic-window-profile coefficient decision completed", flush=True)
