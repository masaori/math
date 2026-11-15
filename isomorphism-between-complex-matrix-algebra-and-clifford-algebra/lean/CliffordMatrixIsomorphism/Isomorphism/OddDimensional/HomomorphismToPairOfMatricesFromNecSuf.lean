/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、φ'・Φ' と Φ' ∘ j・Φ'(g) の具体版が、
必要十分版の K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。

  具体版                                              必要十分版の特殊化
  pairOfMatricesAlgebra                               pairOfMatricesAlgebra_toNecSuf
  mapToPairOfMatrices                                 mapToPairOfMatrices_eq_necSuf（必要十分版の φ' に点を写す写像を先に当てたもの）
  mapToPairOfMatrices_isLinearMap・_mul_self          …_of_necSuf
  existsUnique_homomorphismToPairOfMatrices           existsUnique_homomorphismToPairOfMatrices_of_necSuf
  homomorphismToPairOfMatrices_isHom・_γ              …_of_necSuf
  homomorphismToPairOfMatrices_oddInclusionHom        homomorphismToPairOfMatrices_oddInclusionHom_of_necSuf
  homomorphismToPairOfMatrices_addedGenerator         homomorphismToPairOfMatrices_addedGenerator_of_necSuf

運び方:
- 具体版の Cl(V,q) と必要十分版の前提 `D.toNecSuf` の Cl(V,q) は別の集合なので（`GeneratorsFromNecSuf.lean` の冒頭）、
  Φ ∘ γ = γ_N ∘（点を写す写像）を満たす準同型 T : Cl → Cl_N で運ぶ。具体版の Φ は Φ_N ∘ T に等しく
  （`homomorphismToMatrix_eq_comp`）、T(ε) = ε_N（`toN_parityElement`）なので、具体版の φ' は、必要十分版の φ' に
  V' の点を写す写像 (v, t) ↦ (v を写した点, t) を先に当てたものに等しい（`mapToPairOfMatrices_eq_necSuf`）。
  φ' が線型であることと値の平方は、これで必要十分版の主張から得る。
- Cl(V',q') も具体版と必要十分版で別の集合で、その間の準同型はこの節に置かない。Φ' の存在と一意性は、
  具体版と同じ手順を各段の導出版（普遍性の導出版と、上の二つ）から組み立てる（`OddExtensionFromNecSuf.lean` の j・g と同じ）。
- Φ'(j(a)) は、γ(v) の上では必要十分版の主張を a := γ_N(v を写した点) に当てた値に等しく、二つの準同型は γ(V) の上で
  一致するので等しい。Φ'(g) は、Φ'(g) = φ'(u) = φ'_N(u_N) = Φ'_N(g_N) と運んで必要十分版の主張を当てる。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws` と a + (-a) = 0 の `add_neg_cancel` だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.HomomorphismToPairOfMatrices
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.OddExtensionFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ParityElementFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ProductOfAlgebrasFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.HomomorphismToMatrixAlgebra.HomomorphismToMatrixAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.HomomorphismToPairOfMatrices

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### B × B と φ' の対応 -/

/-- 具体版の B × B を必要十分版の代数として読むと、必要十分版の前提 `D.toNecSuf` の B × B と同じ。 -/
theorem pairOfMatricesAlgebra_toNecSuf :
    D.pairOfMatricesAlgebra.toNecSuf = D.toNecSuf.pairOfMatricesAlgebra complexCliffordLaws := by
  rw [productAlgebra_toNecSuf, D.matrixAlgebra_toNecSuf]
  rfl

/-- V' の点を必要十分版の V' の点へ写す：(v, t) ↦ (v を写した点, t)。 -/
def oddPointToNecSuf (p : (W × DualSpace D.spaceW) × ℂ) : (W × NecSuf.VectorSpace.DualSpace D.spaceW.toNecSuf) × ℂ :=
  (splitPointToNecSuf D.spaceW p.1, p.2)

