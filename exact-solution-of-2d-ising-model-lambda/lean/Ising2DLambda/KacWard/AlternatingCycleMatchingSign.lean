/-
「交互閉路ごとの向き直しが二つのマッチングの符号比を与える」（claim_alternating_cycle_matching_sign）の
具体版のうち、端点列の符号の計算の段。実際の完全マッチング D と基準完全マッチング 𝒟₀
（referenceLongMatching）、辞書式順序について、閉路の点列と共通対の列を受け取り、本文の三つの式鎖を示す。

  人手証明                                              このファイル
  対の第一端点を選んだ向き直しの等式                      `orientedPairWord_sign`
  （claim_matching_pair_word_orientation_sign と列挙独立性）
  閉路ごとの一文字の巡回移動の符号 (-1)^{2k_C-1}          `matchingWordSign_rotate_one`
  ε(W₀) = (-1)^{|𝒞|} ε(W_D) の二等号                     `matchingWordSign_rotate_cycles`
  α₀ sgn(𝒟₀) = ε(W₀) = (-1)^{|𝒞|} ε(W_D) = (-1)^{|𝒞|} α_D sgn(D)
                                                        `alternatingCycleWords_sign_relation`
  sgn(D) sgn(𝒟₀) の三等号                                `alternatingCycleWords_matching_sign`

閉路の点列は仮定で受ける。実際の交互閉路（claim_tagged_difference_cycle_cover）がこの仮定を満たすことは
台帳の次の行で示し、両者を組にして本文ブロックの `lean:` に登録する。
必要十分版は呼ばない。住処は有限集合と ℤ で、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.ReferenceMatchingConstantTerm
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordOrientationSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

section Word

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 点列を先頭から二つずつ区切った対の列。閉路 c の D の対は `consecutivePairs c`、
    𝒟₀ の対は一つ左へ巡回移動した `consecutivePairs (c.rotate 1)` である。 -/
def consecutivePairs {K : Type*} : List K → List (K × K)
  | a :: b :: rest => (a, b) :: consecutivePairs rest
  | _ => []

/-- 本文の η。相異なる二点が昇順なら一、降順なら負の一。 -/
def pairOrientation (p : J × J) : ℤ := if p.1 < p.2 then 1 else -1

/-- 偶数長の点列は、二つずつ区切った対の端点列に戻る。 -/
theorem pairWord_consecutivePairs {K : Type*} :
    ∀ c : List K, Even c.length → matchingPairWord (consecutivePairs c) = c
  | [], _ => rfl
  | [_], h => absurd h (by simp)
  | a :: b :: rest, h => by
      have hr : Even rest.length := by
        simpa [Nat.even_add_one] using h
      change [a, b] ++ matchingPairWord (consecutivePairs rest) = a :: b :: rest
      rw [pairWord_consecutivePairs rest hr]
      rfl

/-- 端点列の連結は、各列の端点列の連結である。 -/
theorem matchingPairWord_append {K : Type*} (l r : List (K × K)) :
    matchingPairWord (l ++ r) = matchingPairWord l ++ matchingPairWord r := by
  simp [matchingPairWord, List.flatMap_append]

theorem matchingPairWord_flatten {K : Type*} :
    ∀ ls : List (List (K × K)),
      matchingPairWord ls.flatten = (ls.map matchingPairWord).flatten
  | [] => rfl
  | l :: ls => by
      rw [List.flatten_cons, matchingPairWord_append, matchingPairWord_flatten ls]
      rfl

omit [Fintype J] in
/-- 本文の η の値は ±1 なので平方は一。 -/
lemma pairOrientation_sq (p : J × J) : pairOrientation p * pairOrientation p = 1 := by
  unfold pairOrientation
  split_ifs <;> norm_num

