/-
章「クリフォード代数」の具体版が、必要十分版の K := ℂ、n := -1_ℂ への特殊化として得られることを示す導出版。
具体版のファイルは必要十分版を引かない。このファイルだけが両方を引く。

  具体版                                        必要十分版との対応
  QuadraticSpaceWithBasis                       toNecSuf（「q は二次形式」の欄を落とす）
  TA・ι・ideal                                  TA_toNecSuf・ι_eq_necSuf・ideal_eq_necSuf
  各主張                                        …_of_necSuf

ℂ の性質は `complexCliffordLaws`（座標による構成の性質・乗法の交換法則・合同の性質）と、a + (-a) = 0 に `add_neg_cancel` を渡す。

具体版の T(V) を K := ℂ の代数として読んだもの（`Q.TA.toNecSuf`）は必要十分版の T(V) に等しいが、
二つは別々に `Classical.choose` で選んだテンソルの積を持つので、等号は定義による一致ではなく命題である。
I_q も同じく、具体版と必要十分版で両側イデアルの定義の structure が違うので、集合の等号は命題である。
クリフォード代数の集合 T(V)/I_q は T(V) と I_q に依存するので、必要十分版の主張をそのまま具体版の主張として読めない。
そこで各主張の必要十分版を、T(V) の代数の構造 S、埋め込み ι、両側イデアル I を変数にした形に書き直し
（S・ι・I が必要十分版のものに等しいなら主張が成り立つ。変数を必要十分版のものに置き換えれば、必要十分版の主張そのもの）、
その変数に具体版のものを入れる。具体版の演算は必要十分版の演算と定義により一致する
（`quotientMul_eq_necSuf` などの rfl）ので、置いた形は具体版の主張と定義により一致する。

節「分裂した二次空間のクリフォード代数の生成元」の導出は `SplitQuadraticSpace/GeneratorsFromNecSuf.lean` に置く。
-/
import CliffordMatrixIsomorphism.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebra
import CliffordMatrixIsomorphism.MathematicalToolkit.QuadraticForm.QuadraticFormFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.TensorAlgebraStructureFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.IdealAndQuotientAlgebra.IdealAndQuotientAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebra

namespace CliffordMatrixIsomorphism.Clifford

open ComplexVectorSpace ComplexAlgebra

universe u w

/-- ℂ と n := -1_ℂ が満たす、必要十分版のクリフォード代数の章の仮定。 -/
theorem complexCliffordLaws : NecSuf.Clifford.CliffordLaws ℂ (-1) where
  valuedMaps := complexValuedMapsLaws
  uniqueness := complexUniquenessLaws
  mul_comm := mul_comm
  congruence := complexCongruenceLaws

namespace QuadraticSpaceWithBasis

variable {V : Type u} (Q : QuadraticSpaceWithBasis V)

/-- 具体版の前提の組を、必要十分版の前提の組として読む（「q は二次形式」の欄を落とす）。 -/
def toNecSuf : NecSuf.Clifford.QuadraticSpaceWithBasis ℂ V where
  space := Q.space.toNecSuf
  dim := Q.dim
  basis := Q.basis
  isBasis := (isBasisFamily_iff_necSuf Q.space Q.dim Q.basis).1 Q.isBasis
  form := Q.form

/-- 族の T_j と線型空間の構造が同じで τ が等しい二つの族は、同じテンソル代数を与える。 -/
theorem tensorAlgebra_mk_congr (SV : NecSuf.VectorSpace ℂ V) (T : ℕ → Type)
    (sp : ∀ j : ℕ, NecSuf.VectorSpace ℂ (T j))
    (τ₁ τ₂ : ∀ j : ℕ, NecSuf.VectorSpace.Tuple V j → T j) (hτ : τ₁ = τ₂)
    (i₁ : ∀ j : ℕ, NecSuf.VectorSpace.IsTensorProduct.{u, 0, 0, 0} SV j (sp j) (τ₁ j))
    (i₂ : ∀ j : ℕ, NecSuf.VectorSpace.IsTensorProduct.{u, 0, 0, 0} SV j (sp j) (τ₂ j)) :
    (NecSuf.VectorSpace.TensorPowers.mk T sp τ₁ i₁).tensorAlgebra mul_comm complexScalarMultipleOfZeroLaws (-1)
        (add_neg_cancel 1)
      = (NecSuf.VectorSpace.TensorPowers.mk T sp τ₂ i₂).tensorAlgebra mul_comm complexScalarMultipleOfZeroLaws (-1)
        (add_neg_cancel 1) := by
  subst hτ
  rfl

