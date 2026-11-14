/-
節「テンソル代数」のうち、線型写像 f : V → A がテンソル代数の上に定める準同型と、テンソル代数の普遍性の必要十分版。具体版
`MathematicalToolkit/TensorAlgebra/UniversalPropertyOfTensorAlgebra.lean` と同じ def と calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                                  このファイル                              K に要るもの
  def_ordered_product_of_values_of_linear_map_on_tuple                          valueFactors・orderedProductOfValues      なし
  claim_ordered_product_of_values_of_linear_map_on_tuple_is_multilinear         orderedProductOfValues_isMultilinear      なし
  def_linear_map_on_tensor_power_extending_linear_map                           TensorPowers.extensionOnPower             なし
  claim_sum_of_values_on_components_does_not_depend_on_zero_bound               TensorPowers.sum_extensionOnPower_eq_of_le 0 + 0 = 0、a · 0 = 0
  def_map_from_tensor_algebra_extending_linear_map                              TensorPowers.extension・extension_eq       定義はなし、零の境によらないことは上と同じ
  claim_map_from_tensor_algebra_extending_linear_map_is_linear_map              TensorPowers.extension_isLinearMap         0 + 0 = 0、a · 0 = 0、1 · λ = λ · 1（と D を線型空間にする 1 + n = 0）
  claim_map_from_tensor_algebra_on_embedded_tensor                              TensorPowers.extension_embedComponent      0 + 0 = 0、a · 0 = 0
  claim_extension_on_tensor_powers_sends_product_of_tensors_to_product          TensorPowers.extensionOnPower_tensorMul    乗法の交換法則（m_{k,l} を定めるため。証明の行は K を使わない）
  claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism    TensorPowers.extension_isAlgebraHomomorphism 乗法の交換法則、0 + 0 = 0、a · 0 = 0、1 + n = 0
  claim_map_from_tensor_algebra_extending_linear_map_composed_with_embedding    TensorPowers.extension_embedVector         0 + 0 = 0、a · 0 = 0
  claim_universal_property_of_tensor_algebra                                    universalProperty_of_tensorAlgebra         座標の構成の性質と乗法の交換法則、1 + ν = 0

μ^f_k が k 重線型であることと F_k を定めることは K の性質を使わない（番号順の積の二つの主張は K を使わない）。
F が線型写像であることでは、和の係数 1 · λ を λ · 1 へ替える行に 1 と λ の交換だけが要る（全体の交換法則は要らない）。
A は任意の宇宙の型で、族が A の宇宙について k 重テンソル積であること hP を引数に取る。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.EmbeddingAndGeneration
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Homomorphisms

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v w uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {V : Type u} {A : Type w}

open AlgebraOver
omit [Zero K] in
/-- 本文 `def_ordered_product_of_values_of_linear_map_on_tuple` の因子：s ∈ {1,…,k} に f(u(s)) を与える族（{1,…,k} の外の値 1_A は使わない）。 -/
def valueFactors (SA : AlgebraOver K A) (f : V → A) {k : ℕ} (u : Tuple V k) : ℕ → A :=
  extendFamily (fun s : Idx k => f (u s)) SA.one

omit [Zero K] in
theorem valueFactors_of_le (SA : AlgebraOver K A) (f : V → A) {k : ℕ} (u : Tuple V k) (s : ℕ)
    (h1 : 1 ≤ s) (h2 : s ≤ k) : valueFactors SA f u s = f (u ⟨s, h1, h2⟩) :=
  extendFamily_of_le _ SA.one s h1 h2

/-- 本文 `def_ordered_product_of_values_of_linear_map_on_tuple`：μ^f_k(u) := ∏_{A,s=1}^{k} f(u(s))。 -/
def orderedProductOfValues (SA : AlgebraOver K A) (f : V → A) (k : ℕ) (u : Tuple V k) : A :=
  AlgebraOver.orderedProduct SA k (valueFactors SA f u)

omit [Zero K] in
/-- 本文 `def_ordered_product_of_values_of_linear_map_on_tuple`：μ^f_0(ε_V) = 1_A。 -/
theorem orderedProductOfValues_emptyTuple (SA : AlgebraOver K A) (f : V → A) :
    orderedProductOfValues SA f 0 (emptyTuple V) = SA.one := rfl

