/-
「根の多項式は相異なる根の一次因子を順に取り出せる」の必要十分版。
具体版と同じ j についての帰納法を、帰納法が実際に使う仮定だけの上で行う。

要るのは次だけである。
- 因子と商を掛ける可換モノイド M（有限積の書き換えに結合則・交換則を使う）と、
  根の型 α・根から因子を与える写像 fac。多項式であることは使わない。
- 上界の述語 bound と先頭の係数の述語 lead（中身は問わない）。
- 出発点: f 自身の上界と先頭の係数（hbase。具体版では f = t^n - 1 の係数の計算が供給する）。
- 根の供給: 先頭の係数を番号 m ≥ 1 に持つ元は根を持つ（hroot。具体版では
  Qbar の代数閉性が供給する）。
- 因数分解: 根を持つ元は、その根の因子と、上界が 1 つ下がり先頭の係数を保つ商に
  分かれる（hfactor。具体版では因数定理・商の係数上界・先頭の係数の維持が供給する）。
- 所属: f の因子の根は指定した述語を満たす（hmem。具体版では分解の評価が供給する）。
- 取り出し: 因子の有限積から指定した 1 つを、上界つきの残りとともに取り出せる
  （hextract。具体版では r3 が供給する）。
- 積の上界: 上界つきの 2 元の積の上界は上界の和である（hmul。具体版では r1 が供給する）。
- 上界の単調性（hmono。具体版では「特に k > n ならば n - 1 < k」の段が使う）。
- 相異性: 所属する根の因子で f を割った残りの分解の根は、その根と相異なる
  （hdistinct。具体版では d4b2c3 が供給する）。

削れたもの: 加法・分配則・体であること・代数閉であること・値が代数的数であること。
これらはすべて仮定（hroot・hfactor・hmem・hdistinct）の供給側に隔離される。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped BigOperators

