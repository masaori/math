# 対象ラベル: claim_power_minus_one_divides_multiple_exponent
# n(k+1)=nk+n と同じ底の冪の積を ZZ で確認する。

for c in range(1, 33):
    for n in range(1, 17):
        for k in range(0, 17):
            assert ZZ(n) * (ZZ(k) + 1) == ZZ(n) * ZZ(k) + ZZ(n)
            assert ZZ(c) ** (ZZ(n) * (ZZ(k) + 1)) == ZZ(c) ** (ZZ(n) * ZZ(k)) * ZZ(c) ** ZZ(n)

print("RESULT: PASS")
