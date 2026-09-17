"""内部語と端点局所量の組が軌道係数を決めるかを有限データ上で判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

二つの正準巡回支持それぞれについて、内部語を巡回移動と反転で
正規化し、二端点の完全な局所署名を組にした鍵ごとに支持係数が
一定かを調べる。
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


def word_endpoint_decision(support):
    by_descriptor = {}
    for arc_type in arc_types:
        descriptor = (
            cyclic_reversal_invariant_word(arc_type[1]),
            arc_type[2],
        )
        coefficient = int(arc_type in support)
        by_descriptor.setdefault(descriptor, {0: [], 1: []})[coefficient].append(
            arc_type
        )

    mixed = {
        descriptor: coefficient_classes
        for descriptor, coefficient_classes in by_descriptor.items()
        if coefficient_classes[0] and coefficient_classes[1]
    }
    witnesses = []
    for descriptor in sorted(mixed)[:2]:
        witnesses.append({
            "internal_word": repr(descriptor[0]),
            "endpoint_signature": repr(descriptor[1]),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "word_endpoint_descriptor_count": len(by_descriptor),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


summaries = {
    name: word_endpoint_decision(support)
    for name, support in supports.items()
}
assert len(arc_types) == 9739
assert summaries == {
    "endpoint_only": {
        "word_endpoint_descriptor_count": 9739,
        "mixed_coefficient_descriptor_count": 0,
        "witnesses": [],
    },
    "step_endpoint": {
        "word_endpoint_descriptor_count": 9739,
        "mixed_coefficient_descriptor_count": 0,
        "witnesses": [],
    },
}

certificate = {
    "kind": "cyclic-word-endpoint-coefficient-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "conclusion": (
        "the cyclic-reversal internal word together with the complete endpoint-local "
        "signature determines both canonical coefficients on this finite universe"
    ),
    "summaries": summaries,
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-word-endpoint-coefficient-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n"
)

for name, summary in summaries.items():
    print(
        "DECISION %s: descriptors=%d mixed=%d" % (
            name,
            summary["word_endpoint_descriptor_count"],
            summary["mixed_coefficient_descriptor_count"],
        ),
        flush=True,
    )
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: cyclic word plus endpoint-local signature decision completed", flush=True)
