load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-vertex-edge-incidence/_prelude.sage")

for example in EXAMPLES:
    left = sum((example["q"] for vertex in example["vertices"]), NN(0))
    right = sum(
        (vertex_corner_set(example, vertex).cardinality() for vertex in example["vertices"]),
        NN(0),
    )
    assert left == right

print("RESULT: PASS — the regular vertex degree replaces every q by the corner-fiber cardinality")
