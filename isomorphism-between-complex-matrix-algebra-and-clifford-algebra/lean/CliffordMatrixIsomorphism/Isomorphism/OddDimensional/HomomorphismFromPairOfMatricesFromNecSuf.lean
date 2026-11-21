/-
`Isomorphism/OddDimensional/HomomorphismFromPairOfMatrices.lean` の具体版の主張が、必要十分版の前半（名前空間
`NecSuf.AlgebraOver`）を K := ℂ、n := -1_ℂ、h := inverseOfTwo、A := Cl(V,q)・A' := Cl(V',q')・B := Mat_{P_M}(ℂ) を
ℂ の上の代数として読んだもの（`toNecSuf`）、e_± := D.idempotentPlus・D.idempotentMinus に特殊化して得られることを示す導出版。
具体版のファイルは必要十分版を引かない。

  具体版                                                         必要十分版の特殊化
  homomorphismFromPairOfMatrices                                 homomorphismFromPairOfMatrices_eq_necSuf（同じ式。rfl）
  homomorphismFromPairOfMatrices_isHom                           homomorphismFromPairOfMatrices_isHom_of_necSuf
  homomorphismToPairOfMatrices_idempotentPlus・…Minus             homomorphismToPairOfMatrices_idempotentPlus_of_necSuf・
                                                                 homomorphismToPairOfMatrices_idempotentMinus_of_necSuf
  homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices    homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices_of_necSuf
  homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices    homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices_of_necSuf
  oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras             oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras_of_necSuf
                                                                 （必要十分版の系の定理を T'・S' で引き戻す）

運び方:
- 必要十分版の前半は A・A'・B を任意の代数に替えて書いてあるので、具体版の Cl(V',q') と必要十分版の前提の組 `D.toNecSuf` の
  Cl(V',q') が別の集合であることに当たらない（`IdempotentsFromNecSuf.lean` と同じ）。具体版の A・A'・B を `toNecSuf` で
  K := ℂ の代数として読み、前半の主張にそのまま当てる。
- 前半が仮定に置く e_± の性質・Φ'(z)・Φ'(j(y))・Φ'(g)・Φ ∘ Ψ = id・Ψ ∘ Φ = id・ε ε = 1・γ'((v, t)) の分解・γ' が A' を
  生成することと、j・Ψ・Φ' が準同型であることは、引いた主張の導出版（`IdempotentsFromNecSuf.lean`・
  `HomomorphismToPairOfMatricesFromNecSuf.lean`・`CentralElementFromNecSuf.lean`・`ParityElementFromNecSuf.lean`・
  `OddExtensionFromNecSuf.lean`・`MutuallyInverseHomomorphismsFromNecSuf.lean`・`HomomorphismFromMatrixAlgebraFromNecSuf.lean`・
  `CliffordAlgebraFromNecSuf.lean`）から渡す。
- 系の定理は、必要十分版の系の定理を特殊化し、互いに逆な準同型 T'・S'（`oddTransport`）で引き戻す。具体版の Φ' は Φ'_N ∘ T'
  （存在と一意性の主張の一意性）、Ψ' は S' ∘ Ψ'_N（T' が j・Ψ・e_± を必要十分版の j_N・Ψ_N・e_{±,N} へ送ること）に等しい。
ℂ から渡す性質は、0 + 0 = 0、a · 0 = 0、1 + (-1) = 0、-(-1) = 1、a · (-1) = -a、h · (1 + 1) = 1 の `inverseOfTwo_mul` である。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.HomomorphismFromPairOfMatrices
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.IdempotentsFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphismsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.HomomorphismFromPairOfMatrices

