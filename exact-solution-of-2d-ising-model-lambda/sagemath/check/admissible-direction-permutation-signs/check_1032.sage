# 対象ラベル: claim_admissible_direction_permutation_signs
# 1032 の転倒数と符号。自然数・整数だけを使う。
sigma = (1, 0, 3, 2)
inversions = {(i, j) for i in range(4) for j in range(i + 1, 4) if sigma[i] > sigma[j]}
assert len(inversions) == 2
assert (-1) ** len(inversions) == 1
print('PASS: 1032 has inversion count 2 and sign 1')
