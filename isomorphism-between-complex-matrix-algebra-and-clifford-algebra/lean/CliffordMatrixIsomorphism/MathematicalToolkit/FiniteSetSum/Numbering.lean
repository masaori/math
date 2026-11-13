/-
節「有限集合の上の和」のうち、有限集合の番号付けの定義。

  本文のラベル                   このファイル
  def_numbering_of_finite_set    Idx（{1,…,n}）・IsNumbering（番号付け）・IsFiniteSet（有限集合）・
                                 IsNumbering.inv（逆写像 e^{-1}）・IsNumbering.apply_inv（e(e^{-1}(x)) = x）・
                                 IsNumbering.inv_apply（e^{-1}(e(k)) = k）

この定義は ℂ を含まないので、必要十分版はこのファイルをそのまま引く（必要十分版を別に置かない）。

{1,…,n} は部分型 `Idx n` で表す。X が空集合のときも番号付け（n = 0）が書けるように、
番号付け e は `ℕ → X` ではなく `Idx n → X` とする。
線型結合は `ℕ` で添字づけた族を取る（`Definitions.lean` の約束）ので、X の上の族 f と番号付け e から、
k ∈ {1,…,n} に f(e(k)) を与える族を `numberedFamily e f d`（{1,…,n} の外では値 d。外の値は使わない）で作る。
本文の「k ∈ {1,…,n} に v_{e(k)} と λ_{e(k)} を与える族」がこれに当たる。
-/
import Mathlib.Data.Complex.Basic

namespace CliffordMatrixIsomorphism

universe u v

/-- 本文の {1,…,n}。 -/
abbrev Idx (n : ℕ) := {k : ℕ // 1 ≤ k ∧ k ≤ n}

/-- 本文 `def_numbering_of_finite_set`：組 (n, e) が X の番号付けであること（e は単射かつ全射）。 -/
structure IsNumbering {X : Type u} (n : ℕ) (e : Idx n → X) : Prop where
  /-- 単射 -/
  injective : ∀ k l : Idx n, e k = e l → k = l
  /-- 全射 -/
  surjective : ∀ x : X, ∃ k : Idx n, e k = x

/-- 本文 `def_numbering_of_finite_set`：X が番号付けを少なくとも一つもつとき、X を有限集合と呼ぶ。 -/
def IsFiniteSet (X : Type u) : Prop :=
  ∃ (n : ℕ) (e : Idx n → X), IsNumbering n e

namespace IsNumbering

variable {X : Type u} {n : ℕ} {e : Idx n → X}

/-- 本文 `def_numbering_of_finite_set` の逆写像 e^{-1}：e(k) = x を満たす k（全射の条件で一つ選ぶ）。 -/
noncomputable def inv (h : IsNumbering n e) (x : X) : Idx n :=
  Classical.choose (h.surjective x)

/-- 本文 `def_numbering_of_finite_set`：e(e^{-1}(x)) = x。 -/
theorem apply_inv (h : IsNumbering n e) (x : X) : e (h.inv x) = x :=
  Classical.choose_spec (h.surjective x)

/-- 本文 `def_numbering_of_finite_set`：e^{-1}(e(k)) = k。k は e(k) = e(k) を満たし、単射の条件で一つに決まる。 -/
theorem inv_apply (h : IsNumbering n e) (k : Idx n) : h.inv (e k) = k :=
  h.injective (h.inv (e k)) k (h.apply_inv (e k))

end IsNumbering

/-- {1,…,n} で添字づけた族 g を、{1,…,n} の外で値 d をとる `ℕ` の族へ延ばす（外の値は使わない）。 -/
def extendFamily {α : Type v} {n : ℕ} (g : Idx n → α) (d : α) (k : ℕ) : α :=
  if h : 1 ≤ k ∧ k ≤ n then g ⟨k, h⟩ else d

theorem extendFamily_of_le {α : Type v} {n : ℕ} (g : Idx n → α) (d : α) (k : ℕ) (h1 : 1 ≤ k)
    (h2 : k ≤ n) : extendFamily g d k = g ⟨k, h1, h2⟩ := by
  unfold extendFamily
  rw [dif_pos ⟨h1, h2⟩]

/-- 本文の「k ∈ {1,…,n} に f(e(k)) を与える族」。 -/
def numberedFamily {X : Type u} {α : Type v} {n : ℕ} (e : Idx n → X) (f : X → α) (d : α) : ℕ → α :=
  extendFamily (fun k => f (e k)) d

theorem numberedFamily_of_le {X : Type u} {α : Type v} {n : ℕ} (e : Idx n → X) (f : X → α) (d : α)
    (k : ℕ) (h1 : 1 ≤ k) (h2 : k ≤ n) : numberedFamily e f d k = f (e ⟨k, h1, h2⟩) :=
  extendFamily_of_le (fun k => f (e k)) d k h1 h2

end CliffordMatrixIsomorphism
