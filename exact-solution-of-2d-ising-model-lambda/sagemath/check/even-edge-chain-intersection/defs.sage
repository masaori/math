def edge_key(L, axis, i, j):
    return (axis, i % L, j % L)

def chain(L, keys):
    result = set()
    for key in keys:
        if key in result:
            result.remove(key)
        else:
            result.add(key)
    return result

def square(L, i, j):
    return chain(L, [edge_key(L, 'H', i, j), edge_key(L, 'H', i + 1, j),
                     edge_key(L, 'V', i, j), edge_key(L, 'V', i, j + 1)])

def horizontal(L):
    return chain(L, [edge_key(L, 'H', 0, j) for j in range(L)])

def vertical(L):
    return chain(L, [edge_key(L, 'V', i, 0) for i in range(L)])

def intersect(L, C, D):
    return sum(ZZ(edge_key(L, 'H', i, j) in C) * ZZ(edge_key(L, 'V', i - 1, j + 1) in D)
               + ZZ(edge_key(L, 'V', i, j) in C) * ZZ(edge_key(L, 'H', i, j) in D)
               for i in range(L) for j in range(L)) % 2

def even(L, C):
    return all((ZZ(edge_key(L, 'H', i, j) in C)
                + ZZ(edge_key(L, 'H', i, j - 1) in C)
                + ZZ(edge_key(L, 'V', i, j) in C)
                + ZZ(edge_key(L, 'V', i - 1, j) in C)) % 2 == 0
               for i in range(L) for j in range(L))

def seams(L, C):
    return (sum(ZZ(edge_key(L, 'H', i, L - 1) in C) for i in range(L)) % 2,
            sum(ZZ(edge_key(L, 'V', L - 1, j) in C) for j in range(L)) % 2)
