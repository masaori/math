def log_vector(value):
    value = QQ(value)
    assert value > 0
    result = {}
    for prime, exponent in ZZ(value.numerator()).factor():
        result[prime] = result.get(prime, 0) + exponent
    for prime, exponent in ZZ(value.denominator()).factor():
        result[prime] = result.get(prime, 0) - exponent
    return {prime: exponent for prime, exponent in result.items() if exponent != 0}

def vector_add(left, right):
    return {prime: left.get(prime, 0) + right.get(prime, 0)
            for prime in set(left) | set(right)
            if left.get(prime, 0) + right.get(prime, 0) != 0}

def rational_of_log(vector):
    result = QQ(1)
    for prime, exponent in vector.items():
        result *= QQ(prime)**exponent
    return result

ell_two = log_vector(2)
for m_num in range(1, 6):
    for m_den in range(1, 6):
        for z_num in range(1, 6):
            for z_den in range(1, 6):
                m = QQ(m_num)/m_den
                z = QQ(z_num)/z_den
                if m/4 > z:
                    continue
                assert rational_of_log(log_vector(m)) <= rational_of_log(log_vector(4*z))
                assert log_vector(4*z) == vector_add(vector_add(ell_two, ell_two), log_vector(z))
                lower = vector_add(log_vector(m), {2: -2})
                assert rational_of_log(lower) <= rational_of_log(log_vector(z))
print('PASS: lower rational inequality transfers through the logarithmic order')
