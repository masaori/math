/-
「非零項は閉歩道ごとのねじれ・回転位相の積に分かれる」の、閉路ごとの合成の段の必要十分版。
具体版と同じ二つの手順（閉路ごとの比、符号の整理と項の組み立て）を、次の一般の対象で行う。

* 閉路ごとの比: 任意の型 K 上の写像 ι、可換環 R に値をとる重み g : K → K → R と η : K → R、
  対の寄与 S : K × K → R、元 X ∈ R、位相の列 h : ℕ → R、閉じた点列 w（w_{n+1} = w_0）。
  仮定は、各一歩の寄与が X · g · h に分かれること（hS）、短い対の重みの積が長い対の重みの積の
  (-1)^{n+1} 倍であること（hratio。この w を巡回の添字で読んだ一本についてだけ）、
  長い対の重みが η であること（hlong）だけである。hper を外すと、短い対の列 (ι(w_r), w_{r+1}) を
  巡回の添字 (ι(γ_{r-1}), γ_r) へ読み替えられず hratio を当てられない。
  ι が反転であること、g が対角変換の重みであること、R が多項式環であることは使わない。
* 符号の整理と組み立て: 可換環 R の元と、添字の列 l の上の写像。仮定は、
  sgn(D) = (-1)^{|l|} ∏ α_D α₀（hsign）、α_D² = α₀² = 1（hD・h0）、|T| の符号が閉路ごとの
  (-1)^{k} の積であること（hcard）、η の積が ∏α_D であること（hAD）、閉路ごとの比（hP）、
  共通対の寄与が一であること（hLc）、項がこれらの積であること（hT）だけである。
  hD・h0 のどちらかを外すと、sgn(D)·∏α_D·∏α₀ が (-1)^{|l|} にならない。
  R が整数の像であること、α が ±1 の値をとる整数であることは使わない（平方が一であることだけを使う）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring
import Mathlib.Data.ZMod.Defs

namespace Ising2DLambda.NecSuf.KacWard

/-- 閉路ごとの比の必要十分版。 -/
theorem cycle_short_product_necSuf {K R : Type*} [CommRing R] (ι : K → K) (g : K → K → R)
    (η : K → R) (S : K × K → R) (X : R) (h : ℕ → R) (n : ℕ) (w : ℕ → K)
    (hper : w (n + 1) = w 0)
    (hS : ∀ r < n + 1, S (ι (w r), w (r + 1)) = X * (g (ι (w r)) (w (r + 1)) * h r))
    (hratio : ∏ r : Fin (n + 1), g (ι (w (r - 1).val)) (w r.val) =
      (-1) ^ (n + 1) * ∏ r : Fin (n + 1), g (w r.val) (ι (w r.val)))
    (hlong : ∀ e, g e (ι e) = η e) :
    ((List.range (n + 1)).map (fun r => S (ι (w r), w (r + 1)))).prod =
      ((-1) ^ (n + 1) * ∏ r ∈ Finset.range (n + 1), η (w r)) *
        (X ^ (n + 1) * ∏ r ∈ Finset.range (n + 1), h r) := by
  have hrange : ∀ (f : ℕ → R) (m : ℕ), ((List.range m).map f).prod = ∏ r ∈ Finset.range m, f r := by
    intro f m
    induction m with
    | zero => rfl
    | succ m ih =>
      rw [List.range_succ, List.map_append, List.prod_append, ih, Finset.prod_range_succ]
      simp
  have hγ : ∀ r : Fin (n + 1), w (r.val + 1) = w (r + 1).val := by
    intro r
    rw [Fin.val_add_one]
    split_ifs with hr
    · rw [hr, Fin.val_last, hper]
    · rfl
  have hweight : ∏ r ∈ Finset.range (n + 1), g (ι (w r)) (w (r + 1)) =
      (-1) ^ (n + 1) * ∏ r ∈ Finset.range (n + 1), η (w r) := by
    calc
      ∏ r ∈ Finset.range (n + 1), g (ι (w r)) (w (r + 1)) =
          ∏ r : Fin (n + 1), g (ι (w r.val)) (w (r + 1).val) := by
        rw [← Fin.prod_univ_eq_prod_range (fun r => g (ι (w r)) (w (r + 1)))]
        exact Finset.prod_congr rfl fun r _ => by rw [hγ r]
      _ = ∏ r : Fin (n + 1), g (ι (w (r - 1).val)) (w r.val) := by
        refine (Fintype.prod_equiv (Equiv.subRight (1 : Fin (n + 1))) _ _ (fun r => ?_)).symm
        simp only [Equiv.subRight_apply, sub_add_cancel]
      _ = (-1) ^ (n + 1) * ∏ r : Fin (n + 1), g (w r.val) (ι (w r.val)) := hratio
      _ = (-1) ^ (n + 1) * ∏ r ∈ Finset.range (n + 1), η (w r) := by
        rw [Finset.prod_congr rfl fun r _ => hlong (w r.val),
          Fin.prod_univ_eq_prod_range (fun r => η (w r))]
  calc
    ((List.range (n + 1)).map (fun r => S (ι (w r), w (r + 1)))).prod =
        ∏ r ∈ Finset.range (n + 1), X * (g (ι (w r)) (w (r + 1)) * h r) := by
      rw [hrange]
      exact Finset.prod_congr rfl fun r hr => hS r (Finset.mem_range.mp hr)
    _ = X ^ (n + 1) * ((∏ r ∈ Finset.range (n + 1), g (ι (w r)) (w (r + 1))) *
          ∏ r ∈ Finset.range (n + 1), h r) := by
      rw [Finset.prod_mul_distrib, Finset.prod_mul_distrib, Finset.prod_const, Finset.card_range]
    _ = _ := by
      rw [hweight]
      ring

