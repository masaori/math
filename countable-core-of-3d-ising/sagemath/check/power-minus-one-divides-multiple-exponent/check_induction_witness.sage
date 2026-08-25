# 対象ラベル: claim_power_minus_one_divides_multiple_exponent
# t_(k+1)=c^(nk)+t_k が整除の証人を更新することを ZZ で確認する。

for c in range(1, 33):
    for n in range(1, 17):
        witness = ZZ(0)
        for k in range(0, 17):
            assert ZZ(c) ** (ZZ(n) * ZZ(k)) - 1 == (ZZ(c) ** ZZ(n) - 1) * witness
            next_witness = ZZ(c) ** (ZZ(n) * ZZ(k)) + witness
            assert ZZ(c) ** (ZZ(n) * (ZZ(k) + 1)) - 1 == (ZZ(c) ** ZZ(n) - 1) * next_witness
            witness = next_witness

print("RESULT: PASS")
