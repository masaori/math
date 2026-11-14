/-
章「同型の証明」の節「クリフォード代数から行列環への準同型」の具体版が、必要十分版のこの節の主張の
K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。
このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質を渡して示す。

  具体版                                     必要十分版の特殊化
  creationMatrix_mul_self                    creationMatrix_mul_self_of_necSuf
  annihilationMatrix_mul_self                annihilationMatrix_mul_self_of_necSuf
  creationFamily・annihilationFamily         creationFamily_eq_necSuf・annihilationFamily_eq_necSuf（成分を `creationMatrix_eq_necSuf` で移す）
  kroneckerDelta_idx_eq_swap                 kroneckerDelta_idx_eq_swap_of_necSuf
  matrixAlgebra                              matrixAlgebra_toNecSuf（`matricesComplexAlgebra_toNecSuf`）
  creationPart・annihilationPart・
  matrixValuedMap                            creationPart_eq_necSuf・annihilationPart_eq_necSuf・matrixValuedMap_eq_necSuf
                                             （座標の写像は 1,…,M の番号で `coordinate_eq_necSuf` により一致する）
  matrixValuedMap_isLinearMap                matrixValuedMap_isLinearMap_of_necSuf
  matrixValuedMap_mul_self                   matrixValuedMap_mul_self_of_necSuf
  existsUnique_homomorphismToMatrix          existsUnique_homomorphismToMatrix_of_necSuf
  homomorphismToMatrix_isHom・
  homomorphismToMatrix_γ                     homomorphismToMatrix_isHom_of_necSuf・homomorphismToMatrix_γ_of_necSuf
  homomorphismToMatrix_creation              homomorphismToMatrix_creation_of_necSuf
  homomorphismToMatrix_annihilation          homomorphismToMatrix_annihilation_of_necSuf

クリフォード代数は、具体版の Cl と必要十分版の前提 `D.toNecSuf` の Cl' が別の集合である（`GeneratorsFromNecSuf.lean` の冒頭）。
そこで、具体版の普遍性から得る準同型 Φ : Cl → Cl'（Φ ∘ γ = γ' ∘（点を写す写像））と、必要十分版の主張の準同型
Φ' : Cl' → Mat_{P_M}(ℂ) の合成 Φ' ∘ Φ を作る。
  - Φ' ∘ Φ は準同型で、Φ' ∘ Φ ∘ γ = Φ' ∘ γ' ∘（点を写す写像）= φ' ∘（点を写す写像）= φ（必要十分版の Φ' ∘ γ' = φ'）。
    これで具体版の存在を得る。一意性は、γ(V) が生成することから、γ の上で一致する準同型が等しいことによる。
  - 具体版の Φ は Φ' ∘ Φ に等しいので、Φ(a†_i) = Φ'(Φ(a†_i)) = Φ'(a'†_i) = c_i（必要十分版の主張）。Φ(a_i) も同じ。
ℂ から渡す性質は、`complexValuedMapsLaws`、a · 1 = a の `mul_one`、a · 0 = 0 の `mul_zero`、0 · a = 0 の `zero_mul`、
章「クリフォード代数」の仮定の組 `complexCliffordLaws`、a + (-a) = 0 の `add_neg_cancel` である。
-/
import CliffordMatrixIsomorphism.Isomorphism.HomomorphismToMatrixAlgebra.HomomorphismToMatrixAlgebra
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CreationMatricesFromNecSuf
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.GeneratorsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.HomomorphismToMatrixAlgebra.HomomorphismToMatrixAlgebra

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 生成作用素の行列・消滅作用素の行列の自分自身との積 -/

/-- 本文 `claim_square_of_creation_operator_matrix_is_zero` を必要十分版から得る。 -/
theorem creationMatrix_mul_self_of_necSuf {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) :
    Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (creationMatrix M i hi) = Mat.zero := by
  rw [Mat.mul_eq_necSuf, creationMatrix_eq_necSuf]
  exact NecSuf.Isomorphism.creationMatrix_mul_self complexValuedMapsLaws mul_one mul_zero zero_mul (-1 : ℂ) hi

