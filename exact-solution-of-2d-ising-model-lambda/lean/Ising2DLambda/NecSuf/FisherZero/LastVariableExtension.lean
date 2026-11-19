/-
節「対称式の基本定理」のうち、末尾に変数を足す持ち上げの必要十分版。

具体版（`Ising2DLambda.FisherZero.lastVariableExtension` と三つの主張）と同じ段
（係数の場合分けの式 → 零代入の係数の式、末尾の指数で場合を分ける → 係数の所属、台の元の末尾の指数は零 → 最大元の性質）で示し、
各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい（多変数多項式環を作るのに Lean が要求する構造）。持ち上げの定義と
  `lz_n(ex_n(Q)) = Q` は、零元と係数の式 `lastVariableZero_coeff_necSuf` しか使わない。
- 部分体係数の主張では、部分体の代わりに `K` の部分集合 `S` で、零元を含むものでよい。和・積・逆元での閉性は使わない。
  零元を含むことは外せない: 末尾の指数が零でない指数の係数は零元であり、それが `S` に属さなければ
  `ex_n(Q)` は `S` を係数としない（`S = {1}`、`Q = 1` が反例）。
- 重み付き次数の主張では、重み付き次数の代わりに、`n` 変数の指数の重み `w` と `n+1` 変数の指数の重み `w'` についての次数でよい。
  使うのは、末尾の指数が零の `a` で `w' a ≤ w (a|_{<n})` であることだけである（具体版では重み付きの指数の総和で、等号が成り立つ）。
-/
import Ising2DLambda.NecSuf.FisherZero.MonomialAndLastVariableZeroCoefficient
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSubfieldCoefficient
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionDegreeBound

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

/-- 制限 `a|_{<n}(k) = a(k)`。 -/
noncomputable def exponentRestrictLast {n : ℕ} (a : Fin (n + 1) →₀ ℕ) : Fin n →₀ ℕ :=
  Finsupp.comapDomain Fin.castSucc a (Fin.castSucc_injective n).injOn

theorem exponentRestrictLast_apply {n : ℕ} (a : Fin (n + 1) →₀ ℕ) (k : Fin n) :
    exponentRestrictLast a k = a k.castSucc :=
  Finsupp.comapDomain_apply _ _ _ _

theorem eq_exponentZeroExtension_of_last_eq_zero {n : ℕ} (a : Fin (n + 1) →₀ ℕ)
    (ha : a (Fin.last n) = 0) : a = exponentZeroExtension (exponentRestrictLast a) := by
  ext j
  refine Fin.lastCases ?_ (fun k => ?_) j
  · rw [exponentZeroExtension_last, ha]
  · rw [exponentZeroExtension_castSucc, exponentRestrictLast_apply]

theorem exponentRestrictLast_exponentZeroExtension {n : ℕ} (b : Fin n →₀ ℕ) :
    exponentRestrictLast (exponentZeroExtension b) = b := by
  ext k
  rw [exponentRestrictLast_apply, exponentZeroExtension_castSucc]

/-- 係数の場合分けの式。 -/
noncomputable def lastVariableExtensionCoeff {n : ℕ} (Q : MvPolynomial (Fin n) K)
    (a : Fin (n + 1) →₀ ℕ) : K :=
  if a (Fin.last n) = 0 then coeff (exponentRestrictLast a) Q else 0

theorem lastVariableExtensionCoeff_support_finite {n : ℕ} (Q : MvPolynomial (Fin n) K) :
    (Function.support (lastVariableExtensionCoeff Q)).Finite := by
  apply ((Q.support : Set (Fin n →₀ ℕ)).toFinite.image exponentZeroExtension).subset
  intro a ha
  rw [Function.mem_support, lastVariableExtensionCoeff] at ha
  split_ifs at ha with hlast
  · exact ⟨exponentRestrictLast a, mem_support_iff.mpr ha,
      (eq_exponentZeroExtension_of_last_eq_zero a hlast).symm⟩
  · exact absurd rfl ha

