/-
章「固有値の代数性」の入口の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（ラベル `def_spin_index` / `def_row_config_order`）と主張「行配位の辞書式順序は線形順序である」
（ラベル `claim_row_config_order_linear`）に対応する。

  人手証明                          このファイル
  ε（スピン値の番号）               spinIndex
  D(τ,τ')                           differingIndex（述語として書く）
  k_0(τ,τ')                         firstDifference（`Nat.find`。自然数の整列性にあたる）
  τ ≺ τ'                            rowConfigLess
  証明の準備の第一                  ne_at_firstDifference
  証明の準備の第二                  eq_below_firstDifference
  証明の準備の第三                  rowConfigLess_trans の中の `key`
  三分律                            rowConfigLess_trichotomy
  推移律                            rowConfigLess_trans

添字について。人手証明は列番号を整数 `k ∈ {0,...,L-1}` で走らせ、行配位の引数へ移すときだけ
射影 `π`（`def_lattice`）を通す。Lean でも同じで、`k : ℕ` を `((k : ℕ) : ZMod L)` で移す。
この 2 本以外の経路で `ℤ` と `ℤ/Lℤ` を行き来しない。

`Nat.find` を使うのは、人手証明が「自然数の空でない部分集合は最小元をもつ」（整列性）を
使っているのと同じ理由である。mathlib の線形順序の一般論（`LinearOrder` の構成子や
辞書式順序の既製インスタンス）は引かない。人手証明が三分律と推移律を自分で示しているので、
そこを一般論へ委ねると 1 対 1 対応が壊れる。

住処: 人手証明のこれらのブロックは ℕ を宣言している。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.Basic

namespace Ising2DLambda.AlgebraicEigenvalue

open PartitionPolynomial TransferMatrix

variable (L : ℕ)

/-- 人手証明の `ε : {+1,-1} → {0,1}`（`ε(+1) = 0`, `ε(-1) = 1`）。 -/
def spinIndex (v : SpinValue) : ℕ := if v.1 = 1 then 0 else 1

/-- `ε` は単射である（人手証明は全単射と述べるが、証明が使うのは単射性だけである）。 -/
lemma spinIndex_injective : Function.Injective spinIndex := by
  rintro ⟨z, hz⟩ ⟨w, hw⟩ h
  simp only [spinIndex] at h
  rcases hz with rfl | rfl <;> rcases hw with rfl | rfl <;> simp_all

variable {L}

/-- 人手証明の `D(τ,τ')` を述語として書いたもの。
`k ∈ D(τ,τ')` は `differingIndex L τ τ' k` にあたる。 -/
def differingIndex (τ τ' : RowConfig L) (k : ℕ) : Prop :=
  k < L ∧ τ ((k : ℕ) : ZMod L) ≠ τ' ((k : ℕ) : ZMod L)

instance (τ τ' : RowConfig L) (k : ℕ) : Decidable (differingIndex τ τ' k) := by
  unfold differingIndex; infer_instance

/-- 人手証明の「`τ ≠ τ'` のとき `D(τ,τ')` は空でない」。
`τ(y) ≠ τ'(y)` となる `y` を取り、`k := s(y)` と置く（`s` は代表を取る写像 `ZMod.val`）。 -/
lemma differingIndex_nonempty [NeZero L] {τ τ' : RowConfig L} (h : τ ≠ τ') :
    ∃ k, differingIndex τ τ' k := by
  obtain ⟨y, hy⟩ : ∃ y, τ y ≠ τ' y := by
    by_contra hcon
    push_neg at hcon
    exact h (funext hcon)
  refine ⟨y.val, ZMod.val_lt y, ?_⟩
  rwa [ZMod.natCast_val, ZMod.cast_id]

/-- 人手証明の `k_0(τ,τ') = min D(τ,τ')`。自然数の整列性（`Nat.find`）で取る。 -/
noncomputable def firstDifference [NeZero L] {τ τ' : RowConfig L} (h : τ ≠ τ') : ℕ :=
  Nat.find (differingIndex_nonempty h)

/-- 証明の準備の第一。`k_0` の位置で値が異なる。 -/
lemma ne_at_firstDifference [NeZero L] {τ τ' : RowConfig L} (h : τ ≠ τ') :
    τ ((firstDifference h : ℕ) : ZMod L) ≠ τ' ((firstDifference h : ℕ) : ZMod L) :=
  (Nat.find_spec (differingIndex_nonempty h)).2

lemma firstDifference_lt [NeZero L] {τ τ' : RowConfig L} (h : τ ≠ τ') :
    firstDifference h < L :=
  (Nat.find_spec (differingIndex_nonempty h)).1

/-- 証明の準備の第二。`k < k_0` の位置では値が一致する。
`k < k_0 < L` なので `k < L` も従い、`D` の定義の後半が否定される。 -/
lemma eq_below_firstDifference [NeZero L] {τ τ' : RowConfig L} (h : τ ≠ τ')
    {k : ℕ} (hk : k < firstDifference h) :
    τ ((k : ℕ) : ZMod L) = τ' ((k : ℕ) : ZMod L) := by
  have hnot := Nat.find_min (differingIndex_nonempty h) hk
  have hkL : k < L := hk.trans (firstDifference_lt h)
  by_contra hne
  exact hnot ⟨hkL, hne⟩

/-- `k_0` が「`D` に属し、それ未満はどれも属さない」ことで特徴づけられること。
場合分けのたびに `k_0(τ,τ'')` が何であるかを決めるのに使う（人手証明の該当箇所）。 -/
lemma firstDifference_eq_of [NeZero L] {τ τ' : RowConfig L} (h : τ ≠ τ') {k : ℕ}
    (hk : differingIndex τ τ' k) (hmin : ∀ j < k, ¬ differingIndex τ τ' j) :
    firstDifference h = k :=
  le_antisymm (Nat.find_le hk)
    (by
      by_contra hlt
      push_neg at hlt
      exact hmin _ hlt (Nat.find_spec (differingIndex_nonempty h)))

/-- `D` が対称なので `k_0` も対称である（人手証明の同じ注意）。 -/
lemma firstDifference_symm [NeZero L] {τ τ' : RowConfig L} (h : τ ≠ τ') :
    firstDifference (Ne.symm h) = firstDifference h := by
  refine firstDifference_eq_of _ ⟨firstDifference_lt h, (ne_at_firstDifference h).symm⟩ ?_
  intro j hj hjmem
  exact hjmem.2 (eq_below_firstDifference h hj).symm

variable (L) in
/-- 人手証明の `τ ≺ τ'`。`τ ≠ τ'` かつ `k_0` の位置で `ε` の値が小さい。 -/
def rowConfigLess [NeZero L] (τ τ' : RowConfig L) : Prop :=
  ∃ h : τ ≠ τ',
    spinIndex (τ ((firstDifference h : ℕ) : ZMod L))
      < spinIndex (τ' ((firstDifference h : ℕ) : ZMod L))

/-- `≺` の判定を `k_0` の位置での `ε` の比較へ落とす補題（`∃ h` の中身を取り出すだけ）。 -/
lemma rowConfigLess_iff [NeZero L] {τ τ' : RowConfig L} (h : τ ≠ τ') :
    rowConfigLess L τ τ'
      ↔ spinIndex (τ ((firstDifference h : ℕ) : ZMod L))
          < spinIndex (τ' ((firstDifference h : ℕ) : ZMod L)) := by
  constructor
  · rintro ⟨h', hlt⟩
    have : h' = h := rfl
    subst this
    exact hlt
  · intro hlt
    exact ⟨h, hlt⟩

/-- 人手証明の三分律。`τ ≺ τ'`・`τ = τ'`・`τ' ≺ τ` のうちちょうど 1 つが成り立つ。
`τ = τ'` の場合は `≺` の定義が相異なることを要求するので両方とも成り立たない。
`τ ≠ τ'` の場合は `ε` が単射なので `k_0` の位置での 2 つの値が相異なり、
相異なる 2 つの自然数はちょうど一方が他方より小さい。 -/
theorem rowConfigLess_trichotomy [NeZero L] (τ τ' : RowConfig L) :
    (rowConfigLess L τ τ' ∧ τ ≠ τ' ∧ ¬ rowConfigLess L τ' τ)
      ∨ (¬ rowConfigLess L τ τ' ∧ τ = τ' ∧ ¬ rowConfigLess L τ' τ)
      ∨ (¬ rowConfigLess L τ τ' ∧ τ ≠ τ' ∧ rowConfigLess L τ' τ) := by
  by_cases h : τ = τ'
  · subst h
    refine Or.inr (Or.inl ⟨?_, rfl, ?_⟩) <;> rintro ⟨hne, -⟩ <;> exact hne rfl
  · have hk : τ ((firstDifference h : ℕ) : ZMod L) ≠ τ' ((firstDifference h : ℕ) : ZMod L) :=
      ne_at_firstDifference h
    have heps : spinIndex (τ ((firstDifference h : ℕ) : ZMod L))
        ≠ spinIndex (τ' ((firstDifference h : ℕ) : ZMod L)) := fun hcon =>
      hk (spinIndex_injective hcon)
    -- `k_0` は対称なので、逆向きの比較も同じ位置で行われる。
    have hsymm : rowConfigLess L τ' τ
        ↔ spinIndex (τ' ((firstDifference h : ℕ) : ZMod L))
            < spinIndex (τ ((firstDifference h : ℕ) : ZMod L)) := by
      rw [rowConfigLess_iff (Ne.symm h), firstDifference_symm h]
    rcases lt_or_gt_of_ne heps with hlt | hgt
    · exact Or.inl ⟨(rowConfigLess_iff h).mpr hlt, h, by rw [hsymm]; omega⟩
    · exact Or.inr (Or.inr ⟨by rw [rowConfigLess_iff h]; omega, h, hsymm.mpr hgt⟩)

/-- 人手証明の推移律。`k_0 < k_1`・`k_1 < k_0`・`k_0 = k_1` で場合を分ける
（人手証明と同じ分け方。いずれの場合も先に `k_0(τ,τ'')` を決めてから `ε` の値を比べる）。 -/
theorem rowConfigLess_trans [NeZero L] {τ τ' τ'' : RowConfig L}
    (h1 : rowConfigLess L τ τ') (h2 : rowConfigLess L τ' τ'') :
    rowConfigLess L τ τ'' := by
  obtain ⟨hne1, hlt1⟩ := h1
  obtain ⟨hne2, hlt2⟩ := h2
  set k0 := firstDifference hne1 with hk0
  set k1 := firstDifference hne2 with hk1
  -- 人手証明の「準備の第三」。3 つの場合に共通して使う形で、
  -- `k` 未満で `τ` と `τ''` が一致し、`k` で `ε` の値が小さければ `τ ≺ τ''` である。
  have key : ∀ k : ℕ, k < L →
      (∀ j < k, τ ((j : ℕ) : ZMod L) = τ'' ((j : ℕ) : ZMod L)) →
      spinIndex (τ ((k : ℕ) : ZMod L)) < spinIndex (τ'' ((k : ℕ) : ZMod L)) →
      rowConfigLess L τ τ'' := by
    intro k hkL hbelow hlt
    have hne : τ ((k : ℕ) : ZMod L) ≠ τ'' ((k : ℕ) : ZMod L) := fun hcon => by
      rw [hcon] at hlt; exact lt_irrefl _ hlt
    have hneτ : τ ≠ τ'' := fun hcon => hne (by rw [hcon])
    have : firstDifference hneτ = k :=
      firstDifference_eq_of hneτ ⟨hkL, hne⟩ (fun j hj hjmem => hjmem.2 (hbelow j hj))
    exact ⟨hneτ, by rw [this]; exact hlt⟩
  rcases lt_trichotomy k0 k1 with hcase | hcase | hcase
  · -- `k_0 < k_1` の場合。`k_0` の位置で `τ'` と `τ''` は一致する。
    have heq : τ' ((k0 : ℕ) : ZMod L) = τ'' ((k0 : ℕ) : ZMod L) :=
      eq_below_firstDifference hne2 hcase
    refine key k0 (firstDifference_lt hne1) (fun j hj => ?_) (by rw [← heq]; exact hlt1)
    have hj1 : j < k1 := hj.trans hcase
    rw [eq_below_firstDifference hne1 hj, eq_below_firstDifference hne2 hj1]
  · -- `k_0 = k_1` の場合。同じ位置で `ε` の値が 2 段に小さくなる。
    have hlt2' : spinIndex (τ' ((k0 : ℕ) : ZMod L)) < spinIndex (τ'' ((k0 : ℕ) : ZMod L)) := by
      rw [hcase]; exact hlt2
    refine key k0 (firstDifference_lt hne1) (fun j hj => ?_) (hlt1.trans hlt2')
    have hj1 : j < k1 := hcase ▸ hj
    rw [eq_below_firstDifference hne1 hj, eq_below_firstDifference hne2 hj1]
  · -- `k_1 < k_0` の場合。`k_1` の位置で `τ` と `τ'` は一致する。
    have heq : τ ((k1 : ℕ) : ZMod L) = τ' ((k1 : ℕ) : ZMod L) :=
      eq_below_firstDifference hne1 hcase
    refine key k1 (firstDifference_lt hne2) (fun j hj => ?_) (by rw [heq]; exact hlt2)
    have hj0 : j < k0 := hj.trans hcase
    rw [eq_below_firstDifference hne1 hj0, eq_below_firstDifference hne2 hj]

end Ising2DLambda.AlgebraicEigenvalue
