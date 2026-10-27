import os
prelude = 'sagemath/check/block-diagonal-determinant-product/_prelude.sage'
if not os.path.isfile(prelude):
    prelude = 'exact-solution-of-2d-ising-model-lambda/' + prelude
load(prelude)
count = 0
for values in cases():
    assert values[2] == values[3]
    count += 1
print(f'PASS: distributivity, {count} cases')
