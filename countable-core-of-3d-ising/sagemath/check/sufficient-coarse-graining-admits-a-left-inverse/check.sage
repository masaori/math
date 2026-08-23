# 対象ラベル: claim_sufficient_coarse_graining_admits_a_left_inverse
# 帰属: QQ と有限集合だけを使う。浮動小数点と非可算への脱出は使わない。

VALUES = sorted(set(QQ(n) / QQ(d) for n in range(1, 13) for d in range(1, 13)))
PRIMES = list(primes(2, 20))

def prime_exponent_data(q):
    q = QQ(q)
    return tuple(q.valuation(p) for p in PRIMES)

COARSE_GRAININGS = [
    ("恒等写像", lambda q: QQ(q)),
    ("素指数データ", prime_exponent_data),
]

for name, pi in COARSE_GRAININGS:
    image = set(pi(u) for u in VALUES)

    # 段 1: 像の各点は少なくとも一つの原像を持つ。
    for s in image:
        preimages = [u for u in VALUES if pi(u) == s]
        assert len(preimages) >= 1

        # 段 2: 衝突が無いので、その原像はちょうど一つである。
        assert len(preimages) == 1

    # 段 3: 一意な原像を対応させる復元写像を定める。
    sigma = {s: [u for u in VALUES if pi(u) == s][0] for s in image}
    assert set(sigma.keys()) == image
    assert all(sigma[s] in VALUES for s in image)

    # 段 4: 復元写像は粗視化写像の左逆写像である。
    for u in VALUES:
        assert sigma[pi(u)] == u

    # 段 5: 左逆写像の条件は像の各点で値を強制するので、左逆写像は一意である。
    tau = {s: sigma[s] for s in image}
    for u in VALUES:
        assert tau[pi(u)] == u
    assert tau == sigma

print("PASS: 衝突を持たない粗視化の像上で左逆写像が一意に定まる")
