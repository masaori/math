/-
定理「分配多項式は転送行列の冪のトレースである」（ラベル
`theorem_partition_polynomial_is_trace`）の必要十分版。

人手証明の定理は、分配多項式という具体的な対象についての等式である。その証明のうち
「転送行列であること」「値が多項式であること」「格子の形」に依らない部分は、次の一言に尽きる。

  どんな行列でも、その `n` 乗のトレースは、周期的に並べた添字の列に沿って成分を掛けたものの
  全体和に等しい。

これがこの版の主張 `trace_matPow_eq_sum_cyclicWeight` である。手順は具体版
（`Ising2DLambda/TransferMatrix/Trace.lean`）と同じで、人手証明の 2 つの準備と 7 つの等号のうち、
「`rows` が全単射である等号」「配位の重みが行に沿った成分の積である等号」「分配多項式の定義の等号」
の 3 つだけが具体版に固有なので、この版では残りを示す。

削った結果に残ったのは次の 4 つである。

  1. 値の側が可換半環であること。使う内訳は
     `Ising2DLambda/NecSuf/TransferMatrix/PowerEntry.lean` に書いたものと同じで、
     この版が新たに使うのは有限和の順序の組み替えだけである。引き算・順序・逆元は使わない。
  2. 添字の側が有限型であること（トレースと和が確定すること）。
  3. 添字の相等が判定できること（両端を指定した道の全体と閉じた道の全体を filter として書くため）。
  4. 周期の長さ `n` が `0` でないこと。`ZMod n` の元が `{0,...,n-1}` の中に代表元をちょうど 1 つ
     持つことに使う。これが無いと `Θ` と `Ξ` を作れない（人手証明が `L ≥ 1` を要求するのと同じ）。

使っていないのは、値が多項式であること、係数が ℤ であること、行列の成分が不定元の冪であること、
添字が行配位であること、格子の形、スピンの値が 2 通りであることである。

具体版がこの特殊化として得られることは
`Ising2DLambda/TransferMatrix/TraceFromNecSuf.lean` に書く。
-/
import Mathlib.Data.ZMod.Basic
import Ising2DLambda.NecSuf.TransferMatrix.PowerEntry

namespace Ising2DLambda.NecSuf.TransferMatrix

open Finset