/-- 本文 `claim_square_of_annihilation_operator_matrix_is_zero` を必要十分版から得る。 -/
theorem annihilationMatrix_mul_self_of_necSuf {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) :
    Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M i hi) (annihilationMatrix M i hi) = Mat.zero := by
  rw [Mat.mul_eq_necSuf, annihilationMatrix_eq_necSuf]
  exact NecSuf.Isomorphism.annihilationMatrix_mul_self complexValuedMapsLaws mul_one mul_zero zero_mul (-1 : ℂ) hi

/-! ### 族の対応 -/

/-- 本文 `def_matrix_valued_map_on_split_quadratic_space` の族 k ↦ c_k は、必要十分版の族の n := -1_ℂ の場合と同じ。 -/
theorem creationFamily_eq_necSuf (M : ℕ) : creationFamily M = NecSuf.Isomorphism.creationFamily (-1 : ℂ) M := by
  funext k
  unfold creationFamily NecSuf.Isomorphism.creationFamily
  split_ifs with hk
  · exact creationMatrix_eq_necSuf M k hk
  · rfl

/-- 本文 `def_matrix_valued_map_on_split_quadratic_space` の族 k ↦ c_k^T は、必要十分版の族の n := -1_ℂ の場合と同じ。 -/
theorem annihilationFamily_eq_necSuf (M : ℕ) :
    annihilationFamily M = NecSuf.Isomorphism.annihilationFamily (-1 : ℂ) M := by
  funext k
  unfold annihilationFamily NecSuf.Isomorphism.annihilationFamily
  split_ifs with hk
  · exact annihilationMatrix_eq_necSuf M k hk
  · rfl

/-- 本文の「k = l と l = k は同値なので δ の定義」を必要十分版から得る。 -/
theorem kroneckerDelta_idx_eq_swap_of_necSuf {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M) (hl : 1 ≤ l ∧ l ≤ M) :
    kroneckerDelta (⟨k, hk⟩ : Idx M) (⟨l, hl⟩ : Idx M) = kroneckerDelta l k :=
  NecSuf.Isomorphism.kroneckerDelta_idx_eq_swap (K := ℂ) hk hl

end CliffordMatrixIsomorphism.Isomorphism

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### 行列環と φ の対応 -/

/-- 具体版の Mat_{P_M}(ℂ) の ℂ-代数を必要十分版の代数として読むと、必要十分版の前提 `D.toNecSuf` の行列環と同じ。 -/
theorem matrixAlgebra_toNecSuf : D.matrixAlgebra.toNecSuf = D.toNecSuf.matrixAlgebra complexCliffordLaws :=
  matricesComplexAlgebra_toNecSuf (isFiniteSet_powerSet D.M)

