# 対象ラベル: claim_invariant_subset_reversal_sign
# 定義と一般結論の有限全数検査。符号は独立に Sage の signature と照合する。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

empty_domain_cases = 0
empty_subset_cases = 0
for row in irs_rows:
    sigma, inverse, subset = row["sigma"], row["inverse"], row["subset"]
    p, q, tau, rank = row["p"], row["q"], row["tau"], row["rank"]
    identity = tuple(range(len(sigma)))
    assert all((sigma[i] in subset) == (i in subset) for i in identity)
    assert irs_compose(p, q) == identity
    assert irs_compose(q, p) == identity
    assert irs_compose(q, irs_compose(q, sigma)) == tau
    assert sorted(tau) == list(identity)
    for phi in (sigma, inverse, p, q, tau, row["q_sigma"], row["q_q_sigma"]):
        assert irs_sign(phi, rank) == Permutation([i + 1 for i in phi]).signature()
    assert irs_sign(tau, rank) == irs_sign(sigma, rank)
    empty_domain_cases += len(sigma) == 0
    empty_subset_cases += len(subset) == 0
assert empty_domain_cases == 1
assert empty_subset_cases == 1746

for row in irs_odd_rows:
    sigma, rank, subset = row["sigma"], row["rank"], row["subset"]
    assert all((sigma[i] in subset) == (i in subset) for i in range(len(sigma)))
    selected = irs_selected_reversal(sigma, rank)
    assert selected == irs_reverse(sigma, subset)
    assert irs_sign(selected, rank) == irs_sign(sigma, rank)

print("RESULT: PASS definition (874 permutations; 5913 invariant subsets; "
      "11823 ordered cases; 172 selected odd orbits; empty domain 1; empty subset 1746)")