theorem root_polynomial_distinct_factorization_necSuf
    {M : Type*} [CommMonoid M] {α : Type*}
    (fac : α → M) (f : M) (n : ℕ) (hn : 1 ≤ n)
    (bound : M → ℕ → Prop) (lead : M → ℕ → Prop)
    (isRoot : α → M → Prop) (rootOk : α → Prop)
    (hbase : bound f n ∧ lead f n)
    (hroot : ∀ (g : M) (m : ℕ), 1 ≤ m → lead g m → ∃ x : α, isRoot x g)
    (hfactor : ∀ (g : M) (x : α) (m : ℕ), 1 ≤ m → bound g m → lead g m →
      isRoot x g →
      ∃ q : M, g = fac x * q ∧ bound q (m - 1) ∧ lead q (m - 1))
    (hmem : ∀ (x : α) (C : M), f = fac x * C → rootOk x)
    (hextract : ∀ (a : ℕ → α) (j i : ℕ), i < j →
      ∃ B : M, (∏ k ∈ Finset.range j, fac (a k)) = fac (a i) * B ∧
        bound B (j - 1))
    (hmul : ∀ (B C : M) (p q : ℕ), bound B p → bound C q →
      bound (B * C) (p + q))
    (hmono : ∀ (C : M) (p q : ℕ), p ≤ q → bound C p → bound C q)
    (hdistinct : ∀ x : α, rootOk x → ∀ (h B g : M), bound h n →
      f = fac x * h → h = B * g → ∀ x' : α, isRoot x' g → x' ≠ x) :
    ∀ j : ℕ, j ≤ n →
      ∃ (w : ℕ → α) (g : M),
        (∀ i : ℕ, i < j → rootOk (w i)) ∧
        (∀ i i' : ℕ, i < j → i' < j → i ≠ i' → w i ≠ w i') ∧
        f = (∏ i ∈ Finset.range j, fac (w i)) * g ∧
        bound g (n - j) ∧ lead g (n - j) := by
  intro j
  induction j with
  | zero =>
      -- 出発点: 根の列は空（α の元は f 自身の根から取る）、g := f。
      intro _
      obtain ⟨x₀, _⟩ := hroot f n hn hbase.2
      refine ⟨fun _ => x₀, f, ?_, ?_, ?_, hbase.1, hbase.2⟩
      · intro i hi; exact absurd hi (Nat.not_lt_zero i)
      · intro i i' hi _ _; exact absurd hi (Nat.not_lt_zero i)
      · rw [Finset.range_zero, Finset.prod_empty, one_mul]
  | succ j ih =>
      intro hj1
      have hjn : j < n := by omega
      obtain ⟨w, g, hmemo, hdist, hdecomp, hbound, hlead⟩ := ih (by omega)
      have hm1 : 1 ≤ n - j := by omega
      -- 根の供給。
      obtain ⟨x, hrootx⟩ := hroot g (n - j) hm1 hlead
      -- 因数分解と、商の上界・先頭の係数。
      obtain ⟨q, hfact, hqbound', hqlead'⟩ :=
        hfactor g x (n - j) hm1 hbound hlead hrootx
      have hsub : n - j - 1 = n - (j + 1) := by omega
      have hqbound : bound q (n - (j + 1)) := by rw [← hsub]; exact hqbound'
      have hqlead : lead q (n - (j + 1)) := by rw [← hsub]; exact hqlead'
      -- 新しい根の所属: f = fac x * ((∏ ...) * q) と並べ替える。
      have hxmem : rootOk x := by
        refine hmem x ((∏ i ∈ Finset.range j, fac (w i)) * q) ?_
        rw [hdecomp, hfact, mul_left_comm]
      -- 相異性: 取り出し（hextract）・積の上界（hmul）・単調性（hmono）・
      -- 相異性の仮定（hdistinct）を、具体版と同じ順で当てる。
      have hxne : ∀ i : ℕ, i < j → x ≠ w i := by
        intro i hij
        obtain ⟨B, hB, hBbound⟩ := hextract w j i hij
        have hhbound : bound (B * g) n := by
          refine hmono (B * g) ((j - 1) + (n - j)) n (by omega) ?_
          exact hmul B g (j - 1) (n - j) hBbound hbound
        have hfeq : f = fac (w i) * (B * g) := by
          rw [hdecomp, hB, mul_assoc]
        exact hdistinct (w i) (hmemo i hij) (B * g) B g hhbound hfeq rfl x hrootx
      -- 根の列へ x を加え、商を q に替える。
      refine ⟨fun i => if i = j then x else w i, q, ?_, ?_, ?_, hqbound, hqlead⟩
      · intro i hi
        by_cases hij : i = j
        · simp only [if_pos hij]; exact hxmem
        · simp only [if_neg hij]; exact hmemo i (by omega)
      · intro i i' hi hi' hne
        by_cases hij : i = j
        · have hij' : ¬ i' = j := by omega
          simp only [if_pos hij, if_neg hij']
          exact hxne i' (by omega)
        · by_cases hij' : i' = j
          · simp only [if_neg hij, if_pos hij']
            exact Ne.symm (hxne i (by omega))
          · simp only [if_neg hij, if_neg hij']
            exact hdist i i' (by omega) (by omega) hne
      · -- 分解の等式（最後の因子を掛ける）。
        have hprodeq :
            (∏ i ∈ Finset.range (j + 1), fac (if i = j then x else w i))
            = (∏ i ∈ Finset.range j, fac (w i)) * fac x := by
          rw [Finset.prod_range_succ, if_pos rfl]
          congr 1
          refine Finset.prod_congr rfl (fun i hi => ?_)
          have hij : ¬ i = j := by
            have := Finset.mem_range.mp hi
            omega
          rw [if_neg hij]
        calc
          f = (∏ i ∈ Finset.range j, fac (w i)) * g := hdecomp
          _ = (∏ i ∈ Finset.range j, fac (w i)) * (fac x * q) := by rw [← hfact]
          _ = ((∏ i ∈ Finset.range j, fac (w i)) * fac x) * q := by
                rw [mul_assoc]
          _ = (∏ i ∈ Finset.range (j + 1),
                fac (if i = j then x else w i)) * q := by rw [hprodeq]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
