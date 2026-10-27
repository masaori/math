def oriented_edges(L):
    for number in range(2 * L * L):
        for reverse in (False, True):
            yield (number, reverse)

def endpoints_and_direction(L, edge):
    number, reverse = edge
    row, column = divmod(number % (L * L), L)
    horizontal = number < L * L
    if horizontal:
        source = (row, (column + 1) % L) if reverse else (row, column)
        target = (row, column) if reverse else (row, (column + 1) % L)
        direction = 2 if reverse else 0
    else:
        source = ((row + 1) % L, column) if reverse else (row, column)
        target = (row, column) if reverse else ((row + 1) % L, column)
        direction = 3 if reverse else 1
    return source, target, direction