/-- 具体版の φ' は、必要十分版の φ' に V' の点を写す写像を先に当てたものと同じ。 -/
theorem mapToPairOfMatrices_eq_necSuf (p : (W × DualSpace D.spaceW) × ℂ) :
    D.mapToPairOfMatrices p
      = D.toNecSuf.mapToPairOfMatrices complexCliffordLaws add_neg_cancel (D.oddPointToNecSuf p) := by
  obtain ⟨T, hT, hTγ⟩ := D.exists_toN
  -- Φ = Φ_N ∘ T、T(γ(v)) = γ_N(v を写した点)、T(ε) = ε_N
  unfold mapToPairOfMatrices
  rw [D.homomorphismToMatrix_eq_comp hT hTγ (D.space.γ p.1), D.homomorphismToMatrix_eq_comp hT hTγ D.parityElement,
    hTγ p.1, toN_parityElement hT hTγ]
  -- B の演算を必要十分版の B の演算に替える
  exact congrArg (fun S : NecSuf.AlgebraOver ℂ (Mat (PowerSet D.M)) =>
    (S.add (D.homomorphismToMatrixN (D.mapToN p.1))
        (S.smul p.2 (D.homomorphismToMatrixN (D.toNecSuf.parityElement complexCliffordLaws))),
      S.add (D.homomorphismToMatrixN (D.mapToN p.1))
        (S.smul (-p.2) (D.homomorphismToMatrixN (D.toNecSuf.parityElement complexCliffordLaws)))))
    D.matrixAlgebra_toNecSuf

/-! ### 主張 -/

/-- 本文 `claim_map_from_odd_extension_to_pair_of_matrices_is_linear_map` を必要十分版から得る。 -/
theorem mapToPairOfMatrices_isLinearMap_of_necSuf :
    IsComplexLinearMap D.oddSpace.space D.pairOfMatricesAlgebra.toComplexVectorSpace D.mapToPairOfMatrices := by
  rw [isComplexLinearMap_iff_necSuf]
  have hN := D.toNecSuf.mapToPairOfMatrices_isLinearMap complexCliffordLaws add_neg_cancel
  have hpt : NecSuf.VectorSpace.IsLinearMap D.oddSpace.space.toNecSuf (D.toNecSuf.oddSpace complexCliffordLaws).space
      D.oddPointToNecSuf := ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  have h := NecSuf.VectorSpace.IsLinearMap.comp hpt hN
  have heq : D.mapToPairOfMatrices
      = fun p => D.toNecSuf.mapToPairOfMatrices complexCliffordLaws add_neg_cancel (D.oddPointToNecSuf p) :=
    funext D.mapToPairOfMatrices_eq_necSuf
  rw [heq, show D.pairOfMatricesAlgebra.toComplexVectorSpace.toNecSuf = D.pairOfMatricesAlgebra.toNecSuf.toVectorSpace
    from rfl, D.pairOfMatricesAlgebra_toNecSuf]
  exact h

