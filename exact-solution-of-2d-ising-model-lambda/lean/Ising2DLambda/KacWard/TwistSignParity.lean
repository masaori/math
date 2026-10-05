import Ising2DLambda.KacWard.DiagonalGaugeInverse

namespace Ising2DLambda.KacWard

/-- 切断線から得る指数を商と余りへ分ける、本文の八等号。 -/
theorem twistSign_eq_neg_one_pow_twistParity {L : ℕ}
    (s : SpinStructure) (e : OrientedEdge L) :
    twistSign s e = (-1 : ℤ) ^ twistParity s e := by
  let n := s.1.toNat * horizontalSeamParity e + s.2.toNat * verticalSeamParity e
  let q := n / 2
  let r := n % 2
  have hdivision : n = 2 * q + r := (Nat.div_add_mod n 2).symm
  calc
    twistSign s e = (-1 : ℤ) ^ n := rfl
    _ = (-1 : ℤ) ^ (2 * q + r) := congrArg ((-1 : ℤ) ^ ·) hdivision
    _ = (-1 : ℤ) ^ (2 * q) * (-1 : ℤ) ^ r := pow_add _ _ _
    _ = ((-1 : ℤ) ^ 2) ^ q * (-1 : ℤ) ^ r := by rw [pow_mul]
    _ = (1 : ℤ) ^ q * (-1 : ℤ) ^ r := by rw [show (-1 : ℤ) ^ 2 = 1 by decide]
    _ = (1 : ℤ) * (-1 : ℤ) ^ r := by rw [one_pow]
    _ = (-1 : ℤ) ^ r := one_mul _
    _ = (-1 : ℤ) ^ twistParity s e := rfl

end Ising2DLambda.KacWard
