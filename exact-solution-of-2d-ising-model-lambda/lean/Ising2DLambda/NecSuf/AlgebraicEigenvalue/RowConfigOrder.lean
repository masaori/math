/-
主張「行配位の辞書式順序は線形順序である」の必要十分版。

目的は 2 つ（`lean/README.md`）。何が本質的かを示すことと、具体版が過剰な構造を
要求していないかを検査することである。

具体版（`Ising2DLambda.AlgebraicEigenvalue.RowConfigOrder`）の証明が実際に使っているのは
次だけである。格子の形・周期境界条件・スピンの値が `{+1,-1}` であること（値が 2 つしかないこと）・
`L ≥ 1` であること・行配位が `ℤ/Lℤ` 上の写像であることは、どこにも使っていない。

  使っている性質                  なぜ削れないか
  `g : ℕ → ι` と `hcover`         添字 `ι` の各点が `{0,…,L-1}` の番号から `g` で届くこと。
  （被覆）                        これが無いと「値の異なる番号 `k < L` が存在する」が言えず、
                                  `k_0` を取れない（具体版の `differingIndex_nonempty`）。
  `ε : V → ℕ` が単射              比較を `ℕ` の大小へ落とし、値が相異なれば `ε` の値も
                                  相異なると言うのに要る。`ε` を単射でなくすると三分律が壊れる。
  `DecidableEq V`                 `k_0` を `Nat.find` で取るのに述語の判定が要る。

値の側に要るのは「`ℕ` への単射」だけであり、値が 2 つであることは使っていない。実際、
推移律の `k_0 = k_1` の場合は `ℕ` の大小の推移律で処理しており、値が 2 つしかないことを
根拠にしていない（人手証明も同じ形に書いてある）。

証明手順は具体版と同じである（`k_0` を整列性で取り、準備 2 つを出し、
三分律は `ε` の単射性で、推移律は `k_0` と `k_1` の大小 3 通りで場合分けする）。
mathlib の辞書式順序の既製インスタンスや `LinearOrder` の構成子は引かない。

住処: ここに ℝ / ℂ は現れない（比較は ℕ）。
-/
import Mathlib.Data.Nat.Find
import Mathlib.Order.Basic
import Mathlib.Tactic.Common

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {ι V : Type*} [DecidableEq V] (g : ℕ → ι) (L : ℕ) (ε : V → ℕ)

