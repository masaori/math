/-
主張「行列の冪の成分は、道に沿った成分の積の和である」（ラベル `claim_matrix_pow_entry`）の
必要十分版。手順は具体版（`Ising2DLambda/TransferMatrix/PowerEntry.lean`）の Step 1–9 と同じで、
仮定だけを必要十分まで削ってある。

削った結果に残ったのは次の 3 つである。

  1. 値の側が可換半環であること。使っているのは
     ・和が可換モノイドをなすこと（有限和が確定し、順序を入れ替えられること）
     ・積が結合的で単位元 `1` をもつこと（道の重みの最後の因子を分けるところ、
       および長さ `0` の道の重みが `1` であること）
     ・積が和に対して分配すること（Step 5）
     である。積の可換性は議論のどのステップでも使っていないが、有限積の記法
     `Finset.prod` が mathlib では可換モノイドに対してしか定義されていないため、
     形式化としては可換な側を仮定する（この 1 点だけは数学的な必要性ではなく記法の都合である）。
     引き算・順序・逆元は一度も使っていない。すなわち値の側が環であることは使っていない。
  2. 添字の側が有限型であること（有限和が確定すること）。
  3. 添字の相等が判定できること（両端を指定した道の全体を filter として書くため）。

使っていないのは、値が多項式であること、係数が ℤ であること、行列の成分が不定元の冪であること、
添字が行配位であること、格子の形、スピンの値が 2 通りであることである。

具体版がこの特殊化として得られることは
`Ising2DLambda/TransferMatrix/PowerEntryFromNecSuf.lean` に書く。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.TransferMatrix

open Finset

