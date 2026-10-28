# 対象ラベル: claim_admissible_direction_permutation_signs
# 0123 の転倒数と符号。自然数・整数だけを使う。
sigma = (0, 1, 2, 3)
inversions = {(i, j) for i in range(4) for j in range(i + 1, 4) if sigma[i] > sigma[j]}
assert len(inversions) == 0
assert (-1) ** len(inversions) == 1
print('PASS: 0123 has inversion count 0 and sign 1')
