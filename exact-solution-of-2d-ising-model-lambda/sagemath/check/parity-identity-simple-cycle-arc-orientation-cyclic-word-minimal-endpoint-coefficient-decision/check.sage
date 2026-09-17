"""両軌道係数を決める端点局所成分の最小集合を有限データ上で判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

同じ巡回・反転内部語を持ちながら、二つの正準支持の係数対が異なる
弧型対を全て作る。各対について少なくとも一つ異なる端点成分を選ぶ
最小 hitting set を二値整数計画で厳密に求める。
"""

import ast
import json
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-one-quadratic-solution/"
    "construction.sage"
)


def cyclic_reversal_invariant_word(word):
    return min(
        oriented[offset:] + oriented[:offset]
        for oriented in (word, tuple(reversed(word)))
        for offset in range(len(oriented))
    )


def endpoint_bits(arc_type):
    bits = []
    for memberships, wrap_flags in arc_type[2]:
        for _, in_doubled, in_single, in_chosen in memberships:
            bits.extend((in_doubled, in_single, in_chosen))
        bits.extend(wrap_flags)
    assert len(bits) == 32
    assert all(bit in (0, 1) for bit in bits)
    return tuple(map(ZZ, bits))


def endpoint_feature_names():
    slots = ("up", "down", "left", "right")
    kinds = ("d", "e", "c")
    wraps = ("row0", "rowlast", "col0", "collast")
    names = []
    for endpoint in ("end0", "end1"):
        for slot in slots:
            for kind in kinds:
                names.append("%s_%s_%s" % (endpoint, kind, slot))
        names.extend("%s_wrap_%s" % (endpoint, wrap) for wrap in wraps)
    assert len(names) == 32
    return tuple(names)


def coefficient_vector(arc_type, supports):
    return tuple(ZZ(arc_type in supports[name]) for name in sorted(supports))


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
assert all(support <= set(arc_types) for support in supports.values())

by_word = {}
for arc_type in arc_types:
    word = cyclic_reversal_invariant_word(arc_type[1])
    by_word.setdefault(word, []).append(arc_type)

difference_masks = set()
pair_count = 0
for word_types in by_word.values():
    for first_index, first in enumerate(word_types):
        first_coefficients = coefficient_vector(first, supports)
        first_bits = endpoint_bits(first)
        for second in word_types[first_index + 1:]:
            if first_coefficients == coefficient_vector(second, supports):
                continue
            second_bits = endpoint_bits(second)
            mask = tuple(
                index for index, (left, right) in enumerate(zip(first_bits, second_bits))
                if left != right
            )
            assert mask
            difference_masks.add(mask)
            pair_count += 1

feature_names = endpoint_feature_names()
program = MixedIntegerLinearProgram(maximization=False, solver="GLPK")
chosen = program.new_variable(binary=True)
program.set_objective(sum(chosen[index] for index in range(len(feature_names))))
for mask in sorted(difference_masks):
    program.add_constraint(sum(chosen[index] for index in mask) >= 1)
minimum_feature_count = ZZ(round(program.solve()))
values = program.get_values(chosen)
selected = tuple(
    index for index in range(len(feature_names)) if ZZ(round(values[index])) == 1
)
assert len(selected) == minimum_feature_count
assert all(any(index in selected for index in mask) for mask in difference_masks)


def projected_summary(support):
    classes = {}
    for arc_type in arc_types:
        bits = endpoint_bits(arc_type)
        descriptor = (
            cyclic_reversal_invariant_word(arc_type[1]),
            tuple(bits[index] for index in selected),
        )
        classes.setdefault(descriptor, set()).add(ZZ(arc_type in support))
    mixed = sum(1 for coefficients in classes.values() if len(coefficients) > 1)
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": int(mixed),
    }


summaries = {
    name: projected_summary(support)
    for name, support in supports.items()
}
assert len(arc_types) == 9739
assert all(summary["mixed_coefficient_descriptor_count"] == 0
           for summary in summaries.values())

certificate = {
    "kind": "cyclic-word-minimal-endpoint-coefficient-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "internal_word_count": len(by_word),
    "coefficient_distinguishing_pair_count": int(pair_count),
    "distinct_difference_mask_count": len(difference_masks),
    "minimum_endpoint_feature_count": int(minimum_feature_count),
    "selected_endpoint_feature_names": [feature_names[index] for index in selected],
    "summaries": summaries,
    "conclusion": (
        "a minimum-cardinality endpoint-local feature set together with the "
        "cyclic-reversal internal word determines both canonical coefficients "
        "on this finite universe"
    ),
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-word-minimal-endpoint-coefficient-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n"
)

print("DISTINGUISHING PAIRS: %d" % pair_count, flush=True)
print("DISTINCT DIFFERENCE MASKS: %d" % len(difference_masks), flush=True)
print("MINIMUM ENDPOINT FEATURES: %d" % minimum_feature_count, flush=True)
print("SELECTED: %s" % ", ".join(certificate["selected_endpoint_feature_names"]), flush=True)
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
print("PASS: minimum endpoint-local feature decision completed", flush=True)
