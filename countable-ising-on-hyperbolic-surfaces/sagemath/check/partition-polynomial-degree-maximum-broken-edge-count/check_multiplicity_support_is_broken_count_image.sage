# 対象ラベル: theorem_partition_polynomial_degree_maximum_broken_edge_count
# 式ペア: max {m | Omega_G(m) != 0} = max_{sigma in S_G} b_G(sigma)
# 帰属: 有限集合、NN

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

for data in examples.values():
    nonzero_multiplicity_degrees = {
        ZZ(m) for m, multiplicity in data["multiplicities"].items() if multiplicity != 0
    }
    broken_count_image = set(data["broken_counts"])
    assert nonzero_multiplicity_degrees == broken_count_image
    assert max(nonzero_multiplicity_degrees) == max(data["broken_counts"])

print("RESULT: PASS — multiplicity support is exactly the finite image of the broken-edge count")
