/-
章「固有値の代数性」の「軌道ごとの和は、軌道の元の個数を指数とする冪と、
単位元の加法についての逆元との和である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_sum_two_terms`）に対応する。

  人手証明                                              このファイル
  準備の第二（G の外の因子は零元）                       orbitFactor_shiftMatrix_eq_zero_of_not_mem_pair
  共通の段（和を G へ狭める）                            orbitSum_shiftMatrix_eq_sum_pair
  第一の場合 |O| ≥ 2（G は 2 元、和は t^{|O|} + u）      orbitSum_shiftMatrix（前半）
  第二の場合 |O| = 1（G は 1 元、和は t + u）            orbitSum_shiftMatrix（後半）
  主張そのもの                                           orbitSum_shiftMatrix

人手証明の `G = {id_O, S↾_O}` は、`OrbitBij O` の 2 元からなる `Finset`
`{Equiv.refl _, shiftOrbitRestriction O}` である。準備の第一（`G ⊂ 𝔅_O`）は、
Lean では `G` の元がもとから `OrbitBij O`（＝ `𝔅_O`）の元であることに現れているので、
別の段を要しない。

`ambientOf` を通した写像で因子を書く（`orbitFactor` の第 2 引数が ambient の写像だから）。
`id_O` と `S↾_O` の因子を既に示した 2 つの主張へつなぐには、値が `O` の上で一致することを
`orbitFactor_congr` で渡せばよい。

mathlib の `Matrix.charpoly` や置換行列の既製定理は引いていない。使ったのは既に示した
`orbitBij_eq_id_or_shift`・`orbitFactor_shiftMatrix_eq_zero`・
`orbitFactor_shiftMatrix_id_of_two_le`・`orbitFactor_shiftMatrix_id_of_card_one`・
`orbitFactor_shiftMatrix_shift_of_two_le`・`rowShift_eq_self_iff_card_orbit_eq_one` と、
有限和の基本則（`Finset.sum_subset`・`Finset.sum_pair`・`Finset.sum_singleton`）だけである。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（成分は `Polynomial (Polynomial ℤ)`、添字は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitShiftRestrictionFactor
import Ising2DLambda.AlgebraicEigenvalue.OrbitFactorZero

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の準備の第二。`ψ` が `id_O` でも `S↾_O` でもないならば、その因子は零元である。

`orbitBij_eq_id_or_shift` の対偶で「それ自身でもその像でもない値を取る点」を取り、
`orbitFactor_shiftMatrix_eq_zero` を当てる。 -/
theorem orbitFactor_shiftMatrix_eq_zero_of_not_mem_pair (O : OrbitIndex L)
    (ψ : OrbitBij O.1) (h₁ : ψ ≠ Equiv.refl {τ : RowConfig L // τ ∈ O.1})
    (h₂ : ψ ≠ shiftOrbitRestriction O) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ) = 0 := by
  classical
  -- 対偶。仮定「各点をそれ自身かその像へ送る」が成り立てば `ψ` は 2 つのどちらかになる。
  have hnot : ¬ (∀ τ : {τ : RowConfig L // τ ∈ O.1},
      (ψ τ).1 = τ.1 ∨ (ψ τ).1 = rowShift L τ.1) := by
    intro hall
    rcases orbitBij_eq_id_or_shift O.2 ψ hall with h | h
    · exact h₁ h
    · exact h₂ h
  obtain ⟨τ, hτ⟩ := not_forall.mp hnot
  obtain ⟨hne₁, hne₂⟩ := not_or.mp hτ
  have hval : ambientOf O.1 ψ τ.1 = (ψ τ).1 := by
    rw [ambientOf_apply O.1 ψ τ.2]
  exact orbitFactor_shiftMatrix_eq_zero O.1 (ambientOf O.1 ψ) τ.2
    (by rw [hval]; exact hne₁) (by rw [hval]; exact hne₂)

/-- 人手証明の共通の段。`𝔅_O` にわたる和は `G = {id_O, S↾_O}` にわたる和に等しい。 -/
theorem orbitSum_shiftMatrix_eq_sum_pair (O : OrbitIndex L) :
    ∑ ψ : OrbitBij O.1, orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ)
      = ∑ ψ ∈ ({Equiv.refl {τ : RowConfig L // τ ∈ O.1}, shiftOrbitRestriction O} :
            Finset (OrbitBij O.1)),
          orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ) := by
  classical
  refine (Finset.sum_subset (Finset.subset_univ _) ?_).symm
  intro ψ _ hnot
  have h₁ : ψ ≠ Equiv.refl {τ : RowConfig L // τ ∈ O.1} := by
    intro h; exact hnot (by rw [h]; exact Finset.mem_insert_self _ _)
  have h₂ : ψ ≠ shiftOrbitRestriction O := by
    intro h
    exact hnot (by rw [h]; exact Finset.mem_insert_of_mem (Finset.mem_singleton_self _))
  exact orbitFactor_shiftMatrix_eq_zero_of_not_mem_pair O ψ h₁ h₂

/-- `id_O` の因子は、ambient の恒等写像の因子である。 -/
theorem orbitFactor_ambientOf_refl (O : OrbitIndex L) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O.1
        (ambientOf O.1 (Equiv.refl {τ : RowConfig L // τ ∈ O.1}))
      = orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (fun τ => τ) := by
  refine orbitFactor_congr _ ?_
  intro τ hτ
  rw [ambientOf_apply O.1 _ hτ]
  rfl

/-- `S↾_O` の因子は、ambient の巡回シフトの因子である。 -/
theorem orbitFactor_ambientOf_shift (O : OrbitIndex L) :
    orbitFactor L (charMatrix L (shiftMatrix L)) O.1
        (ambientOf O.1 (shiftOrbitRestriction O))
      = orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (rowShift L) := by
  refine orbitFactor_congr _ ?_
  intro τ hτ
  rw [ambientOf_apply O.1 _ hτ]
  exact shiftOrbitRestriction_val O ⟨τ, hτ⟩

/-- 人手証明の主張「軌道ごとの和は `t^{|O|} + ι(-κ(1))` である」。

2 つの場合に分ける。`|O| ≥ 2` では `S↾_O ≠ id_O` なので `G` はちょうど 2 元であり、
`|O| = 1` では `S↾_O = id_O` なので `G` はちょうど 1 元である。 -/
theorem orbitSum_shiftMatrix (O : OrbitIndex L) :
    ∑ ψ : OrbitBij O.1, orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ)
      = Polynomial.X ^ O.1.card + constSecond (-(constPoly 1)) := by
  classical
  rw [orbitSum_shiftMatrix_eq_sum_pair O]
  -- 人手証明の準備の第三。`O` は空でないので `|O| ≥ 1` であり、2 つの場合が尽くしている。
  have hne : O.1.Nonempty := by
    have h := (rowShiftOrbitSet_partition (L := L)).1 O.1 O.2
    exact h
  obtain ⟨τ₀, hτ₀⟩ := hne
  have hpos : 1 ≤ O.1.card := Finset.card_pos.mpr ⟨τ₀, hτ₀⟩
  rcases Nat.lt_or_ge O.1.card 2 with hlt | hcard
  · -- 第二の場合。`|O| = 1`。
    have hcard1 : O.1.card = 1 := by omega
    have hfix : rowShift L τ₀ = τ₀ :=
      (rowShift_eq_self_iff_card_orbit_eq_one O.2 hτ₀).mpr hcard1
    -- `S↾_O = id_O`（`O` の各点で値が一致する）。
    have hsame : shiftOrbitRestriction O = Equiv.refl {τ : RowConfig L // τ ∈ O.1} := by
      apply Equiv.ext
      intro τ
      apply Subtype.ext
      have hτeq : τ.1 = τ₀ :=
        Finset.card_le_one.mp (le_of_eq hcard1) τ.1 τ.2 τ₀ hτ₀
      show rowShift L τ.1 = τ.1
      rw [hτeq]
      exact hfix
    rw [hsame, Finset.pair_eq_singleton, Finset.sum_singleton,
      orbitFactor_ambientOf_refl O,
      orbitFactor_shiftMatrix_id_of_card_one O.2 hcard1, hcard1, pow_one]
  · -- 第一の場合。`|O| ≥ 2`。
    have hfixnot : rowShift L τ₀ ≠ τ₀ := by
      intro hfix
      have : O.1.card = 1 := (rowShift_eq_self_iff_card_orbit_eq_one O.2 hτ₀).mp hfix
      omega
    have hne2 : Equiv.refl {τ : RowConfig L // τ ∈ O.1} ≠ shiftOrbitRestriction O := by
      intro heq
      have := congrArg (fun e : OrbitBij O.1 => (e ⟨τ₀, hτ₀⟩).1) heq
      simp only [Equiv.refl_apply, shiftOrbitRestriction_val] at this
      exact hfixnot this.symm
    rw [Finset.sum_pair hne2, orbitFactor_ambientOf_refl O, orbitFactor_ambientOf_shift O,
      orbitFactor_shiftMatrix_id_of_two_le O.2 hcard,
      orbitFactor_shiftMatrix_shift_of_two_le O.2 hcard]

end Ising2DLambda.AlgebraicEigenvalue
