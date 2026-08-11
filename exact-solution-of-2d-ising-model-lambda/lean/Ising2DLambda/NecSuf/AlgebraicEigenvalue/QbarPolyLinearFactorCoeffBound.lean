/-
「一次因子との積の係数は、上の番号で零である」の必要十分版。

本文と同じく、積の係数を番号 k = k' + 1 で開き、C の係数の仮定で両方の項を消す。
必要なのは可換環（一次式 X - C w が加法の逆元を要るため）と一次因子との積の
係数公式だけであり、体・代数閉性は要らない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

/-- 可換環上でも、係数が番号 `m` で尽きる多項式に一次因子を掛けると、
係数は番号 `m + 1` で尽きる。 -/
theorem poly_linear_factor_coeff_bound_necSuf {R : Type*} [CommRing R]
    (w : R) (C : R[X]) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ k, m + 1 < k → ((X - Polynomial.C w) * C).coeff k = 0 := by
  intro k hk
  obtain ⟨k', rfl⟩ : ∃ k', k = k' + 1 := ⟨k - 1, by omega⟩
  have hmul : ((X - Polynomial.C w) * C).coeff (k' + 1) =
      C.coeff k' + (-w) * C.coeff (k' + 1) := by
    simp [sub_mul, Polynomial.coeff_X_mul] <;> ring
  calc
    ((X - Polynomial.C w) * C).coeff (k' + 1)
        = C.coeff k' + (-w) * C.coeff (k' + 1) := hmul
    _ = 0 + (-w) * C.coeff (k' + 1) := by rw [hC k' (by omega)]
    _ = 0 + (-w) * 0 := by rw [hC (k' + 1) (by omega)]
    _ = 0 := by ring

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
