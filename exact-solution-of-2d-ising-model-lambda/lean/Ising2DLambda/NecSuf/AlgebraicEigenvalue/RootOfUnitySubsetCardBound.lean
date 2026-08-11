/-
「1 の冪根の全体の有限部分集合の元の個数は指数を超えない」に必要十分な仮定だけを残した版。

このセクションの中身は「準備の多項式を作り、3 つの仮定を検査して前セクションの上界を当てる」
ことだけなので、前セクションの上界そのものは仮定 `hcard` として受け取る。
残る仮定が示すのは、この検査が要求するのが

- 値の側: 和の記号と零元・単位元・冪の記号、零元との和の 2 規則、
  「1 + m = 0 を満たす元 m」（加法の逆元の存在は全体には要らない。1 の逆元 1 つでよい）、
  および 1 ≠ 0
- 多項式の側: 和・零・不定元の冪・定数の記号と、係数・評価がそれらをどう見るかの約束

だけであり、値の側の積・体であること・代数閉であること・多項式環の構造そのものは
一切使っていないことである（冪 w^n は記号として受け取るだけで、積の反復であることも使わない）。
-/
import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

theorem root_of_unity_subset_card_le_necSuf
    {P α : Type*} [Add α] [Zero α] [One α] [Pow α ℕ]
    (padd : P → P → P) (pzero : P) (xpow : ℕ → P) (pconst : α → P)
    (c : ℕ → P → α) (ev : α → P → α)
    -- 値の側の約束。
    (hzero_add : ∀ a : α, (0 : α) + a = a)
    (hadd_zero : ∀ a : α, a + (0 : α) = a)
    (m : α) (hm : (1 : α) + m = 0) (hone_ne : (1 : α) ≠ 0)
    -- 係数の約束。
    (hc_add : ∀ (k : ℕ) (p q : P), c k (padd p q) = c k p + c k q)
    (hc_xpow : ∀ k j : ℕ, k ≠ j → c k (xpow j) = 0)
    (hc_const_zero : ∀ a : α, c 0 (pconst a) = a)
    (hc_const_pos : ∀ (a : α) (k : ℕ), 1 ≤ k → c k (pconst a) = 0)
    (hc_zero : ∀ k : ℕ, c k pzero = 0)
    -- 評価の約束。
    (hev_add : ∀ (w : α) (p q : P), ev w (padd p q) = ev w p + ev w q)
    (hev_xpow : ∀ (w : α) (j : ℕ), ev w (xpow j) = w ^ j)
    (hev_const : ∀ (w a : α), ev w (pconst a) = a)
    -- 前セクションの主張（根の個数の上界）。
    (hcard : ∀ (p : P) (s : Finset α) (n : ℕ), p ≠ pzero →
      (∀ k : ℕ, n < k → c k p = 0) → (∀ w ∈ s, ev w p = 0) → s.card ≤ n)
    (n : ℕ) (hn : 1 ≤ n) (s : Finset α) (hs : ∀ w ∈ s, w ^ n = (1 : α)) :
    s.card ≤ n := by
  -- m ≠ 0（もし m = 0 なら 0 = 1 + m = 1 + 0 = 1 となり 1 ≠ 0 に反する）。
  have hmne : m ≠ 0 := by
    intro h0
    apply hone_ne
    calc (1 : α) = 1 + 0 := (hadd_zero 1).symm
      _ = 1 + m := by rw [h0]
      _ = 0 := hm
  -- 準備。f := t^n + (定数として送った m)。
  set f : P := padd (xpow n) (pconst m) with hf
  -- 第 1 の検査。c 0 f = m ≠ 0 なので f ≠ pzero。
  have hcoeff0 : c 0 f = m := by
    rw [hf, hc_add, hc_xpow 0 n (by omega), hc_const_zero, hzero_add]
  have hfne : f ≠ pzero := by
    intro h0
    apply hmne
    rw [← hcoeff0, h0, hc_zero]
  -- 第 2 の検査。n < k では両方の項の係数が零である。
  have hcoeff : ∀ k : ℕ, n < k → c k f = 0 := by
    intro k hk
    rw [hf, hc_add, hc_xpow k n (by omega), hc_const_pos m k (by omega), hzero_add]
  -- 第 3 の検査。w^n = 1 から ev w f = 1 + m = 0。
  have hroot : ∀ w ∈ s, ev w f = 0 := by
    intro w hw
    rw [hf, hev_add, hev_xpow, hev_const, hs w hw, hm]
  -- 結論。上界の仮定を当てる。
  exact hcard f s n hfne hcoeff hroot

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