/-- 末尾に変数を足す持ち上げ。 -/
noncomputable def lastVariableExtensionNecSuf {n : ℕ} (Q : MvPolynomial (Fin n) K) :
    MvPolynomial (Fin (n + 1)) K :=
  AddMonoidAlgebra.ofCoeff
    (Finsupp.ofSupportFinite (lastVariableExtensionCoeff Q) (lastVariableExtensionCoeff_support_finite Q))

theorem lastVariableExtension_coeff_necSuf {n : ℕ} (Q : MvPolynomial (Fin n) K) (a : Fin (n + 1) →₀ ℕ) :
    coeff a (lastVariableExtensionNecSuf Q) =
      if a (Fin.last n) = 0 then coeff (exponentRestrictLast a) Q else 0 :=
  rfl

/-- `claim_last_variable_zero_of_extension` の必要十分版（可換半環）。 -/
theorem lastVariableZero_lastVariableExtension_necSuf {n : ℕ} (Q : MvPolynomial (Fin n) K) :
    lastVariableZeroNecSuf n (lastVariableExtensionNecSuf Q) = Q := by
  ext b
  calc coeff b (lastVariableZeroNecSuf n (lastVariableExtensionNecSuf Q))
      = coeff (exponentZeroExtension b) (lastVariableExtensionNecSuf Q) :=
        lastVariableZero_coeff_necSuf _ b
    _ = coeff (exponentRestrictLast (exponentZeroExtension b)) Q := by
        rw [lastVariableExtension_coeff_necSuf, if_pos (exponentZeroExtension_last b)]
    _ = coeff b Q := by rw [exponentRestrictLast_exponentZeroExtension]

/-- `claim_last_variable_extension_subfield_coefficient` の必要十分版（`S` は零元を含む任意の部分集合）。 -/
theorem lastVariableExtension_mem_coeffIn_necSuf {S : Set K} (h0 : (0 : K) ∈ S) {n : ℕ}
    (Q : MvPolynomial (Fin n) K) (hQ : Q ∈ coeffIn S (Fin n)) :
    lastVariableExtensionNecSuf Q ∈ coeffIn S (Fin (n + 1)) := by
  intro a
  by_cases hlast : a (Fin.last n) = 0
  · rw [lastVariableExtension_coeff_necSuf, if_pos hlast]
    exact hQ (exponentRestrictLast a)
  · rw [lastVariableExtension_coeff_necSuf, if_neg hlast]
    exact h0

/-- `claim_last_variable_extension_weighted_degree_bound` の必要十分版
（末尾の指数が零の `a` で `w' a ≤ w (a|_{<n})` だけを使う）。 -/
theorem wDeg_lastVariableExtension_le_necSuf {n : ℕ} (w : (Fin n →₀ ℕ) → ℕ)
    (w' : (Fin (n + 1) →₀ ℕ) → ℕ)
    (hw : ∀ a : Fin (n + 1) →₀ ℕ, a (Fin.last n) = 0 → w' a ≤ w (exponentRestrictLast a))
    (Q : MvPolynomial (Fin n) K) :
    wDeg w' (lastVariableExtensionNecSuf Q) ≤ wDeg w Q := by
  apply wDeg_le_of_forall
  intro a hne
  have hlast : a (Fin.last n) = 0 := by
    by_contra h
    rw [lastVariableExtension_coeff_necSuf, if_neg h] at hne
    exact hne rfl
  have hsupp : coeff (exponentRestrictLast a) Q ≠ 0 := by
    rw [lastVariableExtension_coeff_necSuf, if_pos hlast] at hne
    exact hne
  calc w' a ≤ w (exponentRestrictLast a) := hw a hlast
    _ ≤ wDeg w Q := le_wDeg w Q _ hsupp

end Ising2DLambda.NecSuf.FisherZero
