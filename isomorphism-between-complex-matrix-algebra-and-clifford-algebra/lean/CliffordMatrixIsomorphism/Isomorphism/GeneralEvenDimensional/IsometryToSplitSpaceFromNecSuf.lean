/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」の後半の具体版が、必要十分版の K := ℂ、n := -1_ℂ、
i := imaginaryUnit、h := inverseOfTwo への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。

  具体版                                        必要十分版の特殊化
  index_cases                                   index_cases_of_necSuf（ℂ を含まない）
  splitBasis_first・splitBasis_second           …_of_necSuf
  orthonormalBasis_spec                         orthonormalBasis_spec_of_necSuf（存在の主張の導出版 `exists_orthonormal_basis_of_necSuf` から）
  inverseOfTwo_mul・mul_inverseOfTwo            isInverseOfTwo_inverseOfTwo（必要十分版の仮定 `IsInverseOfTwo` を ℂ で満たすこと）
  negImaginaryUnit_mul_imaginaryUnit            negImaginaryUnit_mul_imaginaryUnit_of_necSuf
  kroneckerDelta_self                           kroneckerDelta_self_of_necSuf
  splitFamily・mapToSplit・inverseFamily・mapFromSplit
                                                splitFamily_toNecSuf・mapToSplit_toNecSuf・inverseFamily_eq_necSuf・mapFromSplit_eq_necSuf
  form_splitFamily ほか各主張                   …_of_necSuf
  generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family
                                                …_of_necSuf（必要十分版の本体を特殊化し、T_Y・S_Y で引き戻す）
  generalCliffordAlgebra_isomorphic_matrixAlgebra …_of_necSuf（本体の導出版を固定した e に当てる）

運び方:
- 具体版の V = W ⊕ W^* と、具体版の前提を写した必要十分版の前提 `D.toNecSuf` の V は、W^* が値の写像の同じ別の部分型なので別の集合である。
  V の点は `splitPointToNecSuf`（W^* の元を `DualSpace.toNecSuf` で写す）で必要十分版の点へ写し、`splitPointOfNecSuf` で戻す。
  どちらも値の写像を変えないので、V の演算・q_W・B_q を定義により保ち（`rfl`）、行き来すると元に戻る（`toNecSuf_injective`）。
- 基底 d・族 u・θ は、写した点が必要十分版のものと一致する（`splitBasis_toNecSuf`・`splitFamily_toNecSuf`・`mapToSplit_toNecSuf`）。
  θ' は必要十分版の θ' に写した点を入れたものに等しい（`mapFromSplit_eq_necSuf`）。座標の写像は具体版と必要十分版で別々に選ぶので、
  1,…,2M の番号で値が一致することを係数の一意性で示す（`coordinate_splitBasis_eq_necSuf`。Y の側は既存の `coordinate_eq_necSuf`）。
- Y の側は同じ型の上で、具体版の前提の組 `QY` を `QY.toNecSuf`（欄を写すだけ）として読む。
- 系の定理の本体は、必要十分版の本体を `D.toNecSuf`・`QY.toNecSuf` に特殊化し、引き戻して得る。具体版の Cl(Y,Q) と
  必要十分版の Cl(Y,Q) は別の集合なので、二つの間の互いに逆な準同型 T_Y・S_Y（`QuadraticSpaceWithBasis.transportToNecSuf`。
  点は動かさない）を置く。具体版の Φ_Y は Φ_{Y,N} ∘ T_Y に等しく（Cl(θ) と Cl_N(θ_N) を T・T_Y が結ぶ。
  `splitToCl_inducedHom_mapToSplit`）、具体版の Ψ_Y は S_Y ∘ Ψ_{Y,N} に等しい（`toCl_inducedHom_mapFromSplit` と、
  Ψ と Ψ_N を T が結ぶ `toN_homomorphismFromMatrix`）。必要十分版の本体の六つの部分を、この二つの等式で具体版へ移す。
