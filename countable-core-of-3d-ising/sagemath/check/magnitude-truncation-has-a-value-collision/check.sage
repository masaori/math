# 対象ラベル: claim_magnitude_truncation_has_a_value_collision
# 素指数データを高さ N で頭打ちにする写像 pi_N(a) = (min{v_p(a), N})_p が、値の衝突
# （u != w かつ pi_N(u) = pi_N(w) を満たす正の有理数 u, w の存在）を持つことを、
# 本文と同じ証人 u = 2^N, w = 2^(N+1) で確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 本文の主張は N >= 1 の任意の自然数についてのものなので、高さをいくつか変えて追う。
HEIGHTS = [1, 2, 3, 5, 8]

# 素指数データを見る素数の範囲（無限積の成分のうち有限個を明示的に検査する）。
# 本文の証明は「2 での成分」と「2 以外の素数での成分」の二つに分けているので、
# 検査でも同じ分け方をする。
PRIMES_CHECKED = [ZZ(p) for p in primes(50)]

# 高さ N による切り詰め pi_N の p 成分。
def pi_N_component(a, p, N):
    return min(ZZ(a.valuation(p)), ZZ(N))

for N in HEIGHTS:
    N = ZZ(N)
    assert N >= 1

    # 本文の証人: u = 2^N, w = 2^(N+1)。N >= 1 なのでいずれも正の整数であり、
    # したがって正の有理数に属する。
    u = QQ(2)**N
    w = QQ(2)**(N + 1)
    assert u in QQ and w in QQ
    assert u > 0
    assert w > 0
    assert ZZ(u) == 2**N
    assert ZZ(w) == 2**(N + 1)

    # 段 1: 素数 2 での素指数。2^N と 2^(N+1) の素因数分解に現れる素数は 2 のみで、
    # その指数はそれぞれ N と N+1 である。
    assert ZZ(u.valuation(2)) == N
    assert ZZ(w.valuation(2)) == N + 1
    assert ZZ(u.valuation(2)) != ZZ(w.valuation(2))

    # 段 2: 素数 2 での成分は切り詰めると一致する。
    assert pi_N_component(u, 2, N) == min(N, N) == N
    assert N <= N + 1
    assert pi_N_component(w, 2, N) == min(N + 1, N) == N
    assert pi_N_component(u, 2, N) == pi_N_component(w, 2, N)

    # 段 3: 2 以外の素数 p での成分。u と w の素因数分解に現れる素数は 2 のみなので
    # 素指数はともに 0 であり、N >= 1 > 0 なので切り詰めても 0 のままで一致する。
    for p in PRIMES_CHECKED:
        if p == 2:
            continue
        assert ZZ(u.valuation(p)) == 0
        assert ZZ(w.valuation(p)) == 0
        assert N > 0
        assert pi_N_component(u, p, N) == 0
        assert pi_N_component(w, p, N) == 0
        assert pi_N_component(u, p, N) == pi_N_component(w, p, N)

    # 段 4: 検査した範囲のすべての素数で成分が一致すること（有限タプルの厳密比較）。
    image_u = tuple(pi_N_component(u, p, N) for p in PRIMES_CHECKED)
    image_w = tuple(pi_N_component(w, p, N) for p in PRIMES_CHECKED)
    assert image_u == image_w

    # 段 5: u != w であること（w - u = 2^(N+1) - 2^N = 2^N >= 2 > 0）。
    assert w - u == QQ(2)**N
    assert w - u >= QQ(2)
    assert w - u > 0
    assert u != w

    # 段 6: 切り詰めで落ちる情報の所在。切り詰める前の素数 2 での素指数は一致しない。
    assert ZZ(w.valuation(2)) - ZZ(u.valuation(2)) == 1

    print("N =", N, "u =", ZZ(u), "w =", ZZ(w), "pi_N(u) = pi_N(w) =", image_u, "u != w: OK")

# 段 7: 対偶の側。切り詰めない写像（高さを頭打ちにしない素指数データそのもの）は
# この証人では衝突しない。すなわち衝突は切り詰めが生んだものである。
for N in HEIGHTS:
    N = ZZ(N)
    u = QQ(2)**N
    w = QQ(2)**(N + 1)
    assert tuple(ZZ(u.valuation(p)) for p in PRIMES_CHECKED) != tuple(ZZ(w.valuation(p)) for p in PRIMES_CHECKED)

print("すべての段が通過した。")
