/-
`claim_real_algebraic_rational_bounds`（実閉部分体の各元は有理数で上下から挟める）の必要十分版。

具体版と同じ手順（順序の事実 (i)〜(v)、x^m − 1 の帰納法、各項の分解、主鎖、三分法、p(−X)）を、
標数零の体 K と「正」の述語 P だけで書く。具体版が使う P の性質は次の五つだけである。
  - posAdd:    正の元の和は正（具体版では推移律から出す）。
  - posMul:    正の元の積は正（具体版では平方の積と零因子の無さから出す）。
  - ratPos:    正の有理数の像は正（具体版では `claim_positive_rational_positive_in_real_closed`）。
  - posNeZero: 正の元は零でない。p(x) ≠ 0 を出すのに要る。
  - total:     各元は正・零・負のいずれか。B ≤ a を否定して a < B を得る三分法の段に要る。
平方であること、代数的閉包、虚数単位、一意表示、平方の三分法の排他性の残りは使わない。
根 a は代数性からではなく、最高次係数が零でない有理係数の和が零であることとして受ける
（K が代数的である必要はない）。K に体と標数零を置くのは、有理係数を K へ環準同型で送るためである。
-/
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Data.Rat.BigOperators
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.CriticalExponent

open Finset

section

variable {K : Type*} [Field K] (P : K → Prop)

/-- 非負: 正か零。 -/
def NonnegOf (u : K) : Prop := P u ∨ 0 = u

variable {P}

theorem pos_add_nonneg_necSuf
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    {u v : K} (hu : P u) (hv : NonnegOf P v) : P (u + v) := by
  rcases hv with hv | hv
  · exact posAdd u v hu hv
  · rw [← hv, add_zero]
    exact hu

theorem nonneg_add_necSuf
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    {u v : K} (hu : NonnegOf P u) (hv : NonnegOf P v) : NonnegOf P (u + v) := by
  rcases hu with hu | hu
  · exact Or.inl (pos_add_nonneg_necSuf posAdd hu hv)
  · rw [← hu, zero_add]
    exact hv

theorem sum_nonneg_necSuf
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    (s : Finset ℕ) (f : ℕ → K) (h : ∀ j ∈ s, NonnegOf P (f j)) :
    NonnegOf P (∑ j ∈ s, f j) := by
  induction s using Finset.induction_on with
  | empty =>
      right
      simp
  | insert j s hj ih =>
      rw [sum_insert hj]
      exact nonneg_add_necSuf posAdd (h j (mem_insert_self j s))
        (ih (fun i hi => h i (mem_insert_of_mem hi)))

theorem nonneg_mul_necSuf
    (posMul : ∀ u v : K, P u → P v → P (u * v))
    {u v : K} (hu : NonnegOf P u) (hv : NonnegOf P v) : NonnegOf P (u * v) := by
  rcases hu with hu | hu
  · rcases hv with hv | hv
    · exact Or.inl (posMul u v hu hv)
    · right
      rw [← hv, mul_zero]
  · right
    rw [← hu, zero_mul]

theorem rat_nonneg_necSuf
    (ratPos : ∀ q : ℚ, 0 < q → P (q : K)) {q : ℚ} (hq : 0 ≤ q) :
    NonnegOf P (q : K) := by
  rcases hq.lt_or_eq with hq | hq
  · exact Or.inl (ratPos q hq)
  · right
    rw [← hq]
    simp

theorem pow_pos_necSuf
    (posMul : ∀ u v : K, P u → P v → P (u * v))
    (ratPos : ∀ q : ℚ, 0 < q → P (q : K))
    {x : K} (hx : P x) : ∀ m : ℕ, P (x ^ m) := by
  intro m
  induction m with
  | zero => simpa using ratPos 1 one_pos
  | succ m ih =>
      rw [pow_succ]
      exact posMul _ _ ih hx

theorem pow_sub_one_nonneg_necSuf
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    (posMul : ∀ u v : K, P u → P v → P (u * v))
    {x : K} (hx : P x) (hx1 : NonnegOf P (x - 1)) :
    ∀ m : ℕ, NonnegOf P (x ^ m - 1) := by
  intro m
  induction m with
  | zero =>
      right
      simp
  | succ m ih =>
      have h : x ^ (m + 1) - 1 = x * (x ^ m - 1) + (x - 1) := by ring
      rw [h]
      exact nonneg_add_necSuf posAdd (nonneg_mul_necSuf posMul (Or.inl hx) ih) hx1

