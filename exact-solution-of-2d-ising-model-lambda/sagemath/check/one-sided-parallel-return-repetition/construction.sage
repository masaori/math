# 整数格子の平行階段と、一側閉包の第三部分を定義から構成する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])),
                  '../reversed-parallel-staircase-turning/construction.sage'))


def return_rows(mode):
    for length in range(1, 4):
        for horizontal in range(-3, 4):
            for vertical in range(-3, 4):
                if horizontal == 0 and vertical == 0:
                    continue
                n = ZZ(length * (abs(horizontal) + abs(vertical)))
                B = vector(ZZ, [length * vertical, length * horizontal])
                G = [vector(ZZ, parallel_point(length, horizontal, vertical, j))
                     for j in range(n + 1)]
                v = [-(G[j + 1] - G[j]) for j in range(n)]
                for A in [vector(ZZ, [0, 0]), vector(ZZ, [7, -11])]:
                    for c in range(1, 5):
                        P = [A + (c - (j // n)) * B - G[j % n]
                             for j in range(c * n + 1)]
                        if mode == 'word':
                            yield n, ZZ(c), ZZ(0), ZZ(0), ZZ(0), A, B, G, P, v
                            continue
                        for i in range(c * n):
                            a, b = ZZ(i) // n, ZZ(i) % n
                            if mode == 'inside' and b + 1 == n:
                                continue
                            if mode == 'seam' and b + 1 != n:
                                continue
                            yield n, ZZ(c), ZZ(i), a, b, A, B, G, P, v
