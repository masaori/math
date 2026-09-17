"""軌道係数が内部語だけで決まるかを有限データ上で判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

二つの正準巡回支持それぞれについて、同じ巡回・反転内部語を持つ
弧型の間で支持係数が一定かを調べる。端点署名が異なる二つの弧型で
係数が異なれば、内部語から作るどの巡回不変量（局所量を含む）も
その係数を表せない。
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


def word_only_obstruction(support):
    by_word = {}
    for arc_type in arc_types:
        word_key = cyclic_reversal_invariant_word(arc_type[1])
        coefficient = int(arc_type in support)
        by_word.setdefault(word_key, {0: [], 1: []})[coefficient].append(arc_type)

    mixed = {
        word_key: coefficient_classes
        for word_key, coefficient_classes in by_word.items()
        if coefficient_classes[0] and coefficient_classes[1]
    }
    witness_key = min(mixed)
    zero_witness = min(mixed[witness_key][0])
    one_witness = min(mixed[witness_key][1])
    assert cyclic_reversal_invariant_word(zero_witness[1]) == witness_key
    assert cyclic_reversal_invariant_word(one_witness[1]) == witness_key
    assert zero_witness[2] != one_witness[2]
    return {
        "word_orbit_count": len(by_word),
        "mixed_coefficient_word_orbit_count": len(mixed),
        "witness_word": repr(witness_key),
        "zero_coefficient_endpoint_signature": repr(zero_witness[2]),
        "one_coefficient_endpoint_signature": repr(one_witness[2]),
    }


summaries = {
    name: word_only_obstruction(support)
    for name, support in supports.items()
}
assert all(
    summary["mixed_coefficient_word_orbit_count"] > 0
    for summary in summaries.values()
)

certificate = {
    "kind": "cyclic-word-only-coefficient-obstruction",
    "scope": "the 10098 finite arc/cycle types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "conclusion": (
        "neither canonical orbit coefficient is a function of the cyclic-reversal "
        "internal word alone; endpoint data are necessary on this finite universe"
    ),
    "summaries": summaries,
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-word-only-coefficient-obstruction/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n"
)

for name, summary in summaries.items():
    print(
        "OBSTRUCTION %s: word_orbits=%d mixed=%d" % (
            name,
            summary["word_orbit_count"],
            summary["mixed_coefficient_word_orbit_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: internal cyclic word alone cannot determine either coefficient", flush=True)
