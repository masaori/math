/-
章「固有値の代数性」の「1 の冪根の全体の有限部分集合の元の個数は指数を超えない」の具体版。
人手証明の正本は `claim_root_of_unity_subset_card_bound` である。

人手証明と同じく、多項式 f = t^n + (-1)^ を準備し、
根の個数の上界（`claim_qbar_distinct_roots_card_bound`）の 3 つの仮定を順に確かめて当てる。
既製の「1 の冪根の個数」の定理には委ねない。

  人手証明                                          このファイル
  f := t^n + (-1)^                                  `f`
  第 1（ac_0(f) = -1 と f ≠ 0）                     `hcoeff0` と `hfne`
  第 2（n < k で ac_k(f) = 0）                      `hcoeff`
  第 3（w ∈ s で aev_w(f) = 0）                     `hroot`
  結論（根の個数の上界を当てる）                    `qbarDistinctRootsCardLe`

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarDistinctRootsCardBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem rootOfUnitySubsetCardLe (n : ℕ) (hn : 1 ≤ n) (s : Finset Qbar)
    (hs : ∀ w ∈ s, w ^ n = 1) :
    s.card ≤ n := by
  classical
  -- 準備。f := t^n + (-1)^（定数として送った -1 との和）。
  set f : QbarPoly := Polynomial.X ^ n + qbarConst (-1) with hf
  -- 第 1 の検査。番号 0 の係数は -1 であり（和の係数・不定元の冪の係数・定数の係数）、
  -- 体 Qbar では -1 ≠ 0 なので f は零多項式でない。
  have hcoeff0 : f.coeff 0 = -1 := by
    rw [hf, Polynomial.coeff_add,
      qbarPolyIndeterminatePowerCoefficient n 0,
      if_neg (by omega : ¬(0 = n))]
    rw [qbarConst, Polynomial.coeff_C_zero, zero_add]
  have hfne : f ≠ 0 := by
    intro h0
    have hzero : f.coeff 0 = 0 := by rw [h0]; rfl
    rw [hcoeff0] at hzero
    exact (by norm_num : (-1 : Qbar) ≠ 0) hzero
  -- 第 2 の検査。n < k では両方の項の係数が零である。
  have hcoeff : ∀ k : ℕ, n < k → f.coeff k = 0 := by
    intro k hk
    rw [hf, Polynomial.coeff_add,
      qbarPolyIndeterminatePowerCoefficient n k,
      if_neg (by omega : ¬(k = n))]
    rw [qbarConst, Polynomial.coeff_C, if_neg (by omega : ¬(k = 0)), zero_add]
  -- 第 3 の検査。w^n = 1 から aev_w(f) = 1 + (-1) = 0（代入は和を保つ・
  -- 不定元の冪の値・定数の値）。
  have hroot : ∀ w ∈ s, qbarPolyEval w f = 0 := by
    intro w hw
    calc
      qbarPolyEval w f
          = qbarPolyEval w (Polynomial.X ^ n) + qbarPolyEval w (qbarConst (-1)) := by
            rw [hf]; simp [qbarPolyEval_eq_eval]
      _ = w ^ n + qbarPolyEval w (qbarConst (-1)) := by
            rw [qbarPolyEvalIndeterminatePow]
      _ = w ^ n + (-1) := by simp [qbarPolyEval_eq_eval, qbarConst]
      _ = 1 + (-1) := by rw [hs w hw]
      _ = 0 := by norm_num
  -- 結論。根の個数の上界を f・s・n に当てる。
  exact qbarDistinctRootsCardLe f s n hfne hcoeff hroot

end Ising2DLambda.AlgebraicEigenvalue
