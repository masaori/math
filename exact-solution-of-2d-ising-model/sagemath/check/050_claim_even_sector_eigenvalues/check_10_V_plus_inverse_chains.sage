# 対象ラベル: V_plus_is_invertible
# Step 2・Step 3 の鎖の 2 行目以降（スカラー倍・結合律・Step 1 の左右逆・単位行列を掛ける段）を一行ずつ厳密に確かめる。
# 1 行目（V^{(+)} と R^{(+)} の表示）は check_07・check_08 が覆う。積の括弧は本文と同じく左の 2 因子を先に掛ける。
# 指数行列 E_±, A_± の代わりに、QQ 上の可逆な行列 E_+, A_+ と E_- := E_+^{-1}, A_- := A_+^{-1} を置く
# （この区間の各段が使うのは Step 1 の四つの左右逆だけなので、その関係を満たす任意の行列で段の正しさが確かめられる）。
# スカラー倍の段は a, a^{-1} を QQ の正の元に取って確かめる（本文は a ∈ ℝ を包含 a_C で掛け、aa^{-1} = 1_C を
# real_inclusion_preserves_product と ℝ の aa^{-1} = 1 の 2 行に分けている。その 2 行と係数の段は check_27 が覆う）。
set_random_seed(20261102)
count = 0
for n in [2, 4, 8]:
    In = identity_matrix(QQ, n)
    for trial in range(3):
        Ep = random_matrix(QQ, n, n, algorithm="unimodular")
        Ap = random_matrix(QQ, n, n, algorithm="unimodular")
        Em = Ep.inverse()
        Am = Ap.inverse()
        a = QQ(trial + 2) / 3
        assert Ep * Em == In and Em * Ep == In and Ap * Am == In and Am * Ap == In
        right = [
            (a * (Ep * Ap * Ep)) * (a ** -1 * (Em * Am * Em)),
            a * ((Ep * Ap * Ep) * (a ** -1 * (Em * Am * Em))),
            a * (a ** -1 * ((Ep * Ap * Ep) * (Em * Am * Em))),
            (a * a ** -1) * ((Ep * Ap * Ep) * (Em * Am * Em)),
            QQ(1) * ((Ep * Ap * Ep) * (Em * Am * Em)),
            (Ep * Ap * Ep) * (Em * Am * Em),
            ((Ep * Ap * Ep) * (Em * Am)) * Em,
            ((Ep * Ap) * (Ep * (Em * Am))) * Em,
            ((Ep * Ap) * ((Ep * Em) * Am)) * Em,
            ((Ep * Ap) * (In * Am)) * Em,
            ((Ep * Ap) * Am) * Em,
            (Ep * (Ap * Am)) * Em,
            (Ep * In) * Em,
            Ep * Em,
            In,
        ]
        left = [
            (a ** -1 * (Em * Am * Em)) * (a * (Ep * Ap * Ep)),
            a ** -1 * ((Em * Am * Em) * (a * (Ep * Ap * Ep))),
            a ** -1 * (a * ((Em * Am * Em) * (Ep * Ap * Ep))),
            (a ** -1 * a) * ((Em * Am * Em) * (Ep * Ap * Ep)),
            QQ(1) * ((Em * Am * Em) * (Ep * Ap * Ep)),
            (Em * Am * Em) * (Ep * Ap * Ep),
            ((Em * Am * Em) * (Ep * Ap)) * Ep,
            ((Em * Am) * (Em * (Ep * Ap))) * Ep,
            ((Em * Am) * ((Em * Ep) * Ap)) * Ep,
            ((Em * Am) * (In * Ap)) * Ep,
            ((Em * Am) * Ap) * Ep,
            (Em * (Am * Ap)) * Ep,
            (Em * In) * Ep,
            Em * Ep,
            In,
        ]
        for chain in (right, left):
            for r in range(len(chain) - 1):
                assert chain[r] == chain[r + 1], (n, trial, r)
                count += 1
        # 単位行列を掛ける段の適用先を個別に（左から A_∓、右から E_±）
        for B in (Am, Ap):
            assert In * B == B
        for B in (Ep, Em):
            assert B * In == B
# 否定コントロール: 左右逆の組を取り違えると単位行列にならない
n = 2
Ep = matrix(QQ, [[1, 1], [0, 1]])
Ap = matrix(QQ, [[1, 0], [1, 1]])
assert Ep * Ap * Ep * Ep.inverse() * Ap * Ep.inverse() != identity_matrix(QQ, n)
print("PASS V_plus_is_invertible Step 2・Step 3: %d 段" % count)
