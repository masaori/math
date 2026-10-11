# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 対象集合の空の場合と、順逆反復と独立なグラフ探索の照合。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))
for sigma in sor_permutations:
    inverse = oso_inverse(sigma)
    for a, support in sor_supports[sigma].items():
        forward = {sfn_iterate(sigma,n,a) for n in range(len(sigma)+1)}
        backward = {sfn_iterate(inverse,n,a) for n in range(len(sigma)+1)}
        assert forward | backward == support
for size in (0,1,2,4):
    assert not [p for p in sor_permutations if len(p)==size and sor_in_domain(p)]
assert {r["ell"] for r in sfn_odd_rows} == {3,5}
assert all(r["tau"] == r["sigma"] for r in sfn_two_rows)
print("definition: 874 permutations; " + str(len(sfn_odd_rows)) + " ordered odd cases; " +
      str(len(sfn_two_rows)) + " nonempty local two-cycle cases; PASS")
