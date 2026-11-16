/-
「半格子ずれた四つのモード和は同じ積分へ収束する」（`claim_shifted_mode_riemann_sums`）の証明のうち、
`claim_dispersion_product_real_log_sum` を使わない段（再添字付けと極限の書き換え）の必要十分版。

再添字付け `modeSum_reindex_necSuf` は具体版と同じ手順（各 `(k,l)` の逆像を全射性で選ぶ、
逆像の単射性を Θ の値の成分と `e₁`・`e₂` の単射性から、全射性を Θ の値の像の表示と Θ の単射性から、
直積上の和を累次和へ、各項を書き換える）を、次の仮定だけで行う。

- 添字の型 `A` は有限（具体版の `U_a × W_b`）。和の値は加法可換モノイド `M` に取ればよい（具体版は `ℝ`）。
  減法も順序も使わない。
- `Θ : A → X × Y` は単射（具体版の複素実現の組）。`X`・`Y` に構造は要らない。
- `e₁ : ℕ → X`・`e₂ : ℕ → Y` は `{0,…,n-1}` の上で単射（具体版の `exp(2πi(k+c/2)/L)`）。
  外すと二つの `(k,l)` が同じ逆像を持ち、右辺が項を重複して数える。
- Θ の値は `e₁({0,…,n-1}) × e₂({0,…,n-1})` に属し（具体版の `E_{L,a} × E_{L,b}` の表示）、
  逆に各 `(e₁ k, e₂ l)` は Θ の値である（具体版の全射性）。前者を外すと左辺の項が右辺に現れず、
  後者を外すと逆像が選べない。
- 項の書き換え `hterm`（具体版の分散因子の角表示と `f_q` の定義）は、Θ の値が `(e₁ k, e₂ l)` の元についてだけ要る。

極限の書き換え `scaled_tendsto_necSuf` は、具体版の `(1/(2L²)) = (1/(8π²))·h_L²` と極限の定数倍を、
モノイド `R` の作用が各定数倍について連続であることだけで行う（具体版は `R = M = ℝ`）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Topology.Algebra.ConstMulAction
import Mathlib.Order.Filter.AtTopBot.Basic

namespace Ising2DLambda.NecSuf.RealEscape

open Filter Topology

/-- `(e₁ k, e₂ l)` の Θ による逆像。 -/
noncomputable def reindexPreimageNecSuf {A X Y : Type*} (Θ : A → X × Y) (e₁ : ℕ → X) (e₂ : ℕ → Y)
    (hsurj : ∀ k l : ℕ, ∃ a : A, Θ a = (e₁ k, e₂ l)) (k l : ℕ) : A :=
  Classical.choose (hsurj k l)

theorem reindexPreimageNecSuf_spec {A X Y : Type*} (Θ : A → X × Y) (e₁ : ℕ → X) (e₂ : ℕ → Y)
    (hsurj : ∀ k l : ℕ, ∃ a : A, Θ a = (e₁ k, e₂ l)) (k l : ℕ) :
    Θ (reindexPreimageNecSuf Θ e₁ e₂ hsurj k l) = (e₁ k, e₂ l) :=
  Classical.choose_spec (hsurj k l)

/-- 必要十分版の再添字付け: `Σ_{a ∈ A} φ a = Σ_{k,l<n} g k l`。 -/
theorem modeSum_reindex_necSuf {A X Y M : Type*} [Fintype A] [AddCommMonoid M]
    (n : ℕ) (Θ : A → X × Y) (hΘ : Function.Injective Θ) (e₁ : ℕ → X) (e₂ : ℕ → Y)
    (he₁ : Set.InjOn e₁ (Finset.range n : Set ℕ)) (he₂ : Set.InjOn e₂ (Finset.range n : Set ℕ))
    (hmaps : ∀ a : A, ∃ k < n, ∃ l < n, Θ a = (e₁ k, e₂ l))
    (hsurj : ∀ k l : ℕ, ∃ a : A, Θ a = (e₁ k, e₂ l))
    (φ : A → M) (g : ℕ → ℕ → M) (hterm : ∀ (a : A) (k l : ℕ), Θ a = (e₁ k, e₂ l) → φ a = g k l) :
    ∑ a : A, φ a = ∑ k ∈ Finset.range n, ∑ l ∈ Finset.range n, g k l := by
  set μ := reindexPreimageNecSuf Θ e₁ e₂ hsurj with hμ
  have hspec := reindexPreimageNecSuf_spec Θ e₁ e₂ hsurj
  calc ∑ a : A, φ a
      -- Θ による再添字付け
      = ∑ kl ∈ Finset.range n ×ˢ Finset.range n, φ (μ kl.1 kl.2) := by
        symm
        refine Finset.sum_bij (fun kl _ => μ kl.1 kl.2) (fun _ _ => Finset.mem_univ _) ?_ ?_
          (fun _ _ => rfl)
        · rintro ⟨k, l⟩ hkl ⟨k', l'⟩ hkl' h
          have hkl2 : ((e₁ k, e₂ l) : X × Y) = (e₁ k', e₂ l') := by
            rw [← hspec k l, ← hspec k' l']; exact congrArg Θ h
          obtain ⟨h1, h2⟩ := Prod.mk.inj hkl2
          simp only [Finset.mem_product] at hkl hkl'
          rw [he₁ (Finset.mem_coe.2 hkl.1) (Finset.mem_coe.2 hkl'.1) h1,
            he₂ (Finset.mem_coe.2 hkl.2) (Finset.mem_coe.2 hkl'.2) h2]
        · intro a _
          obtain ⟨k, hk, l, hl, hkl⟩ := hmaps a
          refine ⟨(k, l), by simp [hk, hl], hΘ ?_⟩
          rw [hspec k l, hkl]
    -- 直積上の和を累次和へ
    _ = ∑ k ∈ Finset.range n, ∑ l ∈ Finset.range n, φ (μ k l) := Finset.sum_product _ _ _
    -- 各項の書き換え
    _ = ∑ k ∈ Finset.range n, ∑ l ∈ Finset.range n, g k l := by
        refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
        exact hterm (μ k l) k l (hspec k l)

/-- 必要十分版の極限の書き換え: `b_L • S_L → I` かつ十分大きい `L` で `a_L = c * b_L` なら
`a_L • S_L → c • I`。 -/
theorem scaled_tendsto_necSuf {R M : Type*} [Monoid R] [TopologicalSpace M] [MulAction R M]
    [ContinuousConstSMul R M] (a b : ℕ → R) (c : R) (S : ℕ → M) (I : M)
    (hab : ∀ᶠ L in atTop, a L = c * b L) (hlim : Tendsto (fun L => b L • S L) atTop (𝓝 I)) :
    Tendsto (fun L => a L • S L) atTop (𝓝 (c • I)) := by
  refine (hlim.const_smul c).congr' ?_
  filter_upwards [hab] with L hL
  rw [hL, mul_smul]

end Ising2DLambda.NecSuf.RealEscape
