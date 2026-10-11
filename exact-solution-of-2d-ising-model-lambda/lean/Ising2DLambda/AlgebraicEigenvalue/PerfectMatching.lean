/-
完全マッチングと不動点のない対合の一対一対応の具体版。
有限添字集合 J 上で、本文と同じ順に相手の一意性、対合性、逆構成、両逆を示す。
完全マッチングは二元集合の集合なので、対の順序と重複はデータに含まない。
相手の選択は存在一意性から行う。非計算的な選択は Lean の実装上の都合である。
-/
import Mathlib.Data.Set.Insert
import Mathlib.Data.Fintype.Basic
import Mathlib.Logic.Equiv.Defs

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 各対が二元集合であり、各点を含む対がただ一つあること。 -/
def IsPerfectMatching {J : Type*} [Fintype J] (D : Set (Set J)) : Prop :=
  (∀ p ∈ D, ∃ i j : J, i ≠ j ∧ p = {i, j}) ∧
    ∀ i : J, ∃! p : Set J, p ∈ D ∧ i ∈ p

/-- 有限添字集合上の完全マッチング全体。 -/
def PerfectMatching (J : Type*) [Fintype J] :=
  {D : Set (Set J) // IsPerfectMatching D}

/-- 各点を動かし、二回の適用で元へ戻す写像全体。 -/
def FixedPointFreeInvolution (J : Type*) [Fintype J] :=
  {τ : J → J // (∀ i : J, τ i ≠ i) ∧ Function.Involutive τ}

variable {J : Type*} [Fintype J]

/-- 各点を含む唯一の対の二元性から、相手の存在と一意性を取り出す。 -/
theorem perfectMatching_partner_existsUnique (D : PerfectMatching J) (i : J) :
    ∃! j : J, j ≠ i ∧ ({i, j} : Set J) ∈ D.val := by
  obtain ⟨p, hp, hunique⟩ := D.property.2 i
  have hexists : ∃ j : J, j ≠ i ∧ ({i, j} : Set J) ∈ D.val := by
    obtain ⟨a, b, hab, hpab⟩ := D.property.1 p hp.1
    have hi : i = a ∨ i = b := by
      simpa only [hpab, Set.mem_insert_iff, Set.mem_singleton_iff] using hp.2
    rcases hi with rfl | rfl
    · refine ⟨b, hab.symm, ?_⟩
      rw [← hpab]
      exact hp.1
    · refine ⟨a, hab, ?_⟩
      rw [Set.pair_comm, ← hpab]
      exact hp.1
  obtain ⟨j, hji, hij⟩ := hexists
  refine ⟨j, ⟨hji, hij⟩, ?_⟩
  intro k hk
  have hkj : ({i, k} : Set J) = {i, j} :=
    (hunique _ ⟨hk.2, by simp⟩).trans (hunique _ ⟨hij, by simp⟩).symm
  have hkmem : k ∈ ({i, j} : Set J) := by
    rw [← hkj]
    simp
  rcases Set.mem_insert_iff.mp hkmem with hki | hkj'
  · exact (hk.1 hki).elim
  · exact Set.mem_singleton_iff.mp hkj'

/-- 完全マッチングの各点に、その点の相手を対応させる写像。 -/
noncomputable def perfectMatchingMate (D : PerfectMatching J) (i : J) : J :=
  Classical.choose (perfectMatching_partner_existsUnique D i).exists

theorem perfectMatchingMate_spec (D : PerfectMatching J) (i : J) :
    perfectMatchingMate D i ≠ i ∧
      ({i, perfectMatchingMate D i} : Set J) ∈ D.val := by
  exact Classical.choose_spec (perfectMatching_partner_existsUnique D i).exists

/-- 別の点 j が i と対をなせば、相手の一意性により j が相手である。 -/
theorem perfectMatchingMate_eq_of_pair (D : PerfectMatching J) (i j : J)
    (hji : j ≠ i) (hpair : ({i, j} : Set J) ∈ D.val) :
    perfectMatchingMate D i = j := by
  exact (perfectMatching_partner_existsUnique D i).unique
    (perfectMatchingMate_spec D i) ⟨hji, hpair⟩

theorem perfectMatchingMate_ne (D : PerfectMatching J) (i : J) :
    perfectMatchingMate D i ≠ i := by
  have hmate := perfectMatchingMate_spec D i
  exact hmate.1

/-- 対の二点を入れ替えても同じ対なので、相手の相手は元の点になる。 -/
theorem perfectMatchingMate_involutive (D : PerfectMatching J) :
    Function.Involutive (perfectMatchingMate D) := by
  intro i
  have hmate := perfectMatchingMate_spec D i
  have hreverse : ({perfectMatchingMate D i, i} : Set J) ∈ D.val := by
    rw [Set.pair_comm]
    exact hmate.2
  exact perfectMatchingMate_eq_of_pair D (perfectMatchingMate D i) i
    hmate.1.symm hreverse

/-- 相手写像を不動点のない対合の集合へ送る写像。 -/
noncomputable def perfectMatchingToInvolution (D : PerfectMatching J) :
    FixedPointFreeInvolution J :=
  ⟨perfectMatchingMate D, perfectMatchingMate_ne D, perfectMatchingMate_involutive D⟩

/-- 対合の二元軌道から作る対の集合。集合なので二度現れる対も一つの元になる。 -/
def involutionPairs (τ : FixedPointFreeInvolution J) : Set (Set J) :=
  {p | ∃ i : J, p = {i, τ.val i}}

/-- 二元性は不動点が無いこと、各点の一意な被覆は対合性から従う。 -/
theorem involutionPairs_isPerfectMatching (τ : FixedPointFreeInvolution J) :
    IsPerfectMatching (involutionPairs τ) := by
  constructor
  · intro p hp
    obtain ⟨i, rfl⟩ := hp
    exact ⟨i, τ.val i, (τ.property.1 i).symm, rfl⟩
  · intro i
    refine ⟨{i, τ.val i}, ⟨⟨i, rfl⟩, by simp⟩, ?_⟩
    intro p hp
    obtain ⟨j, rfl⟩ := hp.1
    have hi : i = j ∨ i = τ.val j := by
      simpa only [Set.mem_insert_iff, Set.mem_singleton_iff] using hp.2
    rcases hi with rfl | rfl
    · rfl
    · rw [τ.property.2 j]
      exact Set.pair_comm j (τ.val j)

/-- 二元軌道の集合を完全マッチングの集合へ送る写像。 -/
def involutionToPerfectMatching (τ : FixedPointFreeInvolution J) :
    PerfectMatching J :=
  ⟨involutionPairs τ, involutionPairs_isPerfectMatching τ⟩

/-- 相手写像の二元軌道を集めると、もとの完全マッチングに戻る。 -/
theorem matching_involution_left_inverse (D : PerfectMatching J) :
    involutionToPerfectMatching (perfectMatchingToInvolution D) = D := by
  apply Subtype.ext
  apply Set.ext
  intro p
  change (∃ i : J, p = {i, perfectMatchingMate D i}) ↔ p ∈ D.val
  constructor
  · rintro ⟨i, rfl⟩
    exact (perfectMatchingMate_spec D i).2
  · intro hp
    obtain ⟨i, j, hij, hpij⟩ := D.property.1 p hp
    refine ⟨i, ?_⟩
    have hpair : ({i, j} : Set J) ∈ D.val := by
      rw [← hpij]
      exact hp
    rw [perfectMatchingMate_eq_of_pair D i j hij.symm hpair]
    exact hpij

/-- 対合の二元軌道で i の相手は τ(i) なので、相手写像はもとの対合に戻る。 -/
theorem matching_involution_right_inverse (τ : FixedPointFreeInvolution J) :
    perfectMatchingToInvolution (involutionToPerfectMatching τ) = τ := by
  apply Subtype.ext
  funext i
  change perfectMatchingMate (involutionToPerfectMatching τ) i = τ.val i
  apply perfectMatchingMate_eq_of_pair
  · exact τ.property.1 i
  · exact ⟨i, rfl⟩

/-- 両逆を備えた、完全マッチングと不動点のない対合の一対一対応。 -/
noncomputable def perfectMatchingEquivInvolution :
    PerfectMatching J ≃ FixedPointFreeInvolution J where
  toFun := perfectMatchingToInvolution
  invFun := involutionToPerfectMatching
  left_inv := matching_involution_left_inverse
  right_inv := matching_involution_right_inverse

/-- 単射は左逆、全射は右逆を明示して示す。 -/
theorem perfectMatchingToInvolution_bijective :
    Function.Bijective (perfectMatchingToInvolution (J := J)) := by
  constructor
  · intro D E hDE
    calc
      D = involutionToPerfectMatching (perfectMatchingToInvolution D) :=
        (matching_involution_left_inverse D).symm
      _ = involutionToPerfectMatching (perfectMatchingToInvolution E) :=
        congrArg involutionToPerfectMatching hDE
      _ = E := matching_involution_left_inverse E
  · intro τ
    exact ⟨involutionToPerfectMatching τ, matching_involution_right_inverse τ⟩

end Ising2DLambda.AlgebraicEigenvalue
