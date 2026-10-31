"""相対端点 10 成分だけで二つの軌道係数を書けるかを判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

前段で選んだ相対端点 10 成分について、各弧型が持つ実現可能な
境界入射候補の 10 ビット列全体を記録する。内部語を捨てたこの
記述が同じなのに軌道係数が異なる弧型があれば、この 10 成分だけの
どのブール式も係数を決められない。
"""

import json
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-word-relative-endpoint-coefficient-decision/"
    "check.sage"
)


def selected_relative_descriptor(arc_type):
    return tuple(
        tuple(bits[index] for index in selected)
        for bits in relative_bits[arc_type]
    )


def boolean_formula_obstruction(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = selected_relative_descriptor(arc_type)
        classes.setdefault(descriptor, {0: [], 1: []})[
            ZZ(arc_type in support)
        ].append(arc_type)

    mixed = {
        descriptor: coefficient_classes
        for descriptor, coefficient_classes in classes.items()
        if coefficient_classes[0] and coefficient_classes[1]
    }
    witnesses = []
    for descriptor in sorted(mixed)[:3]:
        witnesses.append({
            "relative_endpoint_descriptor": repr(descriptor),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


summaries = {
    name: boolean_formula_obstruction(support)
    for name, support in supports.items()
}

assert len(arc_types) == 9739
assert set(len(relative_bits[arc_type]) for arc_type in arc_types) == {1, 2}
assert all(summary["descriptor_count"] == 601 for summary in summaries.values())
assert all(summary["mixed_coefficient_descriptor_count"] > 0
           for summary in summaries.values())

certificate = {
    "kind": "relative-endpoint-boolean-formula-obstruction",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "one_candidate_arc_type_count": sum(
        1 for arc_type in arc_types if len(relative_bits[arc_type]) == 1
    ),
    "two_candidate_arc_type_count": sum(
        1 for arc_type in arc_types if len(relative_bits[arc_type]) == 2
    ),
    "summaries": summaries,
    "conclusion": (
        "even the complete unordered set of feasible ten-bit relative endpoint "
        "descriptors does not determine either canonical coefficient; therefore "
        "no Boolean formula in those ten components alone can do so on this "
        "finite universe, and internal-word information remains necessary"
    ),
}

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-relative-endpoint-boolean-formula/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ARC TYPES: %d" % len(arc_types), flush=True)
print(
    "BOUNDARY CANDIDATES: one=%d two=%d" % (
        certificate["one_candidate_arc_type_count"],
        certificate["two_candidate_arc_type_count"],
    ),
    flush=True,
)
for name, summary in summaries.items():
    print(
        "OBSTRUCTION %s: descriptors=%d mixed=%d" % (
            name,
            summary["descriptor_count"],
            summary["mixed_coefficient_descriptor_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: relative endpoint Boolean-formula obstruction found", flush=True)
