/-
章「複素行列環」の、番号付けによる行列の添字の付け替えとその逆の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                              このファイル
  def_reindexing_of_matrices_by_numbering                                   reindexMatrix（ν_e）・entry_reindexMatrix
  def_reindexing_of_matrices_by_inverse_numbering                           inverseReindexMatrix（μ_e）・entry_inverseReindexMatrix
  claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism         reindexMatrix_add・reindexMatrix_mul・reindexMatrix_one・
                                                                            reindexMatrix_smul（書き出した四つの等式）・
                                                                            reindexMatrix_isComplexAlgebraHomomorphism
  claim_inverse_reindexing_after_reindexing_of_matrices_is_identity         inverseReindexMatrix_reindexMatrix
  claim_reindexing_after_inverse_reindexing_of_matrices_is_identity         reindexMatrix_inverseReindexMatrix
  claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism inverseReindexMatrix_add・inverseReindexMatrix_mul・
                                                                            inverseReindexMatrix_one・inverseReindexMatrix_smul・
                                                                            inverseReindexMatrix_isComplexAlgebraHomomorphism

{1,…,n} は `Idx n`、その番号付け (n, id_n) は `isNumbering_id n`、{1,…,n} が有限集合であることは `isFiniteSet_idx n` である。
Mat_{1,…,n}(ℂ) の単位行列の δ_{k,l} は `Idx n`（ℕ の部分型）の等号の判定を使う。
e の逆写像 e^{-1} は `IsNumbering.inv`（`FiniteSetSum/Numbering.lean`）で、μ_e は番号付けであることの証明 he を引数にとる。
ν_e の定義は e が番号付けであることを使わない（右辺は e の値だけで決まる）ので、ν_e は he をとらない。
X が有限集合であることの証明 hX は、行列の積を定めるのに要る（`Mat.mul hX`）。本文の「(n, e) は X の番号付けなので X は有限集合」は、
どの hX をとっても同じ命題の証明なので、任意の hX を引数にとる形で書く。

本文が引く有限集合の上の和の宣言は、V := ℂ^vec（`complexNumbersVectorSpace`、証明の中では S と書く）で引く。
  def_sum_over_finite_set（番号付けで開く行）                   sumOverFiniteSet_eq
  claim_linear_combinations_with_equal_terms_are_equal          linearCombination_eq_of_terms_eq

