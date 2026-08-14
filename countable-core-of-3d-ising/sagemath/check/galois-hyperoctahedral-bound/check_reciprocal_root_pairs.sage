# 対象ラベル: claim_galois_hyperoctahedral_bound
# 非零根の逆数閉性、固定根の除去、不動点のない対合による二元対分割を検証する。
# 帰属: QQbar と有限集合の厳密計算（等号は代数的数の根分離で決定する）。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

for box_side in [1, 2]:
    polynomial, edge_count = partition_polynomial(box_side)
    assert polynomial[0] != 0
    roots = set(QQbar(root) for root, _multiplicity in polynomial.roots(QQbar))
    assert QQbar(0) not in roots
    assert all(polynomial(QQbar(1) / root) == 0 for root in roots)
    nonfixed_roots = roots.difference({QQbar(1), QQbar(-1)})
    assert all(root != QQbar(1) / root for root in nonfixed_roots)
    pairs = {frozenset((root, QQbar(1) / root)) for root in nonfixed_roots}
    assert all(len(pair) == 2 for pair in pairs)
    assert set().union(*pairs) == nonfixed_roots if pairs else not nonfixed_roots
    assert sum(len(pair) for pair in pairs) == len(nonfixed_roots)

print("RESULT: PASS")