omit [Zero K] in
/-- 本文 `claim_ordered_product_of_values_of_linear_map_on_tuple_is_multilinear`：μ^f_k は V から U_vec(A) への k 重線型写像である。
w_s・w'_s・w''_s・w'''_s は s ≠ r で f(u(s)) に等しく、s = r で w_r = w'_r +_A w''_r、w'''_r = λ ∗_A w'_r を満たすので、
番号順の積の二つの主張を当てる。 -/
theorem orderedProductOfValues_isMultilinear {SV : VectorSpace K V} (SA : AlgebraOver K A) {f : V → A}
    (hf : IsLinearMap SV SA.toVectorSpace f) (k : ℕ) :
    IsMultilinearMap SV SA.toVectorSpace k (orderedProductOfValues SA f k) where
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
    exact AlgebraOver.orderedProduct_add_in_one_factor SA k r.1 r.2.1 r.2.2 _ _ _ hne hr
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
    exact AlgebraOver.orderedProduct_smul_in_one_factor SA k r.1 r.2.1 r.2.2 l _ _ hne hr

omit [Zero K] in
/-- x の零の境 k：emb_k(y) は第 k 成分より先が零である。 -/
theorem isZeroBound_embedComponent {E : ℕ → Type v} (S : ∀ j : ℕ, VectorSpace K (E j)) (k : ℕ) (y : E k) :
    IsZeroBound S (embedComponent S k y).1 k :=
  fun j hj => embedComponent_of_ne S k y j (Nat.ne_of_gt hj)

namespace TensorPowers

variable {SV : VectorSpace K V} (P : TensorPowers.{u, v} SV)
  (hP : ∀ k : ℕ, IsTensorProduct.{u, v, w, uK} SV k (P.space k) (P.τ k))
  (SA : AlgebraOver K A) {f : V → A} (hf : IsLinearMap SV SA.toVectorSpace f)

/-- 本文 `def_linear_map_on_tensor_power_extending_linear_map`：(T_k, τ_k) の普遍性を U = U_vec(A)、h = μ^f_k に当てた線型写像 F_k。 -/
noncomputable def extensionOnPower (k : ℕ) : P.T k → A :=
  Classical.choose ((hP k).universal A SA.toVectorSpace (orderedProductOfValues SA f k)
    (orderedProductOfValues_isMultilinear SA hf k))

omit [Zero K] in
theorem extensionOnPower_spec (k : ℕ) :
    (IsLinearMap (P.space k) SA.toVectorSpace (P.extensionOnPower hP SA hf k) ∧
        ∀ u : Tuple V k, P.extensionOnPower hP SA hf k (P.τ k u) = orderedProductOfValues SA f k u) ∧
      ∀ g : P.T k → A, (IsLinearMap (P.space k) SA.toVectorSpace g ∧
          ∀ u : Tuple V k, g (P.τ k u) = orderedProductOfValues SA f k u) → g = P.extensionOnPower hP SA hf k :=
  Classical.choose_spec ((hP k).universal A SA.toVectorSpace (orderedProductOfValues SA f k)
    (orderedProductOfValues_isMultilinear SA hf k))

omit [Zero K] in
/-- 本文 `def_linear_map_on_tensor_power_extending_linear_map`：F_k は T_k から U_vec(A) への線型写像である。 -/
theorem extensionOnPower_isLinearMap (k : ℕ) :
    IsLinearMap (P.space k) SA.toVectorSpace (P.extensionOnPower hP SA hf k) :=
  (P.extensionOnPower_spec hP SA hf k).1.1

omit [Zero K] in
/-- 本文 `def_linear_map_on_tensor_power_extending_linear_map`：F_k(τ_k(u)) = μ^f_k(u)。 -/
theorem extensionOnPower_tau (k : ℕ) (u : Tuple V k) :
    P.extensionOnPower hP SA hf k (P.τ k u) = orderedProductOfValues SA f k u :=
  (P.extensionOnPower_spec hP SA hf k).1.2 u

