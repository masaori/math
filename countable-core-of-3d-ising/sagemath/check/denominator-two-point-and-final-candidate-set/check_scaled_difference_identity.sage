# 対象ラベル: claim_denominator_two_point_and_final_candidate_set
# 2^E c^n = 2^E Omega0 + a S の両辺から 2^E を引いて 2 倍する等式を、c^n を消去した形で確認する。

E = 12
R = PolynomialRing(QQ, names=("a", "S", "omega0"))
a, S, omega0 = R.gens()

# 仮定 2^E w = 2^E omega0 + a S を w について解いた形
w = omega0 + a * S / 2 ** E
assert 2 ** E * w == 2 ** E * omega0 + a * S

# 両辺から 2^E を引く段
assert 2 ** E * w - 2 ** E == 2 ** E * (omega0 - 1) + a * S
# 2 倍する段
assert 2 ** (E + 1) * (w - 1) == 2 ** (E + 1) * (omega0 - 1) + 2 * a * S

print("RESULT: PASS")
