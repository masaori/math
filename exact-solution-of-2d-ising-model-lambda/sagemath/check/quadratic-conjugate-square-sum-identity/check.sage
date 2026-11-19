load('sagemath/check/quadratic-conjugate-square-sum-identity/check_common_factor.sage')
load('sagemath/check/quadratic-conjugate-square-sum-identity/check_square_expansion.sage')
load('sagemath/check/quadratic-conjugate-square-sum-identity/check_cross_term_cancellation.sage')
load('sagemath/check/quadratic-conjugate-square-sum-identity/check_factor_two.sage')
load('sagemath/check/quadratic-conjugate-square-sum-identity/check_substitute_coefficients.sage')
load('sagemath/check/quadratic-conjugate-square-sum-identity/check_conjugate_cross_terms.sage')
load('sagemath/check/quadratic-conjugate-square-sum-identity/check_square_relation.sage')
load('sagemath/check/quadratic-conjugate-square-sum-identity/check_sum_addition.sage')
load('sagemath/check/quadratic-conjugate-square-sum-identity/check_sum_factor_two.sage')
c = [QQbar(1), QQbar(2), QQbar(3)]
u = [QQbar(-2), QQbar(0), QQbar(1)]
v = [QQbar(3), QQbar(-1), QQbar(2)]
a = QQbar(2)
b = a.sqrt()
left = sum(c[i]*(u[i]+v[i]*b)**2 for i in range(3))
left += sum(c[i]*(u[i]-v[i]*b)**2 for i in range(3))
right = 2*sum(c[i]*(u[i]**2+a*v[i]**2) for i in range(3))
assert left == right
print('PASS: quadratic conjugate square sum identity')
