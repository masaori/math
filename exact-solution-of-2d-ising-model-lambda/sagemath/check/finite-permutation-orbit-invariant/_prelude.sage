from itertools import permutations, product

if "fpoi_permutations" not in globals():
    fpoi_permutations = [tuple(p) for m in range(7) for p in permutations(range(m))]
    fpoi_maps = [tuple(f) for m in range(5) for f in product(range(m), repeat=m)]
    assert len(fpoi_permutations) == 874
    assert len(fpoi_maps) == 289

    def fpoi_iterate(f, n, i):
        for _ in range(n):
            i = f[i]
        return i

    def fpoi_inverse(sigma):
        return tuple(sigma.index(i) for i in range(len(sigma)))

    def fpoi_orbit(sigma, i):
        support = set()
        for f in (sigma, fpoi_inverse(sigma)):
            reached = set()
            j = i
            while j not in reached:
                reached.add(j)
                support.add(j)
                j = f[j]
        return frozenset(support)

    def fpoi_reachable(sigma, i):
        # 順逆の反復列と独立に、無向辺 {j, sigma[j]} の隣接リストを探索する。
        neighbors = [set() for _ in sigma]
        for j, k in enumerate(sigma):
            neighbors[j].add(k)
            neighbors[k].add(j)
        reached = {i}
        pending = [i]
        while pending:
            j = pending.pop()
            for k in neighbors[j] - reached:
                reached.add(k)
                pending.append(k)
        return frozenset(reached)

    fpoi_supports = {(sigma, i): fpoi_orbit(sigma, i)
                     for sigma in fpoi_permutations for i in range(len(sigma))}

    def fpoi_map_points():
        for f in fpoi_maps:
            for y in range(len(f)):
                yield f, y

    def fpoi_map_steps():
        for f, y in fpoi_map_points():
            for n in range(9):
                yield f, n, y

    def fpoi_steps():
        for sigma in fpoi_permutations:
            tau = fpoi_inverse(sigma)
            for i in range(len(sigma)):
                for n in range(2 * len(sigma) + 1):
                    yield sigma, tau, i, n

    def fpoi_points():
        for sigma in fpoi_permutations:
            tau = fpoi_inverse(sigma)
            for i in range(len(sigma)):
                yield sigma, tau, i

    def fpoi_pairs():
        for sigma, tau, i in fpoi_points():
            for j in range(len(sigma)):
                yield sigma, tau, i, j
