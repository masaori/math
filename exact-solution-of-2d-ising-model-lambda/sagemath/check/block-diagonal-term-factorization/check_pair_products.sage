import os
prelude = 'sagemath/check/block-diagonal-term-factorization/_prelude.sage'
if not os.path.isfile(prelude):
    prelude = 'exact-solution-of-2d-ising-model-lambda/' + prelude
load(prelude)
cases = 0
for values in term_values():
    assert values[3] == values[4]
    cases += 1
print(f"PASS: pair products, {cases} terms")
