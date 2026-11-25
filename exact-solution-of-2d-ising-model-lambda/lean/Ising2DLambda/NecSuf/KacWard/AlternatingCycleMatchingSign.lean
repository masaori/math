/-
「交互閉路ごとの向き直しが二つのマッチングの符号比を与える」の端点列の符号の計算の段の必要十分版。
具体版と同じ三段（各対の向き直し、閉路ごとの一文字の巡回移動、平方が一であることによる整理）を、
次の一般の対象で行う。

* 端点列の値: 有限線型順序 J 上の列から可換環 R への任意の写像 F。仮定は
  「完全列挙の隣接二文字を交換すると値が負になる」（hswap）だけで、置換の転倒符号であることは使わない。
  マッチングの符号は F を標準の列挙の端点列で評価した値 sgn_F とする。
* 二つのマッチング: 任意の完全マッチング D と D₀。D₀ が反転対の基準マッチングであること、
  J が向き付き辺であることは使わない。
* 閉路: 各閉路の点列が空でなく偶数長であること（hev）。空の閉路を許すと巡回移動の符号が一になり、
  (-1)^{閉路の数} がずれる。奇数長を許すと二つずつ区切った対が点列に戻らず、巡回移動の符号も一になる。
* 最後の整理には sgn_F(D) の平方が一であること（hsD）だけを使う。sgn_F(D₀) の平方は使わない。
  外すと α₀ sgn(D₀) = ± α_D sgn(D) から sgn(D) sgn(D₀) の形へ移れない。
-/
import Ising2DLambda.KacWard.AlternatingCycleMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordOrientationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrientedMatchingPairValue

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {J R : Type*} [Fintype J] [LinearOrder J] [CommRing R]

/-- 隣り合う二点ずつを対にする。 -/
def pairChunks {K : Type*} : List K → List (K × K)
  | a :: b :: rest => (a, b) :: pairChunks rest
  | _ => []

/-- 対の端点列は、対の列の連結を保つ。 -/
private theorem pairWord_append {K : Type*} (l r : List (K × K)) :
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord (l ++ r) =
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord l ++
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord r := by
  simp [Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord, List.flatMap_append]

/-- 対の列を連結してから端点を読むことと、端点列を連結することは同じ。 -/
private theorem pairWord_flatten {K : Type*} :
    ∀ ls : List (List (K × K)),
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord ls.flatten =
        (ls.map Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord).flatten
  | [] => rfl
  | l :: ls => by
      rw [List.flatten_cons, pairWord_append, pairWord_flatten ls]
      rfl

/-- 閉路ごとの巡回移動は、連結した点列を並べ替える。 -/
private theorem flatten_rotate_perm {K : Type*} : ∀ cs : List (List K),
    ((cs.map (·.rotate 1)).flatten).Perm cs.flatten
  | [] => List.Perm.refl _
  | c :: cs => by
      simp only [List.map_cons, List.flatten_cons]
      exact (List.rotate_perm c 1).append (flatten_rotate_perm cs)

theorem pairChunks_map_range {K : Type*} :
    ∀ (k : ℕ) (f : ℕ → K),
      pairChunks ((List.range (2 * k)).map f) =
        (List.range k).map (fun r => (f (2 * r), f (2 * r + 1)))
  | 0, _ => rfl
  | k + 1, f => by
      have h2 : 2 * (k + 1) = 2 * k + 1 + 1 := by ring
      rw [h2, List.range_succ_eq_map, List.map_cons, List.map_map, List.range_succ_eq_map,
        List.map_cons, List.map_map]
      change (f 0, (f ∘ Nat.succ) 0) ::
          pairChunks ((List.range (2 * k)).map ((f ∘ Nat.succ) ∘ Nat.succ)) = _
      rw [pairChunks_map_range k, List.range_succ_eq_map, List.map_cons, List.map_map]
      congr 1

/-- R に値をとる η。 -/
def pairOrientationIn (R : Type*) [CommRing R] (p : J × J) : R := if p.1 < p.2 then 1 else -1

omit [Fintype J] in
/-- 共通の昇順対は向きの積に寄与せず、閉路ごとの積だけが残る。 -/
theorem pairOrientationIn_cycles (cs : List (List J)) (P : List (J × J))
    (hP : ∀ p ∈ P, p.1 < p.2) :
    (((cs.map pairChunks).flatten ++ P).map (pairOrientationIn R)).prod =
      (cs.map (fun c => ((pairChunks c).map (pairOrientationIn R)).prod)).prod := by
  have hPη : (P.map (pairOrientationIn R)).prod = 1 := by
    have h : P.map (pairOrientationIn R) = P.map (fun _ => (1 : R)) :=
      List.map_congr_left (fun p hp => by simp [pairOrientationIn, hP p hp])
    rw [h]
    simp
  simp only [List.map_append, List.prod_append, hPη, mul_one, List.map_flatten,
    List.prod_flatten, List.map_map]
  rfl

