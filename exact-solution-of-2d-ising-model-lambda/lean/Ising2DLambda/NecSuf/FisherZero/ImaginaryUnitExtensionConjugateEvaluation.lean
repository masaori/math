/-
「虚数単位を足した体の共役は多項式の値と入れ替わる」の必要十分版。

具体版の証明が使うのは次だけである。
- 係数環が可換環であること。分配法則と積の交換・結合法則を使う。逆元は使わない。
- `ω·ω = -1`。積の保存（準備 (三)）で `bω·eω` を `-be` へ移す段で使う。
- 部分集合 `S` が零元・単位元を含み、和・符号反転・積で閉じること。零元は空の和と `cj(0) = 0`、
  単位元は `z^0 = 1 + 0ω`、符号反転は `cj(a + bω) = a + (-b)ω` の所属（準備 (四)）と
  積の表示 `(ac - be) + (ae + bc)ω`、和と積は一次式の値の全体の閉性に使う。
  `-1 ∈ S` は単位元と符号反転から得て、一次式の値の全体の閉性（`a := -1`）へ渡す。
- 写像 `cj` が `S` の任意の元 `a, b` について `cj(a + bω) = a - bω` を満たすこと。
  具体版はこれを表示の一意性による共役の well-defined 性から得る。正錐・`ω ∉ F` はそこにだけ効く。

多項式の値を係数の有限和で書く段（`claim_qbar_evaluation_coefficient_sum`）は具体版の側の段なので、
ここでは係数の列 `p`, `q` と有限和で述べる。
-/
import Ising2DLambda.NecSuf.FisherZero.QuadraticLinearValuesClosed
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 一次式の値の全体 `{a + bω | a, b ∈ S}`。 -/
def linearValuesOn {R : Type*} [CommRing R] (S : Set R) (omega : R) : Set R :=
  {y | ∃ u v : R, u ∈ S ∧ v ∈ S ∧ y = u + v * omega}

