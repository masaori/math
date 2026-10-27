# 対象ラベル: claim_source_direction_bijection
# 辺長一を含め、辺の番号と向きで定めた始点・方向の全組を照合する。
for L in range(1, 5):
    images = []
    for number in range(2 * L * L):
        row, column = divmod(number % (L * L), L)
        horizontal = number < L * L
        for reverse in (False, True):
            direction = (2 if reverse else 0) if horizontal else (3 if reverse else 1)
            if horizontal:
                source = (row, (column + 1) % L) if reverse else (row, column)
            else:
                source = ((row + 1) % L, column) if reverse else (row, column)
            images.append((source, direction))
    target = {((i, j), direction) for i in range(L) for j in range(L)
              for direction in range(4)}
    assert len(images) == 4 * L * L
    assert set(images) == target
    assert len(set(images)) == len(images)
