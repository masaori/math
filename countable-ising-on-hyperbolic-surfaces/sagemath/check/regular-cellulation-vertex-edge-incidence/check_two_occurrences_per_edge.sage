load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-vertex-edge-incidence/_prelude.sage")

for example in EXAMPLES:
    left = sum(
        (edge_fiber(example, edge).cardinality() for edge in example["edges"]),
        NN(0),
    )
    right = sum((NN(2) for edge in example["edges"]), NN(0))
    assert left == right

print("RESULT: PASS — every edge-occurrence fiber has cardinality two")