- 系の定理は、必要十分版の系の定理と同じく、本体を固定した e に当てる。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws`、a + (-a) = 0 の `add_neg_cancel`、(-a)·b = -(a·b) の `neg_mul`、
-(-a) = a の `neg_neg`、i · i = -1 の `imaginaryUnit_mul_self`、h が 1 + 1 の逆元であること（`inverseOfTwo_mul`・`mul_inverseOfTwo`）である。
-/
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpace
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.InducedHomomorphismFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.OrthonormalBasisFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphismsFromNecSuf
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.GeneratorsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpace

-- 添字の再帰的な定義（2^M・個数 N_i(T)・整数の番号順の和など）は具体版と必要十分版に同じ式で別に置いてあり、
-- 変数での値は再帰の展開でしか一致しないので、このファイルでは smartUnfolding を切って定義どおりに展開させる。
set_option smartUnfolding false

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe v

variable {Y : Type v}

/-- 具体版の e の三つの条件を、必要十分版の三つの条件として読む（B_q と基底であることを写すだけ）。 -/
theorem IsOrthonormalBasisFamily.toNecSuf {S : ComplexVectorSpace Y} {q : Y → ℂ} {n : ℕ} {e : ℕ → Y}
    (he : IsOrthonormalBasisFamily S q n e) : NecSuf.VectorSpace.IsOrthonormalBasisFamily S.toNecSuf q n e :=
  ⟨(isBasisFamily_iff_necSuf S n e).1 he.isBasis, he.orthogonal, he.form_eq_one⟩

/-- 具体版の h := (1 + 1)^{-1} は、必要十分版の仮定 `IsInverseOfTwo` を満たす（本文 `def_inverse_of_two_in_complex_numbers`）。 -/
theorem isInverseOfTwo_inverseOfTwo : NecSuf.VectorSpace.IsInverseOfTwo inverseOfTwo :=
  ⟨inverseOfTwo_mul, mul_inverseOfTwo⟩

/-- θ・θ' の必要十分版が K に置く仮定の組を ℂ で満たすこと（章「クリフォード代数」の ℂ の仮定の組から欄を取り出す）。 -/
theorem complexSplitSpaceLaws : NecSuf.Clifford.SplitData.SplitSpaceLaws ℂ :=
  NecSuf.Clifford.CliffordLaws.splitSpaceLaws Clifford.complexCliffordLaws

/-- 本文 `claim_negative_imaginary_unit_times_imaginary_unit_is_one` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem negImaginaryUnit_mul_imaginaryUnit_of_necSuf : (-imaginaryUnit) * imaginaryUnit = 1 :=
  NecSuf.VectorSpace.negImaginaryUnit_mul_imaginaryUnit neg_mul neg_neg imaginaryUnit imaginaryUnit_mul_self

end CliffordMatrixIsomorphism.ComplexVectorSpace

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.Isomorphism

universe u v

/-- `index_cases` を必要十分版から得たもの（ℂ を含まない）。 -/
theorem index_cases_of_necSuf (M k : ℕ) (hk : k ≤ M + M) :
    k ≤ M ∨ ∃ m : ℕ, 1 ≤ m ∧ m ≤ M ∧ k = M + m :=
  NecSuf.Clifford.SplitData.index_cases M k hk

/-- 本文 `def_kronecker_delta` の δ_{m,m} = 1_ℂ を、必要十分版から得たもの。 -/
theorem kroneckerDelta_self_of_necSuf (m : ℕ) : (kroneckerDelta m m : ℂ) = 1 := by
  rw [kroneckerDelta_eq_necSuf]
  exact NecSuf.Clifford.SplitData.kroneckerDelta_self m

noncomputable section

variable {W : Type u} (D : SplitData W) {Y : Type v}

/-! ### 分裂した二次空間の点の行き来 -/

/-- V の点を写してから戻すと元に戻るので、写した点が等しい二点は等しい。 -/
theorem toNecSuf_injective {p p' : W × DualSpace D.spaceW}
    (h : splitPointToNecSuf D.spaceW p = splitPointToNecSuf D.spaceW p') : p = p' :=
  congrArg D.splitPointOfNecSuf h

/-- V の線型結合を写した点は、写した点の線型結合である（写す写像は演算を定義により保つ）。 -/
theorem toNecSuf_partialLinearCombination (c : ℕ → ℂ) (x : ℕ → W × DualSpace D.spaceW) (m : ℕ) :
    splitPointToNecSuf D.spaceW (partialLinearCombination D.space.space c x m)
      = NecSuf.VectorSpace.partialLinearCombination D.spaceN.space c (fun k => splitPointToNecSuf D.spaceW (x k)) m := by
  induction m with
  | zero => rfl
  | succ m ih =>
    show splitPointToNecSuf D.spaceW (D.space.space.add (partialLinearCombination D.space.space c x m)
        (D.space.space.smul (c (m + 1)) (x (m + 1))))
      = D.spaceN.space.add (NecSuf.VectorSpace.partialLinearCombination D.spaceN.space c
          (fun k => splitPointToNecSuf D.spaceW (x k)) m)
        (D.spaceN.space.smul (c (m + 1)) (splitPointToNecSuf D.spaceW (x (m + 1))))
    rw [← ih]
    rfl

theorem toNecSuf_linearCombination (n : ℕ) (c : ℕ → ℂ) (x : ℕ → W × DualSpace D.spaceW) :
    splitPointToNecSuf D.spaceW (linearCombination D.space.space n c x)
      = NecSuf.VectorSpace.linearCombination D.spaceN.space n c (fun k => splitPointToNecSuf D.spaceW (x k)) :=
  D.toNecSuf_partialLinearCombination c x n

/-- 具体版の基底 d を写した点は、必要十分版の基底 d である。 -/
theorem splitBasis_toNecSuf (k : ℕ) :
    splitPointToNecSuf D.spaceW (D.splitBasis k) = D.toNecSuf.splitBasis complexSplitSpaceLaws k := by
  show splitPointToNecSuf D.spaceW (concatenatedFamily D.spaceW (dualSpaceVectorSpace D.spaceW) D.M D.w D.f k)
    = NecSuf.VectorSpace.concatenatedFamily D.toNecSuf.spaceW
      (NecSuf.VectorSpace.dualSpaceVectorSpace complexCliffordLaws.dualSpaceVectorSpaceLaws D.toNecSuf.spaceW)
      D.M D.toNecSuf.w D.toNecSuf.f k
  unfold concatenatedFamily NecSuf.VectorSpace.concatenatedFamily
  split_ifs <;> rfl

/-- 具体版の族 u を写した点は、必要十分版の族 u（i := imaginaryUnit）である。 -/
theorem splitFamily_toNecSuf (k : ℕ) :
    splitPointToNecSuf D.spaceW (D.splitFamily k) = D.toNecSuf.splitFamily complexSplitSpaceLaws imaginaryUnit k := by
  unfold splitFamily NecSuf.Clifford.SplitData.splitFamily
  split_ifs with h1 h2 h2
  · rfl
  · exact absurd h1 h2
  · exact absurd h2 h1
  · rfl

/-- 具体版の d の座標の写像と、必要十分版の d の座標の写像を写した点で開いたものは、1,…,2M の番号で一致する（係数の一意性）。 -/
theorem coordinate_splitBasis_eq_necSuf (y : W × DualSpace D.spaceW) (k : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) :
    coordinate D.space.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis k y
      = NecSuf.VectorSpace.coordinate D.spaceN.space (D.M + D.M) (D.toNecSuf.splitBasis complexSplitSpaceLaws)
          (D.toNecSuf.splitBasis_isBasis complexSplitSpaceLaws) k (splitPointToNecSuf D.spaceW y) := by
  have h := congrArg (splitPointToNecSuf D.spaceW)
    (linearCombination_coordinate D.space.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis y)
  rw [toNecSuf_linearCombination] at h
  have hd : (fun l => splitPointToNecSuf D.spaceW (D.splitBasis l)) = D.toNecSuf.splitBasis complexSplitSpaceLaws :=
    funext D.splitBasis_toNecSuf
  rw [hd] at h
  exact (NecSuf.VectorSpace.coordinate_eq_of_linearCombination_eq D.spaceN.space complexUniquenessLaws (D.M + D.M)
    _ (D.toNecSuf.splitBasis_isBasis complexSplitSpaceLaws) _ _ h k hk1 hk).symm

/-! ### 基底 d と e -/

/-- 本文 `claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary` の一つ目を、必要十分版から得たもの。 -/
theorem splitBasis_first_of_necSuf (m : ℕ) (hmM : m ≤ D.M) :
    D.splitBasis m = embedFirst (dualSpaceVectorSpace D.spaceW) (D.w m) := by
  apply D.toNecSuf_injective
  rw [D.splitBasis_toNecSuf]
  exact D.toNecSuf.splitBasis_first complexSplitSpaceLaws m hmM

/-- 本文 `claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary` の二つ目を、必要十分版から得たもの。 -/
theorem splitBasis_second_of_necSuf (m : ℕ) (hm1 : 1 ≤ m) :
    D.splitBasis (D.M + m) = embedSecond D.spaceW (D.f m) := by
  apply D.toNecSuf_injective
  rw [D.splitBasis_toNecSuf]
  exact D.toNecSuf.splitBasis_second complexSplitSpaceLaws m hm1

/-- 本文 `def_orthonormal_basis_of_general_even_dimensional_space` の固定した e が三つの条件を満たすことを、
存在の主張の導出版（`exists_orthonormal_basis_of_necSuf`。必要十分版に平方根の存在を渡したもの）から得たもの。 -/
theorem orthonormalBasis_spec_of_necSuf (QY : QuadraticSpaceWithBasis Y) (hdim : QY.dim = D.M + D.M)
    (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) (D.orthonormalBasis QY hdim hQ) := by
  obtain ⟨h1, h2, h3⟩ :=
    Classical.choose_spec (exists_orthonormal_basis_of_necSuf QY.space QY.form hQ (D.M + D.M) QY.basis
      (hdim ▸ QY.isBasis))
  exact ⟨h1, h2, h3⟩

/-! ### 族 u -/

/-- 本文 `claim_quadratic_form_on_family_in_split_space_is_one` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem form_splitFamily_of_necSuf (k : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) :
    D.space.form (D.splitFamily k) = 1 := calc
  D.space.form (D.splitFamily k) = D.spaceN.form (splitPointToNecSuf D.spaceW (D.splitFamily k)) := rfl
  _ = D.spaceN.form (D.toNecSuf.splitFamily complexSplitSpaceLaws imaginaryUnit k) := by rw [D.splitFamily_toNecSuf k]
  _ = 1 := D.toNecSuf.form_splitFamily complexSplitSpaceLaws neg_mul neg_neg imaginaryUnit imaginaryUnit_mul_self k hk1 hk

/-- 本文 `claim_family_in_split_space_is_orthogonal` の二つ目の場合を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_splitFamily_first_second_of_necSuf (m m' : ℕ) (hm1 : 1 ≤ m) (hmM : m ≤ D.M) (hm'1 : 1 ≤ m')
    (hm'M : m' ≤ D.M) :
    polarization D.space.space D.space.form (D.splitFamily m) (D.splitFamily (D.M + m')) = 0 := calc
  polarization D.space.space D.space.form (D.splitFamily m) (D.splitFamily (D.M + m'))
      = NecSuf.VectorSpace.polarization D.spaceN.space D.spaceN.form (splitPointToNecSuf D.spaceW (D.splitFamily m))
          (splitPointToNecSuf D.spaceW (D.splitFamily (D.M + m'))) := rfl
  _ = NecSuf.VectorSpace.polarization D.spaceN.space D.spaceN.form
        (D.toNecSuf.splitFamily complexSplitSpaceLaws imaginaryUnit m)
        (D.toNecSuf.splitFamily complexSplitSpaceLaws imaginaryUnit (D.M + m')) := by
      rw [D.splitFamily_toNecSuf m, D.splitFamily_toNecSuf (D.M + m')]
  _ = 0 := D.toNecSuf.polarization_splitFamily_first_second complexSplitSpaceLaws add_neg_cancel imaginaryUnit m m'
      hm1 hmM hm'1 hm'M

/-- 本文 `claim_family_in_split_space_is_orthogonal` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_splitFamily_of_necSuf (k l : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) (hl1 : 1 ≤ l)
    (hl : l ≤ D.M + D.M) (hkl : k ≠ l) :
    polarization D.space.space D.space.form (D.splitFamily k) (D.splitFamily l) = 0 := calc
  polarization D.space.space D.space.form (D.splitFamily k) (D.splitFamily l)
      = NecSuf.VectorSpace.polarization D.spaceN.space D.spaceN.form (splitPointToNecSuf D.spaceW (D.splitFamily k))
          (splitPointToNecSuf D.spaceW (D.splitFamily l)) := rfl
  _ = NecSuf.VectorSpace.polarization D.spaceN.space D.spaceN.form
        (D.toNecSuf.splitFamily complexSplitSpaceLaws imaginaryUnit k)
        (D.toNecSuf.splitFamily complexSplitSpaceLaws imaginaryUnit l) := by
      rw [D.splitFamily_toNecSuf k, D.splitFamily_toNecSuf l]
  _ = 0 := D.toNecSuf.polarization_splitFamily complexSplitSpaceLaws add_neg_cancel imaginaryUnit k l hk1 hk hl1 hl hkl

/-! ### θ と θ' -/

/-- 具体版の θ(x) を写した点は、必要十分版の θ(x) である。 -/
theorem mapToSplit_toNecSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (x : Y) :
    splitPointToNecSuf D.spaceW (D.mapToSplit QY e he x)
      = D.toNecSuf.mapToSplit complexSplitSpaceLaws imaginaryUnit QY.toNecSuf e he.toNecSuf.isBasis x := by
  show splitPointToNecSuf D.spaceW (linearCombination D.space.space (D.M + D.M)
      (fun k => coordinate QY.space (D.M + D.M) e he.isBasis k x) D.splitFamily)
    = NecSuf.VectorSpace.linearCombination D.spaceN.space (D.M + D.M)
      (fun k => NecSuf.VectorSpace.coordinate QY.space.toNecSuf (D.M + D.M) e he.toNecSuf.isBasis k x)
      (D.toNecSuf.splitFamily complexSplitSpaceLaws imaginaryUnit)
  rw [toNecSuf_linearCombination]
  exact NecSuf.VectorSpace.linearCombination_eq_of_terms_eq _ (D.M + D.M) _ _ _ _ fun k hk1 hk => by
    rw [coordinate_eq_necSuf QY.space (D.M + D.M) e he.isBasis k hk1 hk x, D.splitFamily_toNecSuf k]

/-- 具体版の v は、必要十分版の v（i := imaginaryUnit、h := inverseOfTwo）と同じである。 -/
theorem inverseFamily_eq_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y) :
    D.inverseFamily QY e = D.toNecSuf.inverseFamily imaginaryUnit inverseOfTwo QY.toNecSuf e := by
  funext k
  unfold inverseFamily NecSuf.Clifford.SplitData.inverseFamily
  rfl

/-- 具体版の θ'(y) は、必要十分版の θ' に y を写した点を入れたものである。 -/
theorem mapFromSplit_eq_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y) (y : W × DualSpace D.spaceW) :
    D.mapFromSplit QY e y
      = D.toNecSuf.mapFromSplit complexSplitSpaceLaws imaginaryUnit inverseOfTwo QY.toNecSuf e
          (splitPointToNecSuf D.spaceW y) := by
  show linearCombination QY.space (D.M + D.M)
      (fun l => coordinate D.space.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis l y) (D.inverseFamily QY e)
    = NecSuf.VectorSpace.linearCombination QY.space.toNecSuf (D.M + D.M)
      (fun l => NecSuf.VectorSpace.coordinate D.spaceN.space (D.M + D.M) (D.toNecSuf.splitBasis complexSplitSpaceLaws)
        (D.toNecSuf.splitBasis_isBasis complexSplitSpaceLaws) l (splitPointToNecSuf D.spaceW y))
      (D.toNecSuf.inverseFamily imaginaryUnit inverseOfTwo QY.toNecSuf e)
  rw [linearCombination_eq_necSuf, D.inverseFamily_eq_necSuf QY e]
  exact NecSuf.VectorSpace.linearCombination_eq_of_terms_eq _ (D.M + D.M) _ _ _ _ fun l hl1 hl => by
    rw [D.coordinate_splitBasis_eq_necSuf y l hl1 hl]

/-- 本文 `claim_map_to_split_quadratic_space_is_isometry` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapToSplit_isIsometry_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsIsometry QY.space D.space.space QY.form D.space.form (D.mapToSplit QY e he) := by
  have hN := D.toNecSuf.mapToSplit_isIsometry complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e
    he.toNecSuf
  have heq : D.mapToSplit QY e he
      = fun x => D.splitPointOfNecSuf (D.toNecSuf.mapToSplit complexSplitSpaceLaws imaginaryUnit QY.toNecSuf e
          he.toNecSuf.isBasis x) :=
    funext fun x => by rw [← D.mapToSplit_toNecSuf QY e he x]; rfl
  have hof : NecSuf.VectorSpace.IsLinearMap D.spaceN.space D.space.space.toNecSuf D.splitPointOfNecSuf :=
    ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  exact {
    isQuadraticForm := QY.isQuadraticForm
    isQuadraticForm' := splitQuadraticForm_isQuadraticForm_of_necSuf D.spaceW
    isLinearMap := by
      rw [isComplexLinearMap_iff_necSuf, heq]
      exact NecSuf.VectorSpace.IsLinearMap.comp hN.isLinearMap hof
    map_form := fun x => calc
      D.space.form (D.mapToSplit QY e he x) = D.spaceN.form (splitPointToNecSuf D.spaceW (D.mapToSplit QY e he x)) := rfl
      _ = D.spaceN.form (D.toNecSuf.mapToSplit complexSplitSpaceLaws imaginaryUnit QY.toNecSuf e he.toNecSuf.isBasis x) := by
          rw [D.mapToSplit_toNecSuf QY e he x]
      _ = QY.form x := hN.map_form x }

/-- 本文 `claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapFromSplit_splitFamily_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y) (k : ℕ) (hk1 : 1 ≤ k)
    (hk : k ≤ D.M + D.M) : D.mapFromSplit QY e (D.splitFamily k) = e k := by
  rw [D.mapFromSplit_eq_necSuf QY e, D.splitFamily_toNecSuf k]
  exact D.toNecSuf.mapFromSplit_splitFamily complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf e k hk1 hk

