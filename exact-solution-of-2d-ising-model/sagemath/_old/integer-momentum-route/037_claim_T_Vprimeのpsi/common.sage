# Common helpers for 037_claim_T_Vprimeのpsi checks.
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

TEST_M_VALUES = [2, 4]
TEST_ABS_TOLERANCE = 1e-9
TEST_REL_TOLERANCE = 1e-9
RF = RealField(100)
CF = ComplexField(100)


def cal_m(M_val):
    return list(range(-M_val, 0)) + list(range(1, M_val + 1))


def residue_index(mu, M_val):
    r = int(mu) % int(M_val)
    return M_val if r == 0 else r


def kron_all(factors):
    result = factors[0]
    for factor in factors[1:]:
        result = result.tensor_product(factor)
    return result


def fermion_modes(M_val):
    one = matrix(CF, [[1, 0], [0, 1]])
    parity = matrix(CF, [[1, 0], [0, -1]])
    annihilation = matrix(CF, [[0, 1], [0, 0]])
    creation = matrix(CF, [[0, 0], [1, 0]])

    c_ops = {}
    cd_ops = {}

    for j in range(1, M_val + 1):
        prefix = [parity for _ in range(j - 1)]
        suffix = [one for _ in range(M_val - j)]
        c_ops[j] = kron_all(prefix + [annihilation] + suffix)
        cd_ops[j] = kron_all(prefix + [creation] + suffix)

    return c_ops, cd_ops


def psi_dagger_op(mu, M_val, c_ops, cd_ops):
    return cd_ops[residue_index(mu, M_val)]


def psi_op(mu, M_val, c_ops, cd_ops):
    return c_ops[residue_index(-mu, M_val)]


def gamma_value(mu, M_val, val_K1, val_K2):
    th = (2 * pi * mu) / M_val
    g1 = RF(gamma_1(th).subs({K1: val_K1, K2: val_K2}))
    if g1 < 1 and abs(g1 - 1) < 1e-12:
        g1 = RF(1)
    return CF(arccosh(g1))


def Vprime_exponent(M_val, val_K1, val_K2, c_ops, cd_ops):
    dim = 2 ** M_val
    ident = identity_matrix(CF, dim)
    X = zero_matrix(CF, dim)

    for nu in range(1, M_val + 1):
        gamma_nu = gamma_value(nu, M_val, val_K1, val_K2)
        number_op = psi_dagger_op(nu, M_val, c_ops, cd_ops) * psi_op(-nu, M_val, c_ops, cd_ops)
        X += gamma_nu * (number_op - (CF(1) / 2) * ident)

    return X


def max_entry_abs(mat):
    entries = [abs(CF(v)) for v in mat.list()]
    return max(entries) if entries else 0


def error_is_ok(actual, expected):
    err = max_entry_abs(actual - expected)
    scale = max(max_entry_abs(actual), max_entry_abs(expected), 1)
    rel_err = err / scale
    ok = err <= TEST_ABS_TOLERANCE or rel_err <= TEST_REL_TOLERANCE
    return ok, err, rel_err


def run_TVprime_action_check(kind):
    if kind not in ('psi_dagger', 'psi'):
        raise ValueError("kind must be 'psi_dagger' or 'psi'")

    all_ok = True
    max_abs_err = 0
    max_rel_err = 0

    for M_val in TEST_M_VALUES:
        c_ops, cd_ops = fermion_modes(M_val)
        dim = 2 ** M_val
        ident = identity_matrix(CF, dim)
        mu_values = cal_m(M_val)

        for params in DEFAULT_TEST_PARAMS:
            val_K1 = params['K1']
            val_K2 = params['K2']
            print(f"Parameters: K1={val_K1}, K2={val_K2}, M={M_val}")

            X = Vprime_exponent(M_val, val_K1, val_K2, c_ops, cd_ops)
            Vprime = X.exp()
            Vprime_inv = (-X).exp()

            inverse_err = max_entry_abs(Vprime * Vprime_inv - ident)
            max_abs_err = max(max_abs_err, inverse_err)
            if inverse_err > TEST_ABS_TOLERANCE:
                print(f"  ERROR: exp(X) exp(-X) != I, max error = {inverse_err}")
                all_ok = False

            fail_count = 0
            for mu in mu_values:
                gamma_mu = gamma_value(mu, M_val, val_K1, val_K2)

                if kind == 'psi_dagger':
                    op = psi_dagger_op(mu, M_val, c_ops, cd_ops)
                    expected = exp(gamma_mu) * op
                    label = "psi_dagger"
                else:
                    op = psi_op(mu, M_val, c_ops, cd_ops)
                    expected = exp(-gamma_mu) * op
                    label = "psi"

                actual = Vprime * op * Vprime_inv
                ok, err, rel_err = error_is_ok(actual, expected)
                max_abs_err = max(max_abs_err, err)
                max_rel_err = max(max_rel_err, rel_err)

                if not ok:
                    if fail_count < 5:
                        print(f"  MISMATCH {label} at mu={mu}: abs error = {err}, rel error = {rel_err}")
                    fail_count += 1
                    all_ok = False

            if fail_count > 5:
                print(f"  ... and {fail_count - 5} more mismatches")

    if all_ok:
        print("RESULT: PASS")
    else:
        print("RESULT: FAIL")
    print(f"MAX_ABS_ERROR: {max_abs_err}")
    print(f"MAX_REL_ERROR: {max_rel_err}")

    return all_ok
