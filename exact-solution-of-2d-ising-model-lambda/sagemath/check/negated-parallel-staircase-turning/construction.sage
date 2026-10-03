# 座標定義・回転定義は既存の行別検算と共通にする。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])),
                  '../reversed-parallel-staircase-turning/construction.sage'))


def negated_cases():
    for length, horizontal, vertical in winding_cases():
        width = length * abs(horizontal)
        height = length * abs(vertical)
        column = (ZZ(0), integer_sign(horizontal))
        row = (integer_sign(vertical), ZZ(0))
        if horizontal * vertical > 0:
            p, q, a, b = width, height, column, row
        else:
            p, q, a, b = height, width, row, column
        n = p + q
        points = [parallel_point(length, horizontal, vertical, s) for s in range(n + 1)]
        steps = [vector_subtract(vector_scale(-1, points[s + 1]),
                                 vector_scale(-1, points[s])) for s in range(n)]
        yield length, horizontal, vertical, p, q, a, b, n, points, steps


def forward_expansion(p, a, b, s):
    if s < p:
        return vector_subtract(vector_scale(s + 1, a), vector_scale(s, a))
    if s == p:
        return vector_subtract(vector_add(vector_scale(p, a), b), vector_scale(p, a))
    return vector_subtract(vector_add(vector_scale(p, a), vector_scale(s + 1 - p, b)),
                           vector_add(vector_scale(p, a), vector_scale(s - p, b)))


def forward_reduction(p, a, b, s):
    if s < p:
        return vector_scale((s + 1) - s, a)
    if s == p:
        return b
    return vector_scale((s + 1 - p) - (s - p), b)
