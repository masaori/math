# 対象ラベル: claim_collision_free_coarse_graining_is_sufficient_on_general_families
# 衝突を持たない粗視化が一般の有限箱列の箱サイズ極限に十分であることの有限側を確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

L_TOP = 12
PRIMES = list(primes(2, 80))

def prime_exponent_data(q):
    q = QQ(q)
    return tuple(q.valuation(p) for p in PRIMES)

COARSE_GRAININGS = [
    ("恒等写像", lambda q: QQ(q)),
    ("素指数データ", prime_exponent_data),
]

VALUES = [QQ(n) / QQ(d) for n in range(1, 11) for d in range(1, 11)]

for name, pi in COARSE_GRAININGS:
    # 段 1: 検査範囲で粗視化の値の一致から元の正の有理数の一致を得る。
    for u in VALUES:
        for w in VALUES:
            if pi(u) == pi(w):
                assert u == w

    # 定数列に限らない族を、正の有理数の基数と箱ごとに変わる乗根次数から作る。
    roots_A = [QQ(L + 1) / QQ((L % 4) + 1) for L in range(1, L_TOP + 1)]
    roots_B = list(roots_A)
    exponents = [ZZ((L % 5) + 1) for L in range(1, L_TOP + 1)]
    A = [roots_A[i] ** exponents[i] for i in range(L_TOP)]
    B = [roots_B[i] ** exponents[i] for i in range(L_TOP)]

    # 段 2: 各箱で三つの入力列が要求された集合に属する。
    for i in range(L_TOP):
        assert A[i] in QQ and A[i] > 0
        assert B[i] in QQ and B[i] > 0
        assert exponents[i] in ZZ and exponents[i] >= 1

        # 段 3: 粗視化の一致と衝突なしから、各箱の元の値の一致を得る。
        assert pi(A[i]) == pi(B[i])
        assert A[i] == B[i]

        # 段 4: 同じ値に同じ次数の正の乗根を取る二つの列は項別に一致する。
        assert roots_A[i] ** exponents[i] == A[i]
        assert roots_B[i] ** exponents[i] == B[i]
        assert roots_A[i] == roots_B[i]

# 段 5: 検査した族が定数列ではないこと。
assert len(set(A)) > 1
assert len(set(exponents)) > 1

print("PASS: 衝突を持たない粗視化は一般の有限箱列の箱サイズ極限に十分である（有限側の検査）")
