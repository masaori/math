from itertools import product

BITS = (ZZ(0), ZZ(1))

def exponent(a, b, h, v):
    return h*v + (1-a)*h + (1-b)*v

def parity(n):
    return ZZ(n) % 2

def cases():
    return product(BITS, repeat=6)