必要十分版は `NecSuf/ComplexMatrixAlgebra/MatrixReindexing/Reindexing.lean`、導出版は `MatrixReindexingFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Algebra

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

variable {X : Type u}

/-- 本文 `def_reindexing_of_matrices_by_numbering`：ν_e(F)_{k,l} := F_{e(k),e(l)}。 -/
def reindexMatrix {n : ℕ} (e : Idx n → X) (F : Mat X) : Mat (Idx n) := fun p =>
  Mat.entry F (e p.1) (e p.2)

theorem entry_reindexMatrix {n : ℕ} (e : Idx n → X) (F : Mat X) (k l : Idx n) :
    Mat.entry (reindexMatrix e F) k l = Mat.entry F (e k) (e l) := rfl

/-- 本文 `def_reindexing_of_matrices_by_inverse_numbering`：μ_e(G)_{x,y} := G_{e^{-1}(x),e^{-1}(y)}。 -/
noncomputable def inverseReindexMatrix {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G : Mat (Idx n)) : Mat X := fun p =>
  Mat.entry G (he.inv p.1) (he.inv p.2)

theorem entry_inverseReindexMatrix {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G : Mat (Idx n)) (x y : X) :
    Mat.entry (inverseReindexMatrix he G) x y = Mat.entry G (he.inv x) (he.inv y) := rfl

/-! ### ν_e は ℂ-代数の準同型である -/

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism`：加法を保つこと。 -/
theorem reindexMatrix_add {n : ℕ} (e : Idx n → X) (F G : Mat X) :
    reindexMatrix e (Mat.add F G) = Mat.add (reindexMatrix e F) (reindexMatrix e G) :=
  Mat.ext fun k l => calc
    Mat.entry (reindexMatrix e (Mat.add F G)) k l
        = Mat.entry (Mat.add F G) (e k) (e l) := rfl
    _ = Mat.entry F (e k) (e l) + Mat.entry G (e k) (e l) := rfl
    _ = Mat.entry (reindexMatrix e F) k l + Mat.entry (reindexMatrix e G) k l := rfl
    _ = Mat.entry (Mat.add (reindexMatrix e F) (reindexMatrix e G)) k l := rfl

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism`：乗法を保つこと。 -/
theorem reindexMatrix_mul (hX : IsFiniteSet X) {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (F G : Mat X) :
    reindexMatrix e (Mat.mul hX F G)
      = Mat.mul (isFiniteSet_idx n) (reindexMatrix e F) (reindexMatrix e G) :=
  Mat.ext fun k l => by
    -- 各 j で ν_e の定義：F_{e(k),e(j)} ·_{ℂ^vec} G_{e(j),e(l)} = ν_e(F)_{k,j} ·_{ℂ^vec} ν_e(G)_{j,l}
    have hterms : ∀ j : ℕ, 1 ≤ j → j ≤ n →
        complexNumbersVectorSpace.smul (numberedFamily e (fun z => Mat.entry F (e k) z) 0 j)
            (numberedFamily e (fun z => Mat.entry G z (e l)) complexNumbersVectorSpace.zero j)
          = complexNumbersVectorSpace.smul
              (numberedFamily (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e F) k i) 0 j)
              (numberedFamily (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e G) i l)
                complexNumbersVectorSpace.zero j) := by
      intro j hj1 hjn
      rw [numberedFamily_of_le e (fun z => Mat.entry F (e k) z) 0 j hj1 hjn,
        numberedFamily_of_le e (fun z => Mat.entry G z (e l)) complexNumbersVectorSpace.zero j hj1 hjn,
        numberedFamily_of_le (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e F) k i) 0 j hj1 hjn,
        numberedFamily_of_le (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e G) i l)
          complexNumbersVectorSpace.zero j hj1 hjn]
      rfl
    exact calc
      Mat.entry (reindexMatrix e (Mat.mul hX F G)) k l
          = Mat.entry (Mat.mul hX F G) (e k) (e l) := rfl
      _ = sumOverFiniteSet complexNumbersVectorSpace hX (fun z => Mat.entry F (e k) z)
            (fun z => Mat.entry G z (e l)) := rfl
      -- 本文 def_sum_over_finite_set を番号付け (n, e) で
      _ = linearCombination complexNumbersVectorSpace n
            (numberedFamily e (fun z => Mat.entry F (e k) z) 0)
            (numberedFamily e (fun z => Mat.entry G z (e l)) complexNumbersVectorSpace.zero) :=
          sumOverFiniteSet_eq complexNumbersVectorSpace hX _ _ n e he
      -- 各 j で本文 def_reindexing_of_matrices_by_numbering。本文 claim_linear_combinations_with_equal_terms_are_equal
      _ = linearCombination complexNumbersVectorSpace n
            (numberedFamily (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e F) k i) 0)
            (numberedFamily (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e G) i l)
              complexNumbersVectorSpace.zero) :=
          linearCombination_eq_of_terms_eq complexNumbersVectorSpace n _ _ _ _ hterms
      -- 本文 def_sum_over_finite_set を番号付け (n, id_n) で、右辺から左辺へ読む
      _ = sumOverFiniteSet complexNumbersVectorSpace (isFiniteSet_idx n)
            (fun i => Mat.entry (reindexMatrix e F) k i) (fun i => Mat.entry (reindexMatrix e G) i l) :=
          (sumOverFiniteSet_eq complexNumbersVectorSpace (isFiniteSet_idx n) _ _ n (fun i : Idx n => i)
            (isNumbering_id n)).symm
      _ = Mat.entry (Mat.mul (isFiniteSet_idx n) (reindexMatrix e F) (reindexMatrix e G)) k l := rfl

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism`：乗法の単位元を保つこと。
X の中の e(k) = e(l) と {1,…,n} の中の k = l は同値である（e は写像であることと、単射の条件）。 -/
theorem reindexMatrix_one [DecidableEq X] {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) :
    reindexMatrix e (Mat.one : Mat X) = (Mat.one : Mat (Idx n)) :=
  Mat.ext fun k l => by
    have hiff : e k = e l ↔ k = l := ⟨he.injective k l, fun h => by rw [h]⟩
    exact calc
      Mat.entry (reindexMatrix e (Mat.one : Mat X)) k l
          = Mat.entry (Mat.one : Mat X) (e k) (e l) := rfl
      _ = kroneckerDelta (e k) (e l) := rfl
      -- e(k) = e(l) と k = l は同値。本文 def_kronecker_delta
      _ = kroneckerDelta k l := by
          unfold kroneckerDelta
          by_cases h : k = l
          · rw [if_pos (hiff.2 h), if_pos h]
          · rw [if_neg (fun h' => h (hiff.1 h')), if_neg h]
      _ = Mat.entry (Mat.one : Mat (Idx n)) k l := rfl

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism`：スカラー倍を保つこと。 -/
theorem reindexMatrix_smul {n : ℕ} (e : Idx n → X) (l : ℂ) (F : Mat X) :
    reindexMatrix e (Mat.smul l F) = Mat.smul l (reindexMatrix e F) :=
  Mat.ext fun k k' => calc
    Mat.entry (reindexMatrix e (Mat.smul l F)) k k'
        = Mat.entry (Mat.smul l F) (e k) (e k') := rfl
    _ = l * Mat.entry F (e k) (e k') := rfl
    _ = l * Mat.entry (reindexMatrix e F) k k' := rfl
    _ = Mat.entry (Mat.smul l (reindexMatrix e F)) k k' := rfl

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism`：
ν_e : Mat_X(ℂ) → Mat_{1,…,n}(ℂ) は ℂ-代数の準同型である。 -/
theorem reindexMatrix_isComplexAlgebraHomomorphism (hX : IsFiniteSet X) [DecidableEq X] {n : ℕ}
    {e : Idx n → X} (he : IsNumbering n e) :
    IsComplexAlgebraHomomorphism (matricesComplexAlgebra hX)
      (matricesComplexAlgebra (isFiniteSet_idx n)) (reindexMatrix e) where
  isRingHomomorphism :=
    { map_add := reindexMatrix_add e
      map_mul := reindexMatrix_mul hX he
      map_one := reindexMatrix_one he }
  isLinearMap :=
    { map_add := reindexMatrix_add e
      map_smul := reindexMatrix_smul e }

