from itertools import product

K = CyclotomicField(8)
zeta = K.gen()
assert zeta**4 == -1

def u(direction, twist):
    return zeta**(-direction - 2 * twist)

def v(direction, twist):
    return zeta**(direction + 2 * twist)

def w(first_direction, first_twist, second_direction, second_twist):
    return zeta**2 * v(first_direction, first_twist) * u(second_direction, second_twist)

cases = 0
for length in (1, 2, 3):
    for data in product(product(range(4), range(2)), repeat=length):
        short_product = K(1)
        long_product = K(1)
        for index in range(length):
            previous_direction, previous_twist = data[index - 1]
            direction, twist = data[index]
            short_product *= w((previous_direction + 2) % 4, previous_twist, direction, twist)
            long_product *= w(direction, twist, (direction + 2) % 4, twist)
            assert (u(direction, twist) / u((direction + 2) % 4, twist))**2 == -1
        assert short_product == (-1)**length * long_product
        cases += 1

print(f"PASS: {cases} exact cyclotomic assignments")
