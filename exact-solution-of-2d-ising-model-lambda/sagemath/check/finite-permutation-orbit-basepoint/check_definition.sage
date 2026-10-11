from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

assert len(fpob_permutations) == 874
assert () in fpob_permutations
points = pairs = members = 0
for sigma, tau, i in fpob_points():
    support_i = fpob_orbit(sigma, i)
    assert support_i == fpob_supports[(sigma, i)]
    assert i in support_i
    points += 1
    for j in range(len(sigma)):
        support_j = fpob_orbit(sigma, j)
        assert (j in support_i) == (support_i == support_j)
        if j in support_i:
            assert support_j <= support_i
            assert i in support_j
            assert support_i <= support_j
            members += 1
        pairs += 1
assert points == 5039
assert pairs == 29367
assert members > 0
print("definition:", len(fpob_permutations), "permutations;", points,
      "starts;", pairs, "pairs;", members, "same-orbit pairs; PASS")