/-- 本文 `claim_sum_of_values_on_components_does_not_depend_on_zero_bound`：
N ≤ N' なら Σ_{i∈{0,…,N'}} 1_K ∗_A F_i(x_i) = Σ_{i∈{0,…,N}} 1_K ∗_A F_i(x_i)。
d := N' - N、g_s := F_{s-1}(x_{s-1}) と置き、線型結合を前の N + 1 項と後ろの d 項に分ける。 -/
theorem sum_extensionOnPower_eq_of_le (L : ScalarMultipleOfZeroLaws K) (x : DirectSumOfFamily P.space) (N N' : ℕ)
    (hN : IsZeroBound P.space x.1 N) (hNN' : N ≤ N') :
    sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N') (fun _ => 1)
        (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))
      = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) := by
  obtain ⟨d, rfl⟩ : ∃ d : ℕ, N' = N + d := ⟨N' - N, by omega⟩
  -- g_s := F_{s-1}(x_{s-1})
  set g : ℕ → A := fun s => P.extensionOnPower hP SA hf (s - 1) (x.1 (s - 1)) with hg
  -- 番号付け (M + 1, e) で和を開く
  have hopen : ∀ M : ℕ, sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo M) (fun _ => 1)
        (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))
      = linearCombination SA.toVectorSpace (M + 1) (fun _ => 1) g := by
    intro M
    rw [sumOverFiniteSet_eq SA.toVectorSpace _ _ _ (M + 1) (upToNumbering M) (upToNumbering_isNumbering M)]
    apply linearCombination_eq_of_terms_eq
    intro s h1 h2
    rw [numberedFamily_of_le _ _ _ s h1 h2, numberedFamily_of_le _ _ _ s h1 h2]
    rfl
  -- t ∈ {1,…,d} で 1_K ∗_A g_{N+1+t} = 0_A（x_{N+t} = 0_{T_{N+t}}）
  have htail : ∀ t : Idx d, SA.toVectorSpace.smul ((fun _ => (1 : K)) t.1) ((fun j => g (N + 1 + j)) t.1)
      = SA.toVectorSpace.zero := by
    intro t
    have hx0 : x.1 (N + 1 + t.1 - 1) = (P.space (N + 1 + t.1 - 1)).zero := hN _ (by have := t.2.1; omega)
    calc SA.toVectorSpace.smul 1 (g (N + 1 + t.1))
        = SA.toVectorSpace.smul 1
            (P.extensionOnPower hP SA hf (N + 1 + t.1 - 1) (x.1 (N + 1 + t.1 - 1))) := rfl
      _ = SA.toVectorSpace.smul 1
            (P.extensionOnPower hP SA hf (N + 1 + t.1 - 1) (P.space (N + 1 + t.1 - 1)).zero) := by rw [hx0]
      _ = SA.toVectorSpace.smul 1 SA.toVectorSpace.zero := by
          rw [(P.extensionOnPower_isLinearMap hP SA hf _).map_zero L.zero_add_zero]
      _ = SA.toVectorSpace.zero := smul_zero_eq_zero _ L.zero_add_zero L.mul_zero 1
  calc sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo (N + d)) (fun _ => 1)
        (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))
      = linearCombination SA.toVectorSpace (N + d + 1) (fun _ => 1) g := hopen (N + d)
    _ = linearCombination SA.toVectorSpace ((N + 1) + d) (fun _ => 1) g := by
        rw [show N + d + 1 = N + 1 + d by omega]
    _ = SA.toVectorSpace.add (linearCombination SA.toVectorSpace (N + 1) (fun _ => 1) g)
          (linearCombination SA.toVectorSpace d (fun _ => 1) (fun j => g (N + 1 + j))) :=
        linearCombination_split SA.toVectorSpace (N + 1) d g (fun _ => 1)
    _ = SA.toVectorSpace.add (linearCombination SA.toVectorSpace (N + 1) (fun _ => 1) g)
          (sumOverFiniteSet SA.toVectorSpace (isFiniteSet_idx d) (fun t => (fun _ => (1 : K)) t.1)
            (fun t => (fun j => g (N + 1 + j)) t.1)) := by
        rw [sumOverFiniteSet_idx SA.toVectorSpace d (fun _ => 1) (fun j => g (N + 1 + j))]
    _ = SA.toVectorSpace.add (linearCombination SA.toVectorSpace (N + 1) (fun _ => 1) g)
          SA.toVectorSpace.zero := by
        rw [sumOverFiniteSet_eq_zero_of_terms_eq_zero _ L.zero_add_zero L.mul_zero _ _ _ htail]
    _ = linearCombination SA.toVectorSpace (N + 1) (fun _ => 1) g := SA.toVectorSpace.add_zero _
    _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) := (hopen N).symm

/-- 本文 `def_map_from_tensor_algebra_extending_linear_map`：F(x) := Σ_{i∈{0,…,N}} 1_K ∗_A F_i(x_i)（N は x の零の境）。 -/
noncomputable def extension (x : DirectSumOfFamily P.space) : A :=
  sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo (Classical.choose x.2)) (fun _ => 1)
    (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))