/-- 本文 `claim_map_to_split_quadratic_space_sends_family_to_basis` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapToSplit_inverseFamily_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (l : ℕ) (hl1 : 1 ≤ l) (hl : l ≤ D.M + D.M) :
    D.mapToSplit QY e he (D.inverseFamily QY e l) = D.splitBasis l := by
  apply D.toNecSuf_injective
  rw [D.mapToSplit_toNecSuf QY e he, D.splitBasis_toNecSuf, D.inverseFamily_eq_necSuf QY e]
  exact D.toNecSuf.mapToSplit_inverseFamily complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo inverseOfTwo_mul QY.toNecSuf e he.toNecSuf.isBasis l hl1 hl

/-- 本文 `claim_map_from_split_after_map_to_split_is_identity` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapFromSplit_mapToSplit_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (x : Y) :
    D.mapFromSplit QY e (D.mapToSplit QY e he x) = x := by
  rw [D.mapFromSplit_eq_necSuf QY e, D.mapToSplit_toNecSuf QY e he]
  exact D.toNecSuf.mapFromSplit_mapToSplit complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf e he.toNecSuf.isBasis x

/-- 本文 `claim_map_to_split_after_map_from_split_is_identity` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapToSplit_mapFromSplit_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (y : W × DualSpace D.spaceW) :
    D.mapToSplit QY e he (D.mapFromSplit QY e y) = y := by
  apply D.toNecSuf_injective
  rw [D.mapToSplit_toNecSuf QY e he, D.mapFromSplit_eq_necSuf QY e]
  exact D.toNecSuf.mapToSplit_mapFromSplit complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo inverseOfTwo_mul QY.toNecSuf e he.toNecSuf.isBasis
    (splitPointToNecSuf D.spaceW y)

