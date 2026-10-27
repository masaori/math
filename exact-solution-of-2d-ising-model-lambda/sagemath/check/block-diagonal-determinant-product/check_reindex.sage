import os
prelude = 'sagemath/check/block-diagonal-determinant-product/_prelude.sage'
if not os.path.isfile(prelude):
    prelude = 'exact-solution-of-2d-ising-model-lambda/' + prelude
load(prelude)
count = 0
for values in cases():
    assert values[0] == values[1]
    count += 1
print(f'PASS: determinant reindex, {count} cases')
