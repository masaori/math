# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 小集合の全二元部分集合族による定義の照合
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for n in range(5):
    J = tuple(3*i+2 for i in range(n))
    edges = tuple(frozenset(p) for p in combinations(J,2))
    all_families = [frozenset(edges[i] for i in range(len(edges)) if mask & (1<<i)) for mask in range(1<<len(edges))]
    valid = {D for D in all_families if is_matching(J,D)}
    assert valid == set(matching_families(J))
    checked += 1
print("PASS definition_exhaustive: %s 集合等式" % checked)