/-- 族の τ が等しい二つの族は、同じ埋め込み ι を与える。 -/
theorem embedVector_mk_congr (SV : NecSuf.VectorSpace ℂ V) (T : ℕ → Type)
    (sp : ∀ j : ℕ, NecSuf.VectorSpace ℂ (T j))
    (τ₁ τ₂ : ∀ j : ℕ, NecSuf.VectorSpace.Tuple V j → T j) (hτ : τ₁ = τ₂)
    (i₁ : ∀ j : ℕ, NecSuf.VectorSpace.IsTensorProduct.{u, 0, 0, 0} SV j (sp j) (τ₁ j))
    (i₂ : ∀ j : ℕ, NecSuf.VectorSpace.IsTensorProduct.{u, 0, 0, 0} SV j (sp j) (τ₂ j)) :
    (NecSuf.VectorSpace.TensorPowers.mk T sp τ₁ i₁).embedVector
      = (NecSuf.VectorSpace.TensorPowers.mk T sp τ₂ i₂).embedVector := by
  subst hτ
  rfl

theorem coordinateTensor_family_eq_necSuf :
    (fun j => coordinateTensor Q.space Q.dim Q.basis Q.isBasis j)
      = (fun j => NecSuf.VectorSpace.coordinateTensor Q.space.toNecSuf Q.dim Q.basis
          ((isBasisFamily_iff_necSuf Q.space Q.dim Q.basis).1 Q.isBasis) j) :=
  funext fun j => coordinateTensor_eq_necSuf Q.space Q.dim Q.basis Q.isBasis j

/-- 具体版の T(V) を K := ℂ の代数として読んだものは、必要十分版の T(V) に等しい。 -/
theorem TA_toNecSuf : Q.TA.toNecSuf = Q.toNecSuf.TA complexCliffordLaws :=
  Q.tensorPowers.tensorAlgebra_toNecSuf.trans
    (tensorAlgebra_mk_congr Q.space.toNecSuf _ _ _ _ Q.coordinateTensor_family_eq_necSuf _ _)

/-- 具体版の ι は必要十分版の ι に等しい。 -/
theorem ι_eq_necSuf : Q.ι = Q.toNecSuf.ι complexCliffordLaws := by
  have h := embedVector_mk_congr Q.space.toNecSuf _ (fun j => (Q.tensorPowers.space j).toNecSuf) _ _
    Q.coordinateTensor_family_eq_necSuf Q.tensorPowers.toNecSuf.isTensorProduct
    (Q.toNecSuf.tensorPowers complexCliffordLaws).isTensorProduct
  exact h

/-- 具体版の I_q は必要十分版の I_q に等しい（集合の等号）。 -/
theorem ideal_eq_necSuf : Q.ideal = Q.toNecSuf.ideal complexCliffordLaws := by
  have h1 : Q.ideal = NecSuf.AlgebraOver.generatedIdeal Q.TA.toNecSuf
      {x | ∃ v : V, x = Q.TA.toNecSuf.add (Q.TA.toNecSuf.mul (Q.ι v) (Q.ι v))
        (Q.TA.toNecSuf.smul (-Q.form v) Q.TA.toNecSuf.one)} :=
    generatedIdeal_eq_necSuf Q.TA Q.idealGenerators
  rw [h1, Q.TA_toNecSuf, Q.ι_eq_necSuf]
  rfl

/-- 具体版の I_q を、必要十分版の両側イデアルとして読む。 -/
theorem ideal_isTwoSidedIdeal_toNecSuf : NecSuf.AlgebraOver.IsTwoSidedIdeal Q.TA.toNecSuf Q.ideal :=
  (isTwoSidedIdeal_iff_necSuf Q.TA Q.ideal).1 Q.ideal_isTwoSidedIdeal

/-! ### 各主張