/-- F で評価したマッチングの符号。 -/
noncomputable def matchingSignOf (F : List J → R) (D : PerfectMatching J) : R :=
  F (matchingPairWord (matchingCanonicalEnumeration D))

omit [Fintype J] [LinearOrder J] in
/-- 平方が一の元の積の平方は一。 -/
lemma prod_sq_of_sq : ∀ l : List R, (∀ x ∈ l, x * x = 1) → l.prod * l.prod = 1
  | [], _ => by simp
  | x :: l, h => by
      simp only [List.prod_cons]
      calc
        x * l.prod * (x * l.prod) = (x * x) * (l.prod * l.prod) := by ring
        _ = 1 := by rw [h x (by simp), prod_sq_of_sq l (fun y hy => h y (by simp [hy])), one_mul]

section
variable (F : List J → R)
  (hswap : ∀ (u : List J) (a b : J) (v : List J),
    IsCompleteWord (u ++ a :: b :: v) → F (u ++ b :: a :: v) = -F (u ++ a :: b :: v))
include hswap

/-- 列挙の取り替え。具体版の列挙独立性と同じく、既存の前置列付きの帰納法を F へ当てる。 -/
theorem matchingSignOf_enumeration (D : PerfectMatching J) (l : List (J × J))
    (hl : IsMatchingEnumeration D l) :
    F (matchingPairWord l) = matchingSignOf F D := by
  have hp := matchingEnumerations_perm D (matchingCanonicalEnumeration_spec D) hl
  exact NecSuf.AlgebraicEigenvalue.matchingWord_value_pair_perm F Neg.neg neg_involutive
    hswap hp [] (matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D))

/-- 向き直しの等式。第一端点の集合による向きの選択を必要十分版で行う。 -/
theorem orientedPairWord_value (D : PerfectMatching J) (l : List (J × J))
    (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val) :
    F (matchingPairWord l) = (l.map (pairOrientationIn R)).prod * matchingSignOf F D := by
  let D' : Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching J := ⟨D.val, D.property⟩
  have hc' : Ising2DLambda.NecSuf.AlgebraicEigenvalue.IsCompleteWord
      (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord l) := hc
  have h := Ising2DLambda.NecSuf.AlgebraicEigenvalue.orientedMatchingPairValue
    F (fun u a b v hw => hswap u a b v hw) D' l
    {x | ∃ p ∈ l, p.1 = x}
    (Ising2DLambda.NecSuf.AlgebraicEigenvalue.orderedMatchingPairs_enumeration D' l hc' hD)
    (fun p hp => (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairOrientationSelection
      D' l hc' hD p hp).2)
  exact h

