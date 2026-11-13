/-
節「テンソル代数」のうち、線型写像 f : V → A がテンソル代数の上に定める準同型と、テンソル代数の普遍性の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                       このファイル
  def_ordered_product_of_values_of_linear_map_on_tuple                               valueFactors（s に f(u(s)) を与える族）・
                                                                                     orderedProductOfValues（μ^f_k）・orderedProductOfValues_emptyTuple
  claim_ordered_product_of_values_of_linear_map_on_tuple_is_multilinear              orderedProductOfValues_isMultilinear
  def_linear_map_on_tensor_power_extending_linear_map                                TensorPowers.extensionOnPower（F_k）・
                                                                                     …_isLinearMap・…_tau（F_k(τ_k(u)) = μ^f_k(u)）
  claim_sum_of_values_on_components_does_not_depend_on_zero_bound                    TensorPowers.sum_extensionOnPower_eq_of_le
  def_map_from_tensor_algebra_extending_linear_map                                   TensorPowers.extension（F）・TensorPowers.extension_eq
  claim_map_from_tensor_algebra_extending_linear_map_is_linear_map                   TensorPowers.extension_isLinearMap
  claim_map_from_tensor_algebra_on_embedded_tensor                                   TensorPowers.extension_embedComponent
  claim_extension_on_tensor_powers_sends_product_of_tensors_to_product               TensorPowers.extensionOnPower_tensorMul（と二つの段）
  claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism         TensorPowers.extension_isAlgebraHomomorphism
  claim_map_from_tensor_algebra_extending_linear_map_composed_with_embedding         TensorPowers.extension_embedVector
  claim_universal_property_of_tensor_algebra                                         universalProperty_of_tensorAlgebra

A は任意の ℂ-代数で、Lean では任意の宇宙 w の型に置く。F_k を定めるのに (T_k, τ_k) の普遍性を U = U_vec(A) に当てるので、
族 P が A の宇宙について k 重テンソル積であること `hP : ∀ k, IsTensorProduct.{u, v, w} …` を引数に取る
（`TensorPowers` の欄 isTensorProduct は T_j と同じ宇宙 v の U についての普遍性だけを持つため）。
座標による構成は任意の宇宙について k 重テンソル積なので（`coordinateTensor_isTensorProduct`）、本文の T(V) では hP をそこから渡す。

μ^f_k の因子の族は {1,…,k} の外で 1_A をとる `ℕ → A` の族（`valueFactors`。外の値は番号順の積に現れない）。
本文の F の定義の「零の境 N の取り方によらない」は、x の零の境の一つを `Classical.choose` で選んで定め、
どの零の境で開いても同じであること（`extension_eq`）を `sum_extensionOnPower_eq_of_le` から示す。

