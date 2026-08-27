# 対象ラベル: claim_invertible_neighborhood_assignment_cardinality_decidable
# 個数公式と有限決定を段ごとに分けて検査する。
#   (l) 全数走査で得た可逆元全体が {P_sigma : sigma は V の置換} に一致する
#   (m) sigma |-> P_sigma が単射なので、可逆元の個数は n! である
#   (n) 各可逆元の逆元は唯一で、P_{sigma^{-1}} に等しい（逆置換の有限表から決定できる）
#   (o) 任意の N の可逆性は、列挙した可逆元との有限回の等号比較で判定でき、全数走査の判定と一致する
#   (p) 割り当ての等号は |V|^2 回の所属判定へ展開できる
# 帰属: 有限集合、有限写像表、ZZ の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scanned = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    all_assignments = neighborhood_assignments(cells)
    scanned += len(all_assignments)

    scanned_units = set(N for N in all_assignments if is_invertible(cells, N))
    table = set(permutation_assignment(cells, sigma) for sigma in permutations(cells))
    # (l)
    assert scanned_units == table
    # (m) sigma |-> P_sigma の単射性と個数
    assert len(table) == len(tuple(permutations(cells)))
    assert len(scanned_units) == factorial(n)
    # (n) 逆元の唯一性と逆置換による決定
    for sigma in permutations(cells):
        P = permutation_assignment(cells, sigma)
        found = inverses(cells, P)
        assert len(found) == 1
        assert found[0] == permutation_assignment(cells, inverse_permutation(cells, sigma))
    # (o) 表との有限比較による判定が全数走査の判定と一致する
    for N in all_assignments:
        by_table = any(N == P for P in table)
        assert by_table == is_invertible(cells, N)
        # (p) 等号を |V|^2 回の所属判定へ展開する
        for P in table:
            expanded = all(
                (u in N[v]) == (u in P[v]) for v in cells for u in cells
            )
            assert expanded == (N == P)

print("PASS check_units_cardinality_finite_decision")
print("  assignments scanned:", scanned)
print("  unit counts by |V|:", [factorial(n) for n in (0, 1, 2, 3)])
