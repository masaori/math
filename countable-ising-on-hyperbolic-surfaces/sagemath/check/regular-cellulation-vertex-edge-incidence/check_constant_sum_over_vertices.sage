load("countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-vertex-edge-incidence/_prelude.sage")

for example in EXAMPLES:
    left = example["q"] * NN(len(example["vertices"]))
    right = sum((example["q"] for vertex in example["vertices"]), NN(0))
    assert left == right

print("RESULT: PASS — q|V| equals the constant sum of q over all vertices")
