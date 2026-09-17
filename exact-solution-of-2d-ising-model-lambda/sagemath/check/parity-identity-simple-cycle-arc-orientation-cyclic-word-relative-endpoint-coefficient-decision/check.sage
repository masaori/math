"""端点方向に沿う相対局所量が二つの軌道係数を決めるかを判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

各切断候補の境界方向を基準に、整列端点と反対端点の二重辺・単一辺・
選択辺・切断旗を、境界・時計回り・反対・反時計回りの四相対方向へ
並べ直す。絶対方向を捨てたこの端点局所量と巡回・反転内部語の組が、
二つの正準巡回支持の係数を決めるかを有限全データで検査する。
"""

import ast
import json
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-one-quadratic-solution/"
    "construction.sage"
)
load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-outside-membership/"
    "construction.sage"
)


def cyclic_reversal_invariant_word(word):
    return min(
        oriented[offset:] + oriented[:offset]
        for oriented in (word, tuple(reversed(word)))
        for offset in range(len(oriented))
    )


def relative_endpoint_bits(arc_type):
    orbit_key = arc_cyclic_orbit_key(arc_type)
    selector = arc_cyclic_selector(arc_type)
    incidences = candidate_boundary_incidence_descriptor(orbit_key, selector)
    descriptors = []
    for _, endpoint_index, boundary_direction, boundary_data in incidences:
        endpoints = orbit_key[2]
        aligned_endpoint = endpoints[ZZ(endpoint_index)]
        other_endpoint = endpoints[1 - ZZ(endpoint_index)]
        endpoint_bits = []
        for endpoint in (aligned_endpoint, other_endpoint):
            endpoint_bits.extend(boundary_data if endpoint is aligned_endpoint else
                                 endpoint_direction_data(endpoint, boundary_direction))
            for _, direction_map in RELATIVE_DIRECTIONS:
                endpoint_bits.extend(endpoint_direction_data(
                    endpoint, direction_map[ZZ(boundary_direction)]))
        descriptors.append(tuple(endpoint_bits))
    return tuple(sorted(set(descriptors)))


def relative_feature_names():
    names = []
    for endpoint_role in ("aligned", "other"):
        for relative_direction in (
                "boundary", "clockwise", "opposite", "counterclockwise"):
            for membership in ("in_doubled", "in_single", "in_chosen", "wrap"):
                names.append("%s_%s_%s" % (
                    endpoint_role, relative_direction, membership))
    assert len(names) == 32
    return tuple(names)


print("DATA: constructing the finite arc-type universe", flush=True)
compressor = make_orientation_membership_compressor(True, False, True)
_, all_types, _, _ = build_orient_d_congruence_system(compressor)
arc_types = tuple(arc_type for arc_type in all_types if arc_type[0] == "arc")

support_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json"
)
lifts = json.loads(support_path.read_text())["lifts"]
supports = {
    name: frozenset(map(ast.literal_eval, lift["arc_support"]))
    for name, lift in lifts.items()
}
assert set(supports) == {"endpoint_only", "step_endpoint"}


relative_bits = {
    arc_type: relative_endpoint_bits(arc_type)
    for arc_type in arc_types
}
by_word = {}
for arc_type in arc_types:
    by_word.setdefault(
        cyclic_reversal_invariant_word(arc_type[1]), []
    ).append(arc_type)

difference_masks = set()
pair_count = 0
for word_types in by_word.values():
    for first_index, first in enumerate(word_types):
        first_coefficients = tuple(
            ZZ(first in supports[name]) for name in sorted(supports))
        first_bits = relative_bits[first]
        for second in word_types[first_index + 1:]:
            second_coefficients = tuple(
                ZZ(second in supports[name]) for name in sorted(supports))
            if first_coefficients == second_coefficients:
                continue
            second_bits = relative_bits[second]
            mask = tuple(
                index for index in range(32)
                if tuple(bits[index] for bits in first_bits)
                != tuple(bits[index] for bits in second_bits)
            )
            assert mask
            difference_masks.add(mask)
            pair_count += 1

feature_names = relative_feature_names()
program = MixedIntegerLinearProgram(maximization=False, solver="GLPK")
chosen = program.new_variable(binary=True)
program.set_objective(sum(chosen[index] for index in range(32)))
for mask in sorted(difference_masks):
    program.add_constraint(sum(chosen[index] for index in mask) >= 1)
minimum_feature_count = ZZ(round(program.solve()))
values = program.get_values(chosen)
selected = tuple(
    index for index in range(32) if ZZ(round(values[index])) == 1
)
assert len(selected) == minimum_feature_count
assert all(any(index in selected for index in mask) for mask in difference_masks)


def coefficient_decision(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = (
            cyclic_reversal_invariant_word(arc_type[1]),
            tuple(
                tuple(bits[index] for index in selected)
                for bits in relative_bits[arc_type]
            ),
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
            "internal_word": repr(descriptor[0]),
            "relative_endpoint_descriptor": repr(descriptor[1]),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


summaries = {
    name: coefficient_decision(support)
    for name, support in supports.items()
}
assert len(arc_types) == 9739

certificate = {
    "kind": "cyclic-word-relative-endpoint-coefficient-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "coefficient_distinguishing_pair_count": int(pair_count),
    "distinct_difference_mask_count": len(difference_masks),
    "minimum_relative_endpoint_feature_count": int(minimum_feature_count),
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "summaries": summaries,
    "conclusion": (
        "a minimum-cardinality set of endpoint-local memberships expressed "
        "relative to each feasible boundary direction, together with the "
        "cyclic-reversal internal word, determines both canonical coefficients "
        "on this finite universe"
    ),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-word-relative-endpoint-coefficient-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int) + "\n"
)

print("DISTINGUISHING PAIRS: %d" % pair_count, flush=True)
print("DISTINCT DIFFERENCE MASKS: %d" % len(difference_masks), flush=True)
print("MINIMUM RELATIVE ENDPOINT FEATURES: %d" % minimum_feature_count, flush=True)
print("SELECTED: %s" % ", ".join(
    certificate["selected_relative_endpoint_feature_names"]), flush=True)
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
print("PASS: relative endpoint-local coefficient decision completed", flush=True)