omit [Fintype J] in
/-- ±1 の積の平方は一。 -/
lemma prod_pairOrientation_sq (l : List (J × J)) :
    (l.map pairOrientation).prod * (l.map pairOrientation).prod = 1 := by
  induction l with
  | nil => simp
  | cons p l ih =>
      simp only [List.map_cons, List.prod_cons]
      calc
        pairOrientation p * (l.map pairOrientation).prod *
            (pairOrientation p * (l.map pairOrientation).prod) =
            (pairOrientation p * pairOrientation p) *
              ((l.map pairOrientation).prod * (l.map pairOrientation).prod) := by ring
        _ = 1 := by rw [pairOrientation_sq, ih, one_mul]

omit [Fintype J] [LinearOrder J] in
/-- 端点列の中で、二つの対が一点を共有するなら同じ位置の対である。 -/
lemma pair_eq_of_shared_point {l : List (J × J)} (hn : (matchingPairWord l).Nodup)
    {p q : J × J} (hp : p ∈ l) (hq : q ∈ l) {x : J}
    (hxp : x ∈ [p.1, p.2]) (hxq : x ∈ [q.1, q.2]) : p = q := by
  have hpw : l.Pairwise (fun a b : J × J => List.Disjoint [a.1, a.2] [b.1, b.2]) :=
    (List.nodup_flatMap.mp hn).2
  haveI : Std.Symm (fun a b : J × J => List.Disjoint [a.1, a.2] [b.1, b.2]) :=
    ⟨fun _ _ h => List.disjoint_comm.mp h⟩
  by_contra hne
  exact hpw.forall hp hq hne hxp hxq

/-- 対を昇順へ向け直す写像。 -/
def ascendingPair (p : J × J) : J × J := if p.1 < p.2 then p else (p.2, p.1)

