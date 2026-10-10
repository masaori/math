/-
添字写像が非単射のときの行列式内側和の相殺。値を Polynomial Qbar に固定し、
衝突する二点の互換、積の再添字付け、符号反転、二項を除く帰納法を独立に辿る。
有限相殺の必要十分版や行列式の既製定理は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign sign_comp)
open Ising2DLambda.NecSuf.KacWard
  (transpositionPerm transpositionPerm_apply_left transpositionPerm_apply_right
    transpositionPerm_apply_of_ne sign_transposition trichotomous_of_linearOrder)

/-- 本文の符号反転。整数の符号、整数の包含、定数多項式の写像を順に辿る。 -/
theorem qbarPolynomial_sign_right_transposition_neg
    {J : Type*} [Fintype J] [LinearOrder J]
    (a b : J) (hab : a ≠ b) (σ : Equiv.Perm J) :
    Polynomial.C ((sign (fun i j : J => i < j) (σ * transpositionPerm a b) : ℤ) : Qbar) =
      -Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) := by
  have hsign : sign (fun i j : J => i < j) (σ * transpositionPerm a b) =
      -sign (fun i j : J => i < j) σ := by
    calc
      sign (fun i j : J => i < j) (σ * transpositionPerm a b) =
          sign (fun i j : J => i < j) σ *
            sign (fun i j : J => i < j) (transpositionPerm a b) :=
        sign_comp (fun i j : J => i < j) trichotomous_of_linearOrder σ _
      _ = sign (fun i j : J => i < j) σ * (-1) := by rw [sign_transposition a b hab]
      _ = -sign (fun i j : J => i < j) σ := mul_neg_one _
  calc
    Polynomial.C ((sign (fun i j : J => i < j) (σ * transpositionPerm a b) : ℤ) : Qbar) =
        Polynomial.C (((-sign (fun i j : J => i < j) σ) : ℤ) : Qbar) := by rw [hsign]
    _ = Polynomial.C (-((sign (fun i j : J => i < j) σ : ℤ) : Qbar)) := by
      rw [Int.cast_neg]
    _ = -Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) :=
      map_neg Polynomial.C _

/-- 本文の有限集合に関する帰納法。二項を除いた集合の閉性も対合性から証明する。 -/
private theorem qbarPolynomial_sum_of_paired_terms_zero
    {J : Type*} [Fintype J] [LinearOrder J]
    (u : Equiv.Perm J → Polynomial Qbar) (F : Equiv.Perm J → Equiv.Perm J)
    (hF : Function.Involutive F) (hfixed : ∀ σ, F σ ≠ σ)
    (hpair : ∀ σ, u σ + u (F σ) = 0)
    (S : Finset (Equiv.Perm J)) (hstable : ∀ σ ∈ S, F σ ∈ S) :
    ∑ σ ∈ S, u σ = 0 := by
  classical
  revert hstable
  refine Finset.strongInductionOn S ?_
  intro S ih hstable
  by_cases hS : S = ∅
  · subst S
    exact Finset.sum_empty
  obtain ⟨σ, hσ⟩ := Finset.nonempty_iff_ne_empty.mpr hS
  have hFσ : F σ ∈ S.erase σ := Finset.mem_erase.mpr ⟨hfixed σ, hstable σ hσ⟩
  let R := (S.erase σ).erase (F σ)
  have hRsub : R ⊂ S :=
    lt_of_le_of_lt (Finset.erase_subset (F σ) (S.erase σ)) (Finset.erase_ssubset hσ)
  have hRstable : ∀ ρ ∈ R, F ρ ∈ R := by
    intro ρ hρ
    obtain ⟨hρF, hρerase⟩ := Finset.mem_erase.mp hρ
    obtain ⟨hρσ, hρS⟩ := Finset.mem_erase.mp hρerase
    have hFρσ : F ρ ≠ σ := by
      intro heq
      apply hρF
      calc
        ρ = F (F ρ) := (hF ρ).symm
        _ = F σ := congrArg F heq
    have hFρF : F ρ ≠ F σ := by
      intro heq
      apply hρσ
      calc
        ρ = F (F ρ) := (hF ρ).symm
        _ = F (F σ) := congrArg F heq
        _ = σ := hF σ
    exact Finset.mem_erase.mpr ⟨hFρF,
      Finset.mem_erase.mpr ⟨hFρσ, hstable ρ hρS⟩⟩
  have hRzero : ∑ ρ ∈ R, u ρ = 0 := ih R hRsub hRstable
  calc
    ∑ ρ ∈ S, u ρ = u σ + ∑ ρ ∈ S.erase σ, u ρ :=
      (Finset.add_sum_erase S u hσ).symm
    _ = u σ + (u (F σ) + ∑ ρ ∈ R, u ρ) :=
      congrArg (u σ + ·) (Finset.add_sum_erase (S.erase σ) u hFσ).symm
    _ = (u σ + u (F σ)) + ∑ ρ ∈ R, u ρ := (add_assoc _ _ _).symm
    _ = 0 + ∑ ρ ∈ R, u ρ := congrArg (· + ∑ ρ ∈ R, u ρ) (hpair σ)
    _ = 0 + 0 := congrArg (0 + ·) hRzero
    _ = 0 := zero_add _

