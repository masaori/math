/-
全単射の再添字付けと重み付き置換和の乗法性の必要十分版。
内側和では可換半環と重みの合成保存だけを使う。全体では非単射項の相殺のために
加法逆元と互換による重みの反転を加える。順序・標数零・除法・非空性は使わない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatrixProductFunctionExpansion
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.NoninjectivePermutationSum

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 有限積の添字変更には乗法の可換性、共通重みの取り出しには分配則が要る。
係数の負号と添字の順序はこの段には不要である。 -/
theorem permutation_row_sum_reindex_necSuf
    {J R : Type*} [Fintype J] [DecidableEq J] [CommSemiring R]
    (B : Matrix J J R) (c : Equiv.Perm J → R)
    (hc : ∀ π τ : Equiv.Perm J, c (π * τ) = c π * c τ) (τ : Equiv.Perm J) :
    (∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (τ i) (σ i)) =
      c τ * (∑ π : Equiv.Perm J, c π * ∏ j : J, B j (π j)) := by
  classical
  let I : (J → J) → R := fun f => ∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (f i) (σ i)
  let α : Equiv.Perm J → J → J := fun σ i => σ i
  let F : Equiv.Perm J → Equiv.Perm J := fun π => π * τ
  let G : Equiv.Perm J → Equiv.Perm J := fun σ => σ * τ.symm
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
      exact congrArg (· * ∏ i : J, B (τ i) ((π * τ) i)) (hc π τ)
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

/-- 非単射項の相殺、全単射集合と置換集合の往復、二つの和の分離を同じ順に辿る。
可換環の加法逆元は相殺に、分配則は写像展開と最後の因数分離に使う。
重みには合成保存と互換反転だけを要求し、単位元での値は仮定しない。 -/
theorem matrixProduct_permutationSum_mul_necSuf
    {J R : Type*} [Fintype J] [DecidableEq J] [CommRing R]
    (A B : Matrix J J R) (c : Equiv.Perm J → R)
    (hc : ∀ π τ : Equiv.Perm J, c (π * τ) = c π * c τ)
    (hswap : ∀ (a b : J), a ≠ b → ∀ σ : Equiv.Perm J,
      c (σ * Ising2DLambda.NecSuf.KacWard.transpositionPerm a b) = -c σ) :
    (∑ σ : Equiv.Perm J, c σ * ∏ i : J, (A * B) i (σ i)) =
      (∑ τ : Equiv.Perm J, c τ * ∏ i : J, A i (τ i)) *
        (∑ π : Equiv.Perm J, c π * ∏ j : J, B j (π j)) := by
  classical
  let P : (J → J) → R := fun f => ∏ i : J, A i (f i)
  let I : (J → J) → R := fun f =>
    ∑ σ : Equiv.Perm J, c σ * ∏ i : J, B (f i) (σ i)
  let D : R := ∑ π : Equiv.Perm J, c π * ∏ j : J, B j (π j)
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
    obtain ⟨a, b, hf, hab⟩ := Function.not_injective_iff.mp hn
    have hinner : I f = 0 := permutation_row_sum_collision_zero_necSuf
      (fun r s => neg_mul r s) B f a b hab hf c (hswap a b hab)
    calc
      P f * I f = P f * 0 := congrArg (P f * ·) hinner
      _ = 0 := mul_zero _
  calc
    (∑ σ : Equiv.Perm J, c σ * ∏ i : J, (A * B) i (σ i)) =
        ∑ f : J → J, P f * I f :=
      matrixProduct_functionExpansion_necSuf A B c (fun σ i => σ i)
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
    _ = ∑ τ : Equiv.Perm J, P (toFunction τ).val * (c τ * D) := by
      refine Finset.sum_congr rfl ?_
      intro τ _
      exact congrArg (P (fun i => τ i) * ·) (permutation_row_sum_reindex_necSuf B c hc τ)
    _ = ∑ τ : Equiv.Perm J, (P (toFunction τ).val * c τ) * D := by
      exact Finset.sum_congr rfl (fun τ _ => (mul_assoc _ _ _).symm)
    _ = ∑ τ : Equiv.Perm J, (c τ * P (toFunction τ).val) * D := by
      refine Finset.sum_congr rfl ?_
      intro τ _
      exact congrArg (· * D) (mul_comm (P (fun i => τ i)) (c τ))
    _ = (∑ τ : Equiv.Perm J, c τ * P (toFunction τ).val) * D :=
      (Finset.sum_mul _ _ _).symm
    _ = (∑ τ : Equiv.Perm J, c τ * ∏ i : J, A i ((toFunction τ).val i)) * D := rfl
    _ = (∑ τ : Equiv.Perm J, c τ * ∏ i : J, A i (τ i)) * D := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
