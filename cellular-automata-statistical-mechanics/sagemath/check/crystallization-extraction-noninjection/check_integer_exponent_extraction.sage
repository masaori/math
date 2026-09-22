# 対象ラベル: claim_crystallization_extraction_not_injective
# 判定: q=0 評価後の唯一の基底係数が係数 1 の Laurent 単項式で、その整数指数が指定した H と一致することを検査する。
# 帰属: 有限集合、ZZ、QQ[z,z^-1]。除算、対数、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

evaluated = evaluate_matrix_at_zero(R0)
checked = ZZ(0)
for column, source in enumerate(BC):
    row = CB.index(swapped_basis(source))
    monomial = evaluated[row, column]
    terms = monomial.dict()
    assert len(terms) == 1
    extracted_exponent, extracted_coefficient = next(iter(terms.items()))
    assert extracted_coefficient == 1
    assert ZZ(extracted_exponent) == H[source]
    checked += 1

assert checked == len(BC)
print('integer exponents checked:', checked)
print('extracted exponents:', sorted(H.values()))
print('RESULT: PASS')