/-- 符号の整理と組み立ての必要十分版。 -/
theorem cycle_term_compose_necSuf {ι R : Type*} [CommRing R] (l : List ι)
    (sD Mc AD Lc T : R) (k : ι → ℕ) (aD a0 P Y : ι → R)
    (hsign : sD = (-1) ^ l.length * (l.map (fun m => aD m * a0 m)).prod)
    (hD : ∀ m ∈ l, aD m * aD m = 1) (h0 : ∀ m ∈ l, a0 m * a0 m = 1)
    (hcard : Mc = (l.map (fun m => (-1 : R) ^ k m)).prod)
    (hAD : AD = (l.map aD).prod)
    (hP : ∀ m ∈ l, P m = ((-1) ^ k m * a0 m) * Y m)
    (hLc : Lc = 1)
    (hT : T = sD * (Mc * (AD * ((l.map P).prod * Lc)))) :
    T = (l.map (fun m => -Y m)).prod := by
  have hone : (l.map (fun m => aD m * a0 m * (-1 : R) ^ k m * aD m * ((-1 : R) ^ k m * a0 m))).prod
      = 1 := by
    apply List.prod_eq_one
    intro x hx
    obtain ⟨m, hm, rfl⟩ := List.mem_map.mp hx
    calc
      aD m * a0 m * (-1 : R) ^ k m * aD m * ((-1 : R) ^ k m * a0 m) =
          (aD m * aD m) * (a0 m * a0 m) * ((-1 : R) ^ k m * (-1) ^ k m) := by ring
      _ = 1 := by rw [hD m hm, h0 m hm, ← mul_pow]; simp
  simp only [List.prod_map_mul] at hone
  have hneg : (l.map (fun m => -Y m)).prod = (-1) ^ l.length * (l.map Y).prod := by
    rw [show (l.map (fun m => -Y m)) = l.map (fun m => (-1) * Y m) from
        List.map_congr_left fun m _ => (neg_one_mul (Y m)).symm,
      List.prod_map_mul, List.map_const', List.prod_replicate]
  rw [hneg, hT, hsign, hcard, hAD, hLc, List.map_congr_left hP, mul_one]
  simp only [List.prod_map_mul]
  linear_combination ((-1) ^ l.length * (l.map Y).prod) * hone

end Ising2DLambda.NecSuf.KacWard
