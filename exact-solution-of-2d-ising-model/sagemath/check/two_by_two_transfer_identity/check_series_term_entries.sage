# 対象ラベル: two_by_two_transfer_identity
# 証明の行:
#   準備: (b^(m))_ij = (β^(m)_ij)_C（σ^x・I の成分）。
#   中間目標「指数級数の各項の成分」: ((1/m!)B_τ^m)_ij の鎖 6 行と、実数 (1/m!)τ^m β^(m)_11・β^(m)_12 の鎖 各 3 行を、
#   m = 0..20 の全成分で比べる。否定コントロール: β の対角と非対角を入れ替えた値とは一致しない。
# 帰属: GAUSSIAN[τ] と QQ[τ] で厳密に（ℝ 脱出なし）。実数の側の積は QQ[τ] で取り、像は inc で作る。
load("_prelude.sage")

B = inc(tr) * SX
P = scalar_power_by_definition
for m in range(0, 21):
    for i in (1, 2):
        for j in (1, 2):
            assert entry(b_matrix(m), i, j) == inc(QQ_TAU(beta(m, i, j)))          # (b^(m))_ij = (β^(m)_ij)_C
    fm = QQ(1) / factorial(m)
    Bm = matrix_power_by_definition(B, m)
    for i in (1, 2):
        for j in (1, 2):
            bij = QQ_TAU(beta(m, i, j))
            chain = [
                entry(fm * Bm, i, j),                                         # ((1/m!)B^m)_ij
                inc(QQ_TAU(fm)) * entry(Bm, i, j),                            # (1/m!)_C (B^m)_ij
                inc(QQ_TAU(fm)) * entry(inc(P(tr, m)) * b_matrix(m), i, j),   # 冪の中間目標
                inc(QQ_TAU(fm)) * (inc(P(tr, m)) * entry(b_matrix(m), i, j)), # スカラー倍の成分
                inc(QQ_TAU(fm)) * (inc(P(tr, m)) * inc(bij)),                 # (b^(m))_ij = (β^(m)_ij)_C
                inc(QQ_TAU(fm)) * inc(P(tr, m) * bij),                        # QQ[τ] で積を取ってから写す
                inc(fm * P(tr, m) * bij),
            ]
            for k in range(len(chain) - 1):
                assert chain[k] == chain[k + 1], (m, i, j, k)
    # 実数の側の鎖（QQ[τ]）
    d = [fm * P(tr, m) * beta(m, 1, 1), fm * P(tr, m) * (1 + (-1)^m) / 2,
         (P(tr, m) + (-1)^m * P(tr, m)) / (2 * factorial(m)), (P(tr, m) + P(-tr, m)) / (2 * factorial(m))]
    o = [fm * P(tr, m) * beta(m, 1, 2), fm * P(tr, m) * (1 - (-1)^m) / 2,
         (P(tr, m) - (-1)^m * P(tr, m)) / (2 * factorial(m)), (P(tr, m) - P(-tr, m)) / (2 * factorial(m))]
    for k in range(3):
        assert d[k] == d[k + 1] and o[k] == o[k + 1], (m, k)
    assert beta(m, 2, 2) == beta(m, 1, 1) and beta(m, 2, 1) == beta(m, 1, 2)
    # 否定コントロール
    assert entry(fm * Bm, 1, 1) != inc(o[3]) and entry(fm * Bm, 1, 2) != inc(d[3])
print("m = 0..20 の全成分で、(1/m!)B_τ^m の成分の鎖と実数の鎖が一致する")
print("RESULT: PASS")