/-- 具体版と同じ段（準備 (一)〜(六) と七行の式鎖）で示す。 -/
theorem imaginaryUnitExtension_conjugate_evaluation_necSuf
    {R : Type*} [CommRing R] (S : Set R)
    (hzero : (0 : R) ∈ S) (hone : (1 : R) ∈ S)
    (hadd : ∀ x y : R, x ∈ S → y ∈ S → x + y ∈ S)
    (hneg : ∀ x : R, x ∈ S → -x ∈ S)
    (hmulS : ∀ x y : R, x ∈ S → y ∈ S → x * y ∈ S)
    (omega : R) (homega : omega * omega = -1)
    (cj : R → R) (hcj : ∀ a b : R, a ∈ S → b ∈ S → cj (a + b * omega) = a - b * omega)
    (p q : ℕ → R) (hp : ∀ k, p k ∈ linearValuesOn S omega) (hq : ∀ k, q k = cj (p k))
    (z : R) (hz : z ∈ linearValuesOn S omega) (n : ℕ) :
    (∑ k ∈ Finset.range (n + 1), q k * z ^ k) ∈ linearValuesOn S omega ∧
      ∑ k ∈ Finset.range (n + 1), p k * cj z ^ k
        = cj (∑ k ∈ Finset.range (n + 1), q k * z ^ k) := by
  -- 準備 (一): 一次式の値の全体は 0・1・和・積で閉じる。
  obtain ⟨h0, h1, haddL, _, hmulL⟩ :=
    quadraticLinearValues_ringClosed_necSuf S hzero hone hadd hneg hmulS (-1) omega
      (hneg 1 hone) homega
  have hsub : ∀ x y : R, x ∈ S → y ∈ S → x - y ∈ S := fun x y hx hy => by
    rw [sub_eq_add_neg]; exact hadd _ _ hx (hneg _ hy)
  -- 準備 (二): 和の保存。
  have cadd : ∀ u v, u ∈ linearValuesOn S omega → v ∈ linearValuesOn S omega →
      cj (u + v) = cj u + cj v := by
    rintro u v ⟨a, b, ha, hb, rfl⟩ ⟨c, e, hc, he, rfl⟩
    rw [show (a + b * omega) + (c + e * omega) = (a + c) + (b + e) * omega by ring,
      hcj _ _ (hadd _ _ ha hc) (hadd _ _ hb he), hcj a b ha hb, hcj c e hc he]
    ring
  -- 準備 (三): 積の保存。
  have cmul : ∀ u v, u ∈ linearValuesOn S omega → v ∈ linearValuesOn S omega →
      cj (u * v) = cj u * cj v := by
    rintro u v ⟨a, b, ha, hb, rfl⟩ ⟨c, e, hc, he, rfl⟩
    rw [show (a + b * omega) * (c + e * omega)
        = (a * c - b * e) + (a * e + b * c) * omega by linear_combination (b * e) * homega,
      hcj _ _ (hsub _ _ (hmulS _ _ ha hc) (hmulS _ _ hb he))
        (hadd _ _ (hmulS _ _ ha he) (hmulS _ _ hb hc)),
      hcj a b ha hb, hcj c e hc he]
    linear_combination (-(b * e)) * homega
  -- 準備 (四): 共役の所属と、共役の共役。
  have cmem : ∀ u, u ∈ linearValuesOn S omega → cj u ∈ linearValuesOn S omega := by
    rintro u ⟨a, b, ha, hb, rfl⟩
    refine ⟨a, -b, ha, hneg _ hb, ?_⟩
    rw [hcj a b ha hb]; ring
  have cconj : ∀ u, u ∈ linearValuesOn S omega → cj (cj u) = u := by
    rintro u ⟨a, b, ha, hb, rfl⟩
    rw [hcj a b ha hb, show a - b * omega = a + (-b) * omega by ring,
      hcj a (-b) ha (hneg _ hb)]
    ring
  -- 準備 (五): 冪の所属と冪の保存（`k` についての帰納法）。
  have cpow : ∀ k : ℕ, z ^ k ∈ linearValuesOn S omega ∧ cj (z ^ k) = cj z ^ k := by
    intro k
    induction k with
    | zero =>
        refine ⟨by rw [pow_zero]; exact h1, ?_⟩
        rw [pow_zero, pow_zero, show (1 : R) = 1 + 0 * omega by ring, hcj 1 0 hone hzero]
        ring
    | succ k ih =>
        refine ⟨by rw [pow_succ]; exact hmulL _ _ ih.1 hz, ?_⟩
        rw [pow_succ, pow_succ, cmul _ _ ih.1 hz, ih.2]
  -- 準備 (六): 有限和の所属と和の保存（項の個数についての帰納法）。
  have csum : ∀ (x : ℕ → R), (∀ k, x k ∈ linearValuesOn S omega) → ∀ m : ℕ,
      (∑ k ∈ Finset.range m, x k) ∈ linearValuesOn S omega ∧
        cj (∑ k ∈ Finset.range m, x k) = ∑ k ∈ Finset.range m, cj (x k) := by
    intro x hx m
    induction m with
    | zero =>
        simp only [Finset.sum_range_zero]
        refine ⟨h0, ?_⟩
        rw [show (0 : R) = 0 + 0 * omega by ring, hcj 0 0 hzero hzero]
        ring
    | succ m ih =>
        rw [Finset.sum_range_succ, Finset.sum_range_succ]
        exact ⟨haddL _ _ ih.1 (hx m), by rw [cadd _ _ ih.1 (hx m), ih.2]⟩
  have hterm : ∀ k, cj (p k) * z ^ k ∈ linearValuesOn S omega := fun k =>
    hmulL _ _ (cmem _ (hp k)) (cpow k).1
  have hs := csum (fun k => cj (p k) * z ^ k) hterm (n + 1)
  have hqsum : ∑ k ∈ Finset.range (n + 1), q k * z ^ k
      = ∑ k ∈ Finset.range (n + 1), cj (p k) * z ^ k :=
    Finset.sum_congr rfl (fun k _ => by rw [hq k])
  refine ⟨by rw [hqsum]; exact hs.1, ?_⟩
  calc ∑ k ∈ Finset.range (n + 1), p k * cj z ^ k
      = ∑ k ∈ Finset.range (n + 1), cj (cj (p k)) * cj z ^ k :=
        Finset.sum_congr rfl (fun k _ => by rw [cconj _ (hp k)])
    _ = ∑ k ∈ Finset.range (n + 1), cj (cj (p k)) * cj (z ^ k) :=
        Finset.sum_congr rfl (fun k _ => by rw [(cpow k).2])
    _ = ∑ k ∈ Finset.range (n + 1), cj (cj (p k) * z ^ k) :=
        Finset.sum_congr rfl (fun k _ => by rw [cmul _ _ (cmem _ (hp k)) (cpow k).1])
    _ = cj (∑ k ∈ Finset.range (n + 1), cj (p k) * z ^ k) := hs.2.symm
    _ = cj (∑ k ∈ Finset.range (n + 1), q k * z ^ k) := by rw [hqsum]

end Ising2DLambda.NecSuf.FisherZero
