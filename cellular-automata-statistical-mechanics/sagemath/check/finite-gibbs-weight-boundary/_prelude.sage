from itertools import product


def finite_energy_rows():
    entries = (ZZ(-2), ZZ(-1), ZZ(0), ZZ(1), ZZ(2))
    return tuple((left, right) for left, right in product(entries, repeat=2))


def positive_inverse_temperatures():
    return (QQ(1) / QQ(2), QQ(1), QQ(2))


def exponential_weight(beta, energy):
    return exp(-beta * energy)


def row_partition_sum(beta, energy_row):
    return sum(exponential_weight(beta, energy) for energy in energy_row)


def gibbs_row(beta, energy_row):
    partition_sum = row_partition_sum(beta, energy_row)
    return tuple(
        exponential_weight(beta, energy) / partition_sum
        for energy in energy_row
    )