/-- 具体版の C(y) は、必要十分版の C(y) と同じ。 -/
theorem creationPart_eq_necSuf (y : W) : D.creationPart y = D.toNecSuf.creationPart complexCliffordLaws y := by
  unfold creationPart NecSuf.Clifford.SplitData.creationPart
  rw [linearCombination_eq_necSuf, creationFamily_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_eq_of_terms_eq _ D.M _ _ _ _ fun k hk1 hkM => by
    rw [coordinate_eq_necSuf D.spaceW D.M D.w D.isBasis k hk1 hkM y]
    rfl

/-- 具体版の D(h) は、必要十分版の D(h) と同じ。 -/
theorem annihilationPart_eq_necSuf (h : DualSpace D.spaceW) :
    D.annihilationPart h = D.toNecSuf.annihilationPart complexCliffordLaws h.toNecSuf := by
  unfold annihilationPart NecSuf.Clifford.SplitData.annihilationPart
  rw [linearCombination_eq_necSuf, annihilationFamily_eq_necSuf]
  rfl

/-- 具体版の φ は、必要十分版の φ に点を写す写像を先に当てたものと同じ。 -/
theorem matrixValuedMap_eq_necSuf (p : W × DualSpace D.spaceW) :
    D.matrixValuedMap p = D.toNecSuf.matrixValuedMap complexCliffordLaws (splitPointToNecSuf D.spaceW p) := by
  unfold matrixValuedMap NecSuf.Clifford.SplitData.matrixValuedMap
  rw [creationPart_eq_necSuf, annihilationPart_eq_necSuf]
  rfl

/-! ### 主張 -/

/-- 本文 `claim_matrix_valued_map_on_split_quadratic_space_is_linear_map` を必要十分版から得る。 -/
theorem matrixValuedMap_isLinearMap_of_necSuf :
    IsComplexLinearMap D.space.space D.matrixAlgebra.toComplexVectorSpace D.matrixValuedMap := by
  rw [isComplexLinearMap_iff_necSuf]
  have hN := D.toNecSuf.matrixValuedMap_isLinearMap complexCliffordLaws
  have hpt : NecSuf.VectorSpace.IsLinearMap D.space.space.toNecSuf D.spaceN.space (splitPointToNecSuf D.spaceW) :=
    ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  have h := NecSuf.VectorSpace.IsLinearMap.comp hpt hN
  have heq : D.matrixValuedMap
      = fun p => D.toNecSuf.matrixValuedMap complexCliffordLaws (splitPointToNecSuf D.spaceW p) :=
    funext D.matrixValuedMap_eq_necSuf
  rw [heq]
  exact h

/-- 本文 `claim_square_of_matrix_valued_map_on_split_quadratic_space` を必要十分版から得る。 -/
theorem matrixValuedMap_mul_self_of_necSuf (p : W × DualSpace D.spaceW) :
    D.matrixAlgebra.mul (D.matrixValuedMap p) (D.matrixValuedMap p)
      = D.matrixAlgebra.smul (D.space.form p) D.matrixAlgebra.one := by
  -- 必要十分版の主張の行列環を具体版の行列環に、φ' ∘（点を写す写像）を φ に書き戻す
  have hN := D.toNecSuf.matrixValuedMap_mul_self complexCliffordLaws (splitPointToNecSuf D.spaceW p)
  rw [← D.matrixAlgebra_toNecSuf, ← D.matrixValuedMap_eq_necSuf p] at hN
  exact hN

/-- 必要十分版の前提 `D.toNecSuf` の Φ'（必要十分版の主張に ℂ の性質を渡して得たもの）。 -/
abbrev homomorphismToMatrixN : D.spaceN.Cl complexCliffordLaws → Mat (PowerSet D.M) :=
  D.toNecSuf.homomorphismToMatrix complexCliffordLaws add_neg_cancel

/-- Cl から Cl' への準同型 Φ と Φ' の合成 Φ' ∘ Φ は、Cl から Mat_{P_M}(ℂ) への ℂ-代数の準同型である。 -/
theorem comp_toN_isHom {Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws}
    (hΦ : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.algebraN Φ) :
    IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra (fun x => D.homomorphismToMatrixN (Φ x)) := by
  rw [isComplexAlgebraHomomorphism_iff_necSuf, D.matrixAlgebra_toNecSuf]
  exact NecSuf.AlgebraOver.IsAlgebraHomomorphism.comp ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 hΦ)
    (D.toNecSuf.homomorphismToMatrix_isHom complexCliffordLaws add_neg_cancel)