variable {S : Type*} [CommSemiring S] {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 行と列を `ι` で添字づけた行列（具体版の `RowMatrix` にあたる）。 -/
abbrev Mat (S : Type*) (ι : Type*) : Type _ := ι → ι → S

/-- 行列の積 `(AB)_{a,c} = Σ_b A_{a,b} B_{b,c}`（具体版の `rowMatrixProduct`）。 -/
def matProduct (A B : Mat S ι) : Mat S ι := fun a c => ∑ b : ι, A a b * B b c

/-- 行列の冪。具体版と同じく引数を 1 つずらしてあり、引数 `m` が指数 `m+1` を表す。 -/
def matPow (A : Mat S ι) : ℕ → Mat S ι
  | 0 => A
  | m + 1 => matProduct (matPow A m) A

/-- 長さ `k` の道（具体版の `RowWalk`）。 -/
abbrev Walk (ι : Type*) (k : ℕ) : Type _ := Fin (k + 1) → ι

/-- 両端を指定した道の全体（具体版の `rowWalksBetween`）。
`DecidableEq ι` を要求するのはこの filter のためである。 -/
def walksBetween (k : ℕ) (a a'' : ι) : Finset (Walk ι k) :=
  univ.filter fun p => p 0 = a ∧ p (Fin.last k) = a''

/-- 道に沿った成分の積（具体版の `walkWeight`）。 -/
def walkWeight {k : ℕ} (A : Mat S ι) (p : Walk ι k) : S :=
  ∏ i : Fin k, A (p i.castSucc) (p i.succ)

/-- 道の延長（具体版の `extendWalk`。人手証明の Step 6 の `Φ`）。 -/
def extendWalk {k : ℕ} (p : Walk ι k) (a''' : ι) : Walk ι (k + 1) := Fin.snoc p a'''

/-- 定義域を狭めた道（具体版の `restrictWalk`。人手証明の Step 6 の `Ψ` の第 2 成分）。 -/
def restrictWalk {k : ℕ} (q : Walk ι (k + 1)) : Walk ι k := Fin.init q

omit [Fintype ι] [DecidableEq ι] in
lemma extendWalk_zero {k : ℕ} (p : Walk ι k) (a''' : ι) :
    extendWalk p a''' 0 = p 0 := by
  unfold extendWalk
  rw [← Fin.castSucc_zero, Fin.snoc_castSucc]

omit [Fintype ι] [DecidableEq ι] in
lemma extendWalk_last {k : ℕ} (p : Walk ι k) (a''' : ι) :
    extendWalk p a''' (Fin.last (k + 1)) = a''' :=
  Fin.snoc_last _ _

omit [Fintype ι] [DecidableEq ι] in
lemma restrictWalk_extendWalk {k : ℕ} (p : Walk ι k) (a''' : ι) :
    restrictWalk (extendWalk p a''') = p :=
  Fin.init_snoc _ _

omit [Fintype ι] [DecidableEq ι] in
lemma extendWalk_restrictWalk {k : ℕ} (q : Walk ι (k + 1)) :
    extendWalk (restrictWalk q) (q (Fin.last (k + 1))) = q :=
  Fin.snoc_init_self _

omit [Fintype ι] [DecidableEq ι] in
lemma restrictWalk_apply_zero {k : ℕ} (q : Walk ι (k + 1)) :
    restrictWalk q 0 = q 0 := by
  unfold restrictWalk Fin.init
  rw [Fin.castSucc_zero]

omit [Fintype ι] [DecidableEq ι] in
/-- 人手証明の Step 7。積の結合性と、最後の因子を分けられることだけを使う。 -/
lemma walkWeight_extendWalk {k : ℕ} (A : Mat S ι) (p : Walk ι k) (a''' : ι) :
    walkWeight A (extendWalk p a''') = walkWeight A p * A (p (Fin.last k)) a''' := by
  unfold walkWeight extendWalk
  rw [Fin.prod_univ_castSucc]
  congr 1
  · refine prod_congr rfl fun i _ => ?_
    rw [Fin.snoc_castSucc, Fin.succ_castSucc, Fin.snoc_castSucc]
  · rw [Fin.snoc_castSucc, Fin.succ_last, Fin.snoc_last]

/-- 人手証明の Step 1。長さ `1` の道は両端で決まる。 -/
lemma walksBetween_one (a a'' : ι) :
    walksBetween 1 a a'' = {extendWalk (fun _ => a) a''} := by
  refine eq_singleton_iff_unique_mem.mpr ⟨?_, ?_⟩
  · exact mem_filter.mpr ⟨mem_univ _, extendWalk_zero _ _, extendWalk_last _ _⟩
  · intro p hp
    obtain ⟨-, hp0, hp1⟩ := mem_filter.mp hp
    have hinit : restrictWalk p = fun _ => a := by
      funext j
      have hj : j = 0 := Fin.fin_one_eq_zero j
      subst hj
      rw [restrictWalk_apply_zero, hp0]
    calc p = extendWalk (restrictWalk p) (p (Fin.last 1)) := (extendWalk_restrictWalk p).symm
      _ = extendWalk (fun _ => a) a'' := by rw [hinit, hp1]

/-- 主張の必要十分版。人手証明の Step 1–9 と同じ手順で、値の側は可換半環、添字の側は
相等の判定できる有限型しか仮定していない。

仮定について。有限型を外すと Step 3 の和と道の全体の和が確定しない。
相等の判定を外すと両端を指定した道の全体を filter として書けない。
値の側の可換半環は上のファイル冒頭に書いたとおりで、分配則（Step 5）と結合性（Step 7）と
単位元（Step 1）を使う。引き算・順序は使わないので環である必要はない。 -/
theorem matPow_apply_eq_sum_walkWeight (A : Mat S ι) (m : ℕ) (a a'' : ι) :
    matPow A m a a'' = ∑ p ∈ walksBetween (m + 1) a a'', walkWeight A p := by
  induction m generalizing a a'' with
  | zero =>
      -- Step 1（`k = 1` の場合）。
      show A a a'' = _
      rw [walksBetween_one, sum_singleton, walkWeight_extendWalk]
      unfold walkWeight
      rw [Fin.prod_univ_zero, one_mul]
  | succ m ih =>
      -- Step 3（冪と積の定義を使う）。
      show ∑ b : ι, matPow A m a b * A b a'' = _
      -- Step 4（帰納法の仮定を代入する）。
      rw [sum_congr rfl fun b _ => by rw [ih a b]]
      -- Step 5（分配則で括弧を外す）。
      rw [sum_congr rfl fun b (_ : b ∈ univ) => sum_mul _ _ _]
      -- Step 8 の前半（二重和を、左端だけを固定した道の上の 1 つの和として読む）。
      have hfiber :
          ∑ b : ι, ∑ p ∈ walksBetween (m + 1) a b, walkWeight A p * A b a''
            = ∑ p ∈ univ.filter (fun p : Walk ι (m + 1) => p 0 = a),
                walkWeight A p * A (p (Fin.last (m + 1))) a'' := by
        rw [← sum_fiberwise (univ.filter fun p : Walk ι (m + 1) => p 0 = a)
              (fun p => p (Fin.last (m + 1)))
              (fun p => walkWeight A p * A (p (Fin.last (m + 1))) a'')]
        refine sum_congr rfl fun b _ => ?_
        refine sum_congr ?_ ?_
        · unfold walksBetween
          rw [filter_filter]
        · intro p hp
          obtain ⟨-, hlast⟩ := mem_filter.mp hp
          rw [hlast]
      rw [hfiber]
      -- Step 6・Step 7（延長が 1 対 1 対応であり、対応する項が等しい）。
      refine sum_nbij' (i := fun p => extendWalk p a'') (j := fun q => restrictWalk q)
        ?_ ?_ ?_ ?_ ?_
      · intro p hp
        obtain ⟨-, hp0⟩ := mem_filter.mp hp
        refine mem_filter.mpr ⟨mem_univ _, ?_, ?_⟩
        · rw [extendWalk_zero, hp0]
        · exact extendWalk_last _ _
      · intro q hq
        obtain ⟨-, hq0, -⟩ := mem_filter.mp hq
        refine mem_filter.mpr ⟨mem_univ _, ?_⟩
        rw [restrictWalk_apply_zero, hq0]
      · intro p _
        exact restrictWalk_extendWalk p a''
      · intro q hq
        obtain ⟨-, -, hqlast⟩ := mem_filter.mp hq
        rw [← hqlast]
        exact extendWalk_restrictWalk q
      · intro p _
        rw [walkWeight_extendWalk]

end Ising2DLambda.NecSuf.TransferMatrix
