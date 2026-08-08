/-
章「転送行列」の主張「行列の冪の成分は、道に沿った成分の積の和である」（ラベル
`claim_matrix_pow_entry`）の具体版、および定義「行配位の道と、道に沿った成分の積」
（ラベル `def_row_walk` / `def_walk_weight`）。

人手証明の正本は `structured-latex/content/main-text.ts`。

  人手証明のラベル            このファイル
  def_row_walk                RowWalk / rowWalksBetween
  def_walk_weight             walkWeight
  claim_matrix_pow_entry      rowMatrixPow_apply（Step 1–9 と 1 対 1）

添字の対応。人手証明の道は写像 `p : {0,1,...,k} → R_L` であり、Lean では
`Fin (k+1) → RowConfig L` として書く（長さ `k` の道の点は `k+1` 個）。
冪の側は `rowMatrixPow` が引数を 1 つずらしてある（`WeightProduct.lean` の約束。
引数 `m` が人手証明の指数 `m+1` を表す）ので、人手証明の `k = m+1` として述べる。

住処: 人手証明のこれらのブロックは可算側（ℤ[x]）を宣言している。したがって ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.WeightProduct

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 長さ `k` の道 `p : {0,1,...,k} → R_L`（`def_row_walk`）。
定義域は整数の集合であって剰余類の集合ではないので、行配位の族 `RowFamily`
（`ZMod L` 上の写像）とは別の対象である。 -/
def RowWalk (k : ℕ) : Type := Fin (k + 1) → RowConfig L

instance (k : ℕ) : Fintype (RowWalk L k) := by unfold RowWalk RowConfig; infer_instance
instance (k : ℕ) : DecidableEq (RowWalk L k) := by unfold RowWalk RowConfig; infer_instance

/-- 両端を指定した道の全体 `W_{L,k}(τ, τ'')`（`def_row_walk`）。 -/
def rowWalksBetween (k : ℕ) (τ τ'' : RowConfig L) : Finset (RowWalk L k) :=
  univ.filter fun p => p 0 = τ ∧ p (Fin.last k) = τ''

/-- 道に沿った成分の積 `w_A(p) = ∏_{i=0}^{k-1} A_{p(i),p(i+1)}`（`def_walk_weight`）。 -/
noncomputable def walkWeight {k : ℕ} (A : RowMatrix L) (p : RowWalk L k) : Polynomial ℤ :=
  ∏ i : Fin k, A (p i.castSucc) (p i.succ)

/-- 人手証明の Step 6 の延長写像 `Φ`。道 `p` の後ろに `τ'''` を 1 点足す。 -/
def extendWalk {k : ℕ} (p : RowWalk L k) (τ''' : RowConfig L) : RowWalk L (k + 1) :=
  Fin.snoc p τ'''

/-- 人手証明の Step 7。延長した道の重みは、もとの重みに最後の成分を掛けたものである。 -/
lemma walkWeight_extendWalk {k : ℕ} (A : RowMatrix L) (p : RowWalk L k) (τ''' : RowConfig L) :
    walkWeight L A (extendWalk L p τ''')
      = walkWeight L A p * A (p (Fin.last k)) τ''' := by
  -- 因子が `k+1` 個あるうちの最後（`i = k`）を分ける。
  unfold walkWeight extendWalk
  rw [Fin.prod_univ_castSucc]
  congr 1
  · refine prod_congr rfl fun i _ => ?_
    rw [Fin.snoc_castSucc, Fin.succ_castSucc, Fin.snoc_castSucc]
  · rw [Fin.snoc_castSucc, Fin.succ_last, Fin.snoc_last]

/-- 人手証明の Step 6 の前半。延長した道は両端の条件を満たす。 -/
lemma extendWalk_zero {k : ℕ} (p : RowWalk L k) (τ''' : RowConfig L) :
    extendWalk L p τ''' 0 = p 0 := by
  unfold extendWalk
  rw [← Fin.castSucc_zero, Fin.snoc_castSucc]

lemma extendWalk_last {k : ℕ} (p : RowWalk L k) (τ''' : RowConfig L) :
    extendWalk L p τ''' (Fin.last (k + 1)) = τ''' := by
  unfold extendWalk
  rw [Fin.snoc_last]

/-- 人手証明の Step 6 の逆向きの写像 `Ψ` の第 2 成分（定義域を狭めた写像）。 -/
def restrictWalk {k : ℕ} (q : RowWalk L (k + 1)) : RowWalk L k := Fin.init q

lemma restrictWalk_extendWalk {k : ℕ} (p : RowWalk L k) (τ''' : RowConfig L) :
    restrictWalk L (extendWalk L p τ''') = p := Fin.init_snoc

lemma extendWalk_restrictWalk {k : ℕ} (q : RowWalk L (k + 1)) :
    extendWalk L (restrictWalk L q) (q (Fin.last (k + 1))) = q := Fin.snoc_init_self

