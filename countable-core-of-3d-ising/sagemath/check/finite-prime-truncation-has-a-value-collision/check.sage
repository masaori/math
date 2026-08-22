# 対象ラベル: claim_finite_prime_truncation_has_a_value_collision
# 素指数データを有限集合 P の素数での指数だけへ切り詰める写像 pi_P が、値の衝突
# （u != w かつ pi_P(u) = pi_P(w) を満たす正の有理数 u, w の存在）を持つことを、
# 本文と同じ証人 u = 1, w = r で確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 本文の証明が扱う有限集合 P の候補（素数からなる有限集合）。
FINITE_PRIME_SETS = [
    [],
    [2],
    [2, 3],
    [2, 3, 5],
    [3, 5, 7, 11],
    [2, 5, 13],
]

# 素指数データの P への切り詰め pi_P(a) = (v_p(a))_{p in P}。
def pi_P(a, P):
    return tuple(ZZ(a.valuation(p)) for p in P)

# 段 1: P が有限集合であれば P に属さない素数 r が存在すること
#（本文の「素数は無限に多く存在する」の段の有限側の確認。検査は最小の証人を取る）。
def smallest_prime_outside(P):
    p = ZZ(2)
    while True:
        if p not in P:
            return p
        p = next_prime(p)

for P in FINITE_PRIME_SETS:
    r = smallest_prime_outside(P)
    assert r.is_prime()
    assert r not in P

    # 本文の証人: u = 1, w = r。いずれも正の有理数である。
    u = QQ(1)
    w = QQ(r)
    assert u > 0
    assert w > 0

    # 段 2: P のすべての素数で u の素指数が 0 であること（1 の素因数分解は空である）。
    for p in P:
        assert ZZ(u.valuation(p)) == 0

    # 段 3: P のすべての素数で w の素指数が 0 であること
    #（p in P なら p != r であり、r の素因数分解に現れる素数は r だけである）。
    for p in P:
        assert ZZ(p) != r
        assert ZZ(w.valuation(p)) == 0

    # 段 4: 切り詰めた像が一致すること。
    assert pi_P(u, P) == pi_P(w, P)
    assert pi_P(u, P) == tuple(ZZ(0) for p in P)

    # 段 5: u != w であること（r は素数なので r >= 2 であり、w - u = r - 1 >= 1 > 0）。
    assert r >= 2
    assert w - u == QQ(r) - QQ(1)
    assert w - u >= QQ(1)
    assert w - u > 0
    assert u != w

    # 段 6: 切り詰めで落ちる情報の所在。r 自身での素指数は一致しない。
    assert ZZ(u.valuation(r)) == 0
    assert ZZ(w.valuation(r)) == 1
    assert ZZ(u.valuation(r)) != ZZ(w.valuation(r))

    print("P =", P, "r =", r, "pi_P(u) = pi_P(w) =", pi_P(u, P), "u != w: OK")

print("すべての段が通過した。")