/-- 具体版の `differingIndex`。値の異なる番号であること。 -/
def differingIndex (τ τ' : ι → V) (k : ℕ) : Prop := k < L ∧ τ (g k) ≠ τ' (g k)

instance (τ τ' : ι → V) (k : ℕ) : Decidable (differingIndex g L τ τ' k) := by
  unfold differingIndex; infer_instance

variable {g L}

/-- 具体版の `differingIndex_nonempty`。被覆から、値の異なる番号が `{0,…,L-1}` の中にある。 -/
lemma differingIndex_nonempty (hcover : ∀ i : ι, ∃ k, k < L ∧ g k = i)
    {τ τ' : ι → V} (h : τ ≠ τ') : ∃ k, differingIndex g L τ τ' k := by
  obtain ⟨i, hi⟩ : ∃ i, τ i ≠ τ' i := by
    by_contra hcon
    push_neg at hcon
    exact h (funext hcon)
  obtain ⟨k, hkL, hk⟩ := hcover i
  exact ⟨k, hkL, by rw [hk]; exact hi⟩

/-- 具体版の `firstDifference`（`k_0`）。自然数の整列性で取る。 -/
noncomputable def firstDifference (hcover : ∀ i : ι, ∃ k, k < L ∧ g k = i)
    {τ τ' : ι → V} (h : τ ≠ τ') : ℕ :=
  Nat.find (differingIndex_nonempty hcover h)

variable (hcover : ∀ i : ι, ∃ k, k < L ∧ g k = i)

/-- 具体版の準備の第一。 -/
lemma ne_at_firstDifference {τ τ' : ι → V} (h : τ ≠ τ') :
    τ (g (firstDifference hcover h)) ≠ τ' (g (firstDifference hcover h)) :=
  (Nat.find_spec (differingIndex_nonempty hcover h)).2

lemma firstDifference_lt {τ τ' : ι → V} (h : τ ≠ τ') : firstDifference hcover h < L :=
  (Nat.find_spec (differingIndex_nonempty hcover h)).1

/-- 具体版の準備の第二。 -/
lemma eq_below_firstDifference {τ τ' : ι → V} (h : τ ≠ τ') {k : ℕ}
    (hk : k < firstDifference hcover h) : τ (g k) = τ' (g k) := by
  have hnot := Nat.find_min (differingIndex_nonempty hcover h) hk
  have hkL : k < L := hk.trans (firstDifference_lt hcover h)
  by_contra hne
  exact hnot ⟨hkL, hne⟩

lemma firstDifference_eq_of {τ τ' : ι → V} (h : τ ≠ τ') {k : ℕ}
    (hk : differingIndex g L τ τ' k) (hmin : ∀ j < k, ¬ differingIndex g L τ τ' j) :
    firstDifference hcover h = k :=
  le_antisymm (Nat.find_le hk)
    (by
      by_contra hlt
      push_neg at hlt
      exact hmin _ hlt (Nat.find_spec (differingIndex_nonempty hcover h)))

lemma firstDifference_symm {τ τ' : ι → V} (h : τ ≠ τ') :
    firstDifference hcover (Ne.symm h) = firstDifference hcover h := by
  refine firstDifference_eq_of hcover _
    ⟨firstDifference_lt hcover h, (ne_at_firstDifference hcover h).symm⟩ ?_
  intro j hj hjmem
  exact hjmem.2 (eq_below_firstDifference hcover h hj).symm

/-- 具体版の `rowConfigLess`（`≺`）。 -/
def lexLess (τ τ' : ι → V) : Prop :=
  ∃ h : τ ≠ τ',
    ε (τ (g (firstDifference hcover h))) < ε (τ' (g (firstDifference hcover h)))

variable {ε}

lemma lexLess_iff {τ τ' : ι → V} (h : τ ≠ τ') :
    lexLess ε hcover τ τ'
      ↔ ε (τ (g (firstDifference hcover h))) < ε (τ' (g (firstDifference hcover h))) := by
  constructor
  · rintro ⟨h', hlt⟩
    have : h' = h := rfl
    subst this
    exact hlt
  · intro hlt
    exact ⟨h, hlt⟩

/-- `≺` を「最小の相違位置での比較」という明示の形へ書き直したもの。
具体版との対応（`FromNecSuf` ファイル）を、`Nat.find` の同一性を経由せずに取るために置く。 -/
lemma lexLess_iff_exists {τ τ' : ι → V} :
    lexLess ε hcover τ τ'
      ↔ ∃ k, k < L ∧ (∀ j < k, τ (g j) = τ' (g j)) ∧ ε (τ (g k)) < ε (τ' (g k)) := by
  constructor
  · rintro ⟨h, hlt⟩
    exact ⟨firstDifference hcover h, firstDifference_lt hcover h,
      fun j hj => eq_below_firstDifference hcover h hj, hlt⟩
  · rintro ⟨k, hkL, hbelow, hlt⟩
    have hne : τ (g k) ≠ τ' (g k) := fun hcon => by rw [hcon] at hlt; exact lt_irrefl _ hlt
    have hneτ : τ ≠ τ' := fun hcon => hne (by rw [hcon])
    have hk : firstDifference hcover hneτ = k :=
      firstDifference_eq_of hcover hneτ ⟨hkL, hne⟩ fun j hj hjmem => hjmem.2 (hbelow j hj)
    exact ⟨hneτ, by rw [hk]; exact hlt⟩

/-- 具体版の三分律。`ε` の単射性だけを使う（値が 2 つであることは使わない）。 -/
theorem lexLess_trichotomy (hε : Function.Injective ε) (τ τ' : ι → V) :
    (lexLess ε hcover τ τ' ∧ τ ≠ τ' ∧ ¬ lexLess ε hcover τ' τ)
      ∨ (¬ lexLess ε hcover τ τ' ∧ τ = τ' ∧ ¬ lexLess ε hcover τ' τ)
      ∨ (¬ lexLess ε hcover τ τ' ∧ τ ≠ τ' ∧ lexLess ε hcover τ' τ) := by
  by_cases h : τ = τ'
  · subst h
    refine Or.inr (Or.inl ⟨?_, rfl, ?_⟩) <;> rintro ⟨hne, -⟩ <;> exact hne rfl
  · have heps : ε (τ (g (firstDifference hcover h)))
        ≠ ε (τ' (g (firstDifference hcover h))) := fun hcon =>
      ne_at_firstDifference hcover h (hε hcon)
    have hsymm : lexLess ε hcover τ' τ
        ↔ ε (τ' (g (firstDifference hcover h))) < ε (τ (g (firstDifference hcover h))) := by
      rw [lexLess_iff hcover (Ne.symm h), firstDifference_symm hcover h]
    rcases lt_or_gt_of_ne heps with hlt | hgt
    · exact Or.inl ⟨(lexLess_iff hcover h).mpr hlt, h, by rw [hsymm]; omega⟩
    · exact Or.inr (Or.inr ⟨by rw [lexLess_iff hcover h]; omega, h, hsymm.mpr hgt⟩)

/-- 具体版の推移律。`k_0` と `k_1` の大小 3 通りで場合分けする（具体版と同じ手順）。 -/
theorem lexLess_trans {τ τ' τ'' : ι → V}
    (h1 : lexLess ε hcover τ τ') (h2 : lexLess ε hcover τ' τ'') :
    lexLess ε hcover τ τ'' := by
  obtain ⟨hne1, hlt1⟩ := h1
  obtain ⟨hne2, hlt2⟩ := h2
  set k0 := firstDifference hcover hne1 with hk0
  set k1 := firstDifference hcover hne2 with hk1
  have key : ∀ k : ℕ, k < L → (∀ j < k, τ (g j) = τ'' (g j)) →
      ε (τ (g k)) < ε (τ'' (g k)) → lexLess ε hcover τ τ'' := by
    intro k hkL hbelow hlt
    exact (lexLess_iff_exists hcover).mpr ⟨k, hkL, hbelow, hlt⟩
  rcases lt_trichotomy k0 k1 with hcase | hcase | hcase
  · have heq : τ' (g k0) = τ'' (g k0) := eq_below_firstDifference hcover hne2 hcase
    refine key k0 (firstDifference_lt hcover hne1) (fun j hj => ?_) (by rw [← heq]; exact hlt1)
    have hj1 : j < k1 := hj.trans hcase
    rw [eq_below_firstDifference hcover hne1 hj, eq_below_firstDifference hcover hne2 hj1]
  · have hlt2' : ε (τ' (g k0)) < ε (τ'' (g k0)) := by rw [hcase]; exact hlt2
    refine key k0 (firstDifference_lt hcover hne1) (fun j hj => ?_) (hlt1.trans hlt2')
    have hj1 : j < k1 := hcase ▸ hj
    rw [eq_below_firstDifference hcover hne1 hj, eq_below_firstDifference hcover hne2 hj1]
  · have heq : τ (g k1) = τ' (g k1) := eq_below_firstDifference hcover hne1 hcase
    refine key k1 (firstDifference_lt hcover hne2) (fun j hj => ?_) (by rw [heq]; exact hlt2)
    have hj0 : j < k0 := hj.trans hcase
    rw [eq_below_firstDifference hcover hne1 hj0, eq_below_firstDifference hcover hne2 hj]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
