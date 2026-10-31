"""文字出現回数のうち両軌道係数の決定に必要な最小成分を判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

前段で選んだ相対端点 10 成分を固定し、内部語に現れる各文字の
出現回数を候補成分とする。係数対が異なる弧型対を全て分ける
最小の文字集合を hitting set として二値整数計画で求める。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-relative-endpoint-boolean-formula/"
    "check.sage"
)


alphabet = tuple(sorted({letter for arc_type in arc_types for letter in arc_type[1]}))
letter_index = {letter: index for index, letter in enumerate(alphabet)}


def letter_count_vector(arc_type):
    counts = Counter(arc_type[1])
    return tuple(ZZ(counts[letter]) for letter in alphabet)


def coefficient_vector(arc_type):
    return tuple(ZZ(arc_type in supports[name]) for name in sorted(supports))


count_vectors = {arc_type: letter_count_vector(arc_type) for arc_type in arc_types}
by_endpoint_descriptor = {}
for arc_type in arc_types:
    by_endpoint_descriptor.setdefault(
        selected_relative_descriptor(arc_type), []
    ).append(arc_type)

difference_masks = set()
pair_count = 0
for endpoint_types in by_endpoint_descriptor.values():
    for first_index, first in enumerate(endpoint_types):
        first_coefficients = coefficient_vector(first)
        first_counts = count_vectors[first]
        for second in endpoint_types[first_index + 1:]:
            if first_coefficients == coefficient_vector(second):
                continue
            second_counts = count_vectors[second]
            mask = tuple(
                index for index, (left, right) in
                enumerate(zip(first_counts, second_counts))
                if left != right
            )
            assert mask
            difference_masks.add(mask)
            pair_count += 1

program = MixedIntegerLinearProgram(maximization=False, solver="GLPK")
chosen = program.new_variable(binary=True)
program.set_objective(sum(chosen[index] for index in range(len(alphabet))))
for mask in sorted(difference_masks):
    program.add_constraint(sum(chosen[index] for index in mask) >= 1)
minimum_letter_count = ZZ(round(program.solve()))
values = program.get_values(chosen)
selected_letters = tuple(
    index for index in range(len(alphabet))
    if ZZ(round(values[index])) == 1
)
assert len(selected_letters) == minimum_letter_count
assert all(any(index in selected_letters for index in mask)
           for mask in difference_masks)


def projected_summary(support):
    classes = {}
    for arc_type in arc_types:
        counts = count_vectors[arc_type]
        descriptor = (
            selected_relative_descriptor(arc_type),
            tuple(counts[index] for index in selected_letters),
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
            "selected_letter_counts": list(map(int, descriptor[1])),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


summaries = {
    name: projected_summary(support)
    for name, support in supports.items()
}
assert len(arc_types) == 9739
assert all(summary["mixed_coefficient_descriptor_count"] == 0
           for summary in summaries.values())

certificate = {
    "kind": "cyclic-letter-count-minimal-coefficient-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "alphabet_size": len(alphabet),
    "coefficient_distinguishing_pair_count": int(pair_count),
    "distinct_difference_mask_count": len(difference_masks),
    "minimum_letter_count_component_count": int(minimum_letter_count),
    "selected_letters": [repr(alphabet[index]) for index in selected_letters],
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "summaries": summaries,
    "conclusion": (
        "a minimum-cardinality subset of letter-count components, together "
        "with the ten relative endpoint components, determines both canonical "
        "coefficients on this finite universe"
    ),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-letter-count-minimal-coefficient-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ALPHABET SIZE: %d" % len(alphabet), flush=True)
print("DISTINGUISHING PAIRS: %d" % pair_count, flush=True)
print("DISTINCT DIFFERENCE MASKS: %d" % len(difference_masks), flush=True)
print("MINIMUM LETTER-COUNT COMPONENTS: %d" % minimum_letter_count, flush=True)
for index in selected_letters:
    print("SELECTED LETTER: %s" % (repr(alphabet[index]),), flush=True)
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
print("PASS: minimum letter-count component decision completed", flush=True)
