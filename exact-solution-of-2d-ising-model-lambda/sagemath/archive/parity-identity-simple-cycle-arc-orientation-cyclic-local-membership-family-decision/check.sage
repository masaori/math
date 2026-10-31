"""文字をなす局所所属を方向名に依らない述語族へまとめて判定する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

内部語の各文字は、単一辺 E の局所向き、二重辺 D の所属、切断旗の
三つの四ビット列からなる。前段で選んだ 98 個の文字そのものを列挙せず、
E が直進か曲がりか、D と切断旗の個数、および三集合の交わりの個数で
文字を分類する。この局所所属述語族の出現回数と相対端点 10 成分が、
二つの正準巡回支持の係数を決めるかを有限全データで判定する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-letter-count-minimal-coefficient-decision/"
    "check.sage"
)


def local_membership_family(letter):
    in_single, wraps, extras = letter
    in_doubled = extras[0]
    single_slots = frozenset(index for index, bit in enumerate(in_single) if bit)
    doubled_slots = frozenset(index for index, bit in enumerate(in_doubled) if bit)
    wrap_slots = frozenset(index for index, bit in enumerate(wraps) if bit)
    straight = single_slots in (frozenset((0, 1)), frozenset((2, 3)))
    return (
        ZZ(straight),
        ZZ(len(doubled_slots)),
        ZZ(len(wrap_slots)),
        ZZ(len(single_slots & doubled_slots)),
        ZZ(len(single_slots & wrap_slots)),
        ZZ(len(doubled_slots & wrap_slots)),
        ZZ(len(single_slots & doubled_slots & wrap_slots)),
    )


families = tuple(sorted({local_membership_family(letter) for letter in alphabet}))


def family_count_vector(arc_type):
    counts = Counter(local_membership_family(letter) for letter in arc_type[1])
    return tuple(ZZ(counts[family]) for family in families)


def family_summary(support):
    classes = {}
    for arc_type in arc_types:
        descriptor = (
            selected_relative_descriptor(arc_type),
            family_count_vector(arc_type),
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
            "local_membership_family_counts": list(map(int, descriptor[1])),
            "zero_coefficient_arc_type": repr(min(mixed[descriptor][0])),
            "one_coefficient_arc_type": repr(min(mixed[descriptor][1])),
        })
    return {
        "descriptor_count": len(classes),
        "mixed_coefficient_descriptor_count": len(mixed),
        "witnesses": witnesses,
    }


summaries = {name: family_summary(support) for name, support in supports.items()}
assert len(arc_types) == 9739
assert len(alphabet) == 216
assert len(families) == 34
assert summaries["endpoint_only"]["descriptor_count"] == 5753
assert summaries["step_endpoint"]["descriptor_count"] == 5753
assert summaries["endpoint_only"]["mixed_coefficient_descriptor_count"] == 315
assert summaries["step_endpoint"]["mixed_coefficient_descriptor_count"] == 388

certificate = {
    "kind": "cyclic-local-membership-family-decision",
    "scope": "the 9739 finite arc types from side lengths two and three",
    "arc_type_count": len(arc_types),
    "alphabet_size": len(alphabet),
    "local_membership_family_count": len(families),
    "family_coordinates": [
        "single_is_straight",
        "doubled_slot_count",
        "wrap_slot_count",
        "single_doubled_intersection_count",
        "single_wrap_intersection_count",
        "doubled_wrap_intersection_count",
        "triple_intersection_count",
    ],
    "families": [list(map(int, family)) for family in families],
    "selected_relative_endpoint_feature_names": [
        feature_names[index] for index in selected
    ],
    "summaries": summaries,
    "conclusion": (
        "counts of the 34 direction-name-free local membership families do "
        "not determine either canonical coefficient on this finite universe; "
        "relative slot placement discarded by the seven family coordinates "
        "must be restored"
    ),
}

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-local-membership-family-decision/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

print("ALPHABET SIZE: %d" % len(alphabet), flush=True)
print("LOCAL MEMBERSHIP FAMILIES: %d" % len(families), flush=True)
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
print("PASS: local membership family decision completed", flush=True)
