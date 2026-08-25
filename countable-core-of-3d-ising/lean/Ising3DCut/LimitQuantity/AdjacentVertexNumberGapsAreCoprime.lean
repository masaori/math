/-
人手証明「隣接する二つの箱の頂点数の差は、次に隣接する二つの箱の頂点数の差と互いに素である」
（ラベル `claim_adjacent_vertex_number_gaps_are_coprime`）の Lean 具体版。

人手証明と同じ順で進む。
準備段: `g L = 3 * L * (L + 1) + 1` と `g (L + 1) = g L + 6 * (L + 1)` の二つの等式を確かめる。
場合分けの用意: 共通素因子 `p` が差 `6 * (L + 1)` を割ることから、
        `p ∣ L + 1`・`p ∣ 2`・`p ∣ 3` のいずれかが成り立つことを取り出す。
第一の場合: `p ∣ L + 1` から `p ∣ 3 * L * (L + 1)`。
第二の場合: `p = 2` のとき、連続する二つの自然数の積が偶数であることから `p ∣ 3 * L * (L + 1)`。
第三の場合: `p = 3` のとき、そのまま `p ∣ 3 * L * (L + 1)`。
着地: どの場合も `p ∣ g L` と準備の等式から `p ∣ 1` となり、素数が 1 を割ることになって矛盾する。

扱うのは正の自然数の最大公約数だけであり、箱の大きさの極限も正の実数乗根も現れない。
計算は自然数の整除と素数の定義だけで行い、mathlib の一般論へ委ねない。
-/
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Tactic.Ring

namespace Ising3DCut.LimitQuantity

/-- 隣接する二つの箱の頂点数の差 `#V_{L+1} - #V_L = 3L² + 3L + 1`。 -/
def vertexNumberGap (L : ℕ) : ℕ := 3 * L ^ 2 + 3 * L + 1

/-- 人手証明の準備段の第一の等式。`g_L = 3L(L+1) + 1` である。 -/
theorem vertexNumberGap_eq_three_mul_mul_succ_add_one (L : ℕ) :
    vertexNumberGap L = 3 * L * (L + 1) + 1 := by
  unfold vertexNumberGap
  ring

/-- 人手証明の準備段の第二の等式。`g_{L+1} - g_L = 6(L+1)`、すなわち
`g_{L+1} = g_L + 6(L+1)` である。 -/
theorem vertexNumberGap_succ_eq_add_six_mul_succ (L : ℕ) :
    vertexNumberGap (L + 1) = vertexNumberGap L + 6 * (L + 1) := by
  unfold vertexNumberGap
  ring

/-- 場合分けの用意。素数 `p` が `6 * (L + 1) = 2 * (3 * (L + 1))` を割るなら、
`p ∣ L + 1`・`p ∣ 2`・`p ∣ 3` のいずれかが成り立つ。 -/
theorem dvd_two_or_three_or_succ_of_dvd_six_mul_succ
    (p L : ℕ) (hp : Nat.Prime p) (h : p ∣ 6 * (L + 1)) :
    p ∣ L + 1 ∨ p ∣ 2 ∨ p ∣ 3 := by
  have hsplit : (6 : ℕ) * (L + 1) = 2 * (3 * (L + 1)) := by ring
  rcases (Nat.Prime.dvd_mul hp).mp (hsplit ▸ h) with h2 | hrest
  · exact Or.inr (Or.inl h2)
  · rcases (Nat.Prime.dvd_mul hp).mp hrest with h3 | hL
    · exact Or.inr (Or.inr h3)
    · exact Or.inl hL

/-- 人手証明の着地の一歩。`p ∣ g_L` と `p ∣ 3L(L+1)` が同時に成り立つと、
準備の等式 `g_L = 3L(L+1) + 1` により `p ∣ 1` となって素数であることに反する。 -/
theorem false_of_dvd_gap_and_dvd_three_mul_mul_succ
    (p L : ℕ) (hp : Nat.Prime p)
    (hgap : p ∣ vertexNumberGap L) (hprod : p ∣ 3 * L * (L + 1)) : False := by
  have hgap' : p ∣ 3 * L * (L + 1) + 1 :=
    (vertexNumberGap_eq_three_mul_mul_succ_add_one L) ▸ hgap
  have hone : p ∣ 1 := (Nat.dvd_add_right hprod).mp hgap'
  exact Nat.Prime.one_lt hp |>.ne' (Nat.dvd_one.mp hone)

/-- 人手証明の第二の場合の中身。連続する二つの自然数の積は偶数なので `2 ∣ 3L(L+1)`。 -/
theorem two_dvd_three_mul_mul_succ (L : ℕ) : 2 ∣ 3 * L * (L + 1) := by
  have h : 2 ∣ L * (L + 1) := Nat.even_mul_succ_self L |>.two_dvd
  have hassoc : 3 * L * (L + 1) = 3 * (L * (L + 1)) := by ring
  exact hassoc ▸ Dvd.dvd.mul_left h 3

/-- 人手証明の全体。隣接する二つの箱の頂点数の差 `g_L` は、次に隣接する二つの箱の
頂点数の差 `g_{L+1}` と互いに素である。 -/
theorem adjacent_vertex_number_gaps_are_coprime (L : ℕ) :
    Nat.Coprime (vertexNumberGap L) (vertexNumberGap (L + 1)) := by
  by_contra hne
  obtain ⟨p, hp, hpd⟩ :=
    Nat.exists_prime_and_dvd (n := Nat.gcd (vertexNumberGap L) (vertexNumberGap (L + 1))) hne
  have hL : p ∣ vertexNumberGap L := hpd.trans (Nat.gcd_dvd_left _ _)
  have hL1 : p ∣ vertexNumberGap (L + 1) := hpd.trans (Nat.gcd_dvd_right _ _)
  have hdiff : p ∣ 6 * (L + 1) := by
    have hsum : vertexNumberGap (L + 1) = vertexNumberGap L + 6 * (L + 1) :=
      vertexNumberGap_succ_eq_add_six_mul_succ L
    exact (Nat.dvd_add_right hL).mp (hsum ▸ hL1)
  rcases dvd_two_or_three_or_succ_of_dvd_six_mul_succ p L hp hdiff with hsucc | h2 | h3
  · -- 第一の場合。`p ∣ L + 1` から `p ∣ 3L(L+1)`。
    exact false_of_dvd_gap_and_dvd_three_mul_mul_succ p L hp hL
      (Dvd.dvd.mul_left hsucc (3 * L))
  · -- 第二の場合。`p = 2` で、連続する二つの自然数の積が偶数であることを使う。
    have hp2 : p = 2 := (Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).mp h2
    exact false_of_dvd_gap_and_dvd_three_mul_mul_succ p L hp hL
      (hp2 ▸ two_dvd_three_mul_mul_succ L)
  · -- 第三の場合。`p = 3` で、`3 ∣ 3L(L+1)` はそのまま従う。
    have hp3 : p = 3 := (Nat.prime_dvd_prime_iff_eq hp Nat.prime_three).mp h3
    have h3d : (3 : ℕ) ∣ 3 * L * (L + 1) := Dvd.dvd.mul_right (Dvd.intro L rfl) (L + 1)
    exact false_of_dvd_gap_and_dvd_three_mul_mul_succ p L hp hL (hp3 ▸ h3d)

end Ising3DCut.LimitQuantity
