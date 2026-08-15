# 対象ラベル: claim_rational_log_order_iff
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。

from itertools import product


def log_lambda(q):
    # 正の有理数の対数（def_rational_log）: 素因数分解の指数ベクトル
    assert q > 0
    return {ZZ(p): ZZ(e) for p, e in QQ(q).factor() if e != 0}


def rational_of_log(lam):
    # def_rational_of_log
    return prod(QQ(p) ** z for p, z in lam.items())


def le_lambda(lam, mu):
    # def_log_order_group_order
    return rational_of_log(lam) <= rational_of_log(mu)


primes = [2, 3, 5, 7]
exponents = [-2, -1, 0, 1, 2]
rationals = sorted(set(
    prod(QQ(p) ** e for p, e in zip(primes, values))
    for values in product(exponents, repeat=len(primes))
))
assert all(q > 0 for q in rationals)

# 補助等式 rat_Λ(log q) = q と、その手前の log(rat_Λ(log q)) = log q
identity_count = 0
for q in rationals:
    lam = log_lambda(q)
    assert log_lambda(rational_of_log(lam)) == lam
    assert rational_of_log(lam) == q
    identity_count += 1

# 主張: q ≤ q' ⟺ log q ≤_Λ log q'（両向き）。段ごとの一致も見る
iff_count = 0
for q in rationals:
    lam = log_lambda(q)
    for q2 in rationals:
        mu = log_lambda(q2)
        step1 = le_lambda(lam, mu) == (rational_of_log(lam) <= rational_of_log(mu))
        step2 = (rational_of_log(lam) <= rational_of_log(mu)) == (q <= q2)
        assert step1 and step2
        assert (q <= q2) == le_lambda(lam, mu)
        iff_count += 1

print("PASS: rational-log-order-iff (%d positive rationals, %d identities, %d equivalences)"
      % (len(rationals), identity_count, iff_count))
