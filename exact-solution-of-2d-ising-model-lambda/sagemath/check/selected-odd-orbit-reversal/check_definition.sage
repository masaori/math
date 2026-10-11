from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

domain_count = outside_count = 0
domain_by_size = {n: 0 for n in range(7)}
for sigma in sor_permutations:
    rank = tuple(range(len(sigma)))
    expected = all(sigma[i] != i for i in range(len(sigma))) and bool(sor_points[sigma])
    assert sor_in_domain(sigma) == expected
    if expected:
        domain_count += 1
        domain_by_size[len(sigma)] += 1
        tau = sor_reversal(sigma, rank)
        assert sorted(tau) == list(range(len(sigma)))
        assert all(tau[i] != i for i in range(len(sigma)))
        assert sor_points[tau]
        assert sor_reversal(tau, rank) == sigma
    else:
        outside_count += 1
        try:
            sor_reversal(sigma, rank)
        except ValueError:
            pass
        else:
            raise AssertionError("reversal must not select an orbit outside its domain")
assert domain_by_size[0] == domain_by_size[1] == domain_by_size[2] == domain_by_size[4] == 0
assert domain_count > 0 and outside_count > 0
for row in sor_domain_cases():
    sigma, rank, tau = row["sigma"], row["rank"], row["tau"]
    assert sor_reversal(sigma, rank) == tau
    assert sor_reversal(tau, rank) == sigma
print("definition:", len(sor_permutations), "permutations;", domain_count, "in domain;",
      outside_count, "outside;", domain_by_size, "; PASS")