/-- Φ ∘ γ = γ' ∘（点を写す写像）なら、Φ' ∘ Φ ∘ γ = φ。 -/
theorem comp_toN_γ {Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws}
    (hΦγ : ∀ p, Φ (D.space.γ p) = D.mapToN p) (v : W × DualSpace D.spaceW) :
    D.homomorphismToMatrixN (Φ (D.space.γ v)) = D.matrixValuedMap v := by
  -- Φ'(Φ(γ(v))) = Φ'(γ'(v を写した点)) = φ'(v を写した点) = φ(v)
  rw [hΦγ v, D.matrixValuedMap_eq_necSuf v]
  exact D.toNecSuf.homomorphismToMatrix_γ complexCliffordLaws add_neg_cancel _

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra` を必要十分版から得る。
存在は Φ' ∘ Φ、一意性は γ(V) が生成することによる。 -/
theorem existsUnique_homomorphismToMatrix_of_necSuf :
    ∃ Φ : D.space.Cl → Mat (PowerSet D.M),
      (IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra Φ ∧
        ∀ v, Φ (D.space.γ v) = D.matrixValuedMap v) ∧
      ∀ Φ' : D.space.Cl → Mat (PowerSet D.M),
        (IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra Φ' ∧
          ∀ v, Φ' (D.space.γ v) = D.matrixValuedMap v) → Φ' = Φ := by
  obtain ⟨Φ, hΦ, hΦγ⟩ := D.exists_toN
  refine ⟨fun x => D.homomorphismToMatrixN (Φ x), ⟨D.comp_toN_isHom hΦ, D.comp_toN_γ hΦγ⟩, ?_⟩
  rintro Φ' ⟨hΦ', hΦ'γ⟩
  funext x
  exact eq_of_agree_on_generators_of_necSuf hΦ' (D.comp_toN_isHom hΦ) (Set.range D.space.γ)
    D.space.γ_generates_of_necSuf (fun _ ⟨v, hv⟩ => by rw [← hv, hΦ'γ v, D.comp_toN_γ hΦγ v]) x

/-- 本文 `def_homomorphism_from_clifford_algebra_to_matrix_algebra` の「Φ は ℂ-代数の準同型」を必要十分版から得る。 -/
theorem homomorphismToMatrix_isHom_of_necSuf :
    IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra D.homomorphismToMatrix :=
  (Classical.choose_spec D.existsUnique_homomorphismToMatrix_of_necSuf).1.1

/-- 本文 `def_homomorphism_from_clifford_algebra_to_matrix_algebra` の Φ ∘ γ = φ を必要十分版から得る。 -/
theorem homomorphismToMatrix_γ_of_necSuf (v : W × DualSpace D.spaceW) :
    D.homomorphismToMatrix (D.space.γ v) = D.matrixValuedMap v :=
  (Classical.choose_spec D.existsUnique_homomorphismToMatrix_of_necSuf).1.2 v

/-- 具体版の Φ は Φ' ∘ Φ に等しい（存在と一意性の主張の一意性による）。 -/
theorem homomorphismToMatrix_eq_comp {Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws}
    (hΦ : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.algebraN Φ)
    (hΦγ : ∀ p, Φ (D.space.γ p) = D.mapToN p) (x : D.space.Cl) :
    D.homomorphismToMatrix x = D.homomorphismToMatrixN (Φ x) :=
  (congrFun ((Classical.choose_spec D.existsUnique_homomorphismToMatrix_of_necSuf).2
    (fun x => D.homomorphismToMatrixN (Φ x)) ⟨D.comp_toN_isHom hΦ, D.comp_toN_γ hΦγ⟩) x).symm

/-- 本文 `claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix` を必要十分版から得る。 -/
theorem homomorphismToMatrix_creation_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismToMatrix (D.creation i) = creationMatrix D.M i hi := by
  obtain ⟨Φ, hΦ, hΦγ⟩ := D.exists_toN
  -- Φ(a†_i) = Φ'(Φ(a†_i)) = Φ'(a'†_i) = c_i
  rw [D.homomorphismToMatrix_eq_comp hΦ hΦγ, creationMatrix_eq_necSuf,
    show D.creation i = D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i)) from rfl, hΦγ]
  exact D.toNecSuf.homomorphismToMatrix_creation complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix` を必要十分版から得る。 -/
theorem homomorphismToMatrix_annihilation_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismToMatrix (D.annihilation i) = annihilationMatrix D.M i hi := by
  obtain ⟨Φ, hΦ, hΦγ⟩ := D.exists_toN
  -- Φ(a_i) = Φ'(Φ(a_i)) = Φ'(a'_i) = c_i^T
  rw [D.homomorphismToMatrix_eq_comp hΦ hΦγ, annihilationMatrix_eq_necSuf,
    show D.annihilation i = D.space.γ (embedSecond D.spaceW (D.f i)) from rfl, hΦγ]
  exact D.toNecSuf.homomorphismToMatrix_annihilation complexCliffordLaws add_neg_cancel hi

end

end CliffordMatrixIsomorphism.Clifford.SplitData