必要十分版は `NecSuf/MathematicalToolkit/TensorAlgebra/UniversalPropertyOfTensorAlgebra.lean`、導出版は `TensorAlgebraStructureFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.EmbeddingAndGeneration
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.Homomorphisms

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v w

variable {V : Type u} {A : Type w}

open ComplexAlgebra

/-- 本文 `def_ordered_product_of_values_of_linear_map_on_tuple` の因子：s ∈ {1,…,k} に f(u(s)) を与える族（{1,…,k} の外の値 1_A は使わない）。 -/
def valueFactors (SA : ComplexAlgebra A) (f : V → A) {k : ℕ} (u : Tuple V k) : ℕ → A :=
  extendFamily (fun s : Idx k => f (u s)) SA.one

theorem valueFactors_of_le (SA : ComplexAlgebra A) (f : V → A) {k : ℕ} (u : Tuple V k) (s : ℕ)
    (h1 : 1 ≤ s) (h2 : s ≤ k) : valueFactors SA f u s = f (u ⟨s, h1, h2⟩) :=
  extendFamily_of_le _ SA.one s h1 h2

/-- 本文 `def_ordered_product_of_values_of_linear_map_on_tuple`：μ^f_k(u) := ∏_{A,s=1}^{k} f(u(s))。 -/
def orderedProductOfValues (SA : ComplexAlgebra A) (f : V → A) (k : ℕ) (u : Tuple V k) : A :=
  ComplexAlgebra.orderedProduct SA k (valueFactors SA f u)

/-- 本文 `def_ordered_product_of_values_of_linear_map_on_tuple`：μ^f_0(ε_V) = 1_A。 -/
theorem orderedProductOfValues_emptyTuple (SA : ComplexAlgebra A) (f : V → A) :
    orderedProductOfValues SA f 0 (emptyTuple V) = SA.one := rfl

/-- 本文 `claim_ordered_product_of_values_of_linear_map_on_tuple_is_multilinear`：μ^f_k は V から U_vec(A) への k 重線型写像である。
w_s・w'_s・w''_s・w'''_s は s ≠ r で f(u(s)) に等しく、s = r で w_r = w'_r +_A w''_r、w'''_r = λ ∗_A w'_r を満たすので、
番号順の積の二つの主張を当てる。 -/
theorem orderedProductOfValues_isMultilinear {SV : ComplexVectorSpace V} (SA : ComplexAlgebra A) {f : V → A}
    (hf : IsComplexLinearMap SV SA.toComplexVectorSpace f) (k : ℕ) :
    IsMultilinearMap SV SA.toComplexVectorSpace k (orderedProductOfValues SA f k) where
  map_add u r x y := by
    -- s ≠ r ならどの族も f(u(s))
    have hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r.1 →
        valueFactors SA f (replaceComponent u r (SV.add x y)) s = valueFactors SA f (replaceComponent u r x) s ∧
          valueFactors SA f (replaceComponent u r (SV.add x y)) s
            = valueFactors SA f (replaceComponent u r y) s := by
      intro s h1 h2 hsr
      have hne' : (⟨s, h1, h2⟩ : Idx k) ≠ r := fun h => hsr (congrArg Subtype.val h)
      rw [valueFactors_of_le SA f _ s h1 h2, valueFactors_of_le SA f _ s h1 h2, valueFactors_of_le SA f _ s h1 h2,
        replaceComponent_of_ne u r _ _ hne', replaceComponent_of_ne u r _ _ hne',
        replaceComponent_of_ne u r _ _ hne']
      exact ⟨rfl, rfl⟩
    -- w_r = w'_r +_A w''_r
    have hr : valueFactors SA f (replaceComponent u r (SV.add x y)) r.1
        = SA.add (valueFactors SA f (replaceComponent u r x) r.1)
            (valueFactors SA f (replaceComponent u r y) r.1) := calc
        valueFactors SA f (replaceComponent u r (SV.add x y)) r.1
          = f (replaceComponent u r (SV.add x y) r) := valueFactors_of_le SA f _ r.1 r.2.1 r.2.2
        _ = f (SV.add x y) := by rw [replaceComponent_self]
        _ = SA.add (f x) (f y) := hf.map_add x y
        _ = SA.add (f (replaceComponent u r x r)) (f (replaceComponent u r y r)) := by
            rw [replaceComponent_self, replaceComponent_self]
        _ = SA.add (valueFactors SA f (replaceComponent u r x) r.1)
              (valueFactors SA f (replaceComponent u r y) r.1) := by
            rw [valueFactors_of_le SA f _ r.1 r.2.1 r.2.2, valueFactors_of_le SA f _ r.1 r.2.1 r.2.2]
    exact ComplexAlgebra.orderedProduct_add_in_one_factor SA k r.1 r.2.1 r.2.2 _ _ _ hne hr
  map_smul u r l x := by
    have hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r.1 →
        valueFactors SA f (replaceComponent u r (SV.smul l x)) s = valueFactors SA f (replaceComponent u r x) s := by
      intro s h1 h2 hsr
      have hne' : (⟨s, h1, h2⟩ : Idx k) ≠ r := fun h => hsr (congrArg Subtype.val h)
      rw [valueFactors_of_le SA f _ s h1 h2, valueFactors_of_le SA f _ s h1 h2,
        replaceComponent_of_ne u r _ _ hne', replaceComponent_of_ne u r _ _ hne']
    -- w'''_r = λ ∗_A w'_r
    have hr : valueFactors SA f (replaceComponent u r (SV.smul l x)) r.1
        = SA.smul l (valueFactors SA f (replaceComponent u r x) r.1) := calc
        valueFactors SA f (replaceComponent u r (SV.smul l x)) r.1
          = f (replaceComponent u r (SV.smul l x) r) := valueFactors_of_le SA f _ r.1 r.2.1 r.2.2
        _ = f (SV.smul l x) := by rw [replaceComponent_self]
        _ = SA.smul l (f x) := hf.map_smul l x
        _ = SA.smul l (f (replaceComponent u r x r)) := by rw [replaceComponent_self]
        _ = SA.smul l (valueFactors SA f (replaceComponent u r x) r.1) := by
            rw [valueFactors_of_le SA f _ r.1 r.2.1 r.2.2]
    exact ComplexAlgebra.orderedProduct_smul_in_one_factor SA k r.1 r.2.1 r.2.2 l _ _ hne hr

/-- x の零の境 k：emb_k(y) は第 k 成分より先が零である。 -/
theorem isZeroBound_embedComponent {E : ℕ → Type v} (S : ∀ j : ℕ, ComplexVectorSpace (E j)) (k : ℕ) (y : E k) :
    IsZeroBound S (embedComponent S k y).1 k :=
  fun j hj => embedComponent_of_ne S k y j (Nat.ne_of_gt hj)

namespace TensorPowers

variable {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)
  (hP : ∀ k : ℕ, IsTensorProduct.{u, v, w} SV k (P.space k) (P.τ k))
  (SA : ComplexAlgebra A) {f : V → A} (hf : IsComplexLinearMap SV SA.toComplexVectorSpace f)

/-- 本文 `def_linear_map_on_tensor_power_extending_linear_map`：(T_k, τ_k) の普遍性を U = U_vec(A)、h = μ^f_k に当てた線型写像 F_k。 -/
noncomputable def extensionOnPower (k : ℕ) : P.T k → A :=
  Classical.choose ((hP k).universal A SA.toComplexVectorSpace (orderedProductOfValues SA f k)
    (orderedProductOfValues_isMultilinear SA hf k))

theorem extensionOnPower_spec (k : ℕ) :
    (IsComplexLinearMap (P.space k) SA.toComplexVectorSpace (P.extensionOnPower hP SA hf k) ∧
        ∀ u : Tuple V k, P.extensionOnPower hP SA hf k (P.τ k u) = orderedProductOfValues SA f k u) ∧
      ∀ g : P.T k → A, (IsComplexLinearMap (P.space k) SA.toComplexVectorSpace g ∧
          ∀ u : Tuple V k, g (P.τ k u) = orderedProductOfValues SA f k u) → g = P.extensionOnPower hP SA hf k :=
  Classical.choose_spec ((hP k).universal A SA.toComplexVectorSpace (orderedProductOfValues SA f k)
    (orderedProductOfValues_isMultilinear SA hf k))

/-- 本文 `def_linear_map_on_tensor_power_extending_linear_map`：F_k は T_k から U_vec(A) への線型写像である。 -/
theorem extensionOnPower_isLinearMap (k : ℕ) :
    IsComplexLinearMap (P.space k) SA.toComplexVectorSpace (P.extensionOnPower hP SA hf k) :=
  (P.extensionOnPower_spec hP SA hf k).1.1

/-- 本文 `def_linear_map_on_tensor_power_extending_linear_map`：F_k(τ_k(u)) = μ^f_k(u)。 -/
theorem extensionOnPower_tau (k : ℕ) (u : Tuple V k) :
    P.extensionOnPower hP SA hf k (P.τ k u) = orderedProductOfValues SA f k u :=
  (P.extensionOnPower_spec hP SA hf k).1.2 u

/-- 本文 `claim_sum_of_values_on_components_does_not_depend_on_zero_bound`：
N ≤ N' なら Σ_{i∈{0,…,N'}} 1_ℂ ∗_A F_i(x_i) = Σ_{i∈{0,…,N}} 1_ℂ ∗_A F_i(x_i)。
d := N' - N、g_s := F_{s-1}(x_{s-1}) と置き、線型結合を前の N + 1 項と後ろの d 項に分ける。 -/
theorem sum_extensionOnPower_eq_of_le (x : DirectSumOfFamily P.space) (N N' : ℕ)
    (hN : IsZeroBound P.space x.1 N) (hNN' : N ≤ N') :
    sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N') (fun _ => 1)
        (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))
      = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) := by
  obtain ⟨d, rfl⟩ : ∃ d : ℕ, N' = N + d := ⟨N' - N, by omega⟩
  -- g_s := F_{s-1}(x_{s-1})
  set g : ℕ → A := fun s => P.extensionOnPower hP SA hf (s - 1) (x.1 (s - 1)) with hg
  -- 番号付け (M + 1, e) で和を開く
  have hopen : ∀ M : ℕ, sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo M) (fun _ => 1)
        (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))
      = linearCombination SA.toComplexVectorSpace (M + 1) (fun _ => 1) g := by
    intro M
    rw [sumOverFiniteSet_eq SA.toComplexVectorSpace _ _ _ (M + 1) (upToNumbering M) (upToNumbering_isNumbering M)]
    apply linearCombination_eq_of_terms_eq
    intro s h1 h2
    rw [numberedFamily_of_le _ _ _ s h1 h2, numberedFamily_of_le _ _ _ s h1 h2]
    rfl
  -- t ∈ {1,…,d} で 1_ℂ ∗_A g_{N+1+t} = 0_A（x_{N+t} = 0_{T_{N+t}}）
  have htail : ∀ t : Idx d, SA.toComplexVectorSpace.smul ((fun _ => (1 : ℂ)) t.1) ((fun j => g (N + 1 + j)) t.1)
      = SA.toComplexVectorSpace.zero := by
    intro t
    have hx0 : x.1 (N + 1 + t.1 - 1) = (P.space (N + 1 + t.1 - 1)).zero := hN _ (by have := t.2.1; omega)
    calc SA.toComplexVectorSpace.smul 1 (g (N + 1 + t.1))
        = SA.toComplexVectorSpace.smul 1
            (P.extensionOnPower hP SA hf (N + 1 + t.1 - 1) (x.1 (N + 1 + t.1 - 1))) := rfl
      _ = SA.toComplexVectorSpace.smul 1
            (P.extensionOnPower hP SA hf (N + 1 + t.1 - 1) (P.space (N + 1 + t.1 - 1)).zero) := by rw [hx0]
      _ = SA.toComplexVectorSpace.smul 1 SA.toComplexVectorSpace.zero := by
          rw [(P.extensionOnPower_isLinearMap hP SA hf _).map_zero]
      _ = SA.toComplexVectorSpace.zero := smul_zero_eq_zero _ 1
  calc sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo (N + d)) (fun _ => 1)
        (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))
      = linearCombination SA.toComplexVectorSpace (N + d + 1) (fun _ => 1) g := hopen (N + d)
    _ = linearCombination SA.toComplexVectorSpace ((N + 1) + d) (fun _ => 1) g := by
        rw [show N + d + 1 = N + 1 + d by omega]
    _ = SA.toComplexVectorSpace.add (linearCombination SA.toComplexVectorSpace (N + 1) (fun _ => 1) g)
          (linearCombination SA.toComplexVectorSpace d (fun _ => 1) (fun j => g (N + 1 + j))) :=
        linearCombination_split SA.toComplexVectorSpace (N + 1) d g (fun _ => 1)
    _ = SA.toComplexVectorSpace.add (linearCombination SA.toComplexVectorSpace (N + 1) (fun _ => 1) g)
          (sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_idx d) (fun t => (fun _ => (1 : ℂ)) t.1)
            (fun t => (fun j => g (N + 1 + j)) t.1)) := by
        rw [sumOverFiniteSet_idx SA.toComplexVectorSpace d (fun _ => 1) (fun j => g (N + 1 + j))]
    _ = SA.toComplexVectorSpace.add (linearCombination SA.toComplexVectorSpace (N + 1) (fun _ => 1) g)
          SA.toComplexVectorSpace.zero := by
        rw [sumOverFiniteSet_eq_zero_of_terms_eq_zero _ _ _ _ htail]
    _ = linearCombination SA.toComplexVectorSpace (N + 1) (fun _ => 1) g := SA.toComplexVectorSpace.add_zero _
    _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) := (hopen N).symm

/-- 本文 `def_map_from_tensor_algebra_extending_linear_map`：F(x) := Σ_{i∈{0,…,N}} 1_ℂ ∗_A F_i(x_i)（N は x の零の境）。 -/
noncomputable def extension (x : DirectSumOfFamily P.space) : A :=
  sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo (Classical.choose x.2)) (fun _ => 1)
    (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))

/-- 本文 `def_map_from_tensor_algebra_extending_linear_map`：右辺は零の境 N の取り方によらない。 -/
theorem extension_eq (x : DirectSumOfFamily P.space) (N : ℕ) (hN : IsZeroBound P.space x.1 N) :
    P.extension hP SA hf x
      = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) := by
  have hN0 : IsZeroBound P.space x.1 (Classical.choose x.2) := Classical.choose_spec x.2
  rcases le_total (Classical.choose x.2) N with h | h
  · exact (P.sum_extensionOnPower_eq_of_le hP SA hf x _ N hN0 h).symm
  · exact P.sum_extensionOnPower_eq_of_le hP SA hf x N _ hN h

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_linear_map`：F は (D, +_D, ∗_D, 0_D) から U_vec(A) への線型写像である。
N を x と y の零の境の大きい方にとる。 -/
theorem extension_isLinearMap :
    IsComplexLinearMap (directSumOfFamilyVectorSpace P.space) SA.toComplexVectorSpace (P.extension hP SA hf) where
  map_add x y := by
    obtain ⟨Nx, hNx⟩ := x.2
    obtain ⟨Ny, hNy⟩ := y.2
    have hxN : IsZeroBound P.space x.1 (max Nx Ny) :=
      fun j hj => hNx j (lt_of_le_of_lt (le_max_left Nx Ny) hj)
    have hyN : IsZeroBound P.space y.1 (max Nx Ny) :=
      fun j hj => hNy j (lt_of_le_of_lt (le_max_right Nx Ny) hj)
    have hxyN : IsZeroBound P.space (DirectSumOfFamily.add P.space x y).1 (max Nx Ny) := fun j hj => calc
      (DirectSumOfFamily.add P.space x y).1 j = (P.space j).add (x.1 j) (y.1 j) := rfl
      _ = (P.space j).add (P.space j).zero (P.space j).zero := by rw [hxN j hj, hyN j hj]
      _ = (P.space j).zero := (P.space j).add_zero _
    calc P.extension hP SA hf (DirectSumOfFamily.add P.space x y)
        = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 ((DirectSumOfFamily.add P.space x y).1 i.1)) :=
          P.extension_eq hP SA hf _ _ hxyN
      _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 ((P.space i.1).add (x.1 i.1) (y.1 i.1))) := rfl
      _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
            (fun i => SA.toComplexVectorSpace.add (P.extensionOnPower hP SA hf i.1 (x.1 i.1))
              (P.extensionOnPower hP SA hf i.1 (y.1 i.1))) :=
          sumOverFiniteSet_congr _ _ _ _ _ _
            (fun i => by rw [(P.extensionOnPower_isLinearMap hP SA hf i.1).map_add])
      _ = SA.toComplexVectorSpace.add
            (sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
              (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)))
            (sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
              (fun i => P.extensionOnPower hP SA hf i.1 (y.1 i.1))) :=
          (sumOverFiniteSet_add_of_same_coefficients _ _ _ _ _).symm
      _ = SA.toComplexVectorSpace.add (P.extension hP SA hf x) (P.extension hP SA hf y) := by
          rw [P.extension_eq hP SA hf x _ hxN, P.extension_eq hP SA hf y _ hyN]
  map_smul l x := by
    obtain ⟨N, hN⟩ := x.2
    have hlxN : IsZeroBound P.space (DirectSumOfFamily.smul P.space l x).1 N := fun j hj => calc
      (DirectSumOfFamily.smul P.space l x).1 j = (P.space j).smul l (x.1 j) := rfl
      _ = (P.space j).smul l (P.space j).zero := by rw [hN j hj]
      _ = (P.space j).zero := smul_zero_eq_zero _ l
    calc P.extension hP SA hf (DirectSumOfFamily.smul P.space l x)
        = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 ((DirectSumOfFamily.smul P.space l x).1 i.1)) :=
          P.extension_eq hP SA hf _ _ hlxN
      _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 ((P.space i.1).smul l (x.1 i.1))) := rfl
      _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => SA.toComplexVectorSpace.smul l (P.extensionOnPower hP SA hf i.1 (x.1 i.1))) :=
          sumOverFiniteSet_congr _ _ _ _ _ _
            (fun i => by rw [(P.extensionOnPower_isLinearMap hP SA hf i.1).map_smul])
      _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => 1 * l)
            (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) :=
          sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => (SA.toComplexVectorSpace.smul_assoc 1 l _).symm)
      _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => l * 1)
            (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) := by rw [mul_comm 1 l]
      _ = SA.toComplexVectorSpace.smul l (sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))) :=
          (smul_sumOverFiniteSet _ _ _ _ l).symm
      _ = SA.toComplexVectorSpace.smul l (P.extension hP SA hf x) := by rw [P.extension_eq hP SA hf x N hN]

