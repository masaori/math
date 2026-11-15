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
  generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family・generalCliffordAlgebra_isomorphic_matrixAlgebra
                                                …_of_necSuf（具体版と同じ手順を、各段の導出版から組み立てる）

運び方:
- 具体版の V = W ⊕ W^* と、具体版の前提を写した必要十分版の前提 `D.toNecSuf` の V は、W^* が値の写像の同じ別の部分型なので別の集合である。
  V の点は `splitPointToNecSuf`（W^* の元を `DualSpace.toNecSuf` で写す）で必要十分版の点へ写し、`splitPointOfNecSuf` で戻す。
  どちらも値の写像を変えないので、V の演算・q_W・B_q を定義により保ち（`rfl`）、行き来すると元に戻る（`toNecSuf_injective`）。
- 基底 d・族 u・θ は、写した点が必要十分版のものと一致する（`splitBasis_toNecSuf`・`splitFamily_toNecSuf`・`mapToSplit_toNecSuf`）。
  θ' は必要十分版の θ' に写した点を入れたものに等しい（`mapFromSplit_eq_necSuf`）。座標の写像は具体版と必要十分版で別々に選ぶので、
  1,…,2M の番号で値が一致することを係数の一意性で示す（`coordinate_splitBasis_eq_necSuf`。Y の側は既存の `coordinate_eq_necSuf`）。
