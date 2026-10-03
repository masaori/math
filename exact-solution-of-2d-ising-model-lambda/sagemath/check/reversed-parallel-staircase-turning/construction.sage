# def_winding_parallel_staircase と def_step_turning の整数による構成。
# 座標は (row, col)。方向番号は本文の右・下・左・上の順である。


def integer_sign(value):
    return ZZ((value > 0) - (value < 0))


def winding_cases():
    for length in range(1, 6):
        for horizontal in range(-5, 6):
            for vertical in range(-5, 6):
                if horizontal != 0 or vertical != 0:
                    yield ZZ(length), ZZ(horizontal), ZZ(vertical)


def parallel_point(length, horizontal, vertical, index):
    width = length * abs(horizontal)
    height = length * abs(vertical)
    assert 0 <= index <= width + height
    if horizontal * vertical > 0:
        if index <= width:
            return (ZZ(0), integer_sign(horizontal) * index)
        return (integer_sign(vertical) * (index - width), length * horizontal)
    if index <= height:
        return (integer_sign(vertical) * index, ZZ(0))
    return (length * vertical, integer_sign(horizontal) * (index - height))


def reversed_steps(length, horizontal, vertical):
    count = length * (abs(horizontal) + abs(vertical))
    steps = []
    for index in range(count):
        left = parallel_point(length, horizontal, vertical, count - 1 - index)
        right = parallel_point(length, horizontal, vertical, count - index)
        steps.append((left[0] - right[0], left[1] - right[1]))
    return steps


def constant_blocks(length, horizontal, vertical):
    width = length * abs(horizontal)
    height = length * abs(vertical)
    along_column = (ZZ(0), -integer_sign(horizontal))
    along_row = (-integer_sign(vertical), ZZ(0))
    if horizontal * vertical > 0:
        return height, along_row, width, along_column
    return width, along_column, height, along_row


def vector_add(left, right):
    return (left[0] + right[0], left[1] + right[1])


def vector_subtract(left, right):
    return (left[0] - right[0], left[1] - right[1])


def vector_scale(coefficient, point):
    return (coefficient * point[0], coefficient * point[1])


def parallel_coordinate(horizontal, vertical, point):
    return vertical * point[0] + horizontal * point[1]


def two_block_point(boundary, first, last, index):
    if index <= boundary:
        return vector_scale(index, first)
    return vector_add(vector_scale(boundary, first),
                      vector_scale(index - boundary, last))


def unit_directions():
    return [(ZZ(0), ZZ(1)), (ZZ(1), ZZ(0)),
            (ZZ(0), ZZ(-1)), (ZZ(-1), ZZ(0))]


def quarter_turn(left, right):
    return left[1] * right[0] - left[0] * right[1]


def step_turning(left, right):
    directions = unit_directions()
    delta = (ZZ(directions.index(right)) - ZZ(directions.index(left))) % 4
    assert delta != 2
    if delta == 0:
        return ZZ(0)
    if delta == 1:
        return ZZ(1)
    return ZZ(-1)


def internal_turning(steps):
    return sum((quarter_turn(steps[index], steps[index + 1])
                for index in range(len(steps) - 1)), ZZ(0))


def cyclic_turning(steps):
    count = len(steps)
    assert count > 0
    return sum((step_turning(steps[index], steps[(index + 1) % count])
                for index in range(count)), ZZ(0))
