# 対象ラベル: scalar_multiple_by_one
# 証明の (i,j) 成分の二行の鎖の三つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 1A = A を行列全体で確かめ、Sage のスカラー倍 1*A（独立な経路）とも比べる。
# 帰属: QQ 上の多項式環（A の成分は不定元）。
load("_prelude.sage")

count = 0
for m in DIMS:
    for n in DIMS:
        P, _, (A,) = generic_ring([("A", m, n)])
        U = body_scalar(P(1), A)
        for i in range(m):
            for j in range(n):
                chain = [U[i, j], P(1) * A[i, j], A[i, j]]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert U == A and U == P(1) * A
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")
