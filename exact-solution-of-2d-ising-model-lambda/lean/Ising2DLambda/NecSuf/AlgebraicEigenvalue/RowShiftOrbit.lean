/-
主張「反復した巡回シフトは単射である」「軌道の元の個数は最小周期に等しい」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbit`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ向きの帰納法・同じ `Finset.card_bij`・
同じ除法の使い方）。

  主張                    使っている性質
  iterLeft_injective      写像 f が単射であること**だけ**。f が全射である必要は無く、
                          型 ι に有限性も相等の判定も要らない。
  orbit                   ι が有限で相等が判定できること（Finset として書くために要る）。
  card_orbit              上に加えて、f が単射であること・その点が 1 回以上の反復で
                          戻ること・ℕ の除法。**f が全単射である必要は無い**。

削れなかった仮定は 3 つで、いずれも理由が異なる。

1. `Function.Injective f`。単射性の主張そのものと、`card_orbit` の単射性の段で使う。
   全射性はどちらでも使っていない。すなわち人手証明が `claim_row_config_shift_bijective`
   （S は全単射）から引いているのは単射性の半分だけである。
2. `Fintype ι` と `DecidableEq ι`。軌道を `Finset` として書き、その `card` を語るために要る。
   人手証明が「O(τ) は有限集合 R_L の部分集合なので有限」と述べているのにあたる。
   数え上げの中身には効いていない（個数の等式は 1 対 1 対応から出る）。
3. 点ごとの周期の存在（`∃ k, 1 ≤ k ∧ iterLeft f k i = i`）。最小周期が定まるために要る。
   f が全体として周期を持つことは要求していない。

mathlib の `Function.minimalPeriod` / `Function.periodicOrbit` / 軌道の一般論は引いていない。
使ったのは `Finset.card_bij`（人手証明が書いている「写像を置いて単射性と全射性を別々に見る」形
そのもの）と ℕ の除法の基本性質だけである。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、回数と個数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftPeriod

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*}

/-- 人手証明の主張「反復した巡回シフトは単射である」。

要るのは `f` が単射であることだけである（全射性は使っていない）。 -/
theorem iterLeft_injective (f : ι → ι) (hf : Function.Injective f) (k : ℕ) :
    Function.Injective (iterLeft f k) := by
  induction k with
  | zero =>
    -- f^[0] = id
    intro i₁ i₂ h
    exact h
  | succ k ih =>
    -- f^[k+1] = f ∘ f^[k]。f が単射なので f^[k](i₁) = f^[k](i₂) が出る
    intro i₁ i₂ h
    have h' : f (iterLeft f k i₁) = f (iterLeft f k i₂) := h
    exact ih (hf h')

/-- 人手証明が証明の冒頭で置いていること「`e | d` かつ `d < e` ならば `d = 0`」。 -/
theorem eq_zero_of_dvd_of_lt_period {e d : ℕ} (hdvd : e ∣ d) (hlt : d < e) : d = 0 := by
  obtain ⟨q, rfl⟩ := hdvd
  rcases Nat.eq_zero_or_pos q with hq | hq
  · rw [hq, Nat.mul_zero]
  · exact absurd hlt (Nat.not_lt.mpr (Nat.le_mul_of_pos_right e hq))

variable [Fintype ι] [DecidableEq ι]

/-- 人手証明の `O(τ) = { τ' | τ' = S^[k](τ) を満たす k が存在する }`。 -/
noncomputable def orbit (f : ι → ι) (i : ι) : Finset ι :=
  open Classical in univ.filter fun j => ∃ k : ℕ, j = iterLeft f k i

lemma mem_orbit {f : ι → ι} {i j : ι} :
    j ∈ orbit f i ↔ ∃ k : ℕ, j = iterLeft f k i := by
  classical
  simp [orbit]

/-- 人手証明の単射性の段（`a ≤ b` の側）。 -/
theorem eq_of_iterLeft_eq_of_le (f : ι → ι) (hf : Function.Injective f) (i : ι)
    (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i) {a b : ℕ} (hab : a ≤ b)
    (hb : b < minimalPeriod f i h) (heq : iterLeft f a i = iterLeft f b i) : a = b := by
  have hchain : iterLeft f a (iterLeft f (b - a) i) = iterLeft f a i := by
    calc iterLeft f a (iterLeft f (b - a) i)
        = iterLeft f (a + (b - a)) i := (iterLeft_add f a (b - a) i).symm
      _ = iterLeft f b i := by rw [Nat.add_sub_cancel' hab]
      _ = iterLeft f a i := heq.symm
  have hreturn : iterLeft f (b - a) i = i := iterLeft_injective f hf a hchain
  have hdvd : minimalPeriod f i h ∣ b - a := (iterLeft_eq_self_iff f i h (b - a)).mp hreturn
  have hzero : b - a = 0 :=
    eq_zero_of_dvd_of_lt_period hdvd (Nat.lt_of_le_of_lt (Nat.sub_le b a) hb)
  omega

/-- 人手証明の主張「軌道の元の個数は最小周期に等しい」。

`Finset.card_bij` は人手証明の形そのもの（写像 `η(k) = f^[k](i)` を置き、
単射性と全射性を別々に見る）である。 -/
theorem card_orbit (f : ι → ι) (hf : Function.Injective f) (i : ι)
    (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i) :
    (orbit f i).card = minimalPeriod f i h := by
  classical
  have hcard : (range (minimalPeriod f i h)).card = (orbit f i).card := by
    refine card_bij (fun k _ => iterLeft f k i) ?_ ?_ ?_
    · intro k _
      exact mem_orbit.mpr ⟨k, rfl⟩
    · intro a ha b hb heq
      rw [mem_range] at ha hb
      rcases Nat.le_total a b with hle | hle
      · exact eq_of_iterLeft_eq_of_le f hf i h hle hb heq
      · exact (eq_of_iterLeft_eq_of_le f hf i h hle ha heq.symm).symm
    · intro j hj
      obtain ⟨k, hk⟩ := mem_orbit.mp hj
      have hepos : 0 < minimalPeriod f i h := minimalPeriod_pos f i h
      refine ⟨k % minimalPeriod f i h, mem_range.mpr (Nat.mod_lt k hepos), ?_⟩
      calc iterLeft f (k % minimalPeriod f i h) i
          = iterLeft f (k % minimalPeriod f i h)
              (iterLeft f (minimalPeriod f i h * (k / minimalPeriod f i h)) i) := by
            rw [iterLeft_mul f i _ (iterLeft_minimalPeriod f i h)]
        _ = iterLeft f
              (k % minimalPeriod f i h
                + minimalPeriod f i h * (k / minimalPeriod f i h)) i :=
            (iterLeft_add f _ _ i).symm
        _ = iterLeft f k i := by rw [Nat.mod_add_div]
        _ = j := hk.symm
  rw [← hcard, card_range]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
