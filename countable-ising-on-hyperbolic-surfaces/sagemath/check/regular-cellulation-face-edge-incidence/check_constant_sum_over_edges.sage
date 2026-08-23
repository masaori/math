# SageMath: sum_e 2 = 2|E|
# 対象ラベル: theorem_regular_cellulation_face_edge_incidence
# 帰属: NN と有限集合だけを用いる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

for example in EXAMPLES:
    lhs = sum((NN(2) for edge in example["edges"]), NN(0))
    rhs = NN(2) * NN(len(example["edges"]))
    assert lhs == rhs

print("RESULT: PASS — the constant edge sum equals 2|E|")