lemma restrictWalk_apply_zero {k : ℕ} (q : RowWalk L (k + 1)) :
    restrictWalk L q 0 = q 0 := by
  unfold restrictWalk Fin.init
  rw [Fin.castSucc_zero]

lemma restrictWalk_apply_last {k : ℕ} (q : RowWalk L (k + 1)) :
    restrictWalk L q (Fin.last k) = q (Fin.last k).castSucc := rfl

/-- 人手証明の Step 1。長さ `1` の道は両端で決まるので、両端を指定した道はちょうど 1 つである。 -/
lemma rowWalksBetween_one (τ τ'' : RowConfig L) :
    rowWalksBetween L 1 τ τ'' = {(fun i => if i = 0 then τ else τ'' : RowWalk L 1)} := by
  refine eq_singleton_iff_unique_mem.mpr ⟨?_, ?_⟩
  · refine mem_filter.mpr ⟨mem_univ _, ?_, ?_⟩
    · simp
    · norm_num [Fin.last]
  · intro p hp
    obtain ⟨-, hp0, hp1⟩ := mem_filter.mp hp
    funext i
    -- `Fin 2` の元は `0` か `1` のいずれかである。
    rcases Fin.exists_fin_two.mp ⟨i, rfl⟩ with h | h
    all_goals
      first
        | (subst h; simpa using hp0)
        | (subst h; simpa [Fin.last] using hp1)

/-- 主張「行列の冪の成分は、道に沿った成分の積の和である」の具体版。
人手証明の `k = m+1` について
`(A^k)_{τ,τ''} = Σ_{p ∈ W_{L,k}(τ,τ'')} w_A(p)`。 -/
theorem rowMatrixPow_apply (A : RowMatrix L) (m : ℕ) (τ τ'' : RowConfig L) :
    rowMatrixPow L A m τ τ''
      = ∑ p ∈ rowWalksBetween L (m + 1) τ τ'', walkWeight L A p := by
  induction m generalizing τ τ'' with
  | zero =>
      -- Step 1（`k = 1` の場合）。
      rw [rowMatrixPow_one, rowWalksBetween_one, sum_singleton]
      unfold walkWeight
      rw [Fin.prod_univ_one]
      norm_num [Fin.ext_iff]
  | succ m ih =>
      -- Step 3（冪と積の定義を使う）。
      rw [rowMatrixPow_succ]
      show ∑ τ' : RowConfig L, rowMatrixPow L A m τ τ' * A τ' τ'' = _
      -- Step 4（帰納法の仮定を代入する）。
      rw [sum_congr rfl fun τ' _ => by rw [ih τ τ']]
      -- Step 5（分配則で括弧を外す）。
      rw [sum_congr rfl fun τ' _ => sum_mul _ _ _]
      -- Step 8 の前半（二重和を、両端の一方だけを固定した道の上の 1 つの和として読む）。
      have hfiber :
          ∑ τ' : RowConfig L,
              ∑ p ∈ rowWalksBetween L (m + 1) τ τ', walkWeight L A p * A τ' τ''
            = ∑ p ∈ univ.filter (fun p : RowWalk L (m + 1) => p 0 = τ),
                walkWeight L A p * A (p (Fin.last (m + 1))) τ'' := by
        rw [← sum_fiberwise (univ.filter fun p : RowWalk L (m + 1) => p 0 = τ)
              (fun p => p (Fin.last (m + 1))) _]
        refine sum_congr rfl fun τ' _ => ?_
        refine sum_congr ?_ ?_
        · unfold rowWalksBetween
          rw [filter_filter]
          exact filter_congr fun p _ => by constructor <;> (intro h; exact ⟨h.1, h.2⟩)
        · intro p hp
          obtain ⟨-, hlast⟩ := mem_filter.mp hp
          rw [hlast]
      rw [hfiber]
      -- Step 6・Step 7（延長が 1 対 1 対応であり、対応する項が等しい）。
      refine sum_nbij' (i := fun p => extendWalk L p τ'') (j := fun q => restrictWalk L q)
        ?_ ?_ ?_ ?_ ?_
      · intro p hp
        obtain ⟨-, hp0⟩ := mem_filter.mp hp
        refine mem_filter.mpr ⟨mem_univ _, ?_, ?_⟩
        · rw [extendWalk_zero, hp0]
        · rw [extendWalk_last]
      · intro q hq
        obtain ⟨-, hq0, -⟩ := mem_filter.mp hq
        refine mem_filter.mpr ⟨mem_univ _, ?_⟩
        rw [restrictWalk_apply_zero, hq0]
      · intro p _
        exact restrictWalk_extendWalk L p τ''
      · intro q hq
        obtain ⟨-, -, hqlast⟩ := mem_filter.mp hq
        rw [← hqlast]
        exact extendWalk_restrictWalk L q
      · intro p _
        rw [walkWeight_extendWalk]

end Ising2DLambda.TransferMatrix
