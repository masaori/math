# 対象ラベル: claim_power_minus_one_divides_multiple_exponent
# k=0 の帰納法の基底を ZZ で確認する。

for c in range(1, 65):
    for n in range(1, 33):
        left = ZZ(c) ** (ZZ(n) * 0) - 1
        right = (ZZ(c) ** ZZ(n) - 1) * 0
        assert left == right

print("RESULT: PASS")
