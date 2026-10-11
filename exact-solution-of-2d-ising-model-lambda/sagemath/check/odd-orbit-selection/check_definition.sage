from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

for sigma in oso_permutations:
    for j in range(len(sigma)):
        assert oso_orbit(sigma, j) == oso_supports[sigma][j]
        size = len(oso_supports[sigma][j])
        assert (j in oso_odd_points(sigma)) == any(size == k + k + 1 for k in range(len(sigma) + 1))
nonempty = empty = 0
for sigma, rho, subset, rank, old_points, new_points, old_min, new_min in oso_rows:
    assert sorted(rho) == list(range(len(sigma)))
    if not old_points:
        empty += 1
        assert not new_points
        assert oso_selected(sigma, rank) is None
        assert oso_selected(rho, rank) is None
        continue
    nonempty += 1
    assert old_min in old_points and new_min in new_points
    assert all(rank[old_min] <= rank[j] for j in old_points)
    assert all(rank[new_min] <= rank[j] for j in new_points)
    assert oso_selected(sigma, rank) == oso_selected(rho, rank)
assert nonempty > 0 and empty > 0
print("definition:", len(oso_permutations), "permutations;", oso_invariant_pairs,
      "invariant pairs;", len(oso_rows), "ordered cases;", nonempty, "nonempty;", empty, "empty; PASS")
