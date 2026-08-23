# 対象ラベル: claim_countable_core_corresponds_to_prime_exponent_data
# 帰属: QQ、ZZ、有限集合だけを使う。非可算への脱出は使わない。

VALUES = sorted(set(QQ(n) / QQ(d) for n in range(1, 13) for d in range(1, 13)))
PRIMES = list(primes(2, 20))

def prime_exponent_data(q):
    q = QQ(q)
    return tuple(ZZ(q.valuation(p)) for p in PRIMES)

COARSE_GRAININGS = [
    ("恒等写像", lambda q: QQ(q)),
    ("二倍写像", lambda q: QQ(2) * QQ(q)),
]

for name, pi in COARSE_GRAININGS:
    pi_image = set(pi(u) for u in VALUES)
    lambda_image = set(prime_exponent_data(u) for u in VALUES)

    # 段 1: 衝突を持たない粗視化の像から元の値を復元する。
    sigma = {s: [u for u in VALUES if pi(u) == s][0] for s in pi_image}
    assert all(sigma[pi(u)] == u for u in VALUES)

    # 段 2: 粗視化の像へ戻すと元の像の値に戻る。
    assert all(pi(sigma[s]) == s for s in pi_image)

    # 段 3: 素指数データから元の値を復元し、像へ戻すと元のデータに戻る。
    mu = {t: [u for u in VALUES if prime_exponent_data(u) == t][0]
          for t in lambda_image}
    assert all(mu[prime_exponent_data(u)] == u for u in VALUES)
    assert all(prime_exponent_data(mu[t]) == t for t in lambda_image)

    # 段 4: 二つの像を結ぶ写像を定める。
    Phi = {s: prime_exponent_data(sigma[s]) for s in pi_image}
    Psi = {t: pi(mu[t]) for t in lambda_image}
    assert set(Phi.values()).issubset(lambda_image)
    assert set(Psi.values()).issubset(pi_image)

    # 段 5: 粗視化の像から出発した合成は恒等写像である。
    assert all(Psi[Phi[s]] == s for s in pi_image)

    # 段 6: 素指数データの像から出発した合成も恒等写像である。
    assert all(Phi[Psi[t]] == t for t in lambda_image)

print("PASS: 衝突を持たない粗視化の像と素指数データの像は一対一に対応する")
