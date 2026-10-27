import os
prelude = 'sagemath/check/block-diagonal-determinant-product/_prelude.sage'
if not os.path.isfile(prelude):
    prelude = 'exact-solution-of-2d-ising-model-lambda/' + prelude
load(prelude)
count = 0
for values in cases():
    assert values[1] == values[2]
    count += 1
print(f'PASS: term factorization, {count} cases')
