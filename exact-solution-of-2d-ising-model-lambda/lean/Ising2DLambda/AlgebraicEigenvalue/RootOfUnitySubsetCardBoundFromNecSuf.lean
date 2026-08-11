/-
具体版 `rootOfUnitySubsetCardLe` が必要十分版
`root_of_unity_subset_card_le_necSuf` の特殊化として得られることの導出。

多項式の側を QbarPoly、値の側を Qbar、m を -1、上界の仮定を
`qbarDistinctRootsCardLe` と取る。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnitySubsetCardBound
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnitySubsetCardBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem rootOfUnitySubsetCardLe_from_necSuf (n : ℕ) (hn : 1 ≤ n) (s : Finset Qbar)
    (hs : ∀ w ∈ s, w ^ n = 1) :
    s.card ≤ n := by
  refine Ising2DLambda.NecSuf.AlgebraicEigenvalue.root_of_unity_subset_card_le_necSuf
    (P := QbarPoly) (α := Qbar)
    (padd := (· + ·)) (pzero := 0) (xpow := fun j => Polynomial.X ^ j)
    (pconst := qbarConst) (c := fun k p => p.coeff k) (ev := fun w p => qbarPolyEval w p)
    (hzero_add := zero_add) (hadd_zero := add_zero)
    (m := -1) (hm := by norm_num) (hone_ne := one_ne_zero)
    (hc_add := ?_) (hc_xpow := ?_) (hc_const_zero := ?_) (hc_const_pos := ?_)
    (hc_zero := ?_) (hev_add := ?_) (hev_xpow := ?_) (hev_const := ?_)
    (hcard := ?_) n hn s hs
  · intro k p q
    exact Polynomial.coeff_add p q k
  · intro k j hkj
    rw [qbarPolyIndeterminatePowerCoefficient j k, if_neg hkj]
  · intro a
    exact Polynomial.coeff_C_zero
  · intro a k hk
    rw [qbarConst, Polynomial.coeff_C, if_neg (by omega : ¬(k = 0))]
  · intro k
    exact Polynomial.coeff_zero k
  · intro w p q
    simp [qbarPolyEval_eq_eval]
  · intro w j
    exact qbarPolyEvalIndeterminatePow w j
  · intro w a
    simp [qbarPolyEval_eq_eval, qbarConst]
  · intro p s' n' h1 h2 h3
    exact qbarDistinctRootsCardLe p s' n' h1 h2 h3

end Ising2DLambda.AlgebraicEigenvalue
