/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `sum_eq_add_of_outside_zero` と `sum_eq_single_of_outside_zero` に
ι := `OrbitBij O`（軌道の上の全単射の全体）、M := ℤ[x][t]、
f := 軌道の因子、a := `id_O`、b := `S↾_O` を代入すると具体版が出る。
渡す仮定は次の 2 つだけである。

  ∀ ψ, ψ ≠ id_O → ψ ≠ S↾_O → W_O(ch(U),ψ) = 0
      ← `orbitFactor_shiftMatrix_eq_zero_of_not_mem_pair`
  a ≠ b（`|O| ≥ 2` のとき）／ a = b（`|O| = 1` のとき）
      ← `rowShift_eq_self_iff_card_orbit_eq_one`

**軌道であること・因子の作り方・順序 ≺・値が多項式であること・積の構造は渡していない。**
このことは、具体版の狭める段と場合分けがそれらを使っていないという主張の裏取りになっている。
2 つの項の値そのもの（`t^{|O|}` と `ι(-κ(1))`）は前の 2 セクションの主張であり、
この段の外にある。

住処: ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitSumTwoTerms
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitSumTwoTerms

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張を、必要十分版から導いたもの。 -/
theorem orbitSum_shiftMatrix_from_necSuf (O : OrbitIndex L) :
    ∑ ψ : OrbitBij O.1, orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ)
      = Polynomial.X ^ O.1.card + constSecond (-(constPoly 1)) := by
  classical
  have hzero : ∀ ψ : OrbitBij O.1, ψ ≠ Equiv.refl {τ : RowConfig L // τ ∈ O.1} →
      ψ ≠ shiftOrbitRestriction O →
      orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ) = 0 :=
    fun ψ h₁ h₂ => orbitFactor_shiftMatrix_eq_zero_of_not_mem_pair O ψ h₁ h₂
  obtain ⟨τ₀, hτ₀⟩ : O.1.Nonempty := (rowShiftOrbitSet_partition (L := L)).1 O.1 O.2
  have hpos : 1 ≤ O.1.card := Finset.card_pos.mpr ⟨τ₀, hτ₀⟩
  rcases Nat.lt_or_ge O.1.card 2 with hlt | hcard
  · -- 第二の場合。`|O| = 1` なので `a = b` である。
    have hcard1 : O.1.card = 1 := by omega
    have hfix : rowShift L τ₀ = τ₀ :=
      (rowShift_eq_self_iff_card_orbit_eq_one O.2 hτ₀).mpr hcard1
    have hab : Equiv.refl {τ : RowConfig L // τ ∈ O.1} = shiftOrbitRestriction O := by
      apply Equiv.ext
      intro τ
      apply Subtype.ext
      have hτeq : τ.1 = τ₀ :=
        Finset.card_le_one.mp (le_of_eq hcard1) τ.1 τ.2 τ₀ hτ₀
      show τ.1 = rowShift L τ.1
      rw [hτeq]
      exact hfix.symm
    rw [NecSuf.AlgebraicEigenvalue.sum_eq_single_of_outside_zero _ _ _ hzero hab,
      orbitFactor_ambientOf_refl O,
      orbitFactor_shiftMatrix_id_of_card_one O.2 hcard1, hcard1, pow_one]
  · -- 第一の場合。`|O| ≥ 2` なので `a ≠ b` である。
    have hfixnot : rowShift L τ₀ ≠ τ₀ := by
      intro hfix
      have : O.1.card = 1 := (rowShift_eq_self_iff_card_orbit_eq_one O.2 hτ₀).mp hfix
      omega
    have hab : Equiv.refl {τ : RowConfig L // τ ∈ O.1} ≠ shiftOrbitRestriction O := by
      intro heq
      have := congrArg (fun e : OrbitBij O.1 => (e ⟨τ₀, hτ₀⟩).1) heq
      simp only [Equiv.refl_apply, shiftOrbitRestriction_val] at this
      exact hfixnot this.symm
    rw [NecSuf.AlgebraicEigenvalue.sum_eq_add_of_outside_zero _ _ _ hzero hab,
      orbitFactor_ambientOf_refl O, orbitFactor_ambientOf_shift O,
      orbitFactor_shiftMatrix_id_of_two_le O.2 hcard,
      orbitFactor_shiftMatrix_shift_of_two_le O.2 hcard]

end Ising2DLambda.AlgebraicEigenvalue
