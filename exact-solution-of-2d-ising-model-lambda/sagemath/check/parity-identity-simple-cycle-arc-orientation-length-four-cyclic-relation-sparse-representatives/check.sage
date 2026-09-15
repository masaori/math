"""語長四の巡回不変な混合関係商から疎な特徴代表を抽出する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長と全語長についての命題ではない。

端点特徴だけに支持を持つ部分空間と、語位置・端点積だけに支持を
持つ部分空間について、巡回軌道座標上の既約階段基底を作る。
その後、基底行どうしの加算で Hamming 重みが真に減る変更だけを
決定的な順序で反復する。これは再現可能な疎化であり、全非零元の
最小 Hamming 重みを求めたという主張ではない。
"""

print("LOAD: constructing cyclic support classification", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-support-classes/check.sage")


def supported_feature_basis(positions):
    """指定座標だけに支持を持つ行空間の基底を指定座標上で返す。"""
    position_set = set(positions)
    complement = tuple(index for index in range(compressed.ncols())
                       if index not in position_set)
    outside = compressed.matrix_from_columns(complement)
    coefficient_kernel = outside.left_kernel().basis_matrix()
    restricted = coefficient_kernel * compressed.matrix_from_columns(positions)
    rank = restricted.rank()
    echelon = restricted.echelon_form()
    basis = [vector(GF(2), echelon.row(index)) for index in range(rank)]
    assert matrix(GF(2), basis, sparse=True).rank() == rank
    return basis


def sparsify_basis(basis):
    """基底性を保つ基本行操作だけで決定的に Hamming 重みを減らす。"""
    sparse = list(basis)
    improved = True
    while improved:
        improved = False
        for target in range(len(sparse)):
            for source in range(len(sparse)):
                if source == target:
                    continue
                candidate = sparse[target] + sparse[source]
                if candidate.hamming_weight() < sparse[target].hamming_weight():
                    sparse[target] = candidate
                    improved = True
    assert matrix(GF(2), sparse, sparse=True).rank() == len(sparse)
    return sparse


def support_labels(row, positions):
    return tuple(orbits[positions[index]][0]
                 for index in row.nonzero_positions())


def expanded_support_labels(row, positions):
    return tuple(label
                 for index in row.nonzero_positions()
                 for label in orbits[positions[index]])


def summarize_group(name, positions, expected_dimension):
    canonical = supported_feature_basis(positions)
    assert len(canonical) == expected_dimension
    sparse = sparsify_basis(canonical)

    canonical_weights = tuple(row.hamming_weight() for row in canonical)
    sparse_weights = tuple(row.hamming_weight() for row in sparse)
    smallest_index = min(
        range(len(sparse)),
        key=lambda index: (sparse_weights[index], support_labels(sparse[index], positions)),
    )
    smallest = sparse[smallest_index]

    # 疎化後も、指定群だけに支持を持つ商部分空間全体を張る。
    lifted_rows = []
    for row in sparse:
        lifted = vector(GF(2), compressed.ncols())
        for local_index in row.nonzero_positions():
            lifted[positions[local_index]] = 1
        assert lifted in compressed.row_space()
        lifted_rows.append(lifted)
    assert matrix(GF(2), lifted_rows, sparse=True).rank() == expected_dimension

    result = {
        "dimension": expected_dimension,
        "orbit_count": len(positions),
        "canonical_total_weight": int(sum(canonical_weights)),
        "sparse_total_weight": int(sum(sparse_weights)),
        "sparse_minimum_basis_weight": int(min(sparse_weights)),
        "sparse_maximum_basis_weight": int(max(sparse_weights)),
        "smallest_orbit_support": support_labels(smallest, positions),
        "smallest_feature_support": expanded_support_labels(smallest, positions),
    }
    print(
        "SPARSE %s: dimension=%d canonical_total=%d sparse_total=%d "
        "basis_weight_range=%d..%d smallest=%s" % (
            name,
            expected_dimension,
            result["canonical_total_weight"],
            result["sparse_total_weight"],
            result["sparse_minimum_basis_weight"],
            result["sparse_maximum_basis_weight"],
            ",".join(result["smallest_orbit_support"]),
        ),
        flush=True,
    )
    return result


endpoint_result = summarize_group(
    "endpoint_only", group_positions["endpoint_only"], 144)
step_endpoint_result = summarize_group(
    "step_endpoint", group_positions["step_endpoint"], 115)

# 一次特徴は前回の射影階数零により、どちらの最小基底代表にも現れない。
assert all("*" in label for label in endpoint_result["smallest_orbit_support"])
assert all("*" in label for label in step_endpoint_result["smallest_orbit_support"])

import json
from pathlib import Path

certificate = {
    "kind": "cyclic-relation-sparse-representatives",
    "minimality_scope": "minimum among the deterministically sparsified basis rows; not a global minimum-distance claim",
    "endpoint_only": endpoint_result,
    "step_endpoint": step_endpoint_result,
}
certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-sparse-representatives/certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":"),
               default=int) + "\n")
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: sparse cyclic relation representatives extracted", flush=True)
