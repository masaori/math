# SageMath Check: 代数的数係数多項式の積が零なら一方が零である

**対象ラベル**: `claim_qbar_polynomial_zero_product`

本文の最小非零係数による証明を一行ずつ検算する。係数は `QQbar`、多項式は
`QQbar[t]` を用い、浮動小数点は使わない。最小非零次数は零・一・二・三・四・七を含め、
有理数、二の平方根、虚数単位、一の三乗根とその和を係数に持つ十個の多項式を使う。
多項式の積を SageMath で計算した係数と、係数列から別に作った有限和を照合する。

非零二因子の百組では最小次数の係数が非零であることを調べる。
零積の仮定に基づく行は、少なくとも一因子が零である二十一組で検算し、
非零二因子に偽の仮定を与えて検算しない。統合検算は全百二十一組を含む。
いずれも有限例の厳密検算であり、一般命題の証明ではない。

| ファイル | 対象行 | 状態 |
|---|---|---|
| `check_least_coefficients_nonzero.sage` | f_m≠0、g_n≠0 | PASS |
| `check_below_least_coefficient.sage` | i<m ⇒ f_i=0 | PASS |
| `check_substitute_left_zero.sage` | f_i g_j=0 g_j（i<m） | PASS |
| `check_left_zero_product.sage` | 0 g_j=0 | PASS |
| `check_off_diagonal_strict_index.sage` | i≥m、(i,j)≠(m,n) ⇒ i>m | PASS |
| `check_right_index_below_minimum.sage` | i>m、i+j=m+n ⇒ j<n | PASS |
| `check_right_coefficient_zero.sage` | j<n ⇒ g_j=0 | PASS |
| `check_substitute_right_zero.sage` | f_i g_j=f_i 0（j<n） | PASS |
| `check_right_zero_product.sage` | f_i 0=0 | PASS |
| `check_cauchy_product_coefficient.sage` | (fg)_{m+n}=Σ_{i=0}^{m+n} f_i g_{m+n-i} | PASS |
| `check_isolate_least_pair.sage` | Σ_{i+j=m+n} f_i g_j=f_m g_n+Σ_{(i,j)≠(m,n)} f_i g_j | PASS |
| `check_replace_off_diagonal_terms.sage` | f_m g_n+Σ_{(i,j)≠(m,n)} f_i g_j=f_m g_n+Σ_{(i,j)≠(m,n)} 0 | PASS |
| `check_sum_of_zeros.sage` | f_m g_n+Σ 0=f_m g_n+0 | PASS |
| `check_remove_additive_zero.sage` | f_m g_n+0=f_m g_n | PASS |
| `check_least_product_nonzero.sage` | f_m g_n≠0 | PASS |
| `check_zero_polynomial_coefficient_substitution.sage` | fg=0 ⇒ (fg)_k=(0_{Qbar[t]})_k | PASS |
| `check_zero_polynomial_coefficient.sage` | (0_{Qbar[t]})_k=0_{Qbar} | PASS |
| `check_nonzero_coefficient_contradiction.sage` | (fg)_{m+n}≠(0_{Qbar[t]})_{m+n} | PASS |
| `check_add_strict_index.sage` | m+j<i+j | PASS |
| `check_substitute_index_sum.sage` | m+j<m+n | PASS |
| `check_antidiagonal_bijection.sage` | i↦(i,m+n-i) と (i,j)↦i は互いに逆 | PASS |
| `check_reindex_cauchy_sum.sage` | Σ_{i=0}^{m+n} f_i g_{m+n-i}=Σ_{(i,j)∈B} f_i g_j | PASS |
| `check_single_remaining_term.sage` | Σ_{(i,j)∈B} f_i g_j=f_m g_n | PASS |
| `check.sage` | 行別検算と全百二十一組の零積性 | PASS |

```sh
for file in sagemath/check/qbar-polynomial-zero-product/check*.sage; do sage "$file"; done
```

本文との対応では、`off_diagonal_strict_index`・`add_strict_index`・
`substitute_index_sum`・`right_index_below_minimum` が自然数の四つの不等式を担う。
`cauchy_product_coefficient`・`reindex_cauchy_sum`・`single_remaining_term`・
`least_product_nonzero` が積の係数の四行を担う。
`isolate_least_pair`・`replace_off_diagonal_terms`・`sum_of_zeros`・
`remove_additive_zero` は本文の「他の全項が零」による一項への還元を補助検算する。

背理法自体と自然数の整列性は有限検算の対象ではない。
非零二因子では零積仮定を満たす例がないため、末尾の二等式は零因子を含む標本で別に検算する。
`nonzero_coefficient_contradiction` は非零二因子の係数と零多項式の係数が相異なることを確かめるだけで、
矛盾する二つの仮定を持つ実例の検算とは呼ばない。

2026-10-24: 行別23ファイルと統合 `check.sage` の全24ファイルを単独の Sage CLI で実行し、すべて PASS。