/-! ### ν_e と μ_e は互いの逆である -/

/-- 本文 `claim_inverse_reindexing_after_reindexing_of_matrices_is_identity`：μ_e(ν_e(F)) = F。 -/
theorem inverseReindexMatrix_reindexMatrix {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (F : Mat X) : inverseReindexMatrix he (reindexMatrix e F) = F :=
  Mat.ext fun x y => calc
    Mat.entry (inverseReindexMatrix he (reindexMatrix e F)) x y
        = Mat.entry (reindexMatrix e F) (he.inv x) (he.inv y) := rfl
    _ = Mat.entry F (e (he.inv x)) (e (he.inv y)) := rfl
    -- e(e^{-1}(u)) = u を u := x, y に。本文 def_numbering_of_finite_set
    _ = Mat.entry F x y := by rw [he.apply_inv x, he.apply_inv y]

/-- 本文 `claim_reindexing_after_inverse_reindexing_of_matrices_is_identity`：ν_e(μ_e(G)) = G。 -/
theorem reindexMatrix_inverseReindexMatrix {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G : Mat (Idx n)) : reindexMatrix e (inverseReindexMatrix he G) = G :=
  Mat.ext fun k l => calc
    Mat.entry (reindexMatrix e (inverseReindexMatrix he G)) k l
        = Mat.entry (inverseReindexMatrix he G) (e k) (e l) := rfl
    _ = Mat.entry G (he.inv (e k)) (he.inv (e l)) := rfl
    -- e^{-1}(e(j)) = j を j := k, l に。本文 def_numbering_of_finite_set
    _ = Mat.entry G k l := by rw [he.inv_apply k, he.inv_apply l]

/-! ### μ_e は ℂ-代数の準同型である -/

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism`：加法を保つこと。 -/
theorem inverseReindexMatrix_add {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G H : Mat (Idx n)) :
    inverseReindexMatrix he (Mat.add G H)
      = Mat.add (inverseReindexMatrix he G) (inverseReindexMatrix he H) := calc
  inverseReindexMatrix he (Mat.add G H)
      = inverseReindexMatrix he
          (Mat.add (reindexMatrix e (inverseReindexMatrix he G))
            (reindexMatrix e (inverseReindexMatrix he H))) := by
        rw [reindexMatrix_inverseReindexMatrix he G, reindexMatrix_inverseReindexMatrix he H]
  _ = inverseReindexMatrix he
        (reindexMatrix e (Mat.add (inverseReindexMatrix he G) (inverseReindexMatrix he H))) := by
        rw [reindexMatrix_add e (inverseReindexMatrix he G) (inverseReindexMatrix he H)]
  _ = Mat.add (inverseReindexMatrix he G) (inverseReindexMatrix he H) :=
        inverseReindexMatrix_reindexMatrix he _

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism`：乗法を保つこと。 -/
theorem inverseReindexMatrix_mul (hX : IsFiniteSet X) {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) (G H : Mat (Idx n)) :
    inverseReindexMatrix he (Mat.mul (isFiniteSet_idx n) G H)
      = Mat.mul hX (inverseReindexMatrix he G) (inverseReindexMatrix he H) := calc
  inverseReindexMatrix he (Mat.mul (isFiniteSet_idx n) G H)
      = inverseReindexMatrix he
          (Mat.mul (isFiniteSet_idx n) (reindexMatrix e (inverseReindexMatrix he G))
            (reindexMatrix e (inverseReindexMatrix he H))) := by
        rw [reindexMatrix_inverseReindexMatrix he G, reindexMatrix_inverseReindexMatrix he H]
  _ = inverseReindexMatrix he
        (reindexMatrix e (Mat.mul hX (inverseReindexMatrix he G) (inverseReindexMatrix he H))) := by
        rw [reindexMatrix_mul hX he (inverseReindexMatrix he G) (inverseReindexMatrix he H)]
  _ = Mat.mul hX (inverseReindexMatrix he G) (inverseReindexMatrix he H) :=
        inverseReindexMatrix_reindexMatrix he _

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism`：乗法の単位元を保つこと。 -/
theorem inverseReindexMatrix_one [DecidableEq X] {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) :
    inverseReindexMatrix he (Mat.one : Mat (Idx n)) = (Mat.one : Mat X) := calc
  inverseReindexMatrix he (Mat.one : Mat (Idx n))
      = inverseReindexMatrix he (reindexMatrix e (Mat.one : Mat X)) := by
        rw [reindexMatrix_one he]
  _ = (Mat.one : Mat X) := inverseReindexMatrix_reindexMatrix he _

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism`：スカラー倍を保つこと。 -/
theorem inverseReindexMatrix_smul {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) (l : ℂ)
    (G : Mat (Idx n)) :
    inverseReindexMatrix he (Mat.smul l G) = Mat.smul l (inverseReindexMatrix he G) := calc
  inverseReindexMatrix he (Mat.smul l G)
      = inverseReindexMatrix he (Mat.smul l (reindexMatrix e (inverseReindexMatrix he G))) := by
        rw [reindexMatrix_inverseReindexMatrix he G]
  _ = inverseReindexMatrix he (reindexMatrix e (Mat.smul l (inverseReindexMatrix he G))) := by
        rw [reindexMatrix_smul e l (inverseReindexMatrix he G)]
  _ = Mat.smul l (inverseReindexMatrix he G) := inverseReindexMatrix_reindexMatrix he _

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism`：
μ_e : Mat_{1,…,n}(ℂ) → Mat_X(ℂ) は ℂ-代数の準同型である。 -/
theorem inverseReindexMatrix_isComplexAlgebraHomomorphism (hX : IsFiniteSet X) [DecidableEq X]
    {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) :
    IsComplexAlgebraHomomorphism (matricesComplexAlgebra (isFiniteSet_idx n))
      (matricesComplexAlgebra hX) (inverseReindexMatrix he) where
  isRingHomomorphism :=
    { map_add := inverseReindexMatrix_add he
      map_mul := inverseReindexMatrix_mul hX he
      map_one := inverseReindexMatrix_one he }
  isLinearMap :=
    { map_add := inverseReindexMatrix_add he
      map_smul := inverseReindexMatrix_smul he }

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
