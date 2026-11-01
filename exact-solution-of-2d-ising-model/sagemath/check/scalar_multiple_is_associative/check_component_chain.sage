# 対象ラベル: scalar_multiple_is_associative
# 証明の (i,j) 成分の四行の鎖の五つの項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# あわせて主張 a(bA) = (ab)A を、Sage のスカラー倍（独立な経路）で組んだ右辺と行列全体で比べる。
# 帰属: QQ 上の多項式環（a, b と A の成分は不定元）。
load("_prelude.sage")

count = 0
for m in DIMS:
    for n in DIMS:
        P, (a, b), (A,) = generic_ring([("A", m, n)], scalars=["s_a", "s_b"])
        bA = body_scalar(b, A)
        L = body_scalar(a, bA)
        Rt = body_scalar(a * b, A)
        for i in range(m):
            for j in range(n):
                chain = [L[i, j], a * bA[i, j], a * (b * A[i, j]), (a * b) * A[i, j], Rt[i, j]]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, j, t)
                count += 1
        assert L == (a * b) * A
print(f"checked {count} entries and the statement over 9 shapes")
print("RESULT: PASS")
