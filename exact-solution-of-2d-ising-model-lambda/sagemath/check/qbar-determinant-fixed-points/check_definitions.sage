# 対象ラベル: def_qbar_polynomial_determinant, def_fixed_point_free_permutations
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
permutation_count=0
free_count=0
for n in range(7):
    listed=set(qdf_permutations(n))
    independent={tuple(int(v)-1 for v in p) for p in Permutations(n)}
    assert listed==independent
    free={sigma for sigma in listed if qdf_free(sigma)}
    independent_free={tuple(int(v)-1 for v in p) for p in Permutations(n) if not p.fixed_points()}
    assert free==independent_free
    excluded=listed-free
    assert free.isdisjoint(excluded) and free|excluded==listed
    for sigma in listed:
        sign=Permutation([i+1 for i in sigma]).signature()
        assert qdf_weight(sigma)==qdf_R(sign)
    permutation_count+=len(listed)
    free_count+=len(free)
assert permutation_count==874 and free_count==322
matrices=list(qdf_inputs(True))
assert len(matrices)==35
assert all(all(A[i,i]==0 for i in range(n)) for n,family,A in matrices)
empty=matrix(qdf_R,0,0)
assert empty.det()==qdf_R.one()==qdf_total(empty,qdf_free)
assert qdf_permutations(0)==((),) and qdf_free(())
assert not any(qdf_free(s) for s in qdf_permutations(1))
assert any(qdf_term(A,s)!=0 for n,family,A in qdf_inputs(False)
           for s in qdf_permutations(n) if not qdf_free(s))
print("definitions PASS 874 permutations, 322 fixed-point-free permutations, 35 zero-diagonal matrices")