各主張について、必要十分版を S・ι・I を変数にした形 `key` に書き直し（変数を必要十分版のものに置けば必要十分版の主張）、
変数に具体版の T(V)・ι・I_q を入れる。 -/

/-- 本文 `claim_clifford_generator_map_is_linear_map` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem γ_isLinearMap_of_necSuf : IsComplexLinearMap Q.space (underlyingVectorSpace Q.cliffordAlgebra) Q.γ := by
  have key : ∀ (S : NecSuf.AlgebraOver ℂ Q.TV) (ι : V → Q.TV) (I : Set Q.TV),
      S = Q.toNecSuf.TA complexCliffordLaws → ι = Q.toNecSuf.ι complexCliffordLaws →
      I = Q.toNecSuf.ideal complexCliffordLaws → ∀ hI : NecSuf.AlgebraOver.IsTwoSidedIdeal S I,
      NecSuf.VectorSpace.IsLinearMap Q.space.toNecSuf
        (NecSuf.AlgebraOver.underlyingVectorSpace
          (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm))
        (fun v => NecSuf.AlgebraOver.projection S (-1) I (ι v)) := by
    rintro _ _ _ rfl rfl rfl _
    exact Q.toNecSuf.γ_isLinearMap complexCliffordLaws
  exact (isComplexLinearMap_iff_necSuf _ _ _).2
    (key _ _ _ Q.TA_toNecSuf Q.ι_eq_necSuf Q.ideal_eq_necSuf Q.ideal_isTwoSidedIdeal_toNecSuf)

/-- 本文 `claim_square_of_clifford_generator` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem γ_mul_self_of_necSuf (v : V) :
    Q.cliffordAlgebra.mul (Q.γ v) (Q.γ v) = Q.cliffordAlgebra.smul (Q.form v) Q.cliffordAlgebra.one := by
  have key : ∀ (S : NecSuf.AlgebraOver ℂ Q.TV) (ι : V → Q.TV) (I : Set Q.TV),
      S = Q.toNecSuf.TA complexCliffordLaws → ι = Q.toNecSuf.ι complexCliffordLaws →
      I = Q.toNecSuf.ideal complexCliffordLaws → ∀ hI : NecSuf.AlgebraOver.IsTwoSidedIdeal S I,
      (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm).mul
          (NecSuf.AlgebraOver.projection S (-1) I (ι v)) (NecSuf.AlgebraOver.projection S (-1) I (ι v))
        = (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm).smul (Q.form v)
            (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm).one := by
    rintro _ _ _ rfl rfl rfl _
    exact Q.toNecSuf.γ_mul_self complexCliffordLaws add_neg_cancel v
  exact key _ _ _ Q.TA_toNecSuf Q.ι_eq_necSuf Q.ideal_eq_necSuf Q.ideal_isTwoSidedIdeal_toNecSuf

/-- 本文 `claim_anticommutator_of_clifford_generator_images_is_polarization` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem γ_anticommutator_of_necSuf (x y : V) :
    Q.cliffordAlgebra.add (Q.cliffordAlgebra.mul (Q.γ x) (Q.γ y)) (Q.cliffordAlgebra.mul (Q.γ y) (Q.γ x))
      = Q.cliffordAlgebra.smul (polarization Q.space Q.form x y) Q.cliffordAlgebra.one := by
  have key : ∀ (S : NecSuf.AlgebraOver ℂ Q.TV) (ι : V → Q.TV) (I : Set Q.TV),
      S = Q.toNecSuf.TA complexCliffordLaws → ι = Q.toNecSuf.ι complexCliffordLaws →
      I = Q.toNecSuf.ideal complexCliffordLaws → ∀ hI : NecSuf.AlgebraOver.IsTwoSidedIdeal S I,
      let A := NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm
      let g := fun v => NecSuf.AlgebraOver.projection S (-1) I (ι v)
      A.add (A.mul (g x) (g y)) (A.mul (g y) (g x))
        = A.smul (NecSuf.VectorSpace.polarization Q.space.toNecSuf Q.form x y) A.one := by
    rintro _ _ _ rfl rfl rfl _
    exact Q.toNecSuf.γ_anticommutator complexCliffordLaws add_neg_cancel x y
  exact key _ _ _ Q.TA_toNecSuf Q.ι_eq_necSuf Q.ideal_eq_necSuf Q.ideal_isTwoSidedIdeal_toNecSuf