/-- 向き付き対の列の各対が D の対で、端点列が完全列挙なら、昇順へ向け直した列は D の列挙である。 -/
theorem ascendingPairs_enumeration (D : PerfectMatching J) (l : List (J × J))
    (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val) :
    IsMatchingEnumeration D (l.map ascendingPair) := by
  have hne : ∀ p ∈ l, p.1 ≠ p.2 := by
    intro p hp
    have := (List.nodup_flatMap.mp hc.1).1 p hp
    simpa using this
  have hset : ∀ p : J × J, ({(ascendingPair p).1, (ascendingPair p).2} : Set J) = {p.1, p.2} := by
    intro p
    unfold ascendingPair
    split_ifs
    · rfl
    · exact Set.pair_comm _ _
  have hasc : ∀ p ∈ l, (ascendingPair p).1 < (ascendingPair p).2 := by
    intro p hp
    unfold ascendingPair
    split_ifs with h
    · exact h
    · exact lt_of_le_of_ne (not_lt.mp h) (hne p hp).symm
  have heq : ∀ p q : J × J, p.1 < p.2 → q.1 < q.2 →
      ({p.1, p.2} : Set J) = {q.1, q.2} → p = q := by
    intro p q hp hq he
    rcases Set.pair_eq_pair_iff.mp he with h | h
    · exact Prod.ext h.1 h.2
    · have : p.2 < p.1 := by simpa [h.1, h.2] using hq
      exact (hp.asymm this).elim
  have hlnd : l.Nodup := by
    apply (List.nodup_flatMap.mp hc.1).2.imp
    intro p q hd hpq
    subst hpq
    exact hd (by simp : p.1 ∈ [p.1, p.2]) (by simp)
  refine ⟨hlnd.map_on ?_, fun q => ?_⟩
  · intro p hp q hq hpq
    have hs : ({p.1, p.2} : Set J) = {q.1, q.2} := by rw [← hset p, ← hset q, hpq]
    have hx : p.1 ∈ ({q.1, q.2} : Set J) := by rw [← hs]; simp
    exact pair_eq_of_shared_point hc.1 hp hq (x := p.1) (by simp)
      (by simpa only [Set.mem_insert_iff, Set.mem_singleton_iff, List.mem_cons,
        List.not_mem_nil, or_false] using hx)
  · constructor
    · intro hq
      obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hq
      exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hasc p hp, by rw [hset]; exact hD p hp⟩
    · intro hq
      have hq' := (Finset.mem_filter.mp hq).2
      obtain ⟨p, hp, hxp⟩ := List.mem_flatMap.mp (hc.2 q.1)
      refine List.mem_map.mpr ⟨p, hp, heq _ _ (hasc p hp) hq'.1 ?_⟩
      obtain ⟨s, _, hu⟩ := D.property.2 q.1
      rw [hset]
      exact (hu _ ⟨hD p hp, by simpa using hxp⟩).trans
        (hu _ ⟨hq'.2, by simp⟩).symm

/-- 本文の向き直しの等式を任意の向き付き対の列へ当てる。
    ε(端点列) = (∏ η) sgn(D)。claim_matching_pair_word_orientation_sign の具体版
    `matchingOrientationSignAux` を、各対の第一端点を選んだ集合 S で使い、
    列挙独立性 `perfectMatchingSign_enumeration_independent` で sgn(D) へ移す。 -/
theorem orientedPairWord_sign (D : PerfectMatching J) (l : List (J × J))
    (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val) :
    matchingWordSign (matchingPairWord l) =
      (l.map pairOrientation).prod * perfectMatchingSign D := by
  let S : Set J := {x | ∃ p ∈ l, p.1 = x}
  have hen := ascendingPairs_enumeration D l hc hD
  have hne : ∀ p ∈ l, p.1 ≠ p.2 := by
    intro p hp
    have := (List.nodup_flatMap.mp hc.1).1 p hp
    simpa using this
  -- 昇順へ直した対の第一端点が S に入るのは、元の対が昇順のときに限る。
  have hS : ∀ p ∈ l, ((ascendingPair p).1 ∈ S ↔ p.1 < p.2) := by
    intro p hp
    unfold ascendingPair
    split_ifs with h
    · exact iff_of_true ⟨p, hp, rfl⟩ h
    · refine iff_of_false ?_ h
      rintro ⟨q, hq, hqe⟩
      have hpq := pair_eq_of_shared_point hc.1 hp hq (x := p.2) (by simp) (by simp [hqe])
      subst hpq
      exact hne p hp hqe
  have haux := matchingOrientationSignAux S (l.map ascendingPair) []
    (by simpa using matchingEnumeration_complete D _ hen)
  simp only [List.nil_append] at haux
  rw [perfectMatchingSign_enumeration_independent D _ hen] at haux
  convert haux using 2
  · rw [List.flatMap_map, matchingPairWord]
    apply List.flatMap_congr
    intro p hp
    by_cases h : p.1 < p.2
    · rw [if_pos ((hS p hp).mpr h)]
      simp [ascendingPair, h]
    · rw [if_neg (fun hm => h ((hS p hp).mp hm))]
      simp [ascendingPair, h]
  · rw [List.map_map]
    congr 1
    apply List.map_congr_left
    intro p hp
    by_cases h : p.1 < p.2
    · simp only [Function.comp, if_pos ((hS p hp).mpr h), pairOrientation, if_pos h]
    · simp only [Function.comp, if_neg (fun hm => h ((hS p hp).mp hm)), pairOrientation, if_neg h]

/-- 一文字を列 c の後ろへ送る |c| 回の隣接交換。符号は (-1)^{|c|} 倍になる。 -/
theorem matchingWordSign_move_back (a : J) : ∀ (c u v : List J),
    IsCompleteWord (u ++ a :: (c ++ v)) →
    matchingWordSign (u ++ (c ++ a :: v)) =
      (-1) ^ c.length * matchingWordSign (u ++ a :: (c ++ v))
  | [], u, v, _ => by simp
  | b :: c, u, v, h => by
      have h' := completeWord_swap u a b (c ++ v) h
      have ih := matchingWordSign_move_back a c (u ++ [b]) v (by simpa using h')
      have hs := matchingWordSign_swap u a b (c ++ v) h
      simp only [List.append_assoc, List.cons_append, List.nil_append] at ih
      simp only [List.cons_append, List.length_cons]
      rw [ih, hs, pow_succ]
      ring

/-- 本文の巡回移動の符号。一つ左へ巡回移動した点列は、置換の符号 (-1)^{|c|-1} を掛ける。 -/
theorem matchingWordSign_rotate_one (u v : List J) (a : J) (c : List J)
    (h : IsCompleteWord (u ++ ((a :: c) ++ v))) :
    matchingWordSign (u ++ ((a :: c).rotate 1 ++ v)) =
      (-1) ^ c.length * matchingWordSign (u ++ ((a :: c) ++ v)) := by
  have hr : (a :: c).rotate 1 = c ++ [a] := by simp [List.rotate_cons_succ]
  rw [hr, List.append_assoc, List.singleton_append]
  exact matchingWordSign_move_back a c u v (by simpa using h)

/-- 本文の一つ目の式鎖。閉路を一つずつ巡回移動し、各閉路で (-1)^{2k_C-1} = -1 を掛ける。
    ε(W₀) = ∏_C (-1)^{2k_C-1} ε(W_D) = (-1)^{|𝒞|} ε(W_D)。 -/
theorem matchingWordSign_rotate_cycles :
    ∀ (cs : List (List J)) (u v : List J),
      (∀ c ∈ cs, c ≠ [] ∧ Even c.length) →
      IsCompleteWord (u ++ (cs.flatten ++ v)) →
      matchingWordSign (u ++ ((cs.map (·.rotate 1)).flatten ++ v)) =
        (-1) ^ cs.length * matchingWordSign (u ++ (cs.flatten ++ v))
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
      have ih := matchingWordSign_rotate_cycles cs (u ++ (a :: c').rotate 1) v
        (fun d hd => hev d (by simp [hd]))
        (h.perm (by simpa [List.append_assoc] using hperm))
      have hrot := matchingWordSign_rotate_one u (cs.flatten ++ v) a c'
        (by simpa [List.append_assoc] using h)
      calc
        matchingWordSign (u ++ ((((a :: c') :: cs).map (·.rotate 1)).flatten ++ v)) =
            matchingWordSign ((u ++ (a :: c').rotate 1) ++
              ((cs.map (·.rotate 1)).flatten ++ v)) := by
          simp [List.append_assoc]
        _ = (-1) ^ cs.length *
              matchingWordSign ((u ++ (a :: c').rotate 1) ++ (cs.flatten ++ v)) := ih
        _ = (-1) ^ cs.length *
              ((-1) ^ c'.length * matchingWordSign (u ++ ((a :: c') ++ (cs.flatten ++ v)))) := by
          rw [List.append_assoc, hrot]
        _ = (-1) ^ cs.length * ((-1) * matchingWordSign (u ++ ((a :: c') ++ (cs.flatten ++ v)))) := by
          rw [hodd.neg_one_pow]
        _ = (-1) ^ ((a :: c') :: cs).length *
              matchingWordSign (u ++ (((a :: c') :: cs).flatten ++ v)) := by
          simp only [List.length_cons, List.flatten_cons, List.append_assoc, pow_succ]
          ring

omit [Fintype J] [LinearOrder J] in
/-- 閉路の巡回移動は対の列の長さを変えない。 -/
lemma even_length_rotate (c : List J) (h : Even c.length) : Even (c.rotate 1).length := by
  simpa using h

omit [Fintype J] [LinearOrder J] in
/-- 各閉路を巡回移動して連結した列は、元の連結の並べ替えである。 -/
lemma flatten_rotate_perm : ∀ cs : List (List J),
    ((cs.map (·.rotate 1)).flatten).Perm cs.flatten
  | [] => List.Perm.refl _
  | c :: cs => by
      simp only [List.map_cons, List.flatten_cons]
      exact (List.rotate_perm c 1).append (flatten_rotate_perm cs)

end Word

/-- 閉路 c の D の向き付き対の η の積 α_D(C)。 -/
def cycleShortOrientation {J : Type*} [LinearOrder J] (c : List J) : ℤ :=
  ((consecutivePairs c).map pairOrientation).prod

/-- 閉路 c の 𝒟₀ の向き付き対 (c(2r+1), c(2r+2)) の η の積 α₀(C)。c(2k) = c(0)。 -/
def cycleReferenceOrientation {J : Type*} [LinearOrder J] (c : List J) : ℤ :=
  ((consecutivePairs (c.rotate 1)).map pairOrientation).prod

section Main

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 本文の二つ目の式鎖。α₀ sgn(𝒟₀) = ε(W₀) = (-1)^{|𝒞|} ε(W_D) = (-1)^{|𝒞|} α_D sgn(D)。
    閉路の後ろに共通対を昇順で付けた端点列を W_D、各閉路を一つ左へ巡回移動したものを W₀ とする。 -/
theorem alternatingCycleWords_sign_relation (D D₀ : PerfectMatching J)
    (cs : List (List J)) (P : List (J × J))
    (hev : ∀ c ∈ cs, c ≠ [] ∧ Even c.length)
    (hc : IsCompleteWord (cs.flatten ++ matchingPairWord P))
    (hD : ∀ c ∈ cs, ∀ p ∈ consecutivePairs c, ({p.1, p.2} : Set J) ∈ D.val)
    (h₀ : ∀ c ∈ cs, ∀ p ∈ consecutivePairs (c.rotate 1), ({p.1, p.2} : Set J) ∈ D₀.val)
    (hP : ∀ p ∈ P, p.1 < p.2 ∧ ({p.1, p.2} : Set J) ∈ D.val ∧ ({p.1, p.2} : Set J) ∈ D₀.val) :
    (cs.map cycleReferenceOrientation).prod * perfectMatchingSign D₀ =
      (-1) ^ cs.length * ((cs.map cycleShortOrientation).prod * perfectMatchingSign D) := by
  let lD := (cs.map consecutivePairs).flatten ++ P
  let l₀ := (cs.map (fun c => consecutivePairs (c.rotate 1))).flatten ++ P
  have hwD : matchingPairWord lD = cs.flatten ++ matchingPairWord P := by
    simp only [lD, matchingPairWord_append, matchingPairWord_flatten, List.map_map]
    congr 1
    have h' : ∀ c ∈ cs, (matchingPairWord ∘ consecutivePairs) c = c :=
      fun c hcs => pairWord_consecutivePairs c (hev c hcs).2
    rw [List.map_congr_left h', List.map_id']
  have hw₀ : matchingPairWord l₀ = (cs.map (·.rotate 1)).flatten ++ matchingPairWord P := by
    simp only [l₀, matchingPairWord_append, matchingPairWord_flatten, List.map_map]
    congr 2
    apply List.map_congr_left
    intro c hcs
    exact pairWord_consecutivePairs _ (even_length_rotate c (hev c hcs).2)
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
  -- 共通対は昇順なので η は一。
  have hPη : (P.map pairOrientation).prod = 1 := by
    have h' : P.map pairOrientation = P.map (fun _ => (1 : ℤ)) :=
      List.map_congr_left (fun p hp => by simp [pairOrientation, (hP p hp).1])
    rw [h']
    simp
  have hαD : (lD.map pairOrientation).prod = (cs.map cycleShortOrientation).prod := by
    simp only [lD, List.map_append, List.prod_append, hPη, mul_one, List.map_flatten,
      List.prod_flatten, List.map_map]
    rfl
  have hα₀ : (l₀.map pairOrientation).prod = (cs.map cycleReferenceOrientation).prod := by
    simp only [l₀, List.map_append, List.prod_append, hPη, mul_one, List.map_flatten,
      List.prod_flatten, List.map_map]
    rfl
  have hrot := matchingWordSign_rotate_cycles cs [] (matchingPairWord P) hev (by simpa using hc)
  simp only [List.nil_append] at hrot
  calc
    (cs.map cycleReferenceOrientation).prod * perfectMatchingSign D₀ =
        matchingWordSign (matchingPairWord l₀) := by
      rw [orientedPairWord_sign D₀ l₀ hc₀ hl₀, hα₀]
    _ = matchingWordSign ((cs.map (·.rotate 1)).flatten ++ matchingPairWord P) := by rw [hw₀]
    _ = (-1) ^ cs.length * matchingWordSign (cs.flatten ++ matchingPairWord P) := hrot
    _ = (-1) ^ cs.length * matchingWordSign (matchingPairWord lD) := by rw [hwD]
    _ = (-1) ^ cs.length * ((cs.map cycleShortOrientation).prod * perfectMatchingSign D) := by
      rw [orientedPairWord_sign D lD hcD hlD, hαD]

/-- 平方が一の整数の積の平方は一。 -/
lemma int_prod_sq_of_sq : ∀ l : List ℤ, (∀ x ∈ l, x * x = 1) → l.prod * l.prod = 1
  | [], _ => by simp
  | x :: l, h => by
      simp only [List.prod_cons]
      calc
        x * l.prod * (x * l.prod) = (x * x) * (l.prod * l.prod) := by ring
        _ = 1 := by
          rw [h x (by simp), int_prod_sq_of_sq l (fun y hy => h y (by simp [hy])), one_mul]

/-- 本文の主張。sgn(D) sgn(𝒟₀) = (-1)^{|𝒞|} ∏_C α_D(C) α₀(C)。本文の三つ目の式鎖を同順に記す。
    𝒟₀ は実際の基準完全マッチング、順序は向き付き辺の辞書式順序である。 -/
theorem alternatingCycleWords_matching_sign {L : ℕ} (D : PerfectMatching (OrientedEdge L))
    (cs : List (List (OrientedEdge L))) (P : List (OrientedEdge L × OrientedEdge L))
    (hev : ∀ c ∈ cs, c ≠ [] ∧ Even c.length)
    (hc : IsCompleteWord (cs.flatten ++ matchingPairWord P))
    (hD : ∀ c ∈ cs, ∀ p ∈ consecutivePairs c,
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val)
    (h₀ : ∀ c ∈ cs, ∀ p ∈ consecutivePairs (c.rotate 1),
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ (referenceLongMatching L).val)
    (hP : ∀ p ∈ P, p.1 < p.2 ∧ ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val ∧
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ (referenceLongMatching L).val) :
    perfectMatchingSign D * perfectMatchingSign (referenceLongMatching L) =
      (-1) ^ cs.length *
        (cs.map (fun c => cycleShortOrientation c * cycleReferenceOrientation c)).prod := by
  let αD := (cs.map cycleShortOrientation).prod
  let α₀ := (cs.map cycleReferenceOrientation).prod
  let sD := perfectMatchingSign D
  let s₀ := perfectMatchingSign (referenceLongMatching L)
  have hα₀ : α₀ * α₀ = 1 := int_prod_sq_of_sq _ (fun x hx => by
    obtain ⟨c, _, rfl⟩ := List.mem_map.mp hx
    exact prod_pairOrientation_sq _)
  have hsD : sD * sD = 1 := by
    rcases perfectMatchingSign_eq_one_or_neg_one D with h | h <;> simp [sD, h]
  have hrel : α₀ * s₀ = (-1) ^ cs.length * (αD * sD) :=
    alternatingCycleWords_sign_relation D (referenceLongMatching L) cs P hev hc hD h₀ hP
  calc
    sD * s₀ = (α₀ * α₀) * (sD * s₀) := by rw [hα₀, one_mul]
    _ = (α₀ * s₀) * α₀ * sD := by ring
    _ = (-1) ^ cs.length * (αD * sD) * α₀ * sD := by rw [hrel]
    _ = (-1) ^ cs.length * (α₀ * αD) * (sD * sD) := by ring
    _ = (-1) ^ cs.length * (α₀ * αD) := by rw [hsD, mul_one]
    _ = (-1) ^ cs.length *
          (cs.map (fun c => cycleShortOrientation c * cycleReferenceOrientation c)).prod := by
      rw [List.prod_map_mul, mul_comm α₀]

end Main

end Ising2DLambda.KacWard
