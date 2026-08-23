# SageMath: |O_X| = sum_e |{(f,i) in O_X | e_{f,i}=e}|
# 対象ラベル: theorem_regular_cellulation_face_edge_incidence
# 帰属: NN と有限集合だけを用いる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

for example in EXAMPLES:
    lhs = occurrence_set(example).cardinality()
    rhs = sum((edge_fiber(example, edge).cardinality() for edge in example["edges"]), NN(0))
    assert lhs == rhs

print("RESULT: PASS — edge-component fibers partition all boundary occurrences")
