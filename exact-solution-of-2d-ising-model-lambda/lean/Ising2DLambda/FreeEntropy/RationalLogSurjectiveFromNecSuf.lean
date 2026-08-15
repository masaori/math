/-
具体版の全射性を必要十分版の有限積構成から導く。
住処は ℕ・ℤ・ℚ・Λ だけで、実数・複素数は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogSurjective
import Ising2DLambda.NecSuf.FreeEntropy.RationalLogSurjective

namespace Ising2DLambda.FreeEntropy

/-- `logRat_rationalOfLog` を必要十分版へ特殊化して得たもの。 -/
theorem logRat_rationalOfLog_from_necSuf (eta : LogOrderGroup) :
    logRat (rationalOfLog eta) = eta := by
  exact Ising2DLambda.NecSuf.FreeEntropy.log_realize_necSuf
    (I := Nat.Primes) (A := ℚ) (fun p => (p : ℚ)) logRat
    (fun p => by exact_mod_cast p.property.pos)
    logRat_one
    (fun hx hy => logRat_mul hx hy)
    (fun hx => logRat_inv hx)
    logRat_prime
    eta

/-- 正の有理数の対数の全射性を必要十分版から導く。 -/
theorem logRat_surjective_from_necSuf :
    Function.Surjective (fun q : {q : ℚ // 0 < q} => logRat q.1) := by
  intro eta
  exact ⟨⟨rationalOfLog eta, rationalOfLog_pos eta⟩, logRat_rationalOfLog_from_necSuf eta⟩

end Ising2DLambda.FreeEntropy