- Y の側は同じ型の上で、具体版の前提の組 `QY` を `QY.toNecSuf`（欄を写すだけ）として読む。
- 系の定理は、主定理の導出版（`MutuallyInverseHomomorphismsFromNecSuf.lean`）と同じく、具体版と同じ手順を各段の導出版
  （誘導される準同型・主定理の準同型・この節の等長写像の主張）から組み立てる。具体版の Cl(Y,Q) と必要十分版の Cl(Y,Q) は別の集合なので、
  必要十分版の系の定理を直に特殊化することはしない。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws`、a + (-a) = 0 の `add_neg_cancel`、(-a)·b = -(a·b) の `neg_mul`、
-(-a) = a の `neg_neg`、i · i = -1 の `imaginaryUnit_mul_self`、h が 1 + 1 の逆元であること（`inverseOfTwo_mul`・`mul_inverseOfTwo`）である。
-/
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpace
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.InducedHomomorphismFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.OrthonormalBasisFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphismsFromNecSuf
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.GeneratorsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpace

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
    splitPointToNecSuf D.spaceW (D.splitBasis k) = D.toNecSuf.splitBasis complexCliffordLaws k := by
  show splitPointToNecSuf D.spaceW (concatenatedFamily D.spaceW (dualSpaceVectorSpace D.spaceW) D.M D.w D.f k)
    = NecSuf.VectorSpace.concatenatedFamily D.toNecSuf.spaceW
      (NecSuf.VectorSpace.dualSpaceVectorSpace complexCliffordLaws.dualSpaceVectorSpaceLaws D.toNecSuf.spaceW)
      D.M D.toNecSuf.w D.toNecSuf.f k
  unfold concatenatedFamily NecSuf.VectorSpace.concatenatedFamily
  split_ifs <;> rfl

/-- 具体版の族 u を写した点は、必要十分版の族 u（i := imaginaryUnit）である。 -/
theorem splitFamily_toNecSuf (k : ℕ) :
    splitPointToNecSuf D.spaceW (D.splitFamily k) = D.toNecSuf.splitFamily complexCliffordLaws imaginaryUnit k := by
  unfold splitFamily NecSuf.Clifford.SplitData.splitFamily
  split_ifs with h1 h2 h2
  · rfl
  · exact absurd h1 h2
  · exact absurd h2 h1
  · rfl

/-- 具体版の d の座標の写像と、必要十分版の d の座標の写像を写した点で開いたものは、1,…,2M の番号で一致する（係数の一意性）。 -/
theorem coordinate_splitBasis_eq_necSuf (y : W × DualSpace D.spaceW) (k : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) :
    coordinate D.space.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis k y
      = NecSuf.VectorSpace.coordinate D.spaceN.space (D.M + D.M) (D.toNecSuf.splitBasis complexCliffordLaws)
          (D.toNecSuf.splitBasis_isBasis complexCliffordLaws) k (splitPointToNecSuf D.spaceW y) := by
  have h := congrArg (splitPointToNecSuf D.spaceW)
    (linearCombination_coordinate D.space.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis y)
  rw [toNecSuf_linearCombination] at h
  have hd : (fun l => splitPointToNecSuf D.spaceW (D.splitBasis l)) = D.toNecSuf.splitBasis complexCliffordLaws :=
    funext D.splitBasis_toNecSuf
  rw [hd] at h
  exact (NecSuf.VectorSpace.coordinate_eq_of_linearCombination_eq D.spaceN.space complexUniquenessLaws (D.M + D.M)
    _ (D.toNecSuf.splitBasis_isBasis complexCliffordLaws) _ _ h k hk1 hk).symm

/-! ### 基底 d と e -/

/-- 本文 `claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary` の一つ目を、必要十分版から得たもの。 -/
theorem splitBasis_first_of_necSuf (m : ℕ) (hmM : m ≤ D.M) :
    D.splitBasis m = embedFirst (dualSpaceVectorSpace D.spaceW) (D.w m) := by
  apply D.toNecSuf_injective
  rw [D.splitBasis_toNecSuf]
  exact D.toNecSuf.splitBasis_first complexCliffordLaws m hmM

/-- 本文 `claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary` の二つ目を、必要十分版から得たもの。 -/
theorem splitBasis_second_of_necSuf (m : ℕ) (hm1 : 1 ≤ m) :
    D.splitBasis (D.M + m) = embedSecond D.spaceW (D.f m) := by
  apply D.toNecSuf_injective
  rw [D.splitBasis_toNecSuf]
  exact D.toNecSuf.splitBasis_second complexCliffordLaws m hm1

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
  _ = D.spaceN.form (D.toNecSuf.splitFamily complexCliffordLaws imaginaryUnit k) := by rw [D.splitFamily_toNecSuf k]
  _ = 1 := D.toNecSuf.form_splitFamily complexCliffordLaws neg_mul neg_neg imaginaryUnit imaginaryUnit_mul_self k hk1 hk

/-- 本文 `claim_family_in_split_space_is_orthogonal` の二つ目の場合を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_splitFamily_first_second_of_necSuf (m m' : ℕ) (hm1 : 1 ≤ m) (hmM : m ≤ D.M) (hm'1 : 1 ≤ m')
    (hm'M : m' ≤ D.M) :
    polarization D.space.space D.space.form (D.splitFamily m) (D.splitFamily (D.M + m')) = 0 := calc
  polarization D.space.space D.space.form (D.splitFamily m) (D.splitFamily (D.M + m'))
      = NecSuf.VectorSpace.polarization D.spaceN.space D.spaceN.form (splitPointToNecSuf D.spaceW (D.splitFamily m))
          (splitPointToNecSuf D.spaceW (D.splitFamily (D.M + m'))) := rfl
  _ = NecSuf.VectorSpace.polarization D.spaceN.space D.spaceN.form
        (D.toNecSuf.splitFamily complexCliffordLaws imaginaryUnit m)
        (D.toNecSuf.splitFamily complexCliffordLaws imaginaryUnit (D.M + m')) := by
      rw [D.splitFamily_toNecSuf m, D.splitFamily_toNecSuf (D.M + m')]
  _ = 0 := D.toNecSuf.polarization_splitFamily_first_second complexCliffordLaws add_neg_cancel imaginaryUnit m m'
      hm1 hmM hm'1 hm'M

/-- 本文 `claim_family_in_split_space_is_orthogonal` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_splitFamily_of_necSuf (k l : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) (hl1 : 1 ≤ l)
    (hl : l ≤ D.M + D.M) (hkl : k ≠ l) :
    polarization D.space.space D.space.form (D.splitFamily k) (D.splitFamily l) = 0 := calc
  polarization D.space.space D.space.form (D.splitFamily k) (D.splitFamily l)
      = NecSuf.VectorSpace.polarization D.spaceN.space D.spaceN.form (splitPointToNecSuf D.spaceW (D.splitFamily k))
          (splitPointToNecSuf D.spaceW (D.splitFamily l)) := rfl
  _ = NecSuf.VectorSpace.polarization D.spaceN.space D.spaceN.form
        (D.toNecSuf.splitFamily complexCliffordLaws imaginaryUnit k)
        (D.toNecSuf.splitFamily complexCliffordLaws imaginaryUnit l) := by
      rw [D.splitFamily_toNecSuf k, D.splitFamily_toNecSuf l]
  _ = 0 := D.toNecSuf.polarization_splitFamily complexCliffordLaws add_neg_cancel imaginaryUnit k l hk1 hk hl1 hl hkl

/-! ### θ と θ' -/

/-- 具体版の θ(x) を写した点は、必要十分版の θ(x) である。 -/
theorem mapToSplit_toNecSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (x : Y) :
    splitPointToNecSuf D.spaceW (D.mapToSplit QY e he x)
      = D.toNecSuf.mapToSplit complexCliffordLaws imaginaryUnit QY.toNecSuf e he.toNecSuf x := by
  show splitPointToNecSuf D.spaceW (linearCombination D.space.space (D.M + D.M)
      (fun k => coordinate QY.space (D.M + D.M) e he.isBasis k x) D.splitFamily)
    = NecSuf.VectorSpace.linearCombination D.spaceN.space (D.M + D.M)
      (fun k => NecSuf.VectorSpace.coordinate QY.space.toNecSuf (D.M + D.M) e he.toNecSuf.isBasis k x)
      (D.toNecSuf.splitFamily complexCliffordLaws imaginaryUnit)
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
      = D.toNecSuf.mapFromSplit complexCliffordLaws imaginaryUnit inverseOfTwo QY.toNecSuf e
          (splitPointToNecSuf D.spaceW y) := by
  show linearCombination QY.space (D.M + D.M)
      (fun l => coordinate D.space.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis l y) (D.inverseFamily QY e)
    = NecSuf.VectorSpace.linearCombination QY.space.toNecSuf (D.M + D.M)
      (fun l => NecSuf.VectorSpace.coordinate D.spaceN.space (D.M + D.M) (D.toNecSuf.splitBasis complexCliffordLaws)
        (D.toNecSuf.splitBasis_isBasis complexCliffordLaws) l (splitPointToNecSuf D.spaceW y))
      (D.toNecSuf.inverseFamily imaginaryUnit inverseOfTwo QY.toNecSuf e)
  rw [linearCombination_eq_necSuf, D.inverseFamily_eq_necSuf QY e]
  exact NecSuf.VectorSpace.linearCombination_eq_of_terms_eq _ (D.M + D.M) _ _ _ _ fun l hl1 hl => by
    rw [D.coordinate_splitBasis_eq_necSuf y l hl1 hl]

/-- 本文 `claim_map_to_split_quadratic_space_is_isometry` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapToSplit_isIsometry_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsIsometry QY.space D.space.space QY.form D.space.form (D.mapToSplit QY e he) := by
  have hN := D.toNecSuf.mapToSplit_isIsometry complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e
    he.toNecSuf
  have heq : D.mapToSplit QY e he
      = fun x => D.splitPointOfNecSuf (D.toNecSuf.mapToSplit complexCliffordLaws imaginaryUnit QY.toNecSuf e
          he.toNecSuf x) :=
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
      _ = D.spaceN.form (D.toNecSuf.mapToSplit complexCliffordLaws imaginaryUnit QY.toNecSuf e he.toNecSuf x) := by
          rw [D.mapToSplit_toNecSuf QY e he x]
      _ = QY.form x := hN.map_form x }

/-- 本文 `claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapFromSplit_splitFamily_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y) (k : ℕ) (hk1 : 1 ≤ k)
    (hk : k ≤ D.M + D.M) : D.mapFromSplit QY e (D.splitFamily k) = e k := by
  rw [D.mapFromSplit_eq_necSuf QY e, D.splitFamily_toNecSuf k]
  exact D.toNecSuf.mapFromSplit_splitFamily complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf e k hk1 hk

