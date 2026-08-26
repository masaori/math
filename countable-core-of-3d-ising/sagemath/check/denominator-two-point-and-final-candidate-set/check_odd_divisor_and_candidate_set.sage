# 対象ラベル: claim_denominator_two_point_and_final_candidate_set
# a | 2(c^n-1) と a が奇数であることから a=1 が従うこと、および候補集合が三つに限られることを確認する。

E = 12
omega0 = ZZ(2)   # claim_zero_breakage_multiplicity_is_two
admitted = ZZ(0)
rejected = ZZ(0)
for a in range(1, 129, 2):        # 2 と互いに素な正の自然数（奇数）
    a = ZZ(a)
    assert a.gcd(2) == 1
    for k in range(0, 33):
        k = ZZ(k)
        S = 2 ** E * k
        diff = a * k + (omega0 - 1)      # diff は c^n - 1 を表す
        # 分離した等式が標本の上で成り立つこと
        assert 2 ** (E + 1) * diff == 2 ** (E + 1) * (omega0 - 1) + 2 * a * S
        if not a.divides(2 * diff):
            rejected += 1
            continue
        # 仮定を満たす標本では、証明の三段がそのまま整除として成り立つ
        assert a.divides(2 ** (E + 1) * diff)
        assert a.divides(2 * a * S)
        assert a.divides(2 ** (E + 1) * (omega0 - 1))
        assert a.divides(2 ** (E + 1))
        assert a == 1
        admitted += 1

assert admitted > 0
assert rejected > 0

# 整数の有理点側: q | 2 を満たす正の整数は 1 と 2 だけである。
integer_points = [q for q in range(1, 200) if ZZ(2) % ZZ(q) == 0]
assert integer_points == [1, 2]

# 合わせた候補集合は三つ。
candidates = set([QQ(1) / 2]) | set(QQ(q) for q in integer_points)
assert candidates == set([QQ(1) / 2, QQ(1), QQ(2)])
assert len(candidates) == 3
# これらの整除の必要条件だけでは q = 1 を排除できない（1 が候補に残る）。
assert QQ(1) in candidates

print("RESULT: PASS (", admitted, " admitted,", rejected, " rejected exact cases)")
