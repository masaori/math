from itertools import product

def lift_geometries():
    directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    for m in range(1, 5):
        for word in product(directions, repeat=m):
            for offset in [(0, 0), (2, -3)]:
                points = [vector(ZZ, offset)]
                for step in word:
                    points.append(points[-1] + vector(ZZ, step))
                B = points[-1] - points[0]
                def P(k, points=points, B=B, m=m):
                    return points[k % m] + (k // m) * B
                yield m, points, B, P

def translation_rows():
    for m, points, B, P in lift_geometries():
        for j in sorted(set([-m-1, -m, -1, 0, m-1, m, m+1])):
            q, r = divmod(j, m)
            for a in range(-2, 3):
                yield m, points, B, P, j, q, r, a

def repetition_rows():
    for m, points, B, P in lift_geometries():
        for k0 in sorted(set([-m-1, -m, -1, 0, m-1, m, m+1])):
            u = [P(k0+s+1)-P(k0+s) for s in range(m)]
            for c in range(1, 4):
                yield m, B, P, k0, c, u

def step_rows():
    for m, B, P, k0, c, u in repetition_rows():
        for i in range(c*m):
            a, b = divmod(i, m)
            yield m, B, P, k0, c, u, i, a, b
