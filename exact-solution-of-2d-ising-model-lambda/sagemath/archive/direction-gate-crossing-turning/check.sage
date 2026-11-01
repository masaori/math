# 対象ラベル: claim_direction_gate_crossing_turning
#
# 非後退な循環方向列について、循環総回転数が方向番号の門 3|0 の
# 正横断数と負横断数の差の 4 倍に等しいことを ZZ で全列挙する。

from itertools import product

directions = tuple(ZZ(value) for value in range(4))
max_length = 10
checked_sequences = 0
checked_steps = 0


def step_turning(first, second):
    difference = (second - first) % 4
    if difference == 0:
        return ZZ(0)
    if difference == 1:
        return ZZ(1)
    if difference == 3:
        return ZZ(-1)
    raise ValueError("a reversal is not a nonbacktracking transition")


for length in range(1, max_length + 1):
    for sequence in product(directions, repeat=length):
        cyclic_pairs = tuple(zip(sequence, sequence[1:] + sequence[:1]))
        if any((second - first) % 4 == 2 for first, second in cyclic_pairs):
            continue

        turning = ZZ(sum(step_turning(first, second) for first, second in cyclic_pairs))
        positive_gate = ZZ(sum(1 for first, second in cyclic_pairs if (first, second) == (3, 0)))
        negative_gate = ZZ(sum(1 for first, second in cyclic_pairs if (first, second) == (0, 3)))

        local_sum = ZZ(sum(
            second - first
            + (4 if (first, second) == (3, 0) else 0)
            - (4 if (first, second) == (0, 3) else 0)
            for first, second in cyclic_pairs
        ))
        telescoping_sum = ZZ(sum(second - first for first, second in cyclic_pairs))

        assert local_sum == turning, sequence
        assert telescoping_sum == 0, sequence
        assert turning == 4 * (positive_gate - negative_gate), sequence

        checked_sequences += 1
        checked_steps += length

print(
    f"PASS: nonbacktracking cyclic direction sequences={checked_sequences}, "
    f"cyclic steps={checked_steps}, length<=%d" % max_length
)