variable {S : Type*} [CommSemiring S] {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- トレース `Tr A = Σ_a A_{a,a}`（具体版の `rowMatrixTrace`）。 -/
def matTrace (A : Mat S ι) : S := ∑ a : ι, A a a

variable {n : ℕ} [NeZero n]

/-- 閉じた道の全体（具体版の `closedRowWalks`）。 -/
def closedWalks (ι : Type*) [Fintype ι] [DecidableEq ι] (n : ℕ) : Finset (Walk ι n) :=
  univ.filter fun p => p 0 = p (Fin.last n)

/-- 周期的な添字づけから閉じた道を作る写像 `Θ`（具体版の `walkOfFamily`）。 -/
def walkOfFamily (c : ZMod n → ι) : Walk ι n := fun i => c ((i : ℕ) : ZMod n)

/-- 閉じた道から周期的な添字づけを作る写像 `Ξ`（具体版の `familyOfWalk`）。 -/
def familyOfWalk (p : Walk ι n) : ZMod n → ι :=
  fun a => p ⟨a.val, (ZMod.val_lt a).trans (Nat.lt_succ_self n)⟩

lemma walkOfFamily_mem_closedWalks (c : ZMod n → ι) :
    walkOfFamily c ∈ closedWalks ι n := by
  refine mem_filter.mpr ⟨mem_univ _, ?_⟩
  show c ((((0 : Fin (n + 1)) : ℕ) : ZMod n)) = c (((Fin.last n : ℕ) : ZMod n))
  rw [Fin.val_zero, Fin.val_last, Nat.cast_zero, ZMod.natCast_self]

/-- 人手証明の「`Ξ ∘ Θ` が恒等写像であること」。 -/
lemma familyOfWalk_walkOfFamily (c : ZMod n → ι) : familyOfWalk (walkOfFamily c) = c := by
  funext a
  show c ((a.val : ℕ) : ZMod n) = c a
  rw [ZMod.natCast_val, ZMod.cast_id]

/-- 人手証明の「`Θ ∘ Ξ` が恒等写像であること」。場合分けも人手証明と同じである。 -/
lemma walkOfFamily_familyOfWalk (p : Walk ι n) (hp : p ∈ closedWalks ι n) :
    walkOfFamily (familyOfWalk p) = p := by
  have hclosed : p 0 = p (Fin.last n) := (mem_filter.mp hp).2
  funext i
  show p ⟨(((i : ℕ) : ZMod n)).val, _⟩ = p i
  rcases lt_or_eq_of_le (Nat.lt_succ_iff.mp i.isLt) with hi | hi
  · congr 1
    exact Fin.ext (ZMod.val_cast_of_lt hi)
  · have hival : ((i : ℕ) : ZMod n) = 0 := by rw [hi, ZMod.natCast_self]
    have hlast : i = Fin.last n := Fin.ext (by rw [hi, Fin.val_last])
    rw [hival, hlast, ← hclosed]
    congr 1
    exact Fin.ext (by simp)

/-- 人手証明の準備（閉じた道の類別）。閉じた道の全体は両端の値ごとの類の互いに素な合併である。 -/
lemma sum_closedWalks_eq_sum_between (A : Mat S ι) :
    ∑ a : ι, ∑ p ∈ walksBetween n a a, walkWeight A p
      = ∑ p ∈ closedWalks ι n, walkWeight A p := by
  rw [← sum_fiberwise (closedWalks ι n) (fun p => p 0) (fun p => walkWeight A p)]
  refine sum_congr rfl fun a _ => ?_
  refine sum_congr ?_ fun _ _ => rfl
  ext p
  simp only [walksBetween, closedWalks, mem_filter, mem_univ, true_and]
  constructor
  · rintro ⟨h0, hlast⟩
    exact ⟨h0.trans hlast.symm, h0⟩
  · rintro ⟨hclosed, h0⟩
    exact ⟨h0, hclosed.symm.trans h0⟩

/-- 人手証明の準備（族から作った閉じた道の重み）にあたる読み替え。閉じた道の重みは、周期的な添字に沿った成分の積に等しい。
具体版と違い、ここには転送行列も破れボンド数も現れない。 -/
lemma walkWeight_walkOfFamily (A : Mat S ι) (c : ZMod n → ι) :
    walkWeight A (walkOfFamily c) = ∏ i : ZMod n, A (c i) (c (i + 1)) := by
  let e : Fin n ≃ ZMod n :=
    { toFun := fun i => (i.val : ZMod n)
      invFun := fun a => ⟨a.val, ZMod.val_lt a⟩
      left_inv := fun i => Fin.ext (ZMod.val_cast_of_lt i.isLt)
      right_inv := fun a => by simp [ZMod.natCast_val, ZMod.cast_id] }
  have hstep : ∀ i : Fin n,
      A (walkOfFamily c i.castSucc) (walkOfFamily c i.succ) = A (c (e i)) (c (e i + 1)) := by
    intro i
    show A (c (((i.castSucc : Fin (n + 1)) : ℕ) : ZMod n))
        (c (((i.succ : Fin (n + 1)) : ℕ) : ZMod n)) = _
    rw [Fin.val_castSucc, Fin.val_succ, Nat.cast_add, Nat.cast_one]
    rfl
  calc walkWeight A (walkOfFamily c)
      = ∏ i : Fin n, A (c (e i)) (c (e i + 1)) := prod_congr rfl fun i _ => hstep i
    _ = ∏ a : ZMod n, A (c a) (c (a + 1)) := e.prod_comp fun a => A (c a) (c (a + 1))

/-- 主張の必要十分版。`n` 乗のトレースは、周期的に並べた添字の列に沿った成分の積の全体和に等しい。
値の側は可換半環、添字の側は相等の判定できる有限型、周期は `0` でない自然数しか仮定していない。

仮定について。有限型を外すとトレースと道の全体の和が確定しない。
相等の判定を外すと両端を指定した道の全体と閉じた道の全体を filter として書けない。
`NeZero n` を外すと `ZMod n` の代表元が取れず `Θ` と `Ξ` を作れない。
値の側の可換半環は `PowerEntry.lean` に書いたとおりで、引き算・順序は使わない。 -/
theorem trace_matPow_eq_sum_cyclicWeight (A : Mat S ι) :
    matTrace (matPow A (n - 1)) = ∑ c : ZMod n → ι, ∏ i : ZMod n, A (c i) (c (i + 1)) := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 :=
    ⟨n - 1, (Nat.succ_pred_eq_of_pos (Nat.pos_of_ne_zero (NeZero.ne n))).symm⟩
  simp only [Nat.add_sub_cancel]
  calc matTrace (matPow A m)
      -- トレースの定義と、冪の成分表示の等号。
      = ∑ a : ι, ∑ p ∈ walksBetween (m + 1) a a, walkWeight A p :=
        sum_congr rfl fun a _ => matPow_apply_eq_sum_walkWeight A m a a
      -- 準備（閉じた道の類別）の等号。
    _ = ∑ p ∈ closedWalks ι (m + 1), walkWeight A p := sum_closedWalks_eq_sum_between A
      -- Θ が全単射である等号。
    _ = ∑ c : ZMod (m + 1) → ι, walkWeight A (walkOfFamily c) := by
        refine (sum_nbij' (i := fun c => walkOfFamily c) (j := fun p => familyOfWalk p)
          ?_ ?_ ?_ ?_ ?_).symm
        · intro c _
          exact walkOfFamily_mem_closedWalks c
        · intro p _
          exact mem_univ _
        · intro c _
          exact familyOfWalk_walkOfFamily c
        · intro p hp
          exact walkOfFamily_familyOfWalk p hp
        · intro c _
          rfl
      -- 準備（族から作った閉じた道の重み）にあたる読み替え。
    _ = ∑ c : ZMod (m + 1) → ι, ∏ i : ZMod (m + 1), A (c i) (c (i + 1)) :=
        sum_congr rfl fun c _ => walkWeight_walkOfFamily A c

end Ising2DLambda.NecSuf.TransferMatrix