/-- 本文 `def_map_from_tensor_algebra_extending_linear_map`：右辺は零の境 N の取り方によらない
（本文は `claim_sum_of_values_on_components_does_not_depend_on_zero_bound` を引く）。 -/
theorem extension_eq (L : ScalarMultipleOfZeroLaws K) (x : DirectSumOfFamily P.space) (N : ℕ) (hN : IsZeroBound P.space x.1 N) :
    P.extension hP SA hf x
      = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) := by
  have hN0 : IsZeroBound P.space x.1 (Classical.choose x.2) := Classical.choose_spec x.2
  rcases le_total (Classical.choose x.2) N with h | h
  · exact (P.sum_extensionOnPower_eq_of_le hP SA hf L x _ N hN0 h).symm
  · exact P.sum_extensionOnPower_eq_of_le hP SA hf L x N _ hN h

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_linear_map`：F は (D, +_D, ∗_D, 0_D) から U_vec(A) への線型写像である。
N を x と y の零の境の大きい方にとる。 -/
theorem extension_isLinearMap (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (h1comm : ∀ l : K, 1 * l = l * 1) :
    IsLinearMap (directSumOfFamilyVectorSpace P.space L n h1n) SA.toVectorSpace (P.extension hP SA hf) where
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
        = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 ((DirectSumOfFamily.add P.space x y).1 i.1)) :=
          P.extension_eq hP SA hf L _ _ hxyN
      _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 ((P.space i.1).add (x.1 i.1) (y.1 i.1))) := rfl
      _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
            (fun i => SA.toVectorSpace.add (P.extensionOnPower hP SA hf i.1 (x.1 i.1))
              (P.extensionOnPower hP SA hf i.1 (y.1 i.1))) :=
          sumOverFiniteSet_congr _ _ _ _ _ _
            (fun i => by rw [(P.extensionOnPower_isLinearMap hP SA hf i.1).map_add])
      _ = SA.toVectorSpace.add
            (sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
              (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)))
            (sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo (max Nx Ny)) (fun _ => 1)
              (fun i => P.extensionOnPower hP SA hf i.1 (y.1 i.1))) :=
          (sumOverFiniteSet_add_of_same_coefficients _ _ _ _ _).symm
      _ = SA.toVectorSpace.add (P.extension hP SA hf x) (P.extension hP SA hf y) := by
          rw [P.extension_eq hP SA hf L x _ hxN, P.extension_eq hP SA hf L y _ hyN]
  map_smul l x := by
    obtain ⟨N, hN⟩ := x.2
    have hlxN : IsZeroBound P.space (DirectSumOfFamily.smul P.space L l x).1 N := fun j hj => calc
      (DirectSumOfFamily.smul P.space L l x).1 j = (P.space j).smul l (x.1 j) := rfl
      _ = (P.space j).smul l (P.space j).zero := by rw [hN j hj]
      _ = (P.space j).zero := smul_zero_eq_zero _ L.zero_add_zero L.mul_zero l
    calc P.extension hP SA hf (DirectSumOfFamily.smul P.space L l x)
        = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 ((DirectSumOfFamily.smul P.space L l x).1 i.1)) :=
          P.extension_eq hP SA hf L _ _ hlxN
      _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 ((P.space i.1).smul l (x.1 i.1))) := rfl
      _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => SA.toVectorSpace.smul l (P.extensionOnPower hP SA hf i.1 (x.1 i.1))) :=
          sumOverFiniteSet_congr _ _ _ _ _ _
            (fun i => by rw [(P.extensionOnPower_isLinearMap hP SA hf i.1).map_smul])
      _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => 1 * l)
            (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) :=
          sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => (SA.toVectorSpace.smul_assoc 1 l _).symm)
      _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => l * 1)
            (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) := by rw [h1comm l]
      _ = SA.toVectorSpace.smul l (sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => P.extensionOnPower hP SA hf i.1 (x.1 i.1))) :=
          (smul_sumOverFiniteSet _ L.zero_add_zero L.mul_zero _ _ _ l).symm
      _ = SA.toVectorSpace.smul l (P.extension hP SA hf x) := by rw [P.extension_eq hP SA hf L x N hN]

/-- 本文 `claim_map_from_tensor_algebra_on_embedded_tensor`：F(emb_k(G)) = F_k(G)。零の境 k で F を開き、デルタで一項を取り出す。 -/
theorem extension_embedComponent (L : ScalarMultipleOfZeroLaws K) (k : ℕ) (G : P.T k) :
    P.extension hP SA hf (embedComponent P.space k G) = P.extensionOnPower hP SA hf k G := by
  -- 1_K ∗_A g_i = δ_{k,i} ∗_A g_i
  have hterm : ∀ i : UpTo k, SA.toVectorSpace.smul 1
        (P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1))
      = SA.toVectorSpace.smul (kroneckerDelta (⟨k, le_refl k⟩ : UpTo k) i)
        (P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1)) := by
    intro i
    by_cases hi : (⟨k, le_refl k⟩ : UpTo k) = i
    · rw [kroneckerDelta, if_pos hi]
    · have hik : i.1 ≠ k := fun h => hi (Subtype.ext h.symm)
      -- g_i = F_i(x_i) = F_i(0_{T_i}) = 0_A（i ≠ k）
      have hg : P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1)
          = SA.toVectorSpace.zero := calc
        P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1)
            = P.extensionOnPower hP SA hf i.1 (P.space i.1).zero := by
              rw [embedComponent_of_ne P.space k G i.1 hik]
        _ = SA.toVectorSpace.zero := (P.extensionOnPower_isLinearMap hP SA hf i.1).map_zero L.zero_add_zero
      rw [kroneckerDelta, if_neg hi, hg, smul_zero_eq_zero _ L.zero_add_zero L.mul_zero,
        smul_zero_eq_zero _ L.zero_add_zero L.mul_zero]
  calc P.extension hP SA hf (embedComponent P.space k G)
      = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo k) (fun _ => 1)
          (fun i => P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1)) :=
        P.extension_eq hP SA hf L _ k (isZeroBound_embedComponent P.space k G)
    _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo k)
          (fun i => kroneckerDelta (⟨k, le_refl k⟩ : UpTo k) i)
          (fun i => P.extensionOnPower hP SA hf i.1 ((embedComponent P.space k G).1 i.1)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = P.extensionOnPower hP SA hf k ((embedComponent P.space k G).1 k) :=
        sumOverFiniteSet_kroneckerDelta _ L.zero_add_zero _ _ _
    _ = P.extensionOnPower hP SA hf k G := by rw [embedComponent_self]

omit [Zero K] in
/-- 本文 `claim_extension_on_tensor_powers_sends_product_of_tensors_to_product` の（組の像が二つのとき）。 -/
theorem extensionOnPower_tensorMul_tau_tau (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (u : Tuple V k) (u' : Tuple V l) :
    P.extensionOnPower hP SA hf (k + l) (P.tensorMul hcomm k l (P.τ k u) (P.τ l u'))
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
  calc P.extensionOnPower hP SA hf (k + l) (P.tensorMul hcomm k l (P.τ k u) (P.τ l u'))
      = P.extensionOnPower hP SA hf (k + l) (P.τ (k + l) (concatTuple u u')) := by rw [P.tensorMul_tau_tau hcomm]
    _ = AlgebraOver.orderedProduct SA (k + l) (valueFactors SA f (concatTuple u u')) := P.extensionOnPower_tau hP SA hf _ _
    _ = SA.mul (AlgebraOver.orderedProduct SA k (valueFactors SA f (concatTuple u u')))
          (AlgebraOver.orderedProduct SA l (fun t => valueFactors SA f (concatTuple u u') (k + t))) :=
        AlgebraOver.orderedProduct_split SA k l _
    _ = SA.mul (AlgebraOver.orderedProduct SA k (valueFactors SA f u)) (AlgebraOver.orderedProduct SA l (valueFactors SA f u')) := by
        rw [AlgebraOver.orderedProduct_congr SA k _ _ h1, AlgebraOver.orderedProduct_congr SA l _ _ h2]
    _ = SA.mul (P.extensionOnPower hP SA hf k (P.τ k u)) (P.extensionOnPower hP SA hf l (P.τ l u')) := by
        rw [P.extensionOnPower_tau hP SA hf k u, P.extensionOnPower_tau hP SA hf l u']
        rfl

omit [Zero K] in
/-- 本文 `claim_extension_on_tensor_powers_sends_product_of_tensors_to_product` の（前が組の像のとき）。 -/
theorem extensionOnPower_tensorMul_tau_left (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (u : Tuple V k) (H : P.T l) :
    P.extensionOnPower hP SA hf (k + l) (P.tensorMul hcomm k l (P.τ k u) H)
      = SA.mul (P.extensionOnPower hP SA hf k (P.τ k u)) (P.extensionOnPower hP SA hf l H) := by
  have heq : (fun H => P.extensionOnPower hP SA hf (k + l) (P.tensorMul hcomm k l (P.τ k u) H))
      = (fun H => SA.mul (P.extensionOnPower hP SA hf k (P.τ k u)) (P.extensionOnPower hP SA hf l H)) :=
    IsTensorProduct.linearMap_ext (hP l)
      ((P.tensorMul_right_isLinearMap hcomm k l _).comp (P.extensionOnPower_isLinearMap hP SA hf (k + l)))
      ((P.extensionOnPower_isLinearMap hP SA hf l).comp (leftMul_isLinearMap SA _))
      (fun u' => P.extensionOnPower_tensorMul_tau_tau hP SA hf hcomm k l u u')
  exact congrFun heq H

omit [Zero K] in
/-- 本文 `claim_extension_on_tensor_powers_sends_product_of_tensors_to_product`：F_{k+l}(m_{k,l}(G, H)) = F_k(G) ·_A F_l(H)。（一般のとき） -/
theorem extensionOnPower_tensorMul (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (G : P.T k) (H : P.T l) :
    P.extensionOnPower hP SA hf (k + l) (P.tensorMul hcomm k l G H)
      = SA.mul (P.extensionOnPower hP SA hf k G) (P.extensionOnPower hP SA hf l H) := by
  have heq : (fun G => P.extensionOnPower hP SA hf (k + l) (P.tensorMul hcomm k l G H))
      = (fun G => SA.mul (P.extensionOnPower hP SA hf k G) (P.extensionOnPower hP SA hf l H)) :=
    IsTensorProduct.linearMap_ext (hP k)
      ((P.tensorMul_left_isLinearMap hcomm k l H).comp (P.extensionOnPower_isLinearMap hP SA hf (k + l)))
      ((P.extensionOnPower_isLinearMap hP SA hf k).comp (rightMul_isLinearMap SA _))
      (fun u => P.extensionOnPower_tensorMul_tau_left hP SA hf hcomm k l u H)
  exact congrFun heq G

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` の（乗法を保つこと）の一つ目の式：
F(a_i ⋆_D b_j) = F(a_i) ·_A F(b_j)（a_i := emb_i(X)、b_j := emb_j(Y)）。 -/
theorem extension_mul_embed_embed (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (i j : ℕ) (X : P.T i) (Y : P.T j) :
    P.extension hP SA hf (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space j Y))
      = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf (embedComponent P.space j Y)) := calc
    P.extension hP SA hf (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space j Y))
      = P.extension hP SA hf (embedComponent P.space (i + j) (P.tensorMul hcomm i j X Y)) := by
        rw [P.tensorAlgebraMul_embed hcomm L]
    _ = P.extensionOnPower hP SA hf (i + j) (P.tensorMul hcomm i j X Y) := P.extension_embedComponent hP SA hf L _ _
    _ = SA.mul (P.extensionOnPower hP SA hf i X) (P.extensionOnPower hP SA hf j Y) :=
        P.extensionOnPower_tensorMul hP SA hf hcomm i j X Y
    _ = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf (embedComponent P.space j Y)) := by
        rw [P.extension_embedComponent hP SA hf L i X, P.extension_embedComponent hP SA hf L j Y]

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` の（乗法を保つこと）の二つ目の式：
F(a_i ⋆_D y) = F(a_i) ·_A F(y)。 -/
theorem extension_mul_embed_left (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (i : ℕ) (X : P.T i) (y : DirectSumOfFamily P.space) :
    P.extension hP SA hf (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) y)
      = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf y) := by
  obtain ⟨Ny, hNy⟩ := y.2
  have hy := eq_sum_embedComponent P.space L n h1n y Ny hNy
  set b : UpTo Ny → DirectSumOfFamily P.space := fun j => embedComponent P.space j.1 (y.1 j.1) with hb
  calc P.extension hP SA hf (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) y)
      = P.extension hP SA hf (P.tensorAlgebraMul hcomm L (embedComponent P.space i X)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1) b)) := by
        rw [← hy]
    _ = P.extension hP SA hf (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (b j))) := by
        rw [(P.tensorAlgebraMul_right_isLinearMap hcomm L n h1n (embedComponent P.space i X)).map_sumOverFiniteSet L.zero_add_zero]
    _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.extension hP SA hf (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (b j))) :=
        (P.extension_isLinearMap hP SA hf L n h1n (fun l => hcomm 1 l)).map_sumOverFiniteSet L.zero_add_zero _ _ _
    _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf (b j))) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun j => by rw [P.extension_mul_embed_embed hP SA hf hcomm L i j.1 X (y.1 j.1)])
    _ = SA.mul (P.extension hP SA hf (embedComponent P.space i X))
          (sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo Ny) (fun _ => 1)
            (fun j => P.extension hP SA hf (b j))) :=
        ((leftMul_isLinearMap SA _).map_sumOverFiniteSet L.zero_add_zero _ _ _).symm
    _ = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1) b)) := by
        rw [(P.extension_isLinearMap hP SA hf L n h1n (fun l => hcomm 1 l)).map_sumOverFiniteSet L.zero_add_zero]
    _ = SA.mul (P.extension hP SA hf (embedComponent P.space i X)) (P.extension hP SA hf y) := by rw [← hy]

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` の（乗法を保つこと）：F(x ·_{T(V)} y) = F(x) ·_A F(y)。 -/
theorem extension_mul (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (x y : DirectSumOfFamily P.space) :
    P.extension hP SA hf (P.tensorAlgebraMul hcomm L x y) = SA.mul (P.extension hP SA hf x) (P.extension hP SA hf y) := by
  obtain ⟨Nx, hNx⟩ := x.2
  have hx := eq_sum_embedComponent P.space L n h1n x Nx hNx
  set a : UpTo Nx → DirectSumOfFamily P.space := fun i => embedComponent P.space i.1 (x.1 i.1) with ha
  calc P.extension hP SA hf (P.tensorAlgebraMul hcomm L x y)
      = P.extension hP SA hf (P.tensorAlgebraMul hcomm L
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nx) (fun _ => 1) a) y) := by
        rw [← hx]
    _ = P.extension hP SA hf (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.tensorAlgebraMul hcomm L (a i) y)) := by
        rw [(P.tensorAlgebraMul_left_isLinearMap hcomm L n h1n y).map_sumOverFiniteSet L.zero_add_zero]
    _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.extension hP SA hf (P.tensorAlgebraMul hcomm L (a i) y)) :=
        (P.extension_isLinearMap hP SA hf L n h1n (fun l => hcomm 1 l)).map_sumOverFiniteSet L.zero_add_zero _ _ _
    _ = sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => SA.mul (P.extension hP SA hf (a i)) (P.extension hP SA hf y)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => by rw [P.extension_mul_embed_left hP SA hf hcomm L n h1n i.1 (x.1 i.1) y])
    _ = SA.mul (sumOverFiniteSet SA.toVectorSpace (isFiniteSet_upTo Nx) (fun _ => 1)
            (fun i => P.extension hP SA hf (a i))) (P.extension hP SA hf y) :=
        ((rightMul_isLinearMap SA _).map_sumOverFiniteSet L.zero_add_zero _ _ _).symm
    _ = SA.mul (P.extension hP SA hf
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nx) (fun _ => 1) a))
          (P.extension hP SA hf y) := by
        rw [(P.extension_isLinearMap hP SA hf L n h1n (fun l => hcomm 1 l)).map_sumOverFiniteSet L.zero_add_zero]
    _ = SA.mul (P.extension hP SA hf x) (P.extension hP SA hf y) := by rw [← hx]

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` の（乗法の単位元を保つこと）：F(1_{T(V)}) = 1_A。 -/
theorem extension_one (L : ScalarMultipleOfZeroLaws K) : P.extension hP SA hf P.tensorAlgebraOne = SA.one := calc
    P.extension hP SA hf P.tensorAlgebraOne
      = P.extension hP SA hf (embedComponent P.space 0 (P.τ 0 (emptyTuple V))) := rfl
    _ = P.extensionOnPower hP SA hf 0 (P.τ 0 (emptyTuple V)) := P.extension_embedComponent hP SA hf L _ _
    _ = orderedProductOfValues SA f 0 (emptyTuple V) := P.extensionOnPower_tau hP SA hf _ _
    _ = SA.one := orderedProductOfValues_emptyTuple SA f

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism`：F は T(V) から A への K-代数の準同型である。 -/
theorem extension_isAlgebraHomomorphism (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) :
    IsAlgebraHomomorphism (P.tensorAlgebra hcomm L n h1n) SA (P.extension hP SA hf) where
  isRingHomomorphism :=
    { map_add := (P.extension_isLinearMap hP SA hf L n h1n (fun l => hcomm 1 l)).map_add
      map_mul := P.extension_mul hP SA hf hcomm L n h1n
      map_one := P.extension_one hP SA hf L }
  isLinearMap := P.extension_isLinearMap hP SA hf L n h1n (fun l => hcomm 1 l)

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_composed_with_embedding`：F(ι(v)) = f(v)。 -/
theorem extension_embedVector (L : ScalarMultipleOfZeroLaws K) (v : V) : P.extension hP SA hf (P.embedVector v) = f v := calc
    P.extension hP SA hf (P.embedVector v)
      = P.extension hP SA hf (embedComponent P.space 1 (P.τ 1 (oneElementTuple v))) := rfl
    _ = P.extensionOnPower hP SA hf 1 (P.τ 1 (oneElementTuple v)) := P.extension_embedComponent hP SA hf L _ _
    _ = orderedProductOfValues SA f 1 (oneElementTuple v) := P.extensionOnPower_tau hP SA hf _ _
    _ = SA.mul SA.one (valueFactors SA f (oneElementTuple v) 1) := rfl
    _ = SA.mul SA.one (f (oneElementTuple v oneIdx)) := by
        rw [valueFactors_of_le SA f (oneElementTuple v) 1 (le_refl 1) (le_refl 1)]
        rfl
    _ = SA.mul SA.one (f v) := rfl
    _ = f v := SA.one_mul (f v)

end TensorPowers

/-- 本文 `claim_universal_property_of_tensor_algebra`：線型写像 f : V → U_vec(A) について、Φ ∘ ι = f を満たす
T(V) から A への K-代数の準同型 Φ がただ一つ存在する。T(V) は座標による構成の族の上のテンソル代数である。
（存在）F は準同型で F ∘ ι = f。（一意性）ι(V) は T(V) を生成するので、生成元で一致する準同型は等しい。
0 + 0 = 0 と a · 0 = 0 は UniquenessLaws の add_zero 0 と mul_zero から作る。基底の長さ n と区別するため、1 + ν = 0 の ν と書く。 -/
theorem universalProperty_of_tensorAlgebra (LV : ValuedMapsLaws K) (UL : UniquenessLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (ν : K) (h1ν : 1 + ν = 0) (SV : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) (SA : AlgebraOver K A) (f : V → A)
    (hf : IsLinearMap SV SA.toVectorSpace f) :
    ∃ Φ : DirectSumOfFamily (coordinateTensorPowers LV UL hcomm SV n b hb).space → A,
      (IsAlgebraHomomorphism ((coordinateTensorPowers LV UL hcomm SV n b hb).tensorAlgebra hcomm
            ⟨UL.add_zero 0, UL.mul_zero⟩ ν h1ν) SA Φ ∧
          ∀ v : V, Φ ((coordinateTensorPowers LV UL hcomm SV n b hb).embedVector v) = f v) ∧
        ∀ Φ' : DirectSumOfFamily (coordinateTensorPowers LV UL hcomm SV n b hb).space → A,
          (IsAlgebraHomomorphism ((coordinateTensorPowers LV UL hcomm SV n b hb).tensorAlgebra hcomm
                ⟨UL.add_zero 0, UL.mul_zero⟩ ν h1ν) SA Φ' ∧
              ∀ v : V, Φ' ((coordinateTensorPowers LV UL hcomm SV n b hb).embedVector v) = f v) → Φ' = Φ := by
  set P := coordinateTensorPowers LV UL hcomm SV n b hb with hPdef
  set L : ScalarMultipleOfZeroLaws K := ⟨UL.add_zero 0, UL.mul_zero⟩ with hL
  have hP : ∀ k : ℕ, IsTensorProduct.{u, uK, w, uK} SV k (P.space k) (P.τ k) :=
    fun k => coordinateTensor_isTensorProduct LV UL hcomm SV n b hb k
  refine ⟨P.extension hP SA hf, ⟨P.extension_isAlgebraHomomorphism hP SA hf hcomm L ν h1ν,
    P.extension_embedVector hP SA hf L⟩, ?_⟩
  rintro Φ' ⟨hΦ', hΦ'ι⟩
  funext a
  exact eq_of_agree_on_generators hΦ' (P.extension_isAlgebraHomomorphism hP SA hf hcomm L ν h1ν)
    (Set.range P.embedVector) (coordinateTensorPowers_generates LV UL hcomm L ν h1ν SV n b hb)
    (fun x ⟨v, hv⟩ => by rw [← hv, hΦ'ι v, P.extension_embedVector hP SA hf L v]) a

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
