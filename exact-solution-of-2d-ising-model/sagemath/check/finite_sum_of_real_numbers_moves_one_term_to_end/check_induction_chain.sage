# 対象ラベル: finite_sum_of_real_numbers_moves_one_term_to_end
# Σ_{j=1}^{m+1} b_j = (Σ_{j=1}^{m} b_{δ^m_k(j)}) + b_k の証明の各行（m = 1 の k = 1 の 6 行・k = 2 の 3 行、
# m → m+1 の k = m+2 の 3 行・k ≤ m+1 の 10 行）を m = 1,…,8 と全ての k で確かめる。
# 有限和は def_finite_sum_of_real_numbers のとおり左から順に足して組む。δ は def_index_skipping_map のとおり場合分けで組む。
# 帰属: QQ 上の多項式環（b_j は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
# 添字は本文と同じ 1 始まりで書き、多項式環の生成元の列 b を b[j - 1] で引く。
N = 10
P = PolynomialRing(QQ, [f"b{j}" for j in range(1, N + 1)])
gens = P.gens()


def B(j):
    """本文の b_j（1 始まり）。"""
    return gens[j - 1]


def fsum(rs):
    """def_finite_sum_of_real_numbers: Σ_{j=1}^{1} r_j := r_1、Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}。"""
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


def delta(m, k, j):
    """def_index_skipping_map: δ^m_k(j) := j (j < k)、j + 1 (j ≥ k)。j ∈ {1,…,m}、k ∈ {1,…,m+1}。"""
    assert 1 <= j <= m and 1 <= k <= m + 1
    return j if j < k else j + 1


count = 0
# 前置き δ^{m+1}_k(j) = δ^m_k(j) は j < k と j ≥ k の 2 本の鎖を、途中の値（j、j + 1）まで一行ずつ確かめる。
# 定義の値域と、k を飛ばすこと（全単射 {1,…,m} → {1,…,m+1} \ {k}）を確かめる
for m in range(1, N):
    for k in range(1, m + 2):
        image = [delta(m, k, j) for j in range(1, m + 1)]
        assert sorted(image) == [i for i in range(1, m + 2) if i != k]

# m = 1, k = 1
assert delta(1, 1, 1) == 2
lines = [
    fsum([B(1), B(2)]),
    fsum([B(1)]) + B(2),                    # def_finite_sum_of_real_numbers
    B(1) + B(2),                            # def_finite_sum_of_real_numbers
    B(2) + B(1),                            # ℝ の和の交換法則
    B(delta(1, 1, 1)) + B(1),               # δ^1_1(1) = 2
    fsum([B(delta(1, 1, 1))]) + B(1),       # def を右辺から左辺へ
    fsum([B(delta(1, 1, 1))]) + B(1),       # k = 1
]
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], ("m=1,k=1", t)
    count += 1
# m = 1, k = 2
assert delta(1, 2, 1) == 1
lines = [
    fsum([B(1), B(2)]),
    fsum([B(1)]) + B(2),
    fsum([B(delta(1, 2, 1))]) + B(2),       # δ^1_2(1) = 1
    fsum([B(delta(1, 2, 1))]) + B(2),       # k = 2
]
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], ("m=1,k=2", t)
    count += 1

broken = 0
for m in range(1, N - 1):
    bs = [B(j) for j in range(1, m + 3)]                                      # b_1,…,b_{m+2}
    # 帰納法の仮定（m で、b_1,…,b_{m+1} と全ての k ∈ {1,…,m+1}）
    for k in range(1, m + 2):
        assert fsum(bs[:m + 1]) == fsum([B(delta(m, k, j)) for j in range(1, m + 1)]) + B(k)
    # k = m + 2
    k = m + 2
    assert all(delta(m + 1, k, j) == j for j in range(1, m + 2))
    lines = [
        fsum(bs),
        fsum(bs[:m + 1]) + B(m + 2),                                          # def_finite_sum_of_real_numbers
        fsum([B(delta(m + 1, m + 2, j)) for j in range(1, m + 2)]) + B(m + 2),  # δ^{m+1}_{m+2}(j) = j を各項へ
        fsum([B(delta(m + 1, k, j)) for j in range(1, m + 2)]) + B(k),        # k = m + 2
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (m, k, t)
        count += 1
    # k ≤ m + 1
    for k in range(1, m + 2):
        for j in range(1, m + 1):                                             # 前置きの 2 本の鎖を一行ずつ
            if j < k:
                assert delta(m + 1, k, j) == j and j == delta(m, k, j)
            else:
                assert delta(m + 1, k, j) == j + 1 and j + 1 == delta(m, k, j)
        assert delta(m + 1, k, m + 1) == m + 2
        s = fsum([B(delta(m, k, j)) for j in range(1, m + 1)])                # s の置き方
        lines = [
            fsum(bs),
            fsum(bs[:m + 1]) + B(m + 2),                                      # def_finite_sum_of_real_numbers
            (fsum([B(delta(m, k, j)) for j in range(1, m + 1)]) + B(k)) + B(m + 2),  # 帰納法の仮定
            (s + B(k)) + B(m + 2),                                            # s の置き方
            s + (B(k) + B(m + 2)),                                            # 結合法則
            s + (B(m + 2) + B(k)),                                            # 交換法則
            (s + B(m + 2)) + B(k),                                            # 結合法則
            (fsum([B(delta(m, k, j)) for j in range(1, m + 1)]) + B(m + 2)) + B(k),  # s の置き方
            (fsum([B(delta(m + 1, k, j)) for j in range(1, m + 1)]) + B(m + 2)) + B(k),
            (fsum([B(delta(m + 1, k, j)) for j in range(1, m + 1)]) + B(delta(m + 1, k, m + 1))) + B(k),
            fsum([B(delta(m + 1, k, j)) for j in range(1, m + 2)]) + B(k),    # def を右辺から左辺へ
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], (m, k, t)
            count += 1
        # 主張そのものを Sage の sum（独立な経路）と比べる
        assert sum(bs) == sum(B(delta(m + 1, k, j)) for j in range(1, m + 2)) + B(k)
        # 対照: 飛ばさずに先頭 m+1 項を並べた右辺（k ≠ m+2 なら b_k が二重に入り b_{m+2} が落ちる）
        if fsum(bs) != fsum(bs[:m + 1]) + B(k):
            broken += 1
expected_broken = sum(m + 1 for m in range(1, N - 1))
assert broken == expected_broken, (broken, expected_broken)
print(f"m = 1 の 2 つの場合と、帰納法の段 m → m+1（m = 1,…,{N - 2}、全ての k）の各行を確かめた（{count} 段）")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