omit [Fintype J] [LinearOrder J] in
/-- 一文字を列 c の後ろへ送る |c| 回の隣接交換。 -/
theorem value_move_back (a : J) : ∀ (c u v : List J),
    IsCompleteWord (u ++ a :: (c ++ v)) →
    F (u ++ (c ++ a :: v)) = (-1) ^ c.length * F (u ++ a :: (c ++ v))
  | [], u, v, _ => by simp
  | b :: c, u, v, h => by
      have h' := completeWord_swap u a b (c ++ v) h
      have ih := value_move_back a c (u ++ [b]) v (by simpa using h')
      have hs := hswap u a b (c ++ v) h
      simp only [List.append_assoc, List.cons_append, List.nil_append] at ih
      simp only [List.cons_append, List.length_cons]
      rw [ih, hs, pow_succ]
      ring

omit [Fintype J] [LinearOrder J] in
/-- 閉路を一つずつ巡回移動し、各閉路で (-1)^{|c|-1} = -1 を掛ける。 -/
theorem value_rotate_cycles :
    ∀ (cs : List (List J)) (u v : List J),
      (∀ c ∈ cs, c ≠ [] ∧ Even c.length) →
      IsCompleteWord (u ++ (cs.flatten ++ v)) →
      F (u ++ ((cs.map (·.rotate 1)).flatten ++ v)) =
        (-1) ^ cs.length * F (u ++ (cs.flatten ++ v))
  | [], u, v, _, _ => by simp
  | c :: cs, u, v, hev, h => by
      obtain ⟨hcne, hceven⟩ := hev c (by simp)
      obtain ⟨a, c', rfl⟩ := List.exists_cons_of_ne_nil hcne
      have hodd : Odd c'.length := by
        rcases Nat.even_or_odd c'.length with he | ho
        · exact absurd hceven (by simpa [Nat.even_add_one] using he)
        · exact ho
      have hperm : (u ++ (((a :: c') ++ cs.flatten) ++ v)).Perm
          ((u ++ (a :: c').rotate 1) ++ (cs.flatten ++ v)) := by
        simpa [List.append_assoc] using
          (((List.rotate_perm (a :: c') 1).symm.append_right (cs.flatten ++ v)).append_left u)
      have ih := value_rotate_cycles cs (u ++ (a :: c').rotate 1) v
        (fun d hd => hev d (by simp [hd]))
        (h.perm (by simpa [List.append_assoc] using hperm))
      have hr : (a :: c').rotate 1 = c' ++ [a] := by simp [List.rotate_cons_succ]
      have hrot : F (u ++ ((a :: c').rotate 1 ++ (cs.flatten ++ v))) =
          (-1) ^ c'.length * F (u ++ ((a :: c') ++ (cs.flatten ++ v))) := by
        rw [hr, List.append_assoc, List.singleton_append]
        exact value_move_back F hswap a c' u (cs.flatten ++ v) (by simpa using h)
      calc
        F (u ++ ((((a :: c') :: cs).map (·.rotate 1)).flatten ++ v)) =
            F ((u ++ (a :: c').rotate 1) ++ ((cs.map (·.rotate 1)).flatten ++ v)) := by
          simp [List.append_assoc]
        _ = (-1) ^ cs.length * F ((u ++ (a :: c').rotate 1) ++ (cs.flatten ++ v)) := ih
        _ = (-1) ^ cs.length *
              ((-1) ^ c'.length * F (u ++ ((a :: c') ++ (cs.flatten ++ v)))) := by
          rw [List.append_assoc, hrot]
        _ = (-1) ^ cs.length * ((-1) * F (u ++ ((a :: c') ++ (cs.flatten ++ v)))) := by
          rw [hodd.neg_one_pow]
        _ = (-1) ^ ((a :: c') :: cs).length * F (u ++ (((a :: c') :: cs).flatten ++ v)) := by
          simp only [List.length_cons, List.flatten_cons, List.append_assoc, pow_succ]
          ring

/-- 必要十分版の主張。sgn_F(D) sgn_F(D₀) = (-1)^{閉路の数} ∏ α_D(c) α₀(c)。 -/
theorem alternating_cycle_matching_sign_necSuf
    (D D₀ : PerfectMatching J) (cs : List (List J)) (P : List (J × J))
    (hev : ∀ c ∈ cs, c ≠ [] ∧ Even c.length)
    (hc : IsCompleteWord (cs.flatten ++ matchingPairWord P))
    (hD : ∀ c ∈ cs, ∀ p ∈ pairChunks c, ({p.1, p.2} : Set J) ∈ D.val)
    (h₀ : ∀ c ∈ cs, ∀ p ∈ pairChunks (c.rotate 1), ({p.1, p.2} : Set J) ∈ D₀.val)
    (hP : ∀ p ∈ P, p.1 < p.2 ∧ ({p.1, p.2} : Set J) ∈ D.val ∧ ({p.1, p.2} : Set J) ∈ D₀.val)
    (hsD : matchingSignOf F D * matchingSignOf F D = 1) :
    matchingSignOf F D * matchingSignOf F D₀ =
      (-1) ^ cs.length * (cs.map (fun c =>
        ((pairChunks c).map (pairOrientationIn R)).prod *
          ((pairChunks (c.rotate 1)).map (pairOrientationIn R)).prod)).prod := by
  let lD := (cs.map pairChunks).flatten ++ P
  let l₀ := (cs.map (fun c => pairChunks (c.rotate 1))).flatten ++ P
  let αD := (cs.map (fun c => ((pairChunks c).map (pairOrientationIn R)).prod)).prod
  let α₀ := (cs.map (fun c =>
    ((pairChunks (c.rotate 1)).map (pairOrientationIn R)).prod)).prod
  have pairWord_pairChunks :
      ∀ c : List J, Even c.length → matchingPairWord (pairChunks c) = c := by
    intro c
    induction c using List.twoStepInduction with
    | nil => intro _; rfl
    | singleton a => intro h; exact absurd h (by simp)
    | cons_cons a b rest ih =>
        intro h
        have hr : Even rest.length := by
          simpa [Nat.even_add_one] using h
        change [a, b] ++ matchingPairWord (pairChunks rest) = a :: b :: rest
        rw [ih hr]
        rfl
  have hwD : matchingPairWord lD = cs.flatten ++ matchingPairWord P := by
    change Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord lD =
      cs.flatten ++ Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord P
    simp only [lD, pairWord_append, pairWord_flatten, List.map_map]
    congr 1
    have h' : ∀ c ∈ cs,
        (Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord ∘ pairChunks) c = c :=
      fun c hcs => pairWord_pairChunks c (hev c hcs).2
    rw [List.map_congr_left h', List.map_id']
  have hw₀ : matchingPairWord l₀ = (cs.map (·.rotate 1)).flatten ++ matchingPairWord P := by
    change Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord l₀ =
      (cs.map (·.rotate 1)).flatten ++
        Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord P
    simp only [l₀, pairWord_append, pairWord_flatten, List.map_map]
    congr 2
    apply List.map_congr_left
    intro c hcs
    exact pairWord_pairChunks _ (by simpa using (hev c hcs).2)
  have hc₀ : IsCompleteWord (matchingPairWord l₀) := by
    rw [hw₀]
    exact hc.perm ((flatten_rotate_perm cs).symm.append_right _)
  have hcD : IsCompleteWord (matchingPairWord lD) := by rw [hwD]; exact hc
  have hlD : ∀ p ∈ lD, ({p.1, p.2} : Set J) ∈ D.val := by
    intro p hp
    rcases List.mem_append.mp hp with h | h
    · obtain ⟨ps, hps, hpc⟩ := List.mem_flatten.mp h
      obtain ⟨c, hcs, rfl⟩ := List.mem_map.mp hps
      exact hD c hcs p hpc
    · exact (hP p h).2.1
  have hl₀ : ∀ p ∈ l₀, ({p.1, p.2} : Set J) ∈ D₀.val := by
    intro p hp
    rcases List.mem_append.mp hp with h | h
    · obtain ⟨ps, hps, hpc⟩ := List.mem_flatten.mp h
      obtain ⟨c, hcs, rfl⟩ := List.mem_map.mp hps
      exact h₀ c hcs p hpc
    · exact (hP p h).2.2
  have hαD : (lD.map (pairOrientationIn R)).prod = αD := by
    exact pairOrientationIn_cycles (R := R) cs P (fun p hp => (hP p hp).1)
  have hα₀' : (l₀.map (pairOrientationIn R)).prod = α₀ := by
    simpa only [l₀, α₀, List.map_map, Function.comp_def] using
      (pairOrientationIn_cycles (R := R) (cs.map (·.rotate 1)) P
        (fun p hp => (hP p hp).1))
  have hrot := value_rotate_cycles F hswap cs [] (matchingPairWord P) hev (by simpa using hc)
  simp only [List.nil_append] at hrot
  have hrel : α₀ * matchingSignOf F D₀ = (-1) ^ cs.length * (αD * matchingSignOf F D) := by
    calc
      α₀ * matchingSignOf F D₀ = F (matchingPairWord l₀) := by
        rw [orientedPairWord_value F hswap D₀ l₀ hc₀ hl₀, hα₀']
      _ = F ((cs.map (·.rotate 1)).flatten ++ matchingPairWord P) := by rw [hw₀]
      _ = (-1) ^ cs.length * F (cs.flatten ++ matchingPairWord P) := hrot
      _ = (-1) ^ cs.length * F (matchingPairWord lD) := by rw [hwD]
      _ = (-1) ^ cs.length * (αD * matchingSignOf F D) := by
        rw [orientedPairWord_value F hswap D lD hcD hlD, hαD]
  have hα₀ : α₀ * α₀ = 1 := prod_sq_of_sq _ (fun x hx => by
    obtain ⟨c, _, rfl⟩ := List.mem_map.mp hx
    refine prod_sq_of_sq _ (fun y hy => ?_)
    obtain ⟨p, _, rfl⟩ := List.mem_map.mp hy
    unfold pairOrientationIn
    split_ifs <;> ring)
  calc
    matchingSignOf F D * matchingSignOf F D₀ =
        (α₀ * α₀) * (matchingSignOf F D * matchingSignOf F D₀) := by rw [hα₀, one_mul]
    _ = (α₀ * matchingSignOf F D₀) * α₀ * matchingSignOf F D := by ring
    _ = (-1) ^ cs.length * (αD * matchingSignOf F D) * α₀ * matchingSignOf F D := by rw [hrel]
    _ = (-1) ^ cs.length * (α₀ * αD) * (matchingSignOf F D * matchingSignOf F D) := by ring
    _ = (-1) ^ cs.length * (α₀ * αD) := by rw [hsD, mul_one]
    _ = _ := by rw [List.prod_map_mul, mul_comm α₀]

end

end Ising2DLambda.NecSuf.KacWard