/-- 本文 `claim_map_from_split_quadratic_space_is_isometry` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapFromSplit_isIsometry_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsIsometry D.space.space QY.space D.space.form QY.form (D.mapFromSplit QY e) := by
  have hN := D.toNecSuf.mapFromSplit_isIsometry complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo inverseOfTwo_mul QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf
  have heq : D.mapFromSplit QY e
      = fun y => D.toNecSuf.mapFromSplit complexSplitSpaceLaws imaginaryUnit inverseOfTwo QY.toNecSuf e
          (splitPointToNecSuf D.spaceW y) :=
    funext (D.mapFromSplit_eq_necSuf QY e)
  have hto : NecSuf.VectorSpace.IsLinearMap D.space.space.toNecSuf D.spaceN.space (splitPointToNecSuf D.spaceW) :=
    ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  exact {
    isQuadraticForm := splitQuadraticForm_isQuadraticForm_of_necSuf D.spaceW
    isQuadraticForm' := QY.isQuadraticForm
    isLinearMap := by
      rw [isComplexLinearMap_iff_necSuf, heq]
      exact NecSuf.VectorSpace.IsLinearMap.comp hto hN.isLinearMap
    map_form := fun y => calc
      QY.form (D.mapFromSplit QY e y)
          = QY.form (D.toNecSuf.mapFromSplit complexSplitSpaceLaws imaginaryUnit inverseOfTwo QY.toNecSuf e
              (splitPointToNecSuf D.spaceW y)) := by rw [D.mapFromSplit_eq_necSuf QY e y]
      _ = D.spaceN.form (splitPointToNecSuf D.spaceW y) := hN.map_form _
      _ = D.space.form y := rfl }

