# 対象ラベル: claim_binary_finite_positive_bath_count_exponential_comparison
# 式ペア: exp_R(-E_U(x))=Omega_B(U-H_A(x))、P^exp_{1,E_U}(x)=iota(P^count_U(x))。
# 帰属: NN_{>0}、QQ_{>0} とその標準実数像。
# 実対数と実指数の逆写像性を適用した後の有限和・除算を QQ で厳密に検査し、浮動小数点は使わない。
from itertools import product

vector_count = ZZ(0)
component_count = ZZ(0)
for state_count in range(1, 6):
    for multiplicities in product(range(1, 6), repeat=state_count):
        shell_size = ZZ(sum(multiplicities))
        exponential_weights_after_inverse_law = tuple(QQ(value) for value in multiplicities)
        exponential_normalizer = sum(exponential_weights_after_inverse_law, QQ(0))
        assert exponential_normalizer == QQ(shell_size)

        for multiplicity_value, exponential_weight in zip(
            multiplicities,
            exponential_weights_after_inverse_law,
        ):
            count_probability = QQ(multiplicity_value) / shell_size
            exponential_probability = exponential_weight / exponential_normalizer
            assert exponential_weight == QQ(multiplicity_value)
            assert exponential_probability == count_probability
            component_count += 1
        vector_count += 1

assert vector_count == ZZ(sum(5^length for length in range(1, 6)))
assert component_count > 0
print('positive multiplicity vectors checked:', vector_count)
print('distribution components checked:', component_count)
print('RESULT: PASS')
