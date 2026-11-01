# 対象ラベル: kronecker_transpose
# 証明の最後の段: ν は I_M から {1,…,2^M} への全単射であり、どの成分の番号も ν(I) の形に書ける。
# 帰属: ZZ の有限集合。
load("_prelude.sage")

for M in M_RANGE:
    values = [nu(I) for I in index_set(M)]
    assert len(values) == 2**M
    assert sorted(values) == list(range(1, 2**M + 1))
    print(f"M={M}: ν は {2**M} 個の元を 1,…,{2**M} へ一対一に写す")

print("RESULT: PASS")
