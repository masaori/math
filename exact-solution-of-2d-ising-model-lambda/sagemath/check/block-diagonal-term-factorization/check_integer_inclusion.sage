import os
prelude = 'sagemath/check/block-diagonal-term-factorization/_prelude.sage'
if not os.path.isfile(prelude):
    prelude = 'exact-solution-of-2d-ising-model-lambda/' + prelude
load(prelude)
cases = 0
for values in term_values():
    assert values[1] == values[5]
    cases += 1
print(f"PASS: integer inclusion, {cases} terms")
