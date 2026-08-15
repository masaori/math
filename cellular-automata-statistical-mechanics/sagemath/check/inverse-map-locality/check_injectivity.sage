# 対象ラベル: claim_inverse_support_not_in_neighborhood_counterexample
# 証明 (1): 表の右列 32 個が互いに相異なること、および定義どおりの単射性
# （全ての y, y' について F y = F y' ⇒ y = y'）を検査する。
# 帰属: 有限集合の等号だけ。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

configurations = all_configurations()
images = [global_map(y) for y in configurations]

# 右列の 32 個が互いに相異なる（5 文字列の等号検査を全対で行う）
distinct_pairs = 0
for i in range(len(images)):
    for j in range(len(images)):
        if i != j:
            assert images[i] != images[j]
            distinct_pairs += 1
assert len(frozenset(images)) == 32

# 定義どおりの単射性
pairs = 0
for y in configurations:
    for y_prime in configurations:
        assert (global_map(y) != global_map(y_prime)) or (y == y_prime)
        pairs += 1

print("ordered pairs (i != j) with distinct images: {}; pairs scanned for injectivity: {}".format(
    distinct_pairs, pairs))
print("RESULT: PASS")
