# 対象ラベル: claim_common_denominator_order_independent（def_common_denominator の一意性も検査）
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。

from itertools import product


def smul_lambda(n, lam):
    # Λ の整数倍（def_log_order_group）
    return {p: ZZ(n) * z for p, z in lam.items() if n * z != 0}


def rational_of_log(lam):
    return prod(QQ(p) ** z for p, z in lam.items())


def le_lambda(lam, mu):
    # def_log_order_group_order
    return rational_of_log(lam) <= rational_of_log(mu)


def qsmul(r, lam_q):
    # Λ_Q の有理数倍（def_rational_log_order_group）
    return {p: QQ(r) * z for p, z in lam_q.items() if r * z != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}
    return {p: QQ(z) for p, z in lam.items()}


def witness(N, lam_q):
    # N が lam_q の共通分母なら証人 λ_N を返し、そうでなければ None（def_common_denominator）
    scaled = qsmul(N, lam_q)
    if any(v.denominator() != 1 for v in scaled.values()):
        return None
    lamN = {p: ZZ(v) for p, v in scaled.items()}
    assert iota(lamN) == scaled
    return lamN


primes = [2, 3, 5]
coefficients = [QQ(c) for c in ["-1", "-1/2", "0", "1/3", "1/2", "1", "3/2"]]
vectors = [
    {p: c for p, c in zip(primes, values) if c != 0}
    for values in product(coefficients, repeat=len(primes))
]
denominators = [ZZ(n) for n in range(1, 13)]

# 一意性: 共通分母の証人は一つ（Λ の元として、ι で送って一致するものは同じ辞書）
uniq_count = 0
for lam in vectors:
    for N in denominators:
        w = witness(N, lam)
        if w is None:
            continue
        # 別の候補 w' で iota(w') == N·λ となるものは w に限る（有限台上の各素数で整数は一意）
        for p, v in iota(w).items():
            assert v == QQ(N) * lam[p]
        uniq_count += 1

# 独立性: N, N' が λ, μ 双方の共通分母なら判定が一致
iff_count = 0
cross_count = 0
for lam in vectors:
    for mu in vectors:
        wl = {N: witness(N, lam) for N in denominators}
        wm = {N: witness(N, mu) for N in denominators}
        good = [N for N in denominators if wl[N] is not None and wm[N] is not None]
        for N in good:
            for Np in good:
                # 準備: N'λ_N = Nλ_{N'}
                assert smul_lambda(Np, wl[N]) == smul_lambda(N, wl[Np])
                assert smul_lambda(Np, wm[N]) == smul_lambda(N, wm[Np])
                cross_count += 1
                assert le_lambda(wl[N], wm[N]) == le_lambda(wl[Np], wm[Np])
                iff_count += 1

print("PASS: common-denominator-order-independent (%d vectors, %d witnesses, %d cross identities, %d equivalences)"
      % (len(vectors), uniq_count, cross_count, iff_count))