theorem rootBound_term_nonneg_necSuf [CharZero K]
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    (posMul : ∀ u v : K, P u → P v → P (u * v))
    (ratPos : ∀ q : ℚ, 0 < q → P (q : K))
    {x : K} (hx : P x) (hx1 : NonnegOf P (x - 1))
    (alpha : ℚ) {j e : ℕ} (hj : j ≤ e) :
    NonnegOf P (((|alpha| : ℚ) : K) * x ^ e + (alpha : K) * x ^ j) := by
  have hpow : x ^ e = x ^ j * x ^ (e - j) := by
    rw [← pow_add, Nat.add_sub_cancel' hj]
  have hsplit :
      ((|alpha| : ℚ) : K) * x ^ e + (alpha : K) * x ^ j
        = ((|alpha| : ℚ) : K) * x ^ j * (x ^ (e - j) - 1)
          + ((|alpha| + alpha : ℚ) : K) * x ^ j := by
    rw [hpow]
    push_cast
    ring
  rw [hsplit]
  have hsumNonneg : 0 ≤ |alpha| + alpha := by
    have := neg_abs_le alpha
    linarith
  exact nonneg_add_necSuf posAdd
    (nonneg_mul_necSuf posMul
      (nonneg_mul_necSuf posMul (rat_nonneg_necSuf ratPos (abs_nonneg alpha))
        (Or.inl (pow_pos_necSuf posMul ratPos hx j)))
      (pow_sub_one_nonneg_necSuf posAdd posMul hx hx1 (e - j)))
    (nonneg_mul_necSuf posMul (rat_nonneg_necSuf ratPos hsumNonneg)
      (Or.inl (pow_pos_necSuf posMul ratPos hx j)))

/-- 係数比の絶対値の和 `S := Σ_{j<d} |α_j|`。 -/
def rootBoundSumNecSuf (d : ℕ) (alpha : ℕ → ℚ) : ℚ :=
  ∑ j ∈ range d, |alpha j|

theorem rootBoundSumNecSuf_nonneg (d : ℕ) (alpha : ℕ → ℚ) : 0 ≤ rootBoundSumNecSuf d alpha :=
  sum_nonneg (fun j _ => abs_nonneg (alpha j))

/-- 主鎖: `B − x` が負でない側（`x − B` が非負）なら `x^d + Σ α_j x^j` は正。 -/
theorem monic_pos_of_rootBound_le_necSuf [CharZero K]
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    (posMul : ∀ u v : K, P u → P v → P (u * v))
    (ratPos : ∀ q : ℚ, 0 < q → P (q : K))
    (e : ℕ) (alpha : ℕ → ℚ) (x : K)
    (hxB : NonnegOf P (x - ((1 + rootBoundSumNecSuf (e + 1) alpha : ℚ) : K))) :
    P (x ^ (e + 1) + ∑ j ∈ range (e + 1), (alpha j : K) * x ^ j) := by
  set S := rootBoundSumNecSuf (e + 1) alpha with hSdef
  have hS : 0 ≤ S := rootBoundSumNecSuf_nonneg (e + 1) alpha
  have hx1 : NonnegOf P (x - 1) := by
    have h : x - 1 = (x - ((1 + S : ℚ) : K)) + (S : K) := by
      push_cast
      ring
    rw [h]
    exact nonneg_add_necSuf posAdd hxB (rat_nonneg_necSuf ratPos hS)
  have hxS : P (x - (S : K)) := by
    have h : x - (S : K) = ((1 : ℚ) : K) + (x - ((1 + S : ℚ) : K)) := by
      push_cast
      ring
    rw [h]
    exact pos_add_nonneg_necSuf posAdd (ratPos 1 one_pos) hxB
  have hx0 : P x := by
    have h : x = (x - (S : K)) + (S : K) := by ring
    rw [h]
    exact pos_add_nonneg_necSuf posAdd hxS (rat_nonneg_necSuf ratPos hS)
  have hchain :
      x ^ (e + 1) + ∑ j ∈ range (e + 1), (alpha j : K) * x ^ j
        = x ^ e * (x - (S : K))
          + ∑ j ∈ range (e + 1), (((|alpha j| : ℚ) : K) * x ^ e + (alpha j : K) * x ^ j) := by
    rw [sum_add_distrib, ← sum_mul, hSdef, rootBoundSumNecSuf]
    push_cast
    ring
  rw [hchain]
  apply pos_add_nonneg_necSuf posAdd
  · exact posMul _ _ (pow_pos_necSuf posMul ratPos hx0 e) hxS
  · apply sum_nonneg_necSuf posAdd
    intro j hj
    exact rootBound_term_nonneg_necSuf posAdd posMul ratPos hx0 hx1 (alpha j)
      (Nat.lt_succ_iff.mp (mem_range.mp hj))

/-- 正側: 最高次係数が零でない有理係数の和が零になる元は `B` より小さい（`B − y` が正）。 -/
theorem root_lt_rootBound_necSuf [CharZero K]
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    (posMul : ∀ u v : K, P u → P v → P (u * v))
    (ratPos : ∀ q : ℚ, 0 < q → P (q : K))
    (posNeZero : ∀ u : K, P u → u ≠ 0)
    (total : ∀ z : K, P z ∨ z = 0 ∨ P (-z))
    (d : ℕ) (c : ℕ → ℚ) (hd : 1 ≤ d) (hc : c d ≠ 0) (y : K)
    (hroot : ∑ i ∈ range (d + 1), (c i : K) * y ^ i = 0) :
    P (((1 + rootBoundSumNecSuf d (fun j => c j / c d) : ℚ) : K) - y) := by
  obtain ⟨e, rfl⟩ : ∃ e, d = e + 1 := ⟨d - 1, by omega⟩
  have hcK : (c (e + 1) : K) ≠ 0 := by exact_mod_cast hc
  have hfactor : ∀ x : K,
      ∑ i ∈ range (e + 1 + 1), (c i : K) * x ^ i
        = (c (e + 1) : K)
          * (x ^ (e + 1) + ∑ j ∈ range (e + 1), ((c j / c (e + 1) : ℚ) : K) * x ^ j) := by
    intro x
    have hterm : ∀ j : ℕ,
        (c (e + 1) : K) * (((c j / c (e + 1) : ℚ) : K) * x ^ j) = (c j : K) * x ^ j := by
      intro j
      push_cast
      field_simp
    rw [sum_range_succ, mul_add, mul_sum]
    simp only [hterm]
    ring
  have hne : ∀ x : K,
      NonnegOf P (x - ((1 + rootBoundSumNecSuf (e + 1) (fun j => c j / c (e + 1)) : ℚ) : K)) →
      ∑ i ∈ range (e + 1 + 1), (c i : K) * x ^ i ≠ 0 := by
    intro x hx
    rw [hfactor x]
    exact mul_ne_zero hcK (posNeZero _
      (monic_pos_of_rootBound_le_necSuf posAdd posMul ratPos e (fun j => c j / c (e + 1)) x hx))
  -- 三分法: B − y は正か、零か、負。零と負は p(y) = 0 に反する。
  set B : K := ((1 + rootBoundSumNecSuf (e + 1) (fun j => c j / c (e + 1)) : ℚ) : K)
  rcases total (B - y) with h | h | h
  · exact h
  · exfalso
    exact hne y (Or.inr (by rw [show y - B = -(B - y) by ring, h, neg_zero])) hroot
  · exfalso
    exact hne y (Or.inl (by rw [show y - B = -(B - y) by ring]; exact h)) hroot

/-- 必要十分版の主定理: `a − (−B)` と `B − a` がともに正となる正の有理数 `B` がある。 -/
theorem rational_bounds_necSuf [CharZero K]
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    (posMul : ∀ u v : K, P u → P v → P (u * v))
    (ratPos : ∀ q : ℚ, 0 < q → P (q : K))
    (posNeZero : ∀ u : K, P u → u ≠ 0)
    (total : ∀ z : K, P z ∨ z = 0 ∨ P (-z))
    (d : ℕ) (c : ℕ → ℚ) (hc : c d ≠ 0) (a : K)
    (hroot : ∑ i ∈ range (d + 1), (c i : K) * a ^ i = 0) :
    ∃ B : ℚ, 0 < B ∧ P (a - ((-B : ℚ) : K)) ∧ P ((B : K) - a) := by
  have hd : 1 ≤ d := by
    by_contra hlt
    have hd0 : d = 0 := by omega
    rw [hd0] at hroot hc
    simp at hroot
    exact hc hroot
  set B : ℚ := 1 + rootBoundSumNecSuf d (fun j => c j / c d) with hBdef
  have hB : 0 < B := by
    have := rootBoundSumNecSuf_nonneg d (fun j => c j / c d)
    linarith
  have hupper : P ((B : K) - a) :=
    root_lt_rootBound_necSuf posAdd posMul ratPos posNeZero total d c hd hc a hroot
  set c' : ℕ → ℚ := fun i => (-1) ^ i * c i with hc'Def
  have hc' : c' d ≠ 0 := mul_ne_zero (pow_ne_zero d (by norm_num)) hc
  have hroot' : ∑ i ∈ range (d + 1), (c' i : K) * (-a) ^ i = 0 := by
    have hterm : ∀ i : ℕ, (c' i : K) * (-a) ^ i = (c i : K) * a ^ i := by
      intro i
      have hsign : ((-1 : K) ^ i) * ((-1 : K) ^ i) = 1 := by
        rw [← mul_pow]
        norm_num
      rw [hc'Def, neg_pow]
      push_cast
      calc (-1 : K) ^ i * (c i : K) * ((-1) ^ i * a ^ i)
          = ((-1 : K) ^ i * (-1) ^ i) * ((c i : K) * a ^ i) := by ring
        _ = (c i : K) * a ^ i := by rw [hsign, one_mul]
    simp only [hterm]
    exact hroot
  have hS' : rootBoundSumNecSuf d (fun j => c' j / c' d)
      = rootBoundSumNecSuf d (fun j => c j / c d) := by
    unfold rootBoundSumNecSuf
    apply sum_congr rfl
    intro j _
    simp [hc'Def, abs_div, abs_mul]
  have hlowerNeg : P ((B : K) - -a) := by
    have h := root_lt_rootBound_necSuf posAdd posMul ratPos posNeZero total d c' hd hc' (-a) hroot'
    rw [hS'] at h
    exact h
  refine ⟨B, hB, ?_, hupper⟩
  have h : a - ((-B : ℚ) : K) = (B : K) - -a := by
    push_cast
    ring
  rw [h]
  exact hlowerNeg

end

end Ising2DLambda.NecSuf.CriticalExponent
