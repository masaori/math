/-
章「転送行列」の主張「行列の冪の成分は、道に沿った成分の積の和である」（ラベル
`claim_matrix_pow_entry`）の具体版、および定義「行配位の道と、道に沿った成分の積」
（ラベル `def_row_walk` / `def_walk_weight`）。

人手証明の正本は `structured-latex/content/main-text.ts`。

  人手証明のラベル            このファイル
  def_row_walk                RowWalk / rowWalksBetween
  def_walk_weight             walkWeight
  claim_matrix_pow_entry      rowMatrixPow_apply

人手証明の証明は段に番号を振らず、次の 5 つの部分からなる。このファイルとの対応は次のとおり。

  人手証明の部分                        このファイル
  出発点（k = 1 の場合）                rowWalksBetween_one と `induction` の `zero` の枝
  帰納法の仮定                          `induction ... generalizing τ τ''` の `ih`
  道の延長が 1 対 1 対応であること      extendWalk / restrictWalk とその 4 つの補題
                                        （人手証明の Φ と Ψ、および互いに逆であること）
  対応する項が等しいこと                walkWeight_extendWalk
  k + 1 の場合（5 つの等号）            `succ` の枝。第 1 の等号が rowMatrixPow_succ、
                                        第 2 が ih、第 3 が sum_mul、第 4 が hfiber、
                                        第 5 が sum_nbij'

添字の対応。人手証明の道は写像 `p : {0,1,...,k} → R_L` であり、Lean では
`Fin (k+1) → RowConfig L` として書く（長さ `k` の道の点は `k+1` 個）。
冪の側は `rowMatrixPow` が引数を 1 つずらしてある（`WeightProduct.lean` の約束。
引数 `m` が人手証明の指数 `m+1` を表す）ので、人手証明の `k = m+1` として述べる。

`RowWalk` を `abbrev` にしているのは、`Fin` の族に対する mathlib の補題
（`Fin.snoc` / `Fin.init` の計算）をそのまま当てるためである。`RowConfig` のように
`def` で包むと、写像の型として扱う場面で毎回展開が必要になる。

住処: 人手証明のこれらのブロックは可算側（ℤ[x]）を宣言している。したがって ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.BigOperators.Fin
import Ising2DLambda.TransferMatrix.WeightProduct

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 長さ `k` の道 `p : {0,1,...,k} → R_L`（`def_row_walk`）。
定義域は整数の集合であって剰余類の集合ではないので、行配位の族 `RowFamily`
（`ZMod L` 上の写像）とは別の対象である。 -/
abbrev RowWalk (k : ℕ) : Type := Fin (k + 1) → RowConfig L

/-- 両端を指定した道の全体 `W_{L,k}(τ, τ'')`（`def_row_walk`）。 -/
def rowWalksBetween (k : ℕ) (τ τ'' : RowConfig L) : Finset (RowWalk L k) :=
  univ.filter fun p => p 0 = τ ∧ p (Fin.last k) = τ''

/-- 道に沿った成分の積 `w_A(p) = ∏_{i=0}^{k-1} A_{p(i),p(i+1)}`（`def_walk_weight`）。 -/
noncomputable def walkWeight {k : ℕ} (A : RowMatrix L) (p : RowWalk L k) : Polynomial ℤ :=
  ∏ i : Fin k, A (p i.castSucc) (p i.succ)

