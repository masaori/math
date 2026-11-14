/-
章「複素行列環」の、{1,…,M} の部分集合の組全体 P_M × P_M の番号付け。人手証明と 1 対 1 に対応させる。
ℂ を含まないので、具体版と必要十分版が同じこのファイルを引く（必要十分版・導出版を置かない）。

  本文のラベル                                         このファイル
  def_numbering_of_pairs_of_subsets                    pairCount（N_M := (2^M)^2）・one_le_pairCount（N_M ≥ 1）・
                                                       pairNumbering（p_M）
  claim_numbering_of_pairs_of_subsets_is_numbering     pairNumbering_isNumbering・isFiniteSet_powerSetPairs

本文の P_M × P_M（P_M の二つの元の順序対の全体）は Lean の積の型 `PowerSet M × PowerSet M` で表し、
順序対の等しさは `Prod.ext` で書く。η := η_{2^M,2} は `baseNNumbering (twoPower M) 2`、
{1,2} の元 1・2 は `Idx 2` の元 ⟨1, _⟩・⟨2, _⟩ である。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorProduct.BaseNNumbering

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- {1,2} の元 1。 -/
def idxTwoFirst : Idx 2 := ⟨1, le_refl 1, by omega⟩

/-- {1,2} の元 2。 -/
def idxTwoSecond : Idx 2 := ⟨2, by omega, le_refl 2⟩

/-- 本文 `def_numbering_of_pairs_of_subsets`：N_M := (2^M)^2（`def_power_of_nonnegative_integer` の冪で n := 2^M、k := 2）。 -/
def pairCount (M : ℕ) : ℕ := natPower (twoPower M) 2

/-- 本文 `def_numbering_of_pairs_of_subsets`：2^M ≥ 1 なので N_M = 2^M · (2^M · 1) ≥ 1。 -/
theorem one_le_pairCount (M : ℕ) : 1 ≤ pairCount M := by
  have h := one_le_twoPower M
  show 1 ≤ twoPower M * (twoPower M * 1)
  rw [Nat.mul_one]
  exact Nat.one_le_iff_ne_zero.mpr (Nat.mul_ne_zero (by omega) (by omega))

/-- 本文 `def_numbering_of_pairs_of_subsets`：p_M(m) := (e_M(η(m)(1)), e_M(η(m)(2)))、η := η_{2^M,2}。 -/
def pairNumbering (M : ℕ) (m : Idx (pairCount M)) : PowerSet M × PowerSet M :=
  (binaryNumbering M (baseNNumbering (twoPower M) 2 m idxTwoFirst),
    binaryNumbering M (baseNNumbering (twoPower M) 2 m idxTwoSecond))

/-- 本文 `claim_numbering_of_pairs_of_subsets_is_numbering`：(N_M, p_M) は P_M × P_M の番号付けである。 -/
theorem pairNumbering_isNumbering (M : ℕ) : IsNumbering (pairCount M) (pairNumbering M) := by
  -- (2^M, e_M) は P_M の番号付け（claim_binary_numbering_is_numbering_of_power_set）
  have he := binaryNumbering_isNumbering M
  -- (N_M, η) は X_{2^M,2} の番号付け（claim_base_n_numbering_is_numbering_of_maps で n := 2^M、k := 2）
  have hη := baseNNumbering_isNumbering (twoPower M) 2
  -- η := η_{2^M,2}
  let η := baseNNumbering (twoPower M) 2
  constructor
  · -- 単射の条件
    intro m m' hmm'
    -- 順序対の等しさから、s ∈ {1,2} のそれぞれについて e_M(η(m)(s)) = e_M(η(m')(s))
    have h1 : binaryNumbering M (η m idxTwoFirst) = binaryNumbering M (η m' idxTwoFirst) :=
      congrArg Prod.fst hmm'
    have h2 : binaryNumbering M (η m idxTwoSecond) = binaryNumbering M (η m' idxTwoSecond) :=
      congrArg Prod.snd hmm'
    -- e_M の単射の条件から η(m)(s) = η(m')(s)
    have h1' : η m idxTwoFirst = η m' idxTwoFirst := he.injective _ _ h1
    have h2' : η m idxTwoSecond = η m' idxTwoSecond := he.injective _ _ h2
    -- すべての s ∈ {1,2} で成り立つので、X_{2^M,2} の元として η(m) = η(m')
    have hηmm' : η m = η m' := by
      apply MapsBetweenInitialSegments.ext
      intro s
      by_cases hs : s.1 = 1
      · have hs' : s = idxTwoFirst := Subtype.ext hs
        rw [hs']
        exact h1'
      · have hs' : s = idxTwoSecond := Subtype.ext (by have := s.2; show s.1 = 2; omega)
        rw [hs']
        exact h2'
    -- η の単射の条件から m = m'
    exact hη.injective _ _ hηmm'
  · -- 全射の条件
    intro ST
    -- x(1) := e_M^{-1}(S)、x(2) := e_M^{-1}(T)
    let x : MapsBetweenInitialSegments (twoPower M) 2 :=
      fun s => if s.1 = 1 then he.inv ST.1 else he.inv ST.2
    -- m := η^{-1}(x)
    let m : Idx (pairCount M) := hη.inv x
    refine ⟨m, ?_⟩
    calc pairNumbering M m
        -- def_numbering_of_pairs_of_subsets
        = (binaryNumbering M (η m idxTwoFirst), binaryNumbering M (η m idxTwoSecond)) := rfl
      -- m = η^{-1}(x)
      _ = (binaryNumbering M (η (hη.inv x) idxTwoFirst),
            binaryNumbering M (η (hη.inv x) idxTwoSecond)) := rfl
      -- η(η^{-1}(x)) = x（def_numbering_of_finite_set）
      _ = (binaryNumbering M (x idxTwoFirst), binaryNumbering M (x idxTwoSecond)) := by
          have hηx : η (hη.inv x) = x := hη.apply_inv x
          rw [hηx]
      -- x の定め方
      _ = (binaryNumbering M (he.inv ST.1), binaryNumbering M (he.inv ST.2)) := rfl
      -- e_M(e_M^{-1}(U)) = U を U := S, T に（def_numbering_of_finite_set）
      _ = (ST.1, ST.2) := by rw [he.apply_inv ST.1, he.apply_inv ST.2]
      _ = ST := rfl

/-- 本文 `claim_numbering_of_pairs_of_subsets_is_numbering`：P_M × P_M は有限集合である。 -/
theorem isFiniteSet_powerSetPairs (M : ℕ) : IsFiniteSet (PowerSet M × PowerSet M) :=
  ⟨pairCount M, pairNumbering M, pairNumbering_isNumbering M⟩

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
