# SageMath: sum_f |P_f| = |O_X|
# 対象ラベル: theorem_regular_cellulation_face_edge_incidence
# 帰属: NN と有限集合だけを用いる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

for example in EXAMPLES:
    lhs = sum((NN(len(word)) for word in example["faces"].values()), NN(0))
    rhs = occurrence_set(example).cardinality()
    assert lhs == rhs

print("RESULT: PASS — the disjoint union of face positions has the summed cardinality")
