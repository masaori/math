# 対象ラベル: claim_target_direction_bijection
for L in range(1, 5):
    images = []
    for number in range(2 * L * L):
        row, column = divmod(number % (L * L), L)
        horizontal = number < L * L
        for reverse in (False, True):
            direction = (2 if reverse else 0) if horizontal else (3 if reverse else 1)
            if horizontal:
                source = (row, (column + 1) % L) if reverse else (row, column)
                target = (row, column) if reverse else (row, (column + 1) % L)
            else:
                source = ((row + 1) % L, column) if reverse else (row, column)
                target = (row, column) if reverse else ((row + 1) % L, column)
            images.append((target, direction))
            reversed_direction = (2 if not reverse else 0) if horizontal else (3 if not reverse else 1)
            assert reversed_direction == (direction + 2) % 4
            reversed_target = (row, (column + 1) % L) if horizontal and reverse else (
                (row, column) if horizontal else (
                    ((row + 1) % L, column) if reverse else (row, column)))
            assert reversed_target == source
    expected = {((i, j), direction) for i in range(L) for j in range(L)
                for direction in range(4)}
    assert len(images) == 4 * L * L
    assert set(images) == expected
    assert len(set(images)) == len(images)
