# 対象ラベル: theorem_partition_polynomial_degree_maximum_broken_edge_count
# 式ペア: deg Z_G = max {m | Omega_G(m) != 0}
# 帰属: NN、ZZ[x]

import os

load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

for data in examples.values():
    nonzero_multiplicity_degrees = [
        ZZ(m) for m, multiplicity in data["multiplicities"].items() if multiplicity != 0
    ]
    assert ZZ(data["polynomial"].degree()) == max(nonzero_multiplicity_degrees)

print("RESULT: PASS — every exact ZZ[x] degree equals the largest nonzero multiplicity degree")
