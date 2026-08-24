# 対象ラベル: claim_rational_power_base_den_coprime_to_num
# 法 a の合同式と gcd(u,v)=1 から gcd(a,v)=1 が従う背理法を、
# ZZ の整除性だけで一行ずつ有限検証する。

print("== 段 1: 共通素因子から v^N の整除 ==")
checked_common_primes = 0
for a in range(1, 13):
    for v in range(1, 13):
        for p in prime_range(2, 13):
            if ZZ(a) % p != 0 or ZZ(v) % p != 0:
                continue
            for N in range(1, 6):
                assert ZZ(v) ** N % p == 0
                checked_common_primes += 1
assert checked_common_primes > 0
print("  PASS（共通素因子と正の冪", checked_common_primes, "件）")

print("== 段 2: 法 a の合同式を法 p へ移し u^N の整除を得る ==")
checked_congruences = 0
for a in range(1, 13):
    for u in range(1, 13):
        for v in range(1, 13):
            for omega_zero in range(1, 5):
                for N in range(1, 6):
                    if (omega_zero * ZZ(v) ** N - ZZ(u) ** N) % a != 0:
                        continue
                    for p in prime_range(2, 13):
                        if ZZ(a) % p != 0 or ZZ(v) % p != 0:
                            continue
                        assert (omega_zero * ZZ(v) ** N - ZZ(u) ** N) % p == 0
                        assert omega_zero * ZZ(v) ** N % p == 0
                        assert ZZ(u) ** N % p == 0
                        assert ZZ(u) % p == 0
                        checked_congruences += 1
assert checked_congruences > 0
print("  PASS（合同式を満たす標本", checked_congruences, "件）")

print("== 段 3: 既約性を加えると a と v は互いに素 ==")
checked_reduced_cases = 0
for a in range(1, 13):
    for u in range(1, 13):
        for v in range(1, 13):
            if gcd(ZZ(u), ZZ(v)) != 1:
                continue
            for omega_zero in range(1, 5):
                for N in range(1, 6):
                    if (omega_zero * ZZ(v) ** N - ZZ(u) ** N) % a != 0:
                        continue
                    assert gcd(ZZ(a), ZZ(v)) == 1
                    checked_reduced_cases += 1
assert checked_reduced_cases > 0
print("  PASS（既約な標本", checked_reduced_cases, "件）")
print("ALL PASS")