/-- 人手証明の「道の延長が 1 対 1 対応であること」の延長写像 `Φ`。道 `p` の後ろに `τ'''` を 1 点足す。 -/
def extendWalk {k : ℕ} (p : RowWalk L k) (τ''' : RowConfig L) : RowWalk L (k + 1) :=
  Fin.snoc p τ'''

/-- 人手証明の「道の延長が 1 対 1 対応であること」の逆向きの写像 `Ψ` の第 2 成分
（定義域を狭めた写像）。 -/
def restrictWalk {k : ℕ} (q : RowWalk L (k + 1)) : RowWalk L k := Fin.init q

omit [NeZero L] in
/-- 人手証明の「道の延長が 1 対 1 対応であること」の前半（延長した道の左端は変わらない）。 -/
lemma extendWalk_zero {k : ℕ} (p : RowWalk L k) (τ''' : RowConfig L) :
    extendWalk L p τ''' 0 = p 0 := by
  unfold extendWalk
  rw [← Fin.castSucc_zero, Fin.snoc_castSucc]

omit [NeZero L] in
/-- 人手証明の「道の延長が 1 対 1 対応であること」の前半（延長した道の右端は足した点である）。 -/
lemma extendWalk_last {k : ℕ} (p : RowWalk L k) (τ''' : RowConfig L) :
    extendWalk L p τ''' (Fin.last (k + 1)) = τ''' :=
  Fin.snoc_last _ _

omit [NeZero L] in
/-- 人手証明の「道の延長が 1 対 1 対応であること」の後半（`Ψ ∘ Φ` が恒等写像）。 -/
lemma restrictWalk_extendWalk {k : ℕ} (p : RowWalk L k) (τ''' : RowConfig L) :
    restrictWalk L (extendWalk L p τ''') = p :=
  Fin.init_snoc _ _

omit [NeZero L] in
/-- 人手証明の「道の延長が 1 対 1 対応であること」の後半（`Φ ∘ Ψ` が恒等写像）。 -/
lemma extendWalk_restrictWalk {k : ℕ} (q : RowWalk L (k + 1)) :
    extendWalk L (restrictWalk L q) (q (Fin.last (k + 1))) = q :=
  Fin.snoc_init_self _

omit [NeZero L] in
lemma restrictWalk_apply_zero {k : ℕ} (q : RowWalk L (k + 1)) :
    restrictWalk L q 0 = q 0 := by
  unfold restrictWalk Fin.init
  rw [Fin.castSucc_zero]

omit [NeZero L] in
/-- 人手証明の「対応する項が等しいこと」。延長した道の重みは、もとの重みに最後の成分を
掛けたものである。 -/
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

/-- 人手証明の「出発点（`k = 1` の場合）」。長さ `1` の道は両端で決まるので、
両端を指定した道はちょうど 1 つである
（左端だけを値にとる長さ `0` の道へ右端を足したものである）。 -/
lemma rowWalksBetween_one (τ τ'' : RowConfig L) :
    rowWalksBetween L 1 τ τ'' = {extendWalk L (fun _ => τ) τ''} := by
  refine eq_singleton_iff_unique_mem.mpr ⟨?_, ?_⟩
  · refine mem_filter.mpr ⟨mem_univ _, ?_, ?_⟩
    · exact extendWalk_zero L _ _
    · exact extendWalk_last L _ _
  · intro p hp
    obtain ⟨-, hp0, hp1⟩ := mem_filter.mp hp
    have hinit : restrictWalk L p = fun _ => τ := by
      funext j
      have hj : j = 0 := Fin.fin_one_eq_zero j
      subst hj
      rw [restrictWalk_apply_zero, hp0]
    calc p = extendWalk L (restrictWalk L p) (p (Fin.last 1)) :=
          (extendWalk_restrictWalk L p).symm
      _ = extendWalk L (fun _ => τ) τ'' := by rw [hinit, hp1]

/-- 主張「行列の冪の成分は、道に沿った成分の積の和である」の具体版。
人手証明の `k = m+1` について
`(A^k)_{τ,τ''} = Σ_{p ∈ W_{L,k}(τ,τ'')} w_A(p)`。 -/
theorem rowMatrixPow_apply (A : RowMatrix L) (m : ℕ) (τ τ'' : RowConfig L) :
    rowMatrixPow L A m τ τ''
      = ∑ p ∈ rowWalksBetween L (m + 1) τ τ'', walkWeight L A p := by
  induction m generalizing τ τ'' with
  | zero =>
      -- 出発点（`k = 1` の場合）。道はちょうど 1 つで、その重みは `A_{τ,τ''}` である。
      rw [rowMatrixPow_one, rowWalksBetween_one, sum_singleton, walkWeight_extendWalk]
      unfold walkWeight
      rw [Fin.prod_univ_zero, one_mul]
  | succ m ih =>
      -- `k+1` の場合の第 1 の等号（冪と積の定義を使う）。
      rw [rowMatrixPow_succ]
      show ∑ τ' : RowConfig L, rowMatrixPow L A m τ τ' * A τ' τ'' = _
      -- 第 2 の等号（帰納法の仮定を各 `τ'` について使う）。
      rw [sum_congr rfl fun τ' _ => by rw [ih τ τ']]
      -- 第 3 の等号（有限和と 1 つの元との積を項ごとの積の和にする）。
      rw [sum_congr rfl fun τ' (_ : τ' ∈ univ) => sum_mul _ _ _]
      -- 第 4 の等号（二重和を、人手証明の組の集合 `P` の上の 1 つの和として読む。
      -- ここでは `P` を「左端が `τ` の道の全体」として実現し、右端で束ねている）。
      have hfiber :
          ∑ τ' : RowConfig L,
              ∑ p ∈ rowWalksBetween L (m + 1) τ τ', walkWeight L A p * A τ' τ''
            = ∑ p ∈ univ.filter (fun p : RowWalk L (m + 1) => p 0 = τ),
                walkWeight L A p * A (p (Fin.last (m + 1))) τ'' := by
        rw [← sum_fiberwise (univ.filter fun p : RowWalk L (m + 1) => p 0 = τ)
              (fun p => p (Fin.last (m + 1)))
              (fun p => walkWeight L A p * A (p (Fin.last (m + 1))) τ'')]
        refine sum_congr rfl fun τ' _ => ?_
        refine sum_congr ?_ ?_
        · unfold rowWalksBetween
          rw [filter_filter]
        · intro p hp
          obtain ⟨-, hlast⟩ := mem_filter.mp hp
          rw [hlast]
      rw [hfiber]
      -- 第 5 の等号（道の延長が 1 対 1 対応であり、対応する項が等しい）。
      refine sum_nbij' (i := fun p => extendWalk L p τ'') (j := fun q => restrictWalk L q)
        ?_ ?_ ?_ ?_ ?_
      · intro p hp
        obtain ⟨-, hp0⟩ := mem_filter.mp hp
        refine mem_filter.mpr ⟨mem_univ _, ?_, ?_⟩
        · rw [extendWalk_zero, hp0]
        · exact extendWalk_last L _ _
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