/-- 本文 `claim_map_to_split_quadratic_space_sends_family_to_basis` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapToSplit_inverseFamily_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (l : ℕ) (hl1 : 1 ≤ l) (hl : l ≤ D.M + D.M) :
    D.mapToSplit QY e he (D.inverseFamily QY e l) = D.splitBasis l := by
  apply D.toNecSuf_injective
  rw [D.mapToSplit_toNecSuf QY e he, D.splitBasis_toNecSuf, D.inverseFamily_eq_necSuf QY e]
  exact D.toNecSuf.mapToSplit_inverseFamily complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo inverseOfTwo_mul QY.toNecSuf e he.toNecSuf l hl1 hl

/-- 本文 `claim_map_from_split_after_map_to_split_is_identity` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapFromSplit_mapToSplit_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (x : Y) :
    D.mapFromSplit QY e (D.mapToSplit QY e he x) = x := by
  rw [D.mapFromSplit_eq_necSuf QY e, D.mapToSplit_toNecSuf QY e he]
  exact D.toNecSuf.mapFromSplit_mapToSplit complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf e he.toNecSuf x

/-- 本文 `claim_map_to_split_after_map_from_split_is_identity` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapToSplit_mapFromSplit_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (y : W × DualSpace D.spaceW) :
    D.mapToSplit QY e he (D.mapFromSplit QY e y) = y := by
  apply D.toNecSuf_injective
  rw [D.mapToSplit_toNecSuf QY e he, D.mapFromSplit_eq_necSuf QY e]
  exact D.toNecSuf.mapToSplit_mapFromSplit complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf e he.toNecSuf
    (splitPointToNecSuf D.spaceW y)

