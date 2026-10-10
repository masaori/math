/-
全単射の添字写像を置換へ移し、多項式行列式の乗法性を閉じる具体版。
値を Polynomial Qbar に固定し、右合成の両逆・符号の移送・有限積の再添字付け・
零項の除去・有限和の因数分離を本文と同じ順に辿る。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialNoninjectiveCancellation

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign sign_comp)
open Ising2DLambda.NecSuf.KacWard (trichotomous_of_linearOrder)

/-- 本文の符号の乗法性を整数の包含、定数多項式の写像の順で移す。 -/
theorem qbarPolynomial_sign_comp
    {J : Type*} [Fintype J] [LinearOrder J] (π τ : Equiv.Perm J) :
    Polynomial.C ((sign (fun i j : J => i < j) (π * τ) : ℤ) : Qbar) =
      Polynomial.C ((sign (fun i j : J => i < j) π : ℤ) : Qbar) *
        Polynomial.C ((sign (fun i j : J => i < j) τ : ℤ) : Qbar) := by
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  change c (π * τ) = c π * c τ
  calc
    c (π * τ) = Polynomial.C ((sign (fun i j : J => i < j) (π * τ) : ℤ) : Qbar) := rfl
    _ =
        Polynomial.C (((sign (fun i j : J => i < j) π *
          sign (fun i j : J => i < j) τ) : ℤ) : Qbar) := by
      rw [sign_comp (fun i j : J => i < j) trichotomous_of_linearOrder π τ]
    _ = Polynomial.C (((sign (fun i j : J => i < j) π : ℤ) : Qbar) *
        ((sign (fun i j : J => i < j) τ : ℤ) : Qbar)) := by rw [Int.cast_mul]
    _ = Polynomial.C ((sign (fun i j : J => i < j) π : ℤ) : Qbar) *
        Polynomial.C ((sign (fun i j : J => i < j) τ : ℤ) : Qbar) :=
      map_mul Polynomial.C _ _
    _ = c π * c τ := rfl

/-- 全単射で指定した行の内側和。σ = π ∘ τ の全単射を自分で構成する。 -/
theorem qbarPolynomial_bijective_inner_sum
    {J : Type*} [Fintype J] [LinearOrder J]
    (B : Matrix J J (Polynomial Qbar)) (τ : Equiv.Perm J) :
    (∑ σ : Equiv.Perm J,
      Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, B (τ i) (σ i)) =
      Polynomial.C ((sign (fun i j : J => i < j) τ : ℤ) : Qbar) * Matrix.det B := by
  classical
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  let I : (J → J) → Polynomial Qbar := fun f =>
    ∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (f i) (σ i)
  let α : Equiv.Perm J → J → J := fun σ i => σ i
  let F : Equiv.Perm J → Equiv.Perm J := fun π => π * τ
  let G : Equiv.Perm J → Equiv.Perm J := fun σ => σ * τ.symm
  -- 右合成とその逆の両方を、各点で三等号ずつ確認する。
  have hGF (π : Equiv.Perm J) : G (F π) = π := by
    ext i
    calc
      G (F π) i = F π (τ.symm i) := rfl
      _ = π (τ (τ.symm i)) := rfl
      _ = π i := congrArg π (τ.apply_symm_apply i)
  have hFG (σ : Equiv.Perm J) : F (G σ) = σ := by
    ext i
    calc
      F (G σ) i = G σ (τ i) := rfl
      _ = σ (τ.symm (τ i)) := rfl
      _ = σ i := congrArg σ (τ.symm_apply_apply i)
  let e : Equiv.Perm J ≃ Equiv.Perm J :=
    { toFun := F, invFun := G, left_inv := hGF, right_inv := hFG }
  have hprod (π : Equiv.Perm J) :
      (∏ i : J, B (τ i) ((π * τ) i)) = ∏ j : J, B j (π j) := by
    calc
      (∏ i : J, B (τ i) ((π * τ) i)) = ∏ i : J, B (τ i) (π (τ i)) := rfl
      _ = ∏ j : J, B j (π j) := Equiv.prod_comp τ (fun j => B j (π j))
  calc
    I (α τ) = ∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (α τ i) (σ i) := rfl
    _ = ∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (τ i) (σ i) := rfl
    _ = ∑ π : Equiv.Perm J, c (F π) * ∏ i : J, B (τ i) (F π i) :=
      (Equiv.sum_comp e (fun σ => c σ * ∏ i : J, B (τ i) (σ i))).symm
    _ = ∑ π : Equiv.Perm J, c (π * τ) * ∏ i : J, B (τ i) ((π * τ) i) := rfl
    _ = ∑ π : Equiv.Perm J, c (π * τ) * ∏ i : J, B (τ i) (π (τ i)) := rfl
    _ = ∑ π : Equiv.Perm J, (c π * c τ) * ∏ i : J, B (τ i) (π (τ i)) := by
      refine Finset.sum_congr rfl ?_
      intro π _
      exact congrArg (· * ∏ i : J, B (τ i) ((π * τ) i)) (qbarPolynomial_sign_comp π τ)
    _ = ∑ π : Equiv.Perm J, (c π * c τ) * ∏ j : J, B j (π j) := by
      refine Finset.sum_congr rfl ?_
      intro π _
      exact congrArg ((c π * c τ) * ·) (hprod π)
    _ = ∑ π : Equiv.Perm J, (c τ * c π) * ∏ j : J, B j (π j) := by
      refine Finset.sum_congr rfl ?_
      intro π _
      exact congrArg (· * ∏ j : J, B j (π j)) (mul_comm (c π) (c τ))
    _ = ∑ π : Equiv.Perm J, c τ * (c π * ∏ j : J, B j (π j)) := by
      exact Finset.sum_congr rfl (fun π _ => mul_assoc _ _ _)
    _ = c τ * (∑ π : Equiv.Perm J, c π * ∏ j : J, B j (π j)) :=
      (Finset.mul_sum _ _ _).symm
    _ = c τ * Matrix.det B :=
      congrArg (c τ * ·) (qbarPolynomial_det_row_expansion B).symm

