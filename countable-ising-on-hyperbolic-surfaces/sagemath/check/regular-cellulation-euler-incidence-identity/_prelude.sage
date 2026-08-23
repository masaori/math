examples = (
    {"name": "two-face triangular sphere", "p": ZZ(3), "q": ZZ(2), "v": ZZ(3), "e": ZZ(3), "f": ZZ(2)},
    {"name": "one-face square torus", "p": ZZ(4), "q": ZZ(4), "v": ZZ(1), "e": ZZ(2), "f": ZZ(1)},
    {"name": "regular hyperbolic quotient cellulation", "p": ZZ(3), "q": ZZ(7), "v": ZZ(24), "e": ZZ(84), "f": ZZ(56)},
)

for data in examples:
    assert data["p"] * data["f"] == 2 * data["e"]
    assert data["q"] * data["v"] == 2 * data["e"]

def values(data):
    p = data["p"]
    q = data["q"]
    v = data["v"]
    e = data["e"]
    f = data["f"]
    chi = v - e + f
    return p, q, v, e, f, chi