/-- 本文 `claim_square_of_map_from_odd_extension_to_pair_of_matrices` を必要十分版から得る。 -/
theorem mapToPairOfMatrices_mul_self_of_necSuf (p : (W × DualSpace D.spaceW) × ℂ) :
    D.pairOfMatricesAlgebra.mul (D.mapToPairOfMatrices p) (D.mapToPairOfMatrices p)
      = D.pairOfMatricesAlgebra.smul (D.oddSpace.form p) D.pairOfMatricesAlgebra.one := by
  -- 必要十分版の主張の B × B を具体版の B × B に、φ'_N ∘（点を写す写像）を φ' に書き戻す
  have hN := D.toNecSuf.mapToPairOfMatrices_mul_self complexCliffordLaws add_neg_cancel (D.oddPointToNecSuf p)
  rw [← D.pairOfMatricesAlgebra_toNecSuf, ← D.mapToPairOfMatrices_eq_necSuf p] at hN
  exact hN

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras` を、
具体版と同じ手順で、普遍性の導出版と上の二つの導出版から得る。 -/
theorem existsUnique_homomorphismToPairOfMatrices_of_necSuf :
    ∃ Θ : D.oddSpace.Cl → Mat (PowerSet D.M) × Mat (PowerSet D.M),
      (IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra Θ ∧
        ∀ x, Θ (D.oddSpace.γ x) = D.mapToPairOfMatrices x) ∧
      ∀ Θ' : D.oddSpace.Cl → Mat (PowerSet D.M) × Mat (PowerSet D.M),
        (IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra Θ' ∧
          ∀ x, Θ' (D.oddSpace.γ x) = D.mapToPairOfMatrices x) → Θ' = Θ :=
  D.oddSpace.universalProperty_of_necSuf D.pairOfMatricesAlgebra D.mapToPairOfMatrices
    D.mapToPairOfMatrices_isLinearMap_of_necSuf D.mapToPairOfMatrices_mul_self_of_necSuf

/-- 本文 `def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras` の「Φ' は ℂ-代数の準同型」を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_isHom_of_necSuf :
    IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra D.homomorphismToPairOfMatrices :=
  (Classical.choose_spec D.existsUnique_homomorphismToPairOfMatrices_of_necSuf).1.1

/-- 本文 `def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras` の Φ' ∘ γ' = φ' を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_γ_of_necSuf (x : (W × DualSpace D.spaceW) × ℂ) :
    D.homomorphismToPairOfMatrices (D.oddSpace.γ x) = D.mapToPairOfMatrices x :=
  (Classical.choose_spec D.existsUnique_homomorphismToPairOfMatrices_of_necSuf).1.2 x

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism` を必要十分版から得る。
γ(v) の上では、必要十分版の主張を a := γ_N(v を写した点) に当てる。 -/
theorem homomorphismToPairOfMatrices_oddInclusionHom_of_necSuf (a : D.space.Cl) :
    D.homomorphismToPairOfMatrices (D.oddInclusionHom a) = (D.homomorphismToMatrix a, D.homomorphismToMatrix a) := by
  obtain ⟨T, hT, hTγ⟩ := D.exists_toN
  let Φ := D.homomorphismToMatrix
  let Φ' := D.homomorphismToPairOfMatrices
  have hΔ : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.pairOfMatricesAlgebra (pairMap Φ Φ) :=
    pairMap_isHom_of_necSuf D.homomorphismToMatrix_isHom_of_necSuf D.homomorphismToMatrix_isHom_of_necSuf
  have hcomp : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.pairOfMatricesAlgebra
      (fun x => Φ' (D.oddInclusionHom x)) :=
    IsComplexAlgebraHomomorphism.comp_of_necSuf D.oddInclusionHom_isHom_of_necSuf
      D.homomorphismToPairOfMatrices_isHom_of_necSuf
  have hγ : ∀ v : W × DualSpace D.spaceW, Φ' (D.oddInclusionHom (D.space.γ v)) = pairMap Φ Φ (D.space.γ v) := by
    intro v
    -- 具体版：Φ'(j(γ(v))) = φ'(in'_1(v))
    have e1 : D.homomorphismToPairOfMatrices (D.oddInclusionHom (D.space.γ v)) = D.mapToPairOfMatrices (D.oddInclusion v) := by
      rw [D.oddInclusionHom_γ_of_necSuf v, D.homomorphismToPairOfMatrices_γ_of_necSuf]
    -- 必要十分版：Φ'_N(γ'_N(in'_1(v を写した点))) = Φ'_N(j_N(γ_N(v を写した点))) = (Φ_N(γ_N(…)), Φ_N(γ_N(…)))
    have e2 := (D.toNecSuf.homomorphismToPairOfMatrices_γ complexCliffordLaws add_neg_cancel
      (D.oddPointToNecSuf (D.oddInclusion v))).symm.trans
      ((congrArg (D.toNecSuf.homomorphismToPairOfMatrices complexCliffordLaws add_neg_cancel)
        (D.toNecSuf.oddInclusionHom_γ complexCliffordLaws add_neg_cancel (splitPointToNecSuf D.spaceW v)).symm).trans
        (D.toNecSuf.homomorphismToPairOfMatrices_oddInclusionHom complexCliffordLaws add_neg_cancel
          (D.spaceN.γ complexCliffordLaws (splitPointToNecSuf D.spaceW v))))
    -- Φ(γ(v)) = Φ_N(T(γ(v))) = Φ_N(γ_N(v を写した点))
    have h1 : D.homomorphismToMatrix (D.space.γ v) = D.homomorphismToMatrixN (D.mapToN v) := by
      rw [D.homomorphismToMatrix_eq_comp hT hTγ, hTγ v]
    exact e1.trans ((D.mapToPairOfMatrices_eq_necSuf _).trans (e2.trans (congrArg (fun x => (x, x)) h1).symm))
  calc Φ' (D.oddInclusionHom a)
      = pairMap Φ Φ a :=
        eq_of_agree_on_generators_of_necSuf hcomp hΔ (Set.range D.space.γ) D.space.γ_generates_of_necSuf
          (fun _ ⟨v, hv⟩ => by rw [← hv]; exact hγ v) a
    _ = (Φ a, Φ a) := rfl

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_added_generator` を必要十分版から得る。
Φ'(g) = φ'(u) = φ'_N(u_N) = Φ'_N(g_N) と運び、必要十分版の主張（n := -1_ℂ）を当てる。 -/
theorem homomorphismToPairOfMatrices_addedGenerator_of_necSuf :
    D.homomorphismToPairOfMatrices D.addedGenerator
      = (D.homomorphismToMatrix D.parityElement,
          D.matrixAlgebra.smul (-1) (D.homomorphismToMatrix D.parityElement)) := by
  obtain ⟨T, hT, hTγ⟩ := D.exists_toN
  -- Φ'(g) = φ'(u)
  have e1 : D.homomorphismToPairOfMatrices D.addedGenerator = D.mapToPairOfMatrices D.addedUnitVector :=
    D.homomorphismToPairOfMatrices_γ_of_necSuf _
  -- 必要十分版：φ'_N(u_N) = Φ'_N(g_N) = (Φ_N(ε_N), (-1) ∗ Φ_N(ε_N))
  have e2 := (D.toNecSuf.homomorphismToPairOfMatrices_γ complexCliffordLaws add_neg_cancel
    (D.oddPointToNecSuf D.addedUnitVector)).symm.trans
    (D.toNecSuf.homomorphismToPairOfMatrices_addedGenerator complexCliffordLaws add_neg_cancel)
  -- Φ(ε) = Φ_N(T(ε)) = Φ_N(ε_N)
  have h1 : D.homomorphismToMatrix D.parityElement
      = D.homomorphismToMatrixN (D.toNecSuf.parityElement complexCliffordLaws) := by
    rw [D.homomorphismToMatrix_eq_comp hT hTγ, toN_parityElement hT hTγ]
  -- 必要十分版の B の演算を具体版の B の演算に戻す
  have h2 : ((D.homomorphismToMatrixN (D.toNecSuf.parityElement complexCliffordLaws),
        (D.toNecSuf.matrixAlgebra complexCliffordLaws).smul (-1)
          (D.homomorphismToMatrixN (D.toNecSuf.parityElement complexCliffordLaws)))
        : Mat (PowerSet D.M) × Mat (PowerSet D.M))
      = (D.homomorphismToMatrix D.parityElement,
          D.matrixAlgebra.smul (-1) (D.homomorphismToMatrix D.parityElement)) := by
    rw [← h1, ← D.matrixAlgebra_toNecSuf]
    rfl
  exact e1.trans ((D.mapToPairOfMatrices_eq_necSuf _).trans (e2.trans h2))

end

end CliffordMatrixIsomorphism.Clifford.SplitData