/-- 非単射項を消し、全単射と置換の明示的な対応から二つの行列式を分離する。
非空性は既存の本文の展開定理に合わせた仮定であり、この再添字付け自体は空でも成り立つ。 -/
theorem qbarPolynomial_det_mul
    {J : Type*} [Fintype J] [LinearOrder J] [Nonempty J]
    (A B : Matrix J J (Polynomial Qbar)) :
    Matrix.det (A * B) = Matrix.det A * Matrix.det B := by
  classical
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  let P : (J → J) → Polynomial Qbar := fun f => ∏ i : J, A i (f i)
  let I : (J → J) → Polynomial Qbar := fun f =>
    ∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (f i) (σ i)
  let U : Finset (J → J) := univ.filter Function.Bijective
  let toFunction : Equiv.Perm J → {f : J → J // Function.Bijective f} :=
    fun τ => ⟨fun i => τ i, τ.bijective⟩
  let toPermutation : {f : J → J // Function.Bijective f} → Equiv.Perm J :=
    fun f => Equiv.ofBijective f.val f.property
  have hperm (τ : Equiv.Perm J) : toPermutation (toFunction τ) = τ := by
    ext i
    calc
      (toPermutation ∘ toFunction) τ i = toPermutation (toFunction τ) i := rfl
      _ = (toFunction τ).val i := rfl
      _ = τ i := rfl
  have hfun (f : {f : J → J // Function.Bijective f}) :
      toFunction (toPermutation f) = f := by
    apply Subtype.ext
    funext i
    calc
      ((toFunction ∘ toPermutation) f).val i = (toFunction (toPermutation f)).val i := rfl
      _ = toPermutation f i := rfl
      _ = f.val i := rfl
  let e : Equiv.Perm J ≃ {f : J → J // Function.Bijective f} :=
    { toFun := toFunction, invFun := toPermutation, left_inv := hperm, right_inv := hfun }
  -- 単射の像は元の集合と同じ個数を持ち、部分集合なので全体に等しい。
  have hsurjective (f : J → J) (hinj : Function.Injective f) : Function.Surjective f := by
    have hcard : (univ.image f).card = (univ : Finset J).card :=
      card_image_of_injective univ hinj
    have himage : univ.image f = (univ : Finset J) := by
      exact eq_of_subset_of_card_le (subset_univ _) (le_of_eq hcard.symm)
    intro j
    obtain ⟨i, _, hi⟩ := mem_image.mp (himage.symm ▸ mem_univ j)
    exact ⟨i, hi⟩
  have hzero (f : J → J) (hf : ¬Function.Bijective f) : P f * I f = 0 := by
    have hn : ¬Function.Injective f := by
      intro hinj
      exact hf ⟨hinj, hsurjective f hinj⟩
    have hinner : I f = 0 :=
      qbarPolynomial_noninjective_inner_sum_zero B f hn
    calc
      P f * I f = P f * 0 := congrArg (P f * ·) hinner
      _ = 0 := mul_zero _
  calc
    Matrix.det (A * B) = ∑ f : J → J, P f * I f :=
      qbarPolynomial_det_mul_function_expansion A B
    _ = ∑ f ∈ U, P f * I f := by
      symm
      apply Finset.sum_subset (Finset.filter_subset _ _)
      intro f _ hf
      exact hzero f (by simpa only [U, mem_filter, mem_univ, true_and] using hf)
    _ = ∑ f : {f : J → J // Function.Bijective f}, P f.val * I f.val :=
      Finset.sum_subtype U (fun f => by simp only [U, mem_filter, mem_univ, true_and])
        (fun f => P f * I f)
    _ = ∑ τ : Equiv.Perm J, P (toFunction τ).val * I (toFunction τ).val :=
      (Fintype.sum_equiv e _ _ (fun _ => rfl)).symm
    _ = ∑ τ : Equiv.Perm J, P (toFunction τ).val * (c τ * Matrix.det B) := by
      refine Finset.sum_congr rfl ?_
      intro τ _
      exact congrArg (P (fun i => τ i) * ·) (qbarPolynomial_bijective_inner_sum B τ)
    _ = ∑ τ : Equiv.Perm J, (P (toFunction τ).val * c τ) * Matrix.det B := by
      exact Finset.sum_congr rfl (fun τ _ => (mul_assoc _ _ _).symm)
    _ = ∑ τ : Equiv.Perm J, (c τ * P (toFunction τ).val) * Matrix.det B := by
      refine Finset.sum_congr rfl ?_
      intro τ _
      exact congrArg (· * Matrix.det B) (mul_comm (P (fun i => τ i)) (c τ))
    _ = (∑ τ : Equiv.Perm J, c τ * P (toFunction τ).val) * Matrix.det B :=
      (Finset.sum_mul _ _ _).symm
    _ = (∑ τ : Equiv.Perm J, c τ * ∏ i : J, A i ((toFunction τ).val i)) * Matrix.det B := rfl
    _ = (∑ τ : Equiv.Perm J, c τ * ∏ i : J, A i (τ i)) * Matrix.det B := rfl
    _ = Matrix.det A * Matrix.det B :=
      congrArg (· * Matrix.det B) (qbarPolynomial_det_row_expansion A).symm

end Ising2DLambda.AlgebraicEigenvalue