/-- 本文 `claim_map_from_tensor_algebra_on_embedded_tensor`：F(emb_k(G)) = F_k(G)。零の境 k で F を開き、デルタで一項を取り出す。 -/
theorem extension_embedComponent (k : ℕ) (G : P.T k) :
    P.extension hP SA hf (embedComponent P.space k G) = P.extensionOnPower hP SA hf k G := by
  -- 1_ℂ ∗_A g_i = δ_{k,i} ∗_A g_i
  have hterm : ∀ i : UpTo k, SA.toComplexVectorSpace.smul 1
        (P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1))
      = SA.toComplexVectorSpace.smul (kroneckerDelta (⟨k, le_refl k⟩ : UpTo k) i)
        (P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1)) := by
    intro i
    by_cases hi : (⟨k, le_refl k⟩ : UpTo k) = i
    · rw [kroneckerDelta, if_pos hi]
    · have hik : i.1 ≠ k := fun h => hi (Subtype.ext h.symm)
      rw [kroneckerDelta, if_neg hi, embedComponent_of_ne P.space k G i.1 hik,
        (P.extensionOnPower_isLinearMap hP SA hf i.1).map_zero, smul_zero_eq_zero, smul_zero_eq_zero]
  calc P.extension hP SA hf (embedComponent P.space k G)
      = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo k) (fun _ => 1)
          (fun i => P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1)) :=
        P.extension_eq hP SA hf _ k (isZeroBound_embedComponent P.space k G)
    _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo k)
          (fun i => kroneckerDelta (⟨k, le_refl k⟩ : UpTo k) i)
          (fun i => P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = P.extensionOnPower hP SA hf k ((embedComponent P.space k G).1 k) :=
        sumOverFiniteSet_kroneckerDelta _ _ _ _
    _ = P.extensionOnPower hP SA hf k G := by rw [embedComponent_self]

/-- 本文 `claim_extension_on_tensor_powers_sends_product_of_tensors_to_product` の（組の像が二つのとき）。 -/
theorem extensionOnPower_tensorMul_tau_tau (k l : ℕ) (u : Tuple V k) (u' : Tuple V l) :
    P.extensionOnPower hP SA hf (k + l) (P.tensorMul k l (P.τ k u) (P.τ l u'))
      = SA.mul (P.extensionOnPower hP SA hf k (P.τ k u)) (P.extensionOnPower hP SA hf l (P.τ l u')) := by
  -- s ∈ {1,…,k} で f(c(s)) = f(u(s))
  have h1 : ∀ s : ℕ, 1 ≤ s → s ≤ k → valueFactors SA f (concatTuple u u') s = valueFactors SA f u s := by
    intro s hs1 hs2
    rw [valueFactors_of_le SA f _ s hs1 (by omega), valueFactors_of_le SA f _ s hs1 hs2,
      concatTuple_of_le u u' ⟨s, hs1, by omega⟩ hs2]
  -- t ∈ {1,…,l} で f(c(k+t)) = f(u'(t))
  have h2 : ∀ t : ℕ, 1 ≤ t → t ≤ l →
      (fun t => valueFactors SA f (concatTuple u u') (k + t)) t = valueFactors SA f u' t := by
    intro t ht1 ht2
    show valueFactors SA f (concatTuple u u') (k + t) = valueFactors SA f u' t
    rw [valueFactors_of_le SA f _ (k + t) (by omega) (by omega), valueFactors_of_le SA f _ t ht1 ht2,
      concatTuple_of_gt u u' ⟨k + t, by omega, by omega⟩ (by show k < k + t; omega)]
    have hidx : (⟨k + t - k, by omega, by omega⟩ : Idx l) = ⟨t, ht1, ht2⟩ := Subtype.ext (by show k + t - k = t; omega)
    rw [hidx]
  calc P.extensionOnPower hP SA hf (k + l) (P.tensorMul k l (P.τ k u) (P.τ l u'))
      = P.extensionOnPower hP SA hf (k + l) (P.τ (k + l) (concatTuple u u')) := by rw [P.tensorMul_tau_tau]
    _ = ComplexAlgebra.orderedProduct SA (k + l) (valueFactors SA f (concatTuple u u')) := P.extensionOnPower_tau hP SA hf _ _
    _ = SA.mul (ComplexAlgebra.orderedProduct SA k (valueFactors SA f (concatTuple u u')))
          (ComplexAlgebra.orderedProduct SA l (fun t => valueFactors SA f (concatTuple u u') (k + t))) :=
        ComplexAlgebra.orderedProduct_split SA k l _
    _ = SA.mul (ComplexAlgebra.orderedProduct SA k (valueFactors SA f u)) (ComplexAlgebra.orderedProduct SA l (valueFactors SA f u')) := by
        rw [ComplexAlgebra.orderedProduct_congr SA k _ _ h1, ComplexAlgebra.orderedProduct_congr SA l _ _ h2]
    _ = SA.mul (P.extensionOnPower hP SA hf k (P.τ k u)) (P.extensionOnPower hP SA hf l (P.τ l u')) := by
        rw [P.extensionOnPower_tau hP SA hf k u, P.extensionOnPower_tau hP SA hf l u']
        rfl

/-- 本文 `claim_extension_on_tensor_powers_sends_product_of_tensors_to_product` の（前が組の像のとき）。 -/
theorem extensionOnPower_tensorMul_tau_left (k l : ℕ) (u : Tuple V k) (H : P.T l) :
    P.extensionOnPower hP SA hf (k + l) (P.tensorMul k l (P.τ k u) H)
      = SA.mul (P.extensionOnPower hP SA hf k (P.τ k u)) (P.extensionOnPower hP SA hf l H) := by
  have heq : (fun H => P.extensionOnPower hP SA hf (k + l) (P.tensorMul k l (P.τ k u) H))
      = (fun H => SA.mul (P.extensionOnPower hP SA hf k (P.τ k u)) (P.extensionOnPower hP SA hf l H)) :=
    IsTensorProduct.linearMap_ext (hP l)
      ((P.tensorMul_right_isLinearMap k l _).comp (P.extensionOnPower_isLinearMap hP SA hf (k + l)))
      ((P.extensionOnPower_isLinearMap hP SA hf l).comp (leftMul_isLinearMap SA _))
      (fun u' => P.extensionOnPower_tensorMul_tau_tau hP SA hf k l u u')
  exact congrFun heq H

/-- 本文 `claim_extension_on_tensor_powers_sends_product_of_tensors_to_product`：F_{k+l}(m_{k,l}(G, H)) = F_k(G) ·_A F_l(H)。（一般のとき） -/
theorem extensionOnPower_tensorMul (k l : ℕ) (G : P.T k) (H : P.T l) :
    P.extensionOnPower hP SA hf (k + l) (P.tensorMul k l G H)
      = SA.mul (P.extensionOnPower hP SA hf k G) (P.extensionOnPower hP SA hf l H) := by
  have heq : (fun G => P.extensionOnPower hP SA hf (k + l) (P.tensorMul k l G H))
      = (fun G => SA.mul (P.extensionOnPower hP SA hf k G) (P.extensionOnPower hP SA hf l H)) :=
    IsTensorProduct.linearMap_ext (hP k)
      ((P.tensorMul_left_isLinearMap k l H).comp (P.extensionOnPower_isLinearMap hP SA hf (k + l)))
      ((P.extensionOnPower_isLinearMap hP SA hf k).comp (rightMul_isLinearMap SA _))
      (fun u => P.extensionOnPower_tensorMul_tau_left hP SA hf k l u H)
  exact congrFun heq G

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` の（乗法を保つこと）の一つ目の式：
F(a_i ⋆_D b_j) = F(a_i) ·_A F(b_j)（a_i := emb_i(X)、b_j := emb_j(Y)）。 -/
theorem extension_mul_embed_embed (i j : ℕ) (X : P.T i) (Y : P.T j) :
    P.extension hP SA hf (P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space j Y))
      = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf (embedComponent P.space j Y)) := calc
    P.extension hP SA hf (P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space j Y))
      = P.extension hP SA hf (embedComponent P.space (i + j) (P.tensorMul i j X Y)) := by
        rw [P.tensorAlgebraMul_embed]
    _ = P.extensionOnPower hP SA hf (i + j) (P.tensorMul i j X Y) := P.extension_embedComponent hP SA hf _ _
    _ = SA.mul (P.extensionOnPower hP SA hf i X) (P.extensionOnPower hP SA hf j Y) :=
        P.extensionOnPower_tensorMul hP SA hf i j X Y
    _ = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf (embedComponent P.space j Y)) := by
        rw [P.extension_embedComponent hP SA hf i X, P.extension_embedComponent hP SA hf j Y]

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` の（乗法を保つこと）の二つ目の式：
F(a_i ⋆_D y) = F(a_i) ·_A F(y)。 -/
theorem extension_mul_embed_left (i : ℕ) (X : P.T i) (y : DirectSumOfFamily P.space) :
    P.extension hP SA hf (P.tensorAlgebraMul (embedComponent P.space i X) y)
      = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf y) := by
  obtain ⟨Ny, hNy⟩ := y.2
  have hy := eq_sum_embedComponent P.space y Ny hNy
  set b : UpTo Ny → DirectSumOfFamily P.space := fun j => embedComponent P.space j.1 (y.1 j.1) with hb
  calc P.extension hP SA hf (P.tensorAlgebraMul (embedComponent P.space i X) y)
      = P.extension hP SA hf (P.tensorAlgebraMul (embedComponent P.space i X)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1) b)) := by
        rw [← hy]
    _ = P.extension hP SA hf (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.tensorAlgebraMul (embedComponent P.space i X) (b j))) := by
        rw [(P.tensorAlgebraMul_right_isLinearMap (embedComponent P.space i X)).map_sumOverFiniteSet]
    _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.extension hP SA hf (P.tensorAlgebraMul (embedComponent P.space i X) (b j))) :=
        (P.extension_isLinearMap hP SA hf).map_sumOverFiniteSet _ _ _
    _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf (b j))) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun j => by rw [P.extension_mul_embed_embed hP SA hf i j.1 X (y.1 j.1)])
    _ = SA.mul (P.extension hP SA hf (embedComponent P.space i X))
          (sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo Ny) (fun _ => 1)
            (fun j => P.extension hP SA hf (b j))) :=
        ((leftMul_isLinearMap SA _).map_sumOverFiniteSet _ _ _).symm
    _ = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1) b)) := by
        rw [(P.extension_isLinearMap hP SA hf).map_sumOverFiniteSet]
    _ = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf y) := by rw [← hy]

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` の（乗法を保つこと）：F(x ·_{T(V)} y) = F(x) ·_A F(y)。 -/
theorem extension_mul (x y : DirectSumOfFamily P.space) :
    P.extension hP SA hf (P.tensorAlgebraMul x y) = SA.mul (P.extension hP SA hf x) (P.extension hP SA hf y) := by
  obtain ⟨Nx, hNx⟩ := x.2
  have hx := eq_sum_embedComponent P.space x Nx hNx
  set a : UpTo Nx → DirectSumOfFamily P.space := fun i => embedComponent P.space i.1 (x.1 i.1) with ha
  calc P.extension hP SA hf (P.tensorAlgebraMul x y)
      = P.extension hP SA hf (P.tensorAlgebraMul
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nx) (fun _ => 1) a) y) := by
        rw [← hx]
    _ = P.extension hP SA hf (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.tensorAlgebraMul (a i) y)) := by
        rw [(P.tensorAlgebraMul_left_isLinearMap y).map_sumOverFiniteSet]
    _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.extension hP SA hf (P.tensorAlgebraMul (a i) y)) :=
        (P.extension_isLinearMap hP SA hf).map_sumOverFiniteSet _ _ _
    _ = sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => SA.mul (P.extension hP SA hf (a i)) (P.extension hP SA hf y)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => by rw [P.extension_mul_embed_left hP SA hf i.1 (x.1 i.1) y])
    _ = SA.mul (sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo Nx) (fun _ => 1)
            (fun i => P.extension hP SA hf (a i))) (P.extension hP SA hf y) :=
        ((rightMul_isLinearMap SA _).map_sumOverFiniteSet _ _ _).symm
    _ = SA.mul (P.extension hP SA hf
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nx) (fun _ => 1) a))
          (P.extension hP SA hf y) := by
        rw [(P.extension_isLinearMap hP SA hf).map_sumOverFiniteSet]
    _ = SA.mul (P.extension hP SA hf x) (P.extension hP SA hf y) := by rw [← hx]

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` の（乗法の単位元を保つこと）：F(1_{T(V)}) = 1_A。 -/
theorem extension_one : P.extension hP SA hf P.tensorAlgebraOne = SA.one := calc
    P.extension hP SA hf P.tensorAlgebraOne
      = P.extension hP SA hf (embedComponent P.space 0 (P.τ 0 (emptyTuple V))) := rfl
    _ = P.extensionOnPower hP SA hf 0 (P.τ 0 (emptyTuple V)) := P.extension_embedComponent hP SA hf _ _
    _ = orderedProductOfValues SA f 0 (emptyTuple V) := P.extensionOnPower_tau hP SA hf _ _
    _ = SA.one := orderedProductOfValues_emptyTuple SA f

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism`：F は T(V) から A への ℂ-代数の準同型である。 -/
theorem extension_isAlgebraHomomorphism :
    IsComplexAlgebraHomomorphism P.tensorAlgebra SA (P.extension hP SA hf) where
  isRingHomomorphism :=
    { map_add := (P.extension_isLinearMap hP SA hf).map_add
      map_mul := P.extension_mul hP SA hf
      map_one := P.extension_one hP SA hf }
  isLinearMap := P.extension_isLinearMap hP SA hf

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_composed_with_embedding`：F(ι(v)) = f(v)。 -/
theorem extension_embedVector (v : V) : P.extension hP SA hf (P.embedVector v) = f v := calc
    P.extension hP SA hf (P.embedVector v)
      = P.extension hP SA hf (embedComponent P.space 1 (P.τ 1 (oneElementTuple v))) := rfl
    _ = P.extensionOnPower hP SA hf 1 (P.τ 1 (oneElementTuple v)) := P.extension_embedComponent hP SA hf _ _
    _ = orderedProductOfValues SA f 1 (oneElementTuple v) := P.extensionOnPower_tau hP SA hf _ _
    _ = SA.mul SA.one (valueFactors SA f (oneElementTuple v) 1) := rfl
    _ = SA.mul SA.one (f (oneElementTuple v oneIdx)) := by
        rw [valueFactors_of_le SA f (oneElementTuple v) 1 (le_refl 1) (le_refl 1)]
        rfl
    _ = SA.mul SA.one (f v) := rfl
    _ = f v := SA.one_mul (f v)

end TensorPowers

/-- 本文 `claim_universal_property_of_tensor_algebra`：線型写像 f : V → U_vec(A) について、Φ ∘ ι = f を満たす
T(V) から A への ℂ-代数の準同型 Φ がただ一つ存在する。T(V) は座標による構成の族の上のテンソル代数である。
（存在）F は準同型で F ∘ ι = f。（一意性）ι(V) は T(V) を生成するので、生成元で一致する準同型は等しい。 -/
theorem universalProperty_of_tensorAlgebra (SV : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (SA : ComplexAlgebra A) (f : V → A)
    (hf : IsComplexLinearMap SV SA.toComplexVectorSpace f) :
    ∃ Φ : DirectSumOfFamily (coordinateTensorPowers SV n b hb).space → A,
      (IsComplexAlgebraHomomorphism (coordinateTensorPowers SV n b hb).tensorAlgebra SA Φ ∧
          ∀ v : V, Φ ((coordinateTensorPowers SV n b hb).embedVector v) = f v) ∧
        ∀ Φ' : DirectSumOfFamily (coordinateTensorPowers SV n b hb).space → A,
          (IsComplexAlgebraHomomorphism (coordinateTensorPowers SV n b hb).tensorAlgebra SA Φ' ∧
              ∀ v : V, Φ' ((coordinateTensorPowers SV n b hb).embedVector v) = f v) → Φ' = Φ := by
  set P := coordinateTensorPowers SV n b hb with hPdef
  have hP : ∀ k : ℕ, IsTensorProduct.{u, 0, w} SV k (P.space k) (P.τ k) :=
    fun k => coordinateTensor_isTensorProduct.{u, w} SV n b hb k
  refine ⟨P.extension hP SA hf, ⟨P.extension_isAlgebraHomomorphism hP SA hf, P.extension_embedVector hP SA hf⟩, ?_⟩
  rintro Φ' ⟨hΦ', hΦ'ι⟩
  funext a
  exact eq_of_agree_on_generators hΦ' (P.extension_isAlgebraHomomorphism hP SA hf)
    (Set.range P.embedVector) (coordinateTensorPowers_generates SV n b hb)
    (fun x ⟨v, hv⟩ => by rw [← hv, hΦ'ι v, P.extension_embedVector hP SA hf v]) a

end CliffordMatrixIsomorphism.ComplexVectorSpace
