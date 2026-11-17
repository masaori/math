/-
人手証明の定義「部分体の正錐に従う前錐」（ラベル `def_subfield_precone`）と、
主張「前錐に一つの元を付け足した集合は、もとの前錐とその元を含む前錐である」
（ラベル `claim_precone_adjoin_element_is_precone`）、
「負の単位元を含まない前錐には、元とその符号反転の少なくとも一方を負の単位元を含めずに付け足せる」
（ラベル `claim_precone_adjoin_one_side_avoids_minus_one`）の具体版。

部分体は Qbar の部分体、前錐は Qbar の部分集合として、本文の条件をそのまま並べる。
住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldPositiveCone
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_subfield_precone` の具体版。本文の前提（`F ⊆ E`、`CF` は `F` の正錐）と、
`E` の部分集合であることと四条件（和・積・平方・`CF` の包含）をそのまま並べる。 -/
structure IsSubfieldPrecone (F E : Subfield Qbar) (CF T : Set Qbar) : Prop where
  subfield_le : ∀ z : Qbar, z ∈ F → z ∈ E
  cone_F : IsSubfieldPositiveCone F CF
  subset : ∀ z : Qbar, z ∈ T → z ∈ E
  add_mem : ∀ a b : Qbar, a ∈ T → b ∈ T → a + b ∈ T
  mul_mem : ∀ a b : Qbar, a ∈ T → b ∈ T → a * b ∈ T
  sq_mem : ∀ y : Qbar, y ∈ E → y * y ∈ T
  cone_subset : ∀ c : Qbar, c ∈ CF → c ∈ T

/-- 本文の集合 `T⟨a⟩ = {t + a·t' | t ∈ T, t' ∈ T}`。 -/
def preconeAdjoin (T : Set Qbar) (a : Qbar) : Set Qbar :=
  {z | ∃ t : Qbar, t ∈ T ∧ ∃ t' : Qbar, t' ∈ T ∧ z = t + a * t'}

/-- `claim_precone_adjoin_element_is_precone` の具体版。本文の証明の段
（零元と単位元の所属、包含、`a` の所属、`E` への包含、和、積、平方、正錐の包含）の順に示す。 -/
theorem preconeAdjoin_isSubfieldPrecone (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (a : Qbar) (ha : a ∈ E) :
    IsSubfieldPrecone F E CF (preconeAdjoin T a) ∧
      (∀ t : Qbar, t ∈ T → t ∈ preconeAdjoin T a) ∧ a ∈ preconeAdjoin T a := by
  -- 零元と単位元の所属（本文の最初の六行）
  have h0 : (0 : Qbar) ∈ T := by
    have h := hT.sq_mem 0 E.zero_mem
    rw [mul_zero] at h
    exact h
  have h1 : (1 : Qbar) ∈ T := by
    have h := hT.sq_mem 1 E.one_mem
    rw [mul_one] at h
    exact h
  -- 包含 T ⊆ T⟨a⟩（t = t + a·0）
  have hincl : ∀ t : Qbar, t ∈ T → t ∈ preconeAdjoin T a := by
    intro t ht
    refine ⟨t, ht, 0, h0, ?_⟩
    rw [mul_zero, add_zero]
  -- 所属 a ∈ T⟨a⟩（a = 0 + a·1）
  have hself : a ∈ preconeAdjoin T a := by
    refine ⟨0, h0, 1, h1, ?_⟩
    rw [mul_one, zero_add]
  refine ⟨⟨hT.subfield_le, hT.cone_F, ?_, ?_, ?_, ?_, ?_⟩, hincl, hself⟩
  · -- T⟨a⟩ ⊆ E
    rintro z ⟨t, ht, t', ht', rfl⟩
    exact E.add_mem (hT.subset t ht) (E.mul_mem ha (hT.subset t' ht'))
  · -- 和で閉じること
    rintro z1 z2 ⟨t1, ht1, t2, ht2, rfl⟩ ⟨t3, ht3, t4, ht4, rfl⟩
    refine ⟨t1 + t3, hT.add_mem _ _ ht1 ht3, t2 + t4, hT.add_mem _ _ ht2 ht4, ?_⟩
    calc (t1 + a * t2) + (t3 + a * t4) = (t1 + t3) + (a * t2 + a * t4) := by ring
      _ = (t1 + t3) + a * (t2 + t4) := by rw [mul_add]
  · -- 積で閉じること
    rintro z1 z2 ⟨t1, ht1, t2, ht2, rfl⟩ ⟨t3, ht3, t4, ht4, rfl⟩
    have hsq : a * a ∈ T := hT.sq_mem a ha
    have hA : t1 * t3 + (a * a) * (t2 * t4) ∈ T :=
      hT.add_mem _ _ (hT.mul_mem _ _ ht1 ht3) (hT.mul_mem _ _ hsq (hT.mul_mem _ _ ht2 ht4))
    have hB : t1 * t4 + t2 * t3 ∈ T :=
      hT.add_mem _ _ (hT.mul_mem _ _ ht1 ht4) (hT.mul_mem _ _ ht2 ht3)
    refine ⟨_, hA, _, hB, ?_⟩
    calc (t1 + a * t2) * (t3 + a * t4)
        = t1 * t3 + t1 * (a * t4) + (a * t2) * t3 + (a * t2) * (a * t4) := by ring
      _ = (t1 * t3 + (a * a) * (t2 * t4)) + a * (t1 * t4 + t2 * t3) := by ring
  · -- 平方の条件
    intro y hy
    exact hincl _ (hT.sq_mem y hy)
  · -- 正錐を含むこと
    intro c hc
    exact hincl _ (hT.cone_subset c hc)

/-- `claim_precone_adjoin_one_side_avoids_minus_one` の具体版。本文と同じく背理法で、
移項の二式、`-1` の四行の書き直し、右辺の各項の所属の順に示す。 -/
theorem neg_one_not_mem_preconeAdjoin_or (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) (a : Qbar) (ha : a ∈ E) :
    (-1 : Qbar) ∉ preconeAdjoin T a ∨ (-1 : Qbar) ∉ preconeAdjoin T (-a) := by
  by_contra hcon
  rw [not_or, not_not, not_not] at hcon
  obtain ⟨⟨t1, ht1, t2, ht2, h1⟩, ⟨t3, ht3, t4, ht4, h3⟩⟩ := hcon
  -- 移項の二式
  have e1 : a * t2 = -1 - t1 := by linear_combination -h1
  have e3 : (-a) * t4 = -1 - t3 := by linear_combination -h3
  -- -1 の書き直し（本文の四行）
  have key : (-1 : Qbar) = (t1 + t3 + t1 * t3) + (a * a) * (t2 * t4) := by
    calc (-1 : Qbar) = (t1 + t3 + t1 * t3) - (1 + t1 + t3 + t1 * t3) := by ring
      _ = (t1 + t3 + t1 * t3) - (-1 - t1) * (-1 - t3) := by ring
      _ = (t1 + t3 + t1 * t3) - (a * t2) * ((-a) * t4) := by rw [e1, e3]
      _ = (t1 + t3 + t1 * t3) + (a * a) * (t2 * t4) := by ring
  -- 右辺の各項の所属
  have hhead : t1 + t3 + t1 * t3 ∈ T :=
    hT.add_mem _ _ (hT.add_mem _ _ ht1 ht3) (hT.mul_mem _ _ ht1 ht3)
  have htail : (a * a) * (t2 * t4) ∈ T :=
    hT.mul_mem _ _ (hT.sq_mem a ha) (hT.mul_mem _ _ ht2 ht4)
  have hmem : (-1 : Qbar) ∈ T := by
    rw [key]
    exact hT.add_mem _ _ hhead htail
  exact hneg hmem

end Ising2DLambda.FisherZero