/-! ### 系の定理 -/

/-- 必要十分版の Φ_Y（`D.toNecSuf` と `QY.toNecSuf` に ℂ の性質を渡したもの）。 -/
abbrev homomorphismToMatrixOfGeneralN (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    QY.toNecSuf.Cl complexCliffordLaws → Mat (PowerSet D.M) :=
  D.toNecSuf.homomorphismToMatrixOfGeneral complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e
    he.toNecSuf

/-- 必要十分版の Ψ_Y（`D.toNecSuf` と `QY.toNecSuf` に ℂ の性質を渡したもの）。 -/
abbrev homomorphismFromMatrixOfGeneralN (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    Mat (PowerSet D.M) → QY.toNecSuf.Cl complexCliffordLaws :=
  D.toNecSuf.homomorphismFromMatrixOfGeneral complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf

/-- T(Cl(θ)(a)) = Cl_N(θ_N)(T_Y(a))。二つの準同型 Cl(Y,Q) → Cl_N(V,q) は γ_Y(Y) の上で一致する
（θ_N は θ の値を写した点を返す。`mapToSplit_toNecSuf`）。 -/
theorem splitToCl_inducedHom_mapToSplit (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl) :
    D.splitTransport.toCl
        (QuadraticSpaceWithBasis.inducedHom QY D.space (D.mapToSplit QY e he) (D.mapToSplit_isIsometry QY e he) a)
      = NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom complexCliffordLaws add_neg_cancel QY.toNecSuf D.spaceN
          (D.toNecSuf.mapToSplit complexSplitSpaceLaws imaginaryUnit QY.toNecSuf e he.toNecSuf.isBasis)
          (D.toNecSuf.mapToSplit_isIsometry complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
            imaginaryUnit_mul_self QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm)
            e he.toNecSuf).isLinearMap
          (D.toNecSuf.mapToSplit_isIsometry complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
            imaginaryUnit_mul_self QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm)
            e he.toNecSuf).map_form
          ((QuadraticSpaceWithBasis.transportToNecSuf QY).toCl a) :=
  equal_of_agree_on_generators_of_necSuf
    (IsComplexAlgebraHomomorphism.comp_of_necSuf
      (QuadraticSpaceWithBasis.inducedHom_isHom_of_necSuf QY D.space _ (D.mapToSplit_isIsometry QY e he))
      D.splitTransport.toCl_isHom)
    (IsComplexAlgebraHomomorphism.comp_of_necSuf (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_isHom
      ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2
        (NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom_isHom complexCliffordLaws add_neg_cancel _ _ _ _ _)))
    (Set.range QY.γ) QY.γ_generates_of_necSuf
    (fun _ ⟨y, hy⟩ => by
      rw [← hy]
      show D.splitTransport.toCl
          (QuadraticSpaceWithBasis.inducedHom QY D.space (D.mapToSplit QY e he) (D.mapToSplit_isIsometry QY e he)
            (QY.γ y))
        = NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom complexCliffordLaws add_neg_cancel QY.toNecSuf D.spaceN _ _ _
          ((QuadraticSpaceWithBasis.transportToNecSuf QY).toCl (QY.γ y))
      rw [QuadraticSpaceWithBasis.inducedHom_γ_of_necSuf, D.splitTransport.toCl_γ,
        (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_γ,
        NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom_γ]
      exact congrArg (D.spaceN.γ complexCliffordLaws) (D.mapToSplit_toNecSuf QY e he y)) a

/-- T_Y(Cl(θ')(x)) = Cl_N(θ'_N)(T(x))。二つの準同型 Cl(V,q) → Cl_N(Y,Q) は γ(V) の上で一致する
（θ' は θ'_N に写した点を入れたもの。`mapFromSplit_eq_necSuf`）。 -/
theorem toCl_inducedHom_mapFromSplit (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (x : D.space.Cl) :
    (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl
        (QuadraticSpaceWithBasis.inducedHom D.space QY (D.mapFromSplit QY e) (D.mapFromSplit_isIsometry QY e he) x)
      = NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom complexCliffordLaws add_neg_cancel D.spaceN QY.toNecSuf
          (D.toNecSuf.mapFromSplit complexSplitSpaceLaws imaginaryUnit inverseOfTwo QY.toNecSuf e)
          (D.toNecSuf.mapFromSplit_isIsometry complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
            imaginaryUnit_mul_self inverseOfTwo inverseOfTwo_mul QY.toNecSuf
            ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf).isLinearMap
          (D.toNecSuf.mapFromSplit_isIsometry complexSplitSpaceLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
            imaginaryUnit_mul_self inverseOfTwo inverseOfTwo_mul QY.toNecSuf
            ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf).map_form
          (D.splitTransport.toCl x) :=
  equal_of_agree_on_generators_of_necSuf
    (IsComplexAlgebraHomomorphism.comp_of_necSuf
      (QuadraticSpaceWithBasis.inducedHom_isHom_of_necSuf D.space QY _ (D.mapFromSplit_isIsometry QY e he))
      (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_isHom)
    (IsComplexAlgebraHomomorphism.comp_of_necSuf D.splitTransport.toCl_isHom
      ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2
        (NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom_isHom complexCliffordLaws add_neg_cancel _ _ _ _ _)))
    (Set.range D.space.γ) D.space.γ_generates_of_necSuf
    (fun _ ⟨p, hp⟩ => by
      rw [← hp]
      show (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl
          (QuadraticSpaceWithBasis.inducedHom D.space QY (D.mapFromSplit QY e) (D.mapFromSplit_isIsometry QY e he)
            (D.space.γ p))
        = NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom complexCliffordLaws add_neg_cancel D.spaceN QY.toNecSuf _ _ _
          (D.splitTransport.toCl (D.space.γ p))
      rw [QuadraticSpaceWithBasis.inducedHom_γ_of_necSuf, (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_γ,
        D.splitTransport.toCl_γ, NecSuf.Clifford.QuadraticSpaceWithBasis.inducedHom_γ]
      exact congrArg (QY.toNecSuf.γ complexCliffordLaws) (D.mapFromSplit_eq_necSuf QY e p)) x

/-- 具体版の Φ_Y は、必要十分版の Φ_Y に T_Y を先に当てたものである。 -/
theorem homomorphismToMatrixOfGeneral_eq_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl) :
    D.homomorphismToMatrixOfGeneral QY e he a
      = D.homomorphismToMatrixOfGeneralN QY e he ((QuadraticSpaceWithBasis.transportToNecSuf QY).toCl a) := by
  show D.homomorphismToMatrix
      (QuadraticSpaceWithBasis.inducedHom QY D.space (D.mapToSplit QY e he) (D.mapToSplit_isIsometry QY e he) a) = _
  rw [D.homomorphismToMatrix_eq_comp D.splitTransport.toCl_isHom D.splitTransport.toCl_γ,
    D.splitToCl_inducedHom_mapToSplit QY e he a]
  rfl

/-- 具体版の Ψ_Y を T_Y で写したものは、必要十分版の Ψ_Y である。 -/
theorem toCl_homomorphismFromMatrixOfGeneral (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (F : Mat (PowerSet D.M)) :
    (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl (D.homomorphismFromMatrixOfGeneral QY e he F)
      = D.homomorphismFromMatrixOfGeneralN QY e he F := by
  show (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl
      (QuadraticSpaceWithBasis.inducedHom D.space QY (D.mapFromSplit QY e) (D.mapFromSplit_isIsometry QY e he)
        (D.homomorphismFromMatrix F)) = _
  rw [D.toCl_inducedHom_mapFromSplit QY e he,
    toN_homomorphismFromMatrix D.splitTransport.toCl_isHom D.splitTransport.toCl_γ F]
  rfl

/-- 系の定理の本体（`generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family`）を、必要十分版の系の定理の本体を
`D.toNecSuf`・`QY.toNecSuf` と ℂ の性質に特殊化し、互いに逆な準同型 T_Y : Cl(Y,Q) → Cl_N(Y,Q)・S_Y で引き戻して得たもの。
具体版の Φ_Y は Φ_{Y,N} ∘ T_Y、Ψ_Y は S_Y ∘ Ψ_{Y,N} に等しい。 -/
theorem generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family_of_necSuf (QY : QuadraticSpaceWithBasis Y)
    (e : ℕ → Y) (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra (D.homomorphismToMatrixOfGeneral QY e he) ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra (D.homomorphismFromMatrixOfGeneral QY e he) ∧
      (∀ a : QY.Cl, D.homomorphismFromMatrixOfGeneral QY e he (D.homomorphismToMatrixOfGeneral QY e he a) = a) ∧
      (∀ F : Mat (PowerSet D.M),
        D.homomorphismToMatrixOfGeneral QY e he (D.homomorphismFromMatrixOfGeneral QY e he F) = F) ∧
      Function.Bijective (D.homomorphismToMatrixOfGeneral QY e he) ∧
      (∀ (F : Mat (PowerSet D.M)) (a : QY.Cl),
        D.homomorphismToMatrixOfGeneral QY e he a = F → a = D.homomorphismFromMatrixOfGeneral QY e he F) := by
  let P := QuadraticSpaceWithBasis.transportToNecSuf QY
  let ΦN := D.homomorphismToMatrixOfGeneralN QY e he
  let ΨN := D.homomorphismFromMatrixOfGeneralN QY e he
  obtain ⟨hΦN, hΨN, hΨΦN, hΦΨN, hbijN, hinvN⟩ :=
    D.toNecSuf.generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family complexCliffordLaws add_neg_cancel neg_mul
      neg_neg imaginaryUnit imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf
      ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf
  rw [← D.matrixAlgebra_toNecSuf] at hΦN hΨN
  have hΦeq : D.homomorphismToMatrixOfGeneral QY e he = fun a => ΦN (P.toCl a) :=
    funext (D.homomorphismToMatrixOfGeneral_eq_necSuf QY e he)
  have hΨeq : D.homomorphismFromMatrixOfGeneral QY e he = fun F => P.ofCl (ΨN F) := funext fun F =>
    (P.ofCl_toCl _).symm.trans (congrArg P.ofCl (D.toCl_homomorphismFromMatrixOfGeneral QY e he F))
  rw [hΦeq, hΨeq]
  refine ⟨IsComplexAlgebraHomomorphism.comp_of_necSuf P.toCl_isHom
      ((isComplexAlgebraHomomorphism_iff_necSuf (QuadraticSpaceWithBasis.algebraOfNecSuf QY.toNecSuf) D.matrixAlgebra
        ΦN).2 hΦN),
    IsComplexAlgebraHomomorphism.comp_of_necSuf
      ((isComplexAlgebraHomomorphism_iff_necSuf D.matrixAlgebra (QuadraticSpaceWithBasis.algebraOfNecSuf QY.toNecSuf)
        ΨN).2 hΨN) P.ofCl_isHom,
    fun a => ?_, fun F => ?_, ?_, fun F a ha => ?_⟩
  · exact (congrArg P.ofCl (hΨΦN (P.toCl a))).trans (P.ofCl_toCl a)
  · exact (congrArg ΦN (P.toCl_ofCl (ΨN F))).trans (hΦΨN F)
  · exact hbijN.comp P.toCl_bijective
  · exact (P.ofCl_toCl a).symm.trans (congrArg P.ofCl (hinvN F (P.toCl a) ha))

/-- 本文 `theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra`
を得たもの（e := `orthonormalBasis`）。必要十分版の系の定理が、必要十分版の本体を e := 必要十分版の `orthonormalBasis` に当てるのと
同じ手順で、上の本体の導出版を具体版の e に当てる（二つの e は別々に `Classical.choose` で選ぶので、必要十分版の系の定理そのものは
具体版の e について述べない）。 -/
theorem generalCliffordAlgebra_isomorphic_matrixAlgebra_of_necSuf (QY : QuadraticSpaceWithBasis Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    let e := D.orthonormalBasis QY hdim hQ
    let he := D.orthonormalBasis_spec QY hdim hQ
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra (D.homomorphismToMatrixOfGeneral QY e he) ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra (D.homomorphismFromMatrixOfGeneral QY e he) ∧
      (∀ a : QY.Cl, D.homomorphismFromMatrixOfGeneral QY e he (D.homomorphismToMatrixOfGeneral QY e he a) = a) ∧
      (∀ F : Mat (PowerSet D.M),
        D.homomorphismToMatrixOfGeneral QY e he (D.homomorphismFromMatrixOfGeneral QY e he F) = F) ∧
      Function.Bijective (D.homomorphismToMatrixOfGeneral QY e he) ∧
      (∀ (F : Mat (PowerSet D.M)) (a : QY.Cl),
        D.homomorphismToMatrixOfGeneral QY e he a = F → a = D.homomorphismFromMatrixOfGeneral QY e he F) :=
  D.generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family_of_necSuf QY _
    (D.orthonormalBasis_spec_of_necSuf QY hdim hQ)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
