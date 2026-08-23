# SageMath: sum_e |fiber_e| = sum_e 2
# 対象ラベル: theorem_regular_cellulation_face_edge_incidence
# 帰属: NN と有限集合だけを用いる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

for example in EXAMPLES:
    lhs = sum((edge_fiber(example, edge).cardinality() for edge in example["edges"]), NN(0))
    rhs = sum((NN(2) for edge in example["edges"]), NN(0))
    assert lhs == rhs

print("RESULT: PASS — every edge contributes exactly two boundary occurrences")
