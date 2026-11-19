# Exact sample of the cone extension for F = QQ and E = QQ(sqrt(2)).
# Target: claim_square_root_adjoined_positive_cone_extension.
# This checks finite samples of the four steps in the human proof.

from itertools import product

K = QuadraticField(2, 's')
s = K.gen()
root = AA(2).sqrt()

def image(z):
    return AA(z[0]) + AA(z[1]) * root

def cone(z):
    return image(z) > 0

def base_cone(q):
    return q > 0

samples = [K(u) + K(v) * s for u, v in product(range(-3, 4), repeat=2)]
positive_weights = [QQ(1), QQ(2), QQ(1) / QQ(2)]
checks = 0

# Sq(C_F; E) is a precone and excludes -1 in these samples.
for z, w in product(samples, repeat=2):
    for c, d in product(positive_weights, repeat=2):
        weighted = c * z * z + d * w * w
        assert image(weighted) >= 0
        assert weighted != -1
        checks += 2

# The concrete positive cone is closed under addition and multiplication.
positive = [z for z in samples if cone(z)]
for z, w in product(positive, repeat=2):
    assert cone(z + w)
    assert cone(z * w)
    checks += 2

# Its sign trichotomy and its restriction to QQ agree with C_F.
for z in samples:
    assert sum([z == 0, cone(z), cone(-z)]) == 1
    checks += 1
for q in range(-3, 4):
    assert cone(K(q)) == base_cone(QQ(q))
    checks += 1

print('RESULT: PASS', checks)