/-- 本文 `claim_map_from_split_quadratic_space_is_isometry` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem mapFromSplit_isIsometry_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsIsometry D.space.space QY.space D.space.form QY.form (D.mapFromSplit QY e) := by
  have hN := D.toNecSuf.mapFromSplit_isIsometry complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf
  have heq : D.mapFromSplit QY e
      = fun y => D.toNecSuf.mapFromSplit complexCliffordLaws imaginaryUnit inverseOfTwo QY.toNecSuf e
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
          = QY.form (D.toNecSuf.mapFromSplit complexCliffordLaws imaginaryUnit inverseOfTwo QY.toNecSuf e
              (splitPointToNecSuf D.spaceW y)) := by rw [D.mapFromSplit_eq_necSuf QY e y]
      _ = D.spaceN.form (splitPointToNecSuf D.spaceW y) := hN.map_form _
      _ = D.space.form y := rfl }

/-! ### 系の定理 -/

/-- 系の定理の本体（`generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family`）を、具体版と同じ手順で、
各段の導出版から組み立てたもの。 -/
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
  let θ := D.mapToSplit QY e he
  let θ' := D.mapFromSplit QY e
  let hθ := D.mapToSplit_isIsometry_of_necSuf QY e he
  let hθ' := D.mapFromSplit_isIsometry_of_necSuf QY e he
  let Clθ := QuadraticSpaceWithBasis.inducedHom QY D.space θ hθ
  let Clθ' := QuadraticSpaceWithBasis.inducedHom D.space QY θ' hθ'
  let Φ := D.homomorphismToMatrix
  let Ψ := D.homomorphismFromMatrix
  let ΦY := D.homomorphismToMatrixOfGeneral QY e he
  let ΨY := D.homomorphismFromMatrixOfGeneral QY e he
  have hΦY : IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra ΦY :=
    IsComplexAlgebraHomomorphism.comp_of_necSuf (φ := Clθ) (ψ := Φ)
      (QuadraticSpaceWithBasis.inducedHom_isHom_of_necSuf QY D.space θ hθ) D.homomorphismToMatrix_isHom_of_necSuf
  have hΨY : IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra ΨY :=
    IsComplexAlgebraHomomorphism.comp_of_necSuf (φ := Ψ) (ψ := Clθ') D.homomorphismFromMatrix_isHom_of_necSuf
      (QuadraticSpaceWithBasis.inducedHom_isHom_of_necSuf D.space QY θ' hθ')
  have h1 : ∀ a : QY.Cl, Clθ' (Clθ a) = a :=
    QuadraticSpaceWithBasis.inducedHom_comp_inducedHom_of_necSuf QY D.space θ hθ θ' hθ'
      (D.mapFromSplit_mapToSplit_of_necSuf QY e he)
  have h2 : ∀ X : D.space.Cl, Clθ (Clθ' X) = X :=
    QuadraticSpaceWithBasis.inducedHom_comp_inducedHom_of_necSuf D.space QY θ' hθ' θ hθ
      (D.mapToSplit_mapFromSplit_of_necSuf QY e he)
  have hΨΦ : ∀ a : QY.Cl, ΨY (ΦY a) = a := fun a => calc
    ΨY (ΦY a) = Clθ' (Ψ (Φ (Clθ a))) := rfl
    _ = Clθ' (Clθ a) := by
        rw [show Ψ (Φ (Clθ a)) = Clθ a from D.homomorphismFromMatrix_homomorphismToMatrix_of_necSuf (Clθ a)]
    _ = a := h1 a
  have hΦΨ : ∀ F : Mat (PowerSet D.M), ΦY (ΨY F) = F := fun F => calc
    ΦY (ΨY F) = Φ (Clθ (Clθ' (Ψ F))) := rfl
    _ = Φ (Ψ F) := by rw [h2 (Ψ F)]
    _ = F := D.homomorphismToMatrix_homomorphismFromMatrix_of_necSuf F
  have hinj : Function.Injective ΦY := by
    intro a a' haa'
    calc a = ΨY (ΦY a) := (hΨΦ a).symm
      _ = ΨY (ΦY a') := by rw [haa']
      _ = a' := hΨΦ a'
  have hsurj : Function.Surjective ΦY := fun F => ⟨ΨY F, hΦΨ F⟩
  have hinv : ∀ (F : Mat (PowerSet D.M)) (a : QY.Cl), ΦY a = F → a = ΨY F := by
    intro F a ha
    apply hinj
    calc ΦY a = F := ha
      _ = ΦY (ΨY F) := (hΦΨ F).symm
  exact ⟨hΦY, hΨY, hΨΦ, hΦΨ, ⟨hinj, hsurj⟩, hinv⟩

/-- 本文 `theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra`
を、各段の導出版から組み立てたもの（e := `orthonormalBasis`）。 -/
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