/-- 本文 `claim_image_of_clifford_generator_map_generates_clifford_algebra` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem γ_generates_of_necSuf : GeneratesAlgebra Q.cliffordAlgebra (Set.range Q.γ) := by
  have key : ∀ (S : NecSuf.AlgebraOver ℂ Q.TV) (ι : V → Q.TV) (I : Set Q.TV),
      S = Q.toNecSuf.TA complexCliffordLaws → ι = Q.toNecSuf.ι complexCliffordLaws →
      I = Q.toNecSuf.ideal complexCliffordLaws → ∀ hI : NecSuf.AlgebraOver.IsTwoSidedIdeal S I,
      NecSuf.AlgebraOver.GeneratesAlgebra
        (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm)
        (Set.range fun v => NecSuf.AlgebraOver.projection S (-1) I (ι v)) := by
    rintro _ _ _ rfl rfl rfl _
    exact Q.toNecSuf.γ_generates complexCliffordLaws
  exact (generatesAlgebra_iff_necSuf _ _).2
    (key _ _ _ Q.TA_toNecSuf Q.ι_eq_necSuf Q.ideal_eq_necSuf Q.ideal_isTwoSidedIdeal_toNecSuf)

/-- 本文 `claim_universal_property_of_clifford_algebra` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem universalProperty_of_necSuf {A : Type w} (SA : ComplexAlgebra A) (f : V → A)
    (hf : IsComplexLinearMap Q.space SA.toComplexVectorSpace f)
    (hsq : ∀ v : V, SA.mul (f v) (f v) = SA.smul (Q.form v) SA.one) :
    ∃ Φ : Q.Cl → A, (IsComplexAlgebraHomomorphism Q.cliffordAlgebra SA Φ ∧ ∀ v : V, Φ (Q.γ v) = f v) ∧
      ∀ Φ' : Q.Cl → A, (IsComplexAlgebraHomomorphism Q.cliffordAlgebra SA Φ' ∧ ∀ v : V, Φ' (Q.γ v) = f v) →
        Φ' = Φ := by
  have key : ∀ (S : NecSuf.AlgebraOver ℂ Q.TV) (ι : V → Q.TV) (I : Set Q.TV),
      S = Q.toNecSuf.TA complexCliffordLaws → ι = Q.toNecSuf.ι complexCliffordLaws →
      I = Q.toNecSuf.ideal complexCliffordLaws → ∀ hI : NecSuf.AlgebraOver.IsTwoSidedIdeal S I,
      ∃ Φ : NecSuf.AlgebraOver.QuotientSet S (-1) I → A,
        (NecSuf.AlgebraOver.IsAlgebraHomomorphism
            (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm) SA.toNecSuf Φ ∧
          ∀ v : V, Φ (NecSuf.AlgebraOver.projection S (-1) I (ι v)) = f v) ∧
        ∀ Φ' : NecSuf.AlgebraOver.QuotientSet S (-1) I → A,
          (NecSuf.AlgebraOver.IsAlgebraHomomorphism
              (NecSuf.AlgebraOver.quotientAlgebra hI complexCongruenceLaws complexNegOneComm) SA.toNecSuf Φ' ∧
            ∀ v : V, Φ' (NecSuf.AlgebraOver.projection S (-1) I (ι v)) = f v) → Φ' = Φ := by
    rintro _ _ _ rfl rfl rfl _
    exact Q.toNecSuf.universalProperty complexCliffordLaws add_neg_cancel SA.toNecSuf f
      ((isComplexLinearMap_iff_necSuf _ _ _).1 hf) hsq
  obtain ⟨Φ, ⟨hΦ, hΦγ⟩, huniq⟩ :=
    key _ _ _ Q.TA_toNecSuf Q.ι_eq_necSuf Q.ideal_eq_necSuf Q.ideal_isTwoSidedIdeal_toNecSuf
  exact ⟨Φ, ⟨(isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2 hΦ, hΦγ⟩,
    fun Φ' hΦ' => huniq Φ' ⟨(isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 hΦ'.1, hΦ'.2⟩⟩

end QuadraticSpaceWithBasis

end CliffordMatrixIsomorphism.Clifford