-- 添字の再帰的な定義（2^M・個数 N_i(T)・整数の番号順の和など）は具体版と必要十分版に同じ式で別に置いてあり、
-- 変数での値は再帰の展開でしか一致しないので、このファイルでは smartUnfolding を切って定義どおりに展開させる。
set_option smartUnfolding false

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra`：具体版の Ψ' は、必要十分版の Ψ' を
K := ℂ、j := D.oddInclusionHom、Ψ := D.homomorphismFromMatrix、e_± := D.idempotentPlus・D.idempotentMinus に当てたものと同じ式である。 -/
theorem homomorphismFromPairOfMatrices_eq_necSuf (p : Mat (PowerSet D.M) × Mat (PowerSet D.M)) :
    D.homomorphismFromPairOfMatrices p
      = NecSuf.AlgebraOver.pairMapThroughIdempotents D.oddSpace.cliffordAlgebra.toNecSuf D.oddInclusionHom
          D.homomorphismFromMatrix D.idempotentPlus D.idempotentMinus p := rfl

/-- 本文 `claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism` を必要十分版から得る。 -/
theorem homomorphismFromPairOfMatrices_isHom_of_necSuf :
    IsComplexAlgebraHomomorphism D.pairOfMatricesAlgebra D.oddSpace.cliffordAlgebra D.homomorphismFromPairOfMatrices :=
  (isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2
    (NecSuf.AlgebraOver.pairMapThroughIdempotents_isHom (_root_.add_zero 0) D.space.cliffordAlgebra.toNecSuf
      D.oddSpace.cliffordAlgebra.toNecSuf D.matrixAlgebra.toNecSuf
      ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismFromMatrix_isHom_of_necSuf)
      ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.oddInclusionHom_isHom_of_necSuf)
      (D.idempotent_comm_of_necSuf 1) (D.idempotent_comm_of_necSuf (-1))
      D.idempotentPlus_mul_self_of_necSuf D.idempotentMinus_mul_self_of_necSuf
      D.idempotentPlus_mul_idempotentMinus_of_necSuf D.idempotentMinus_mul_idempotentPlus_of_necSuf
      D.idempotentPlus_add_idempotentMinus_of_necSuf)

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半
（Φ'(e_+) = (1_B, 0_B)）を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_idempotentPlus_of_necSuf :
    D.homomorphismToPairOfMatrices D.idempotentPlus = (D.matrixAlgebra.one, D.matrixAlgebra.zero) :=
  NecSuf.AlgebraOver.map_idempotentOfSquareRootOfOne_one (_root_.add_zero 0) mul_zero (add_neg_cancel 1)
    D.oddSpace.cliffordAlgebra.toNecSuf D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    D.homomorphismToPairOfMatrices_centralElement_of_necSuf (fun a => mul_neg_one a) inverseOfTwo inverseOfTwo_mul

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半
（Φ'(e_-) = (0_B, 1_B)）を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_idempotentMinus_of_necSuf :
    D.homomorphismToPairOfMatrices D.idempotentMinus = (D.matrixAlgebra.zero, D.matrixAlgebra.one) :=
  NecSuf.AlgebraOver.map_idempotentOfSquareRootOfOne_n (_root_.add_zero 0) mul_zero
    D.oddSpace.cliffordAlgebra.toNecSuf D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    (neg_neg 1) (add_neg_cancel 1)
    D.homomorphismToPairOfMatrices_centralElement_of_necSuf (fun a => mul_neg_one a) inverseOfTwo inverseOfTwo_mul

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices_of_necSuf (F G : Mat (PowerSet D.M)) :
    D.homomorphismToPairOfMatrices (D.homomorphismFromPairOfMatrices (F, G)) = (F, G) :=
  NecSuf.AlgebraOver.map_pairMapThroughIdempotents (_root_.add_zero 0) D.oddSpace.cliffordAlgebra.toNecSuf
    D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    D.homomorphismToPairOfMatrices_oddInclusionHom_of_necSuf D.homomorphismToMatrix_homomorphismFromMatrix_of_necSuf
    D.homomorphismToPairOfMatrices_idempotentPlus_of_necSuf D.homomorphismToPairOfMatrices_idempotentMinus_of_necSuf F G

/-- 本文 `claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity` を必要十分版から得る。 -/
theorem homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices_of_necSuf (a : D.oddSpace.Cl) :
    D.homomorphismFromPairOfMatrices (D.homomorphismToPairOfMatrices a) = a :=
  NecSuf.AlgebraOver.pairMapThroughIdempotents_map D.space.cliffordAlgebra.toNecSuf D.oddSpace.cliffordAlgebra.toNecSuf
    D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.oddInclusionHom_isHom_of_necSuf)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismFromMatrix_isHom_of_necSuf)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismFromPairOfMatrices_isHom_of_necSuf)
    D.homomorphismToPairOfMatrices_oddInclusionHom_of_necSuf D.homomorphismFromMatrix_homomorphismToMatrix_of_necSuf
    D.homomorphismToPairOfMatrices_addedGenerator_of_necSuf D.idempotentPlus_add_idempotentMinus_of_necSuf
    D.idempotentPlus_sub_idempotentMinus_of_necSuf rfl D.parityElement_mul_self_of_necSuf D.space.γ D.oddSpace.γ
    ((generatesAlgebra_iff_necSuf _ _).1 D.oddSpace.γ_generates_of_necSuf) D.oddSpace_γ_pair_of_necSuf a

/-! ### 系の定理：必要十分版の定理を T'・S' で引き戻す -/

/-- 必要十分版の Φ'（`D.toNecSuf` に ℂ の性質を渡したもの）。 -/
abbrev homomorphismToPairOfMatricesN :
    (D.toNecSuf.oddSpace complexCliffordLaws).Cl complexCliffordLaws → Mat (PowerSet D.M) × Mat (PowerSet D.M) :=
  D.toNecSuf.homomorphismToPairOfMatrices complexCliffordLaws add_neg_cancel

/-- 必要十分版の Ψ'（`D.toNecSuf` に ℂ の性質と h := inverseOfTwo を渡したもの）。 -/
abbrev homomorphismFromPairOfMatricesN :
    Mat (PowerSet D.M) × Mat (PowerSet D.M) → (D.toNecSuf.oddSpace complexCliffordLaws).Cl complexCliffordLaws :=
  D.toNecSuf.homomorphismFromPairOfMatrices complexCliffordLaws add_neg_cancel inverseOfTwo

/-- 具体版の Φ' は、必要十分版の Φ' に T' を先に当てたものである（存在と一意性の主張の一意性による）。 -/
theorem homomorphismToPairOfMatrices_eq_comp (a : D.oddSpace.Cl) :
    D.homomorphismToPairOfMatrices a = D.homomorphismToPairOfMatricesN (D.oddTransport.toCl a) := by
  let P := D.oddTransport
  obtain ⟨Θ, -, huniq⟩ := D.existsUnique_homomorphismToPairOfMatrices_of_necSuf
  have hN := D.toNecSuf.homomorphismToPairOfMatrices_isHom complexCliffordLaws add_neg_cancel
  rw [← D.pairOfMatricesAlgebra_toNecSuf] at hN
  have h1 : D.homomorphismToPairOfMatrices = Θ :=
    huniq _ ⟨D.homomorphismToPairOfMatrices_isHom_of_necSuf, D.homomorphismToPairOfMatrices_γ_of_necSuf⟩
  have h2 : (fun x => D.homomorphismToPairOfMatricesN (P.toCl x)) = Θ :=
    huniq _ ⟨IsComplexAlgebraHomomorphism.comp_of_necSuf P.toCl_isHom
        ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2 hN), fun x => by
      show D.homomorphismToPairOfMatricesN (P.toCl (D.oddSpace.γ x)) = D.mapToPairOfMatrices x
      rw [P.toCl_γ, D.mapToPairOfMatrices_eq_necSuf]
      exact D.toNecSuf.homomorphismToPairOfMatrices_γ complexCliffordLaws add_neg_cancel _⟩
  exact congrFun (h1.trans h2.symm) a

/-- T'(e_σ) = e_{σ,N}（T' は準同型で、T'(z) = z_N）。 -/
theorem oddToCl_idempotent (σ : ℂ) :
    D.oddTransport.toCl (D.idempotent σ) = D.toNecSuf.idempotent complexCliffordLaws add_neg_cancel inverseOfTwo σ := by
  have hT := D.oddTransport.toCl_isHom
  rw [idempotent, hT.map_smul, hT.map_add, hT.map_one, hT.map_smul, D.oddToCl_centralElement]
  rfl

/-- T'(Ψ'((F, G))) = Ψ'_N((F, G))。 -/
theorem oddToCl_homomorphismFromPairOfMatrices (p : Mat (PowerSet D.M) × Mat (PowerSet D.M)) :
    D.oddTransport.toCl (D.homomorphismFromPairOfMatrices p) = D.homomorphismFromPairOfMatricesN p := by
  have hT := D.oddTransport.toCl_isHom
  show D.oddTransport.toCl (D.oddSpace.cliffordAlgebra.add
      (D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.homomorphismFromMatrix p.1)) D.idempotentPlus)
      (D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.homomorphismFromMatrix p.2)) D.idempotentMinus)) = _
  rw [hT.map_add, hT.map_mul, hT.map_mul, D.oddToCl_oddInclusionHom, D.oddToCl_oddInclusionHom,
    toN_homomorphismFromMatrix D.splitTransport.toCl_isHom D.splitTransport.toCl_γ,
    toN_homomorphismFromMatrix D.splitTransport.toCl_isHom D.splitTransport.toCl_γ,
    show D.idempotentPlus = D.idempotent 1 from rfl, show D.idempotentMinus = D.idempotent (-1) from rfl,
    D.oddToCl_idempotent, D.oddToCl_idempotent]
  rfl

/-- 本文 `theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras` を、
必要十分版の系の定理を `D.toNecSuf`・ℂ の性質・h := inverseOfTwo に特殊化し、互いに逆な準同型 T'・S'（`oddTransport`）で
引き戻して得たもの。具体版の Φ' は Φ'_N ∘ T'、Ψ' は S' ∘ Ψ'_N に等しい。 -/
theorem oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras_of_necSuf :
    IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra D.homomorphismToPairOfMatrices ∧
      IsComplexAlgebraHomomorphism D.pairOfMatricesAlgebra D.oddSpace.cliffordAlgebra
        D.homomorphismFromPairOfMatrices ∧
      (∀ a : D.oddSpace.Cl, D.homomorphismFromPairOfMatrices (D.homomorphismToPairOfMatrices a) = a) ∧
      (∀ F G : Mat (PowerSet D.M), D.homomorphismToPairOfMatrices (D.homomorphismFromPairOfMatrices (F, G)) = (F, G)) ∧
      Function.Bijective D.homomorphismToPairOfMatrices ∧
      (∀ (F G : Mat (PowerSet D.M)) (a : D.oddSpace.Cl),
        D.homomorphismToPairOfMatrices a = (F, G) → a = D.homomorphismFromPairOfMatrices (F, G)) := by
  let P := D.oddTransport
  let ΦN := D.homomorphismToPairOfMatricesN
  let ΨN := D.homomorphismFromPairOfMatricesN
  obtain ⟨hΦN, hΨN, hΨΦN, hΦΨN, hbijN, hinvN⟩ :=
    D.toNecSuf.oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras complexCliffordLaws add_neg_cancel inverseOfTwo
      inverseOfTwo_mul
  rw [← D.pairOfMatricesAlgebra_toNecSuf] at hΦN hΨN
  have hΦeq : D.homomorphismToPairOfMatrices = fun a => ΦN (P.toCl a) := funext D.homomorphismToPairOfMatrices_eq_comp
  have hΨeq : D.homomorphismFromPairOfMatrices = fun p => P.ofCl (ΨN p) := funext fun p =>
    (P.ofCl_toCl _).symm.trans (congrArg P.ofCl (D.oddToCl_homomorphismFromPairOfMatrices p))
  rw [hΦeq, hΨeq]
  refine ⟨IsComplexAlgebraHomomorphism.comp_of_necSuf P.toCl_isHom
      ((isComplexAlgebraHomomorphism_iff_necSuf
        (QuadraticSpaceWithBasis.algebraOfNecSuf (D.toNecSuf.oddSpace complexCliffordLaws)) D.pairOfMatricesAlgebra ΦN).2 hΦN),
    IsComplexAlgebraHomomorphism.comp_of_necSuf
      ((isComplexAlgebraHomomorphism_iff_necSuf D.pairOfMatricesAlgebra
        (QuadraticSpaceWithBasis.algebraOfNecSuf (D.toNecSuf.oddSpace complexCliffordLaws)) ΨN).2 hΨN) P.ofCl_isHom,
    fun a => ?_, fun F G => ?_, ?_, fun F G a ha => ?_⟩
  · exact (congrArg P.ofCl (hΨΦN (P.toCl a))).trans (P.ofCl_toCl a)
  · exact (congrArg ΦN (P.toCl_ofCl (ΨN (F, G)))).trans (hΦΨN F G)
  · exact hbijN.comp P.toCl_bijective
  · exact (P.ofCl_toCl a).symm.trans (congrArg P.ofCl (hinvN F G (P.toCl a) ha))

end

end CliffordMatrixIsomorphism.Clifford.SplitData