/-- 本文の非単射項の相殺。衝突する二点の互換を置換の右から合成して対を作る。
非単射性自体が相異なる二点を与えるので、非空性や辺長の条件は追加しない。 -/
theorem qbarPolynomial_noninjective_inner_sum_zero
    {J : Type*} [Fintype J] [LinearOrder J]
    (B : Matrix J J (Polynomial Qbar)) (f : J → J) (h : ¬Function.Injective f) :
    (∑ σ : Equiv.Perm J,
      Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, B (f i) (σ i)) = 0 := by
  classical
  obtain ⟨a, b, hf, hab⟩ := Function.not_injective_iff.mp h
  let t : Equiv.Perm J := transpositionPerm a b
  let F : Equiv.Perm J → Equiv.Perm J := fun σ => σ * t
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  let P : Equiv.Perm J → Polynomial Qbar := fun σ => ∏ i : J, B (f i) (σ i)
  let u : Equiv.Perm J → Polynomial Qbar := fun σ => c σ * P σ
  -- 衝突する二点とそれ以外の三場合で、添字写像は互換の前後で変わらない。
  have hft : ∀ i : J, f (t i) = f i := by
    intro i
    by_cases hia : i = a
    · subst i
      calc
        f (t a) = f b := congrArg f (transpositionPerm_apply_left a b)
        _ = f a := hf.symm
    · by_cases hib : i = b
      · subst i
        calc
          f (t b) = f a := congrArg f (transpositionPerm_apply_right a b)
          _ = f b := hf
      · exact congrArg f (transpositionPerm_apply_of_ne a b hia hib)
  have htt (i : J) : t (t i) = i := by
    exact NecSuf.AlgebraicEigenvalue.transpositionOn_involutive a b i
  -- 二重合成を点ごとに計算し、対合性を得る。
  have hF : Function.Involutive F := by
    intro σ
    ext i
    calc
      F (F σ) i = F σ (t i) := rfl
      _ = σ (t (t i)) := rfl
      _ = σ i := congrArg σ (htt i)
  -- 不動点なら a の像が等しくなり、σ の単射性と a ≠ b に矛盾する。
  have hfixed (σ : Equiv.Perm J) : F σ ≠ σ := by
    intro heq
    have himage : F σ a ≠ σ a := by
      calc
        F σ a = σ (t a) := rfl
        _ = σ b := congrArg σ (transpositionPerm_apply_left a b)
        _ ≠ σ a := fun hba => hab (σ.injective hba).symm
    exact himage (congrArg (fun ρ : Equiv.Perm J => ρ a) heq)
  -- 積の定義、合成、添字写像の不変性、互換による再添字付け。
  have hP (σ : Equiv.Perm J) : P (F σ) = P σ := by
    calc
      P (F σ) = ∏ i : J, B (f i) (F σ i) := rfl
      _ = ∏ i : J, B (f i) (σ (t i)) := rfl
      _ = ∏ i : J, B (f (t i)) (σ (t i)) := by
        exact Finset.prod_congr rfl (fun i _ => congrArg (fun j => B j (σ (t i))) (hft i).symm)
      _ = ∏ i : J, B (f i) (σ i) := Equiv.prod_comp t (fun i => B (f i) (σ i))
      _ = P σ := rfl
  have hc (σ : Equiv.Perm J) : c (F σ) = -c σ := by
    exact qbarPolynomial_sign_right_transposition_neg a b hab σ
  have hu (σ : Equiv.Perm J) : u (F σ) = -u σ := by
    calc
      u (F σ) = c (F σ) * P (F σ) := rfl
      _ = (-c σ) * P (F σ) := congrArg (· * P (F σ)) (hc σ)
      _ = (-c σ) * P σ := congrArg ((-c σ) * ·) (hP σ)
      _ = -(c σ * P σ) := neg_mul _ _
      _ = -u σ := rfl
  have hpair (σ : Equiv.Perm J) : u σ + u (F σ) = 0 := by
    calc
      u σ + u (F σ) = u σ + (-u σ) := congrArg (u σ + ·) (hu σ)
      _ = 0 := add_neg_cancel _
  calc
    (∑ σ : Equiv.Perm J, Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, B (f i) (σ i)) = ∑ σ : Equiv.Perm J, u σ := rfl
    _ = 0 := qbarPolynomial_sum_of_paired_terms_zero u F hF hfixed hpair univ
      (fun σ _ => mem_univ (F σ))

end Ising2DLambda.AlgebraicEigenvalue
