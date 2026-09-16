# 対象ラベル: claim_binary_finite_bath_count_distribution_is_marginal
# 併せて検証: claim_binary_finite_total_shell_cardinality
# 式ペア: P_U^count(x)=sum_y 1/|Sigma_U|、sum_x P_U^count(x)=1。
# 帰属: 有限集合、NN、QQ。正の殻だけで除算し、対数・実数体・浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

positive_shell_count = ZZ(0)
marginal_component_count = ZZ(0)
for first_set, second_set, first_observation, second_observation, total in sample_systems():
    shell = shell_pairs(first_set, second_set, first_observation, second_observation, total)
    shell_size = ZZ(len(shell))
    if shell_size == 0:
        continue

    probabilities = []
    for first_index in range(len(first_set)):
        numerator = multiplicity(
            second_set,
            second_observation,
            total - first_observation[first_index],
        )
        count_probability = QQ(numerator) / shell_size
        marginal_probability = sum(
            QQ(1) / shell_size
            for second_index in range(len(second_set))
            if (first_index, second_index) in shell
        )
        assert count_probability == marginal_probability
        assert QQ(0) <= count_probability <= QQ(1)
        probabilities.append(count_probability)
        marginal_component_count += 1

    assert sum(probabilities, QQ(0)) == QQ(1)
    positive_shell_count += 1

assert positive_shell_count > 0
assert marginal_component_count > 0
print('positive finite shells checked:', positive_shell_count)
print('marginal components checked:', marginal_component_count)
print('RESULT: PASS')
