"""次数三以下の二つの左核矛盾証拠の有限構造を比較する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長・一般の内部語についての命題ではない。

保存済みの二証拠について、共有観測・共有弧型・共有巡回軌道・共有原始特徴
ベクトルを比較し、各証拠を弧型ごとの候補数と絶対境界方向で分解する。
"""

import json
from collections import Counter
from pathlib import Path

load(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-absolute-boundary-direction-quadratic-formula/"
    "check.sage"
)

SOURCE = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-cubic-formula-decision/"
    "certificate.json"
)
source = json.loads(SOURCE.read_text())
support_order = tuple(source["support_order"])


def witness_indices(support):
    return tuple(source["results"][support]["left_kernel_observation_indices"])


def observation_descriptor(index):
    observation = observations[index]
    boundary_direction, endpoint_bits, sparse_counts = absolute_descriptors[
        observation["arc_type"]
    ][observation["candidate_index"]]
    return (
        int(boundary_direction),
        tuple(map(int, endpoint_bits)),
        tuple((int(triple_index), int(count % 2))
              for triple_index, count in sparse_counts if count % 2 == 1),
    )


def witness_summary(indices):
    arc_type_counts = Counter(observations[index]["arc_type"] for index in indices)
    orbit_counts = Counter(
        arc_cyclic_orbit_key(observations[index]["arc_type"])
        for index in indices
    )
    descriptors = tuple(observation_descriptor(index) for index in indices)
    active_vectors = tuple(
        tuple(map(int, observations[index]["active"])) for index in indices
    )
    return {
        "observation_count": len(indices),
        "distinct_arc_type_count": len(arc_type_counts),
        "arc_type_multiplicities": sorted(arc_type_counts.values()),
        "distinct_cyclic_orbit_count": len(orbit_counts),
        "cyclic_orbit_multiplicities": sorted(orbit_counts.values()),
        "boundary_direction_counts": dict(sorted(Counter(
            descriptor[0] for descriptor in descriptors
        ).items())),
        "distinct_relative_endpoint_vector_count": len({
            descriptor[1] for descriptor in descriptors
        }),
        "distinct_triple_parity_vector_count": len({
            descriptor[2] for descriptor in descriptors
        }),
        "distinct_active_primitive_vector_count": len(set(active_vectors)),
        "arc_types": [
            {
                "arc_type": repr(arc_type),
                "observation_count": count,
                "candidate_indices": sorted(
                    int(observations[index]["candidate_index"])
                    for index in indices
                    if observations[index]["arc_type"] == arc_type
                ),
            }
            for arc_type, count in sorted(arc_type_counts.items(), key=lambda item: repr(item[0]))
        ],
    }


witnesses = {support: witness_indices(support) for support in support_order}
summaries = {support: witness_summary(indices) for support, indices in witnesses.items()}

first, second = support_order
first_observations = set(witnesses[first])
second_observations = set(witnesses[second])
first_arc_types = {observations[index]["arc_type"] for index in witnesses[first]}
second_arc_types = {observations[index]["arc_type"] for index in witnesses[second]}
first_orbits = {arc_cyclic_orbit_key(arc_type) for arc_type in first_arc_types}
second_orbits = {arc_cyclic_orbit_key(arc_type) for arc_type in second_arc_types}
first_descriptors = {observation_descriptor(index) for index in witnesses[first]}
second_descriptors = {observation_descriptor(index) for index in witnesses[second]}
first_active = {
    tuple(map(int, observations[index]["active"])) for index in witnesses[first]
}
second_active = {
    tuple(map(int, observations[index]["active"])) for index in witnesses[second]
}

comparison = {
    "shared_observation_count": len(first_observations & second_observations),
    "shared_arc_type_count": len(first_arc_types & second_arc_types),
    "shared_cyclic_orbit_count": len(first_orbits & second_orbits),
    "shared_candidate_descriptor_count": len(first_descriptors & second_descriptors),
    "shared_active_primitive_vector_count": len(first_active & second_active),
}

for support, indices in witnesses.items():
    assert len(indices) == 16
    assert not xor_observation_rows(indices)
    assert xor_targets(indices, support_order.index(support)) == 1

certificate = {
    "kind": "cyclic-cubic-obstruction-structure-comparison",
    "scope": source["scope"],
    "source_certificate": str(SOURCE),
    "support_order": list(support_order),
    "summaries": summaries,
    "comparison": comparison,
    "conclusion": (
        "the two saved obstructions have been compared by observations, arc "
        "types, cyclic orbits, candidate descriptors, and active primitive vectors"
    ),
    "next_step": (
        "use the recorded multiplicities and intersections to choose the next "
        "structural quotient; do not add degree four or new primitive features automatically"
    ),
}

certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-cubic-obstruction-structure/"
    "certificate.json"
)
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"), default=int)
    + "\n"
)

for support in support_order:
    print(
        "WITNESS %s: observations=%d arc_types=%d orbits=%d directions=%s" % (
            support,
            summaries[support]["observation_count"],
            summaries[support]["distinct_arc_type_count"],
            summaries[support]["distinct_cyclic_orbit_count"],
            summaries[support]["boundary_direction_counts"],
        ),
        flush=True,
    )
print("COMPARISON: %s" % comparison, flush=True)
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: cubic-obstruction structure compared", flush=True)
