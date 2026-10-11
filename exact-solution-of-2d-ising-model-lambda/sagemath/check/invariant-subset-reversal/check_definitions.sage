# 対象ラベル: def_invariant_subset_reversal, claim_invariant_subset_reversal
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
permutation_count=0
for n in range(7):
    python_perms=set(permutations(range(n)))
    sage_perms={tuple(int(i)-1 for i in s) for s in Permutations(n)}
    assert python_perms == sage_perms
    permutation_count += len(python_perms)
count=0
for sigma,C,inv,f,g,r,rinv,rr in isr_cases:
    n=len(sigma)
    sp=Permutation([i+1 for i in sigma])
    sr=Permutation([i+1 for i in r])
    assert tuple(int(i)-1 for i in sp.inverse()) == inv
    assert tuple(int(i)-1 for i in sr.inverse()) == g
    assert all((sigma[i] in C) == (i in C) for i in range(n))
    assert sorted(r) == list(range(n))
    assert rr == sigma
    if not C: assert r == sigma
    if len(C)==n: assert r == inv
    count+=1
assert permutation_count==874
assert isr_cases[0] == ((),frozenset(),(),(),(),(),(),())
isr_report("definitions",count,5913)
print("PASS independent_permutations: " + str(permutation_count))
