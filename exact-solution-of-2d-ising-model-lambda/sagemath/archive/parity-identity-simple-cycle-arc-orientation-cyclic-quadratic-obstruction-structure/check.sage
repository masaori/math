"""二つの次数二以下左核矛盾証拠が共有する三次相互作用を抽出する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

既存の二証拠が定数・一次・二次単項式を全て相殺することを再検算し、
同じ原始特徴の相異なる三特徴積のうち、各証拠で奇数回現れる列と、
二証拠に共通する列の種類を有限集合として抽出する。
"""

import json
from collections import Counter
from itertools import combinations
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-absolute-boundary-direction-quadratic-formula/"
    "check.sage"
)

SOURCE = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-absolute-boundary-direction-quadratic-formula/"
    "certificate.json"
)
source = json.loads(SOURCE.read_text())


def primitive_kind(index):
    if index < DIRECTION_COUNT:
        return "absolute_boundary_direction"
    if index < DIRECTION_COUNT + ENDPOINT_COUNT:
        return "relative_endpoint"
    return "boundary_framed_triple_parity"


def toggle(target, item):
    if item in target:
        target.remove(item)
    else:
        target.add(item)


def odd_monomials(indices, degree):
    odd = set()
    for observation_index in indices:
        active = observations[observation_index]["active"]
        for monomial in combinations(active, degree):
            toggle(odd, tuple(map(int, monomial)))
    return odd


def kind_counts(monomials):
    return dict(sorted(Counter(
        " * ".join(sorted(primitive_kind(index) for index in monomial))
        for monomial in monomials
    ).items()))


support_order = tuple(source["support_order"])
witnesses = {
    support: tuple(source["results"][support]["left_kernel_observation_indices"])
    for support in support_order
}

analysis = {}
odd_cubics = {}
for support in support_order:
    witness = witnesses[support]
    assert odd_monomials(witness, 1) == set()
    assert odd_monomials(witness, 2) == set()
    assert len(witness) % 2 == 0
    support_index = support_order.index(support)
    assert xor_targets(witness, support_index) == 1

    cubics = odd_monomials(witness, 3)
    assert cubics
    odd_cubics[support] = cubics
    analysis[support] = {
        "witness_observation_count": len(witness),
        "distinct_arc_type_count": len({
            observations[index]["arc_type"] for index in witness
        }),
        "odd_cubic_column_count": len(cubics),
        "odd_cubic_kind_counts": kind_counts(cubics),
    }

first, second = support_order
shared_observations = set(witnesses[first]) & set(witnesses[second])
shared_cubics = odd_cubics[first] & odd_cubics[second]
assert shared_cubics

certificate = {
    "kind": "cyclic-quadratic-obstruction-shared-structure",
    "scope": source["scope"],
    "source_certificate": str(SOURCE),
    "support_order": list(support_order),
    "analysis": analysis,
    "shared_observation_count": len(shared_observations),
    "shared_odd_cubic_column_count": len(shared_cubics),
    "shared_odd_cubic_kind_counts": kind_counts(shared_cubics),
    "shared_odd_cubic_examples": [
        list(monomial) for monomial in sorted(shared_cubics)[:20]
    ],
    "next_candidate_class": (
        "all squarefree F_2 monomials of degree at most three in the same fixed "
        "four absolute-boundary-direction indicators, ten relative-endpoint "
        "components, and boundary-framed cyclic-triple parities, decided for "
        "both target coefficients in one finite system"
    ),
    "interpretation": (
        "a shared odd cubic column only destroys both saved quadratic witnesses; "
        "it does not prove that the degree-at-most-three system is solvable"
    ),
    "no_automatic_escalation": (
        "if that fixed cubic candidate class is inconsistent, this result does "
        "not authorize adding degree four or new primitive features incrementally"
    ),
}

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-quadratic-obstruction-structure/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int) + "\n"
)

print(
    "WITNESSES: %s" % ", ".join(
        "%s=%d" % (support, len(witnesses[support])) for support in support_order
    ),
    flush=True,
)
print(
    "SHARED: observations=%d odd_cubic_columns=%d" % (
        len(shared_observations), len(shared_cubics),
    ),
    flush=True,
)
print("CUBIC KINDS: %s" % kind_counts(shared_cubics), flush=True)
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: shared quadratic-obstruction structure extracted", flush=True)
