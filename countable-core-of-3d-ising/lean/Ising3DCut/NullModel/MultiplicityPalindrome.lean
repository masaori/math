/-
人手証明の主張「多重度は回文である」（ラベル `claim_palindrome`）の具体版。

人手証明とこのファイルの対応:

  S_m = {σ : Σ_L | m_L(σ) = m}                 `LevelSet L m`
  T : S_m → S_(#E_L-m)                         `palindromeEquiv` の順写像
  T : S_(#E_L-m) → S_m                         `palindromeEquiv` の逆写像
  T(Tσ) = σ                                    二つの写像が互いに逆であること
  #S_m = #S_(#E_L-m)                           `multiplicity_palindrome`

住処: `Fin`、`Nat`、`Bool`、整数 ±1、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.BrokenComplement

namespace Ising3DCut.NullModel

noncomputable section

/-- 配位の値 ±1 は二つしかないので有限である。 -/
instance : Finite Spin :=
  Finite.of_injective (fun z : Spin => if z.1 = 1 then true else false) (by
    intro z w h
    apply Subtype.ext
    rcases z.2 with hz | hz <;> rcases w.2 with hw | hw <;> simp_all)

instance : Fintype Spin := Fintype.ofFinite _

instance {L : ℕ} : Finite (Config L) :=
  inferInstanceAs (Finite (Site L → Spin))

instance {L : ℕ} : Fintype (Config L) := Fintype.ofFinite _

/-- 破れ数が `m` である配位の有限集合。 -/
def levelSetFinset (L m : ℕ) : Finset (Config L) :=
  Finset.univ.filter fun σ => brokenCount σ = m

/-- 破れ数が `m` である配位の有限型。人手証明の S_m。 -/
def LevelSet (L m : ℕ) := ↥(levelSetFinset L m)

instance (L m : ℕ) : Fintype (LevelSet L m) :=
  inferInstanceAs (Fintype ↥(levelSetFinset L m))

/-- 多重度 Ω_L(m) = #S_m（`def_multiplicity` の具体化）。 -/
def multiplicity (L m : ℕ) : ℕ := Fintype.card (LevelSet L m)

/-- 人手証明の二つの写像を一つの全単射として束ねたもの。 -/
def palindromeEquiv {L m : ℕ} (h : m ≤ Fintype.card (Edge L)) :
    LevelSet L m ≃ LevelSet L (Fintype.card (Edge L) - m) where
  toFun σ := ⟨oddFlip σ.1, by
    have hmem := σ.2
    change σ.1 ∈ Finset.univ.filter (fun ρ : Config L => brokenCount ρ = m) at hmem
    have hs : brokenCount σ.1 = m := (Finset.mem_filter.mp hmem).2
    change oddFlip σ.1 ∈
      Finset.univ.filter (fun ρ : Config L => brokenCount ρ = Fintype.card (Edge L) - m)
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by rw [brokenCount_oddFlip, hs]⟩
  ⟩
  invFun τ := ⟨oddFlip τ.1, by
    have hmem := τ.2
    change τ.1 ∈ Finset.univ.filter
      (fun ρ : Config L => brokenCount ρ = Fintype.card (Edge L) - m) at hmem
    have ht : brokenCount τ.1 = Fintype.card (Edge L) - m :=
      (Finset.mem_filter.mp hmem).2
    change oddFlip τ.1 ∈ Finset.univ.filter (fun ρ : Config L => brokenCount ρ = m)
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by rw [brokenCount_oddFlip, ht, Nat.sub_sub_self h]⟩
  ⟩
  left_inv σ := Subtype.ext (oddFlip_oddFlip σ.1)
  right_inv τ := Subtype.ext (oddFlip_oddFlip τ.1)

/-- `claim_palindrome` の具体版。Ω_L(m) = Ω_L(#E_L-m)。 -/
theorem multiplicity_palindrome {L m : ℕ} (h : m ≤ Fintype.card (Edge L)) :
    multiplicity L m = multiplicity L (Fintype.card (Edge L) - m) := by
  exact Fintype.card_congr (palindromeEquiv h)

end

end Ising3DCut.NullModel
