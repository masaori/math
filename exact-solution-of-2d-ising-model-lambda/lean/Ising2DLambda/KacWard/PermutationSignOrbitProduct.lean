/-
章「Kac--Ward 行列式の置換展開」の
参照用ノート「不採用経路: 置換符号の動く軌道ごとの分解」に退避した
「置換符号は動く軌道の符号因子の積である」の具体版。

人手証明と同じ順で進む。
1. 各軌道の基点 `e` からの反復列（基点を除く）`φ(e), …, φ^{∘(m-1)}(e)` を作り、
   互換の鎖 `finiteTranspositionChain` がその軌道上で `σ` と一致し、軌道外を動かさないことを示す。
2. 互換の鎖の符号 `(-1)^{m-1}` と軌道の元の個数 `m`（`card_orbit`）を結ぶ。
3. 互いに素な台・軌道上の一致・軌道外の恒等・被覆から合成を元の置換へ戻し、
   具体版の符号の有限積則を適用して積表示を得る。
-/
import Ising2DLambda.KacWard.MovedOrbitPartition
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignFiniteOrderedSetIndependent
import Ising2DLambda.KacWard.TranspositionSignFiniteOrderedSet

namespace Ising2DLambda.KacWard

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign
  (finiteOrderedPairs finiteOrderedInversionCount finiteOrderedSign
    finiteOrderedSign_comp finiteOrderedSign_noncommProd)

variable {ι : Type} [Fintype ι] [LinearOrder ι]

set_option linter.unusedSectionVars false

private lemma iterLeft_eq_iterate' (σ : Equiv.Perm ι) (n : ℕ) (e : ι) :
    iterLeft (⇑σ) n e = (⇑σ)^[n] e := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [iterLeft, Function.iterate_succ_apply']
    rw [ih]

private lemma perm_return (σ : Equiv.Perm ι) (e : ι) :
    ∃ k, 1 ≤ k ∧ iterLeft (⇑σ) k e = e := by
  obtain ⟨k, hk, hreturn⟩ := permutation_power_return σ e
  exact ⟨k, hk, (iterLeft_eq_iterate' σ k e).trans hreturn⟩

/-- 人手証明の最小周期 `m_C`。 -/
private noncomputable def orbitPeriod (σ : Equiv.Perm ι) (e : ι) : ℕ :=
  minimalPeriod (⇑σ) e (perm_return σ e)

private lemma iterate_orbitPeriod (σ : Equiv.Perm ι) (e : ι) :
    (⇑σ)^[orbitPeriod σ e] e = e :=
  (iterLeft_eq_iterate' σ (orbitPeriod σ e) e).symm.trans
    (iterLeft_minimalPeriod (⇑σ) e (perm_return σ e))

/-- 動く基点の最小周期は 2 以上である（1 なら `σ e = e` となり矛盾）。 -/
private lemma two_le_orbitPeriod (σ : Equiv.Perm ι) {e : ι} (he : σ e ≠ e) :
    2 ≤ orbitPeriod σ e := by
  have h1 : 1 ≤ orbitPeriod σ e := minimalPeriod_pos (⇑σ) e (perm_return σ e)
  rcases Nat.lt_or_ge (orbitPeriod σ e) 2 with h2 | h2
  · have hm1 : orbitPeriod σ e = 1 := by omega
    have hret := iterate_orbitPeriod σ e
    rw [hm1, Function.iterate_one] at hret
    exact absurd hret he
  · exact h2

/-- 最小周期より小さい 1 以上の回数では戻らない（反復記法へ移送）。 -/
private lemma iterate_ne_of_lt_orbitPeriod (σ : Equiv.Perm ι) (e : ι) {k : ℕ}
    (hk1 : 1 ≤ k) (hk : k < orbitPeriod σ e) : (⇑σ)^[k] e ≠ e := by
  rw [← iterLeft_eq_iterate' σ k e]
  exact not_iterLeft_of_lt_minimalPeriod (⇑σ) e (perm_return σ e) hk1 hk

/-- 軌道の元は基点の `orbitPeriod σ e` 未満の反復で尽くされる。 -/
private lemma mem_movedOrbit_iff_iterate (σ : Equiv.Perm ι) (e : ι) {x : ι} :
    x ∈ movedOrbit σ e ↔ ∃ j, j < orbitPeriod σ e ∧ x = (⇑σ)^[j] e := by
  constructor
  · intro hx
    obtain ⟨k, hk⟩ := mem_orbit.mp hx
    rw [iterLeft_eq_iterate' σ k e] at hk
    have hmpos : 0 < orbitPeriod σ e := minimalPeriod_pos (⇑σ) e (perm_return σ e)
    refine ⟨k % orbitPeriod σ e, Nat.mod_lt k hmpos, ?_⟩
    have hmul : (⇑σ)^[orbitPeriod σ e * (k / orbitPeriod σ e)] e = e := by
      rw [← iterLeft_eq_iterate' σ _ e]
      exact iterLeft_mul (⇑σ) e (orbitPeriod σ e)
        (iterLeft_minimalPeriod (⇑σ) e (perm_return σ e)) (k / orbitPeriod σ e)
    calc x = (⇑σ)^[k] e := hk
      _ = (⇑σ)^[k % orbitPeriod σ e + orbitPeriod σ e * (k / orbitPeriod σ e)] e := by
          rw [Nat.mod_add_div]
      _ = (⇑σ)^[k % orbitPeriod σ e] ((⇑σ)^[orbitPeriod σ e * (k / orbitPeriod σ e)] e) :=
          Function.iterate_add_apply (⇑σ) _ _ e
      _ = (⇑σ)^[k % orbitPeriod σ e] e := by rw [hmul]
  · rintro ⟨j, -, rfl⟩
    exact mem_orbit.mpr ⟨j, (iterLeft_eq_iterate' σ j e).symm⟩

/-- 軌道は `σ` で閉じている。 -/
private lemma movedOrbit_mapsTo (σ : Equiv.Perm ι) (e : ι) {x : ι}
    (hx : x ∈ movedOrbit σ e) : σ x ∈ movedOrbit σ e := by
  obtain ⟨k, hk⟩ := mem_orbit.mp hx
  refine mem_orbit.mpr ⟨k + 1, ?_⟩
  show σ x = iterLeft (⇑σ) (k + 1) e
  rw [show iterLeft (⇑σ) (k + 1) e = σ (iterLeft (⇑σ) k e) from rfl, ← hk]

/-- 人手証明の反復列 `φ(e_C), φ^{∘2}(e_C), …, φ^{∘(m_C-1)}(e_C)`（基点を除く）。 -/
private noncomputable def orbitTail (σ : Equiv.Perm ι) (e : ι) : List ι :=
  (List.range (orbitPeriod σ e - 1)).map fun i => (⇑σ)^[i + 1] e

private lemma orbitTail_length (σ : Equiv.Perm ι) (e : ι) :
    (orbitTail σ e).length = orbitPeriod σ e - 1 := by
  simp [orbitTail]

private lemma orbitTail_getElem (σ : Equiv.Perm ι) (e : ι) {i : ℕ}
    (hi : i < (orbitTail σ e).length) :
    (orbitTail σ e)[i] = (⇑σ)^[i + 1] e := by
  simp [orbitTail]

private lemma mem_orbitTail_iff (σ : Equiv.Perm ι) (e : ι) {x : ι} :
    x ∈ orbitTail σ e ↔ ∃ i, i < orbitPeriod σ e - 1 ∧ x = (⇑σ)^[i + 1] e := by
  constructor
  · intro hx
    obtain ⟨i, hi, hxi⟩ := List.mem_iff_getElem.mp hx
    rw [orbitTail_getElem σ e hi] at hxi
    exact ⟨i, by simpa [orbitTail_length] using hi, hxi.symm⟩
  · rintro ⟨i, hi, rfl⟩
    have hi' : i < (orbitTail σ e).length := by rwa [orbitTail_length]
    exact List.mem_iff_getElem.mpr ⟨i, hi', orbitTail_getElem σ e hi'⟩

/-- 人手証明の「右辺の向き付き辺は相異なり」。基点と反復列を合わせた列は重複しない。 -/
private lemma nodup_cons_orbitTail (σ : Equiv.Perm ι) (e : ι) :
    (e :: orbitTail σ e).Nodup := by
  have hdistinct : ∀ j l, j < l → l < orbitPeriod σ e → (⇑σ)^[j] e ≠ (⇑σ)^[l] e :=
    orbit_iterates_distinct σ.injective
      (fun k hk1 hk => iterate_ne_of_lt_orbitPeriod σ e hk1 hk)
  rw [List.nodup_cons]
  constructor
  · intro hmem
    obtain ⟨i, hi, hxi⟩ := (mem_orbitTail_iff σ e).mp hmem
    exact hdistinct 0 (i + 1) (Nat.succ_pos i) (by omega) hxi
  · rw [List.nodup_iff_getElem?_ne_getElem?]
    intro i j hij hj
    rw [orbitTail_length] at hj
    have hi' : i < (orbitTail σ e).length := by rw [orbitTail_length]; omega
    have hj' : j < (orbitTail σ e).length := by rw [orbitTail_length]; omega
    rw [List.getElem?_eq_getElem hi', List.getElem?_eq_getElem hj',
      orbitTail_getElem σ e hi', orbitTail_getElem σ e hj']
    intro hcontra
    exact hdistinct (i + 1) (j + 1) (by omega) (by omega) (Option.some_injective ι hcontra)

/-- 基点と反復列の各点を順に交換する、本文の互換鎖。 -/
private def finiteTranspositionChain (a : ι) : List ι → Equiv.Perm ι
  | [] => 1
  | b :: l => finiteTranspositionChain a l * finiteTranspositionPerm a b

private lemma finiteTranspositionChain_apply_of_notMem (a : ι) (l : List ι) {x : ι}
    (hxa : x ≠ a) (hxl : x ∉ l) : finiteTranspositionChain a l x = x := by
  induction l with
  | nil => rfl
  | cons b t ih =>
    rw [List.mem_cons, not_or] at hxl
    obtain ⟨hxb, hxt⟩ := hxl
    change (finiteTranspositionChain a t * finiteTranspositionPerm a b) x = x
    rw [Equiv.Perm.mul_apply, finiteTranspositionPerm_apply,
      finiteTransposition_apply_of_ne a b hxa hxb]
    exact ih hxt

private lemma finiteTranspositionChain_apply_head (a : ι) (l : List ι)
    (hnd : (a :: l).Nodup) : finiteTranspositionChain a l a = l.headD a := by
  cases l with
  | nil => rfl
  | cons b t =>
    rw [List.nodup_cons, List.mem_cons, not_or] at hnd
    obtain ⟨⟨hab, hat⟩, hnd'⟩ := hnd
    have hbt : b ∉ t := (List.nodup_cons.mp hnd').1
    change (finiteTranspositionChain a t * finiteTranspositionPerm a b) a = b
    rw [Equiv.Perm.mul_apply, finiteTranspositionPerm_apply,
      finiteTransposition_apply_left]
    exact finiteTranspositionChain_apply_of_notMem a t (fun h => hab h.symm) hbt

private lemma finiteTranspositionChain_apply_getElem (a : ι) (l : List ι)
    (hnd : (a :: l).Nodup) {i : ℕ} (hi : i + 1 < l.length) :
    finiteTranspositionChain a l (l[i]'(Nat.lt_of_succ_lt hi)) = l[i + 1]'hi := by
  induction l generalizing i with
  | nil => simp at hi
  | cons b t ih =>
    rw [List.nodup_cons, List.mem_cons, not_or] at hnd
    obtain ⟨⟨hab, hat⟩, hnd'⟩ := hnd
    have hbt : b ∉ t := (List.nodup_cons.mp hnd').1
    have hndat : (a :: t).Nodup := List.nodup_cons.mpr ⟨hat, (List.nodup_cons.mp hnd').2⟩
    cases i with
    | zero =>
      have ht : 0 < t.length := by simpa using hi
      simp only [List.getElem_cons_zero, List.getElem_cons_succ]
      change (finiteTranspositionChain a t * finiteTranspositionPerm a b) b = t[0]'ht
      rw [Equiv.Perm.mul_apply, finiteTranspositionPerm_apply,
        finiteTransposition_apply_right, finiteTranspositionChain_apply_head a t hndat]
      cases t with
      | nil => simp at ht
      | cons c u => rfl
    | succ j =>
      have hj : j + 1 < t.length := by simpa using hi
      simp only [List.getElem_cons_succ]
      change (finiteTranspositionChain a t * finiteTranspositionPerm a b)
        (t[j]'(Nat.lt_of_succ_lt hj)) = t[j + 1]'hj
      have htja : t[j]'(Nat.lt_of_succ_lt hj) ≠ a := fun h => hat (h ▸ List.getElem_mem _)
      have htjb : t[j]'(Nat.lt_of_succ_lt hj) ≠ b := fun h => hbt (h ▸ List.getElem_mem _)
      rw [Equiv.Perm.mul_apply, finiteTranspositionPerm_apply,
        finiteTransposition_apply_of_ne a b htja htjb]
      exact ih hndat hj

private lemma finiteTranspositionChain_apply_getLast (a : ι) (l : List ι)
    (hnd : (a :: l).Nodup) (hne : l ≠ []) :
    finiteTranspositionChain a l (l.getLast hne) = a := by
  induction l with
  | nil => exact absurd rfl hne
  | cons b t ih =>
    rw [List.nodup_cons, List.mem_cons, not_or] at hnd
    obtain ⟨⟨hab, hat⟩, hnd'⟩ := hnd
    have hbt : b ∉ t := (List.nodup_cons.mp hnd').1
    have hndat : (a :: t).Nodup := List.nodup_cons.mpr ⟨hat, (List.nodup_cons.mp hnd').2⟩
    cases t with
    | nil =>
      change (finiteTranspositionChain a [] * finiteTranspositionPerm a b) b = a
      rw [Equiv.Perm.mul_apply, finiteTranspositionPerm_apply,
        finiteTransposition_apply_right]
      rfl
    | cons c u =>
      have htne : (c :: u : List ι) ≠ [] := by simp
      rw [List.getLast_cons htne]
      have hlast_mem : (c :: u).getLast htne ∈ c :: u := List.getLast_mem htne
      have hxa : (c :: u).getLast htne ≠ a := fun h => hat (h ▸ hlast_mem)
      have hxb : (c :: u).getLast htne ≠ b := fun h => hbt (h ▸ hlast_mem)
      change (finiteTranspositionChain a (c :: u) * finiteTranspositionPerm a b)
        ((c :: u).getLast htne) = a
      rw [Equiv.Perm.mul_apply, finiteTranspositionPerm_apply,
        finiteTransposition_apply_of_ne a b hxa hxb]
      exact ih hndat htne

/-- 互換の鎖は軌道上で `σ` と一致する。人手証明の
「`φ_C` は `m_C - 1` 個の互換の合成に等しい」の作用の側である。 -/
private lemma transpositionChain_orbitTail_eq_apply (σ : Equiv.Perm ι) {e : ι}
    (he : σ e ≠ e) {x : ι} (hx : x ∈ movedOrbit σ e) :
    finiteTranspositionChain e (orbitTail σ e) x = σ x := by
  have hm2 : 2 ≤ orbitPeriod σ e := two_le_orbitPeriod σ he
  have hnodup := nodup_cons_orbitTail σ e
  have hlen := orbitTail_length σ e
  obtain ⟨j, hj, rfl⟩ := (mem_movedOrbit_iff_iterate σ e).mp hx
  rcases Nat.eq_zero_or_pos j with hj0 | hjpos
  · -- 基点。鎖は先頭の点をリストの最初の元 `σ e` へ送る。
    subst hj0
    have hne : orbitTail σ e ≠ [] := by
      intro hnil
      have := orbitTail_length σ e
      rw [hnil] at this
      simp at this
      omega
    have h0 : 0 < (orbitTail σ e).length := List.length_pos_iff.mpr hne
    have hb : (orbitTail σ e)[0]'h0 = (⇑σ)^[1] e := orbitTail_getElem σ e h0
    rw [Function.iterate_zero_apply, finiteTranspositionChain_apply_head e _ hnodup]
    cases hcase : orbitTail σ e with
    | nil => exact absurd hcase hne
    | cons b t =>
      have hb0 : b = σ e := by
        have hb' := hb
        simp only [hcase, List.getElem_cons_zero, Function.iterate_one] at hb'
        exact hb'
      simp [hb0]
  · rcases Nat.lt_or_ge (j + 1) (orbitPeriod σ e) with hjmid | hjlast
    · -- 中間の元。鎖はリストの各元を次の元へ送る。
      have hij : (j - 1) + 1 < (orbitTail σ e).length := by omega
      have hi : j - 1 < (orbitTail σ e).length := Nat.lt_of_succ_lt hij
      have hxj : (orbitTail σ e)[j - 1]'hi = (⇑σ)^[j] e := by
        rw [orbitTail_getElem σ e hi]
        congr 1
        omega
      have hchainstep := finiteTranspositionChain_apply_getElem e (orbitTail σ e) hnodup hij
      rw [hxj] at hchainstep
      rw [hchainstep, orbitTail_getElem σ e hij,
        ← Function.iterate_succ_apply' (⇑σ) j e]
      congr 1
      omega
    · -- 最後の元。鎖はリストの最後の元を基点へ送り、`σ` も一周して基点へ戻す。
      have hjeq : j = orbitPeriod σ e - 1 := by omega
      have hne : orbitTail σ e ≠ [] := by
        intro hnil
        have := orbitTail_length σ e
        rw [hnil] at this
        simp at this
        omega
      have hlast : (orbitTail σ e).getLast hne = (⇑σ)^[j] e := by
        rw [List.getLast_eq_getElem hne, orbitTail_getElem σ e]
        · congr 1
          rw [orbitTail_length]
          omega
      have hchainstep := finiteTranspositionChain_apply_getLast e (orbitTail σ e) hnodup hne
      rw [hlast] at hchainstep
      rw [hchainstep, ← Function.iterate_succ_apply' (⇑σ) j e]
      have hjm : j.succ = orbitPeriod σ e := by omega
      rw [hjm, iterate_orbitPeriod σ e]

/-- 互換の鎖は軌道の外を動かさない。人手証明の「軌道外では恒等写像」である。 -/
private lemma transpositionChain_orbitTail_fix (σ : Equiv.Perm ι) (e : ι) {x : ι}
    (hx : x ∉ movedOrbit σ e) :
    finiteTranspositionChain e (orbitTail σ e) x = x := by
  apply finiteTranspositionChain_apply_of_notMem
  · intro hxe
    exact hx (hxe ▸ self_mem_orbit (⇑σ) e)
  · intro hmem
    obtain ⟨i, hi, rfl⟩ := (mem_orbitTail_iff σ e).mp hmem
    exact hx ((mem_movedOrbit_iff_iterate σ e).mpr ⟨i + 1, by omega, rfl⟩)

/-- 互換の鎖の符号は `(-1)^{|C|-1}` である。人手証明の
「この巡回置換の符号は `(-1)^{m_C-1}` である」と `m_C = |C|`（`card_orbit`）を結ぶ。 -/
private lemma sign_transpositionChain_orbitTail (σ : Equiv.Perm ι) (e : ι) :
    finiteOrderedSign (finiteTranspositionChain e (orbitTail σ e)) =
      (-1 : ℤ) ^ ((movedOrbit σ e).card - 1) := by
  have hcard : (movedOrbit σ e).card = orbitPeriod σ e :=
    card_orbit (⇑σ) σ.injective e (perm_return σ e)
  have hnotmem : e ∉ orbitTail σ e := (List.nodup_cons.mp (nodup_cons_orbitTail σ e)).1
  have hsign : ∀ (l : List ι), e ∉ l →
      finiteOrderedSign (finiteTranspositionChain e l) = (-1 : ℤ) ^ l.length := by
    intro l
    induction l with
    | nil =>
      intro _
      have hinv : finiteOrderedInversionCount (1 : Equiv.Perm ι) = 0 := by
        rw [finiteOrderedInversionCount, Finset.card_eq_zero, Finset.filter_eq_empty_iff]
        intro p hp
        have hlt : p.1 < p.2 := by simpa [finiteOrderedPairs] using hp
        exact lt_asymm hlt
      simp only [finiteTranspositionChain, List.length_nil, pow_zero, finiteOrderedSign, hinv]
    | cons b t ih =>
      intro hal
      rw [List.mem_cons, not_or] at hal
      obtain ⟨hab, hat⟩ := hal
      change finiteOrderedSign (finiteTranspositionChain e t * finiteTranspositionPerm e b) = _
      rw [finiteOrderedSign_comp, finiteTransposition_sign hab,
        ih hat, List.length_cons, pow_succ]
  rw [hsign (orbitTail σ e) hnotmem, orbitTail_length, hcard]

/-- 各軌道に、基点からの互換の鎖を割り当てる（軌道でない集合には恒等置換）。
人手証明の `φ_C`（軌道上は `φ`、軌道外は恒等写像）の実装である。 -/
private noncomputable def orbitChainPerm (σ : Equiv.Perm ι) (O : Finset ι) : Equiv.Perm ι :=
  open Classical in
  if h : ∃ e, σ e ≠ e ∧ movedOrbit σ e = O then
    finiteTranspositionChain h.choose (orbitTail σ h.choose)
  else 1

/-- 置換符号は動く軌道の符号因子の積である。具体版。
参照用ノートに残した元の人手証明と同じ順で、
軌道ごとの互換の鎖・その符号・互いに素な台の合成を結ぶ。 -/
theorem sign_movedEdgeOrbit_product (σ : Equiv.Perm ι) :
    finiteOrderedSign σ =
      ∏ O ∈ movedEdgeOrbitSet σ, (-1 : ℤ) ^ (O.card - 1) := by
  classical
  -- 各軌道の基点の存在（軌道族の定義から従う）。
  have hex : ∀ O ∈ movedEdgeOrbitSet σ, ∃ e, σ e ≠ e ∧ movedOrbit σ e = O := by
    intro O hO
    obtain ⟨e, he, horb⟩ := mem_movedEdgeOrbitSet.mp hO
    exact ⟨e, mem_movedEdgeSet.mp he, horb⟩
  obtain ⟨hnonempty, hdisjoint, hcover⟩ := movedEdgeOrbitSet_partition σ
  -- 軌道ごとの鎖が、その軌道の中で `σ` と一致し、外を固定することをまとめて示す。
  have hchain : ∀ O ∈ movedEdgeOrbitSet σ,
      (∀ x ∈ O, orbitChainPerm σ O x = σ x)
        ∧ (∀ x, x ∉ O → orbitChainPerm σ O x = x)
        ∧ finiteOrderedSign (orbitChainPerm σ O) = (-1 : ℤ) ^ (O.card - 1) := by
    intro O hO
    have h := hex O hO
    obtain ⟨hemoved, horb⟩ := h.choose_spec
    have hperm : orbitChainPerm σ O =
        finiteTranspositionChain h.choose (orbitTail σ h.choose) := by
      rw [orbitChainPerm, dif_pos h]
    refine ⟨?_, ?_, ?_⟩
    · intro x hx
      rw [hperm]
      exact transpositionChain_orbitTail_eq_apply σ hemoved (horb.symm ▸ hx)
    · intro x hx
      rw [hperm]
      exact transpositionChain_orbitTail_fix σ h.choose (fun hmem => hx (horb ▸ hmem))
    · rw [hperm, sign_transpositionChain_orbitTail σ h.choose, horb]
  -- 軌道の台は互いに素で、各鎖は自分の台だけを動かす。
  let s := movedEdgeOrbitSet σ
  let f := orbitChainPerm σ
  have hstay : ∀ O ∈ s, ∀ x, x ∈ O → f O x ∈ O := by
    intro O hO x hx
    obtain ⟨e, _, horb⟩ := hex O hO
    rw [(hchain O hO).1 x hx]
    exact horb ▸ movedOrbit_mapsTo σ e (horb.symm ▸ hx)
  have hcomm : (s : Set (Finset ι)).Pairwise fun O₁ O₂ => Commute (f O₁) (f O₂) := by
    intro O₁ h₁ O₂ h₂ hne
    have hdisj := hdisjoint O₁ h₁ O₂ h₂ hne
    apply Equiv.ext
    intro x
    simp only [Equiv.Perm.mul_apply]
    by_cases hx₁ : x ∈ O₁
    · have hx₂ : x ∉ O₂ := fun hx₂ => Finset.disjoint_left.mp hdisj hx₁ hx₂
      have hfx₁ : f O₁ x ∈ O₁ := hstay O₁ h₁ x hx₁
      have hfx₂ : f O₁ x ∉ O₂ := fun hx₂ => Finset.disjoint_left.mp hdisj hfx₁ hx₂
      rw [(hchain O₂ h₂).2.1 x hx₂, (hchain O₂ h₂).2.1 (f O₁ x) hfx₂]
    · by_cases hx₂ : x ∈ O₂
      · have hfx₂ : f O₂ x ∈ O₂ := hstay O₂ h₂ x hx₂
        have hfx₁ : f O₂ x ∉ O₁ := fun hx₁ => Finset.disjoint_left.mp hdisj hx₁ hfx₂
        rw [(hchain O₁ h₁).2.1 x hx₁, (hchain O₁ h₁).2.1 (f O₂ x) hfx₁]
      · calc
          f O₁ (f O₂ x) = f O₁ x := by rw [(hchain O₂ h₂).2.1 x hx₂]
          _ = x := (hchain O₁ h₁).2.1 x hx₁
          _ = f O₂ (f O₁ x) := by
            rw [(hchain O₁ h₁).2.1 x hx₁, (hchain O₂ h₂).2.1 x hx₂]
  have hproduct : s.noncommProd f hcomm = σ := by
    apply Equiv.ext
    intro x
    by_cases hx : σ x = x
    · have hfix : ∀ O ∈ s, f O x = x := by
        intro O hO
        apply (hchain O hO).2.1 x
        intro hxO
        have hxunion : x ∈ s.biUnion id := mem_biUnion.mpr ⟨O, hO, hxO⟩
        change x ∈ (movedEdgeOrbitSet σ).biUnion id at hxunion
        rw [hcover] at hxunion
        exact (mem_movedEdgeSet.mp hxunion) hx
      exact (Finset.noncommProd_induction s f hcomm
        (fun g => g x = x)
        (fun g h hg hh => by simp only [Equiv.Perm.mul_apply, hh, hg])
        rfl hfix).trans hx.symm
    · have hmoved : x ∈ movedEdgeSet σ := mem_movedEdgeSet.mpr hx
      rw [← hcover] at hmoved
      obtain ⟨O, hO, hxO⟩ := mem_biUnion.mp hmoved
      let commErase : ((s.erase O : Finset (Finset ι)) : Set (Finset ι)).Pairwise
          (Function.onFun Commute f) :=
        fun _ hy _ hz hne => hcomm (s.mem_of_mem_erase hy) (s.mem_of_mem_erase hz) hne
      have herase : ((s.erase O).noncommProd f commErase) x = x := by
        apply Finset.noncommProd_induction (s.erase O) f commErase (fun g => g x = x)
        · intro g h hg hh
          simp only [Equiv.Perm.mul_apply, hh, hg]
        · rfl
        · intro P hP
          apply (hchain P (s.mem_of_mem_erase hP)).2.1 x
          intro hxP
          have hPO : P ≠ O := (Finset.mem_erase.mp hP).1
          exact Finset.disjoint_left.mp
            (hdisjoint P (s.mem_of_mem_erase hP) O hO hPO) hxP hxO
      rw [← Finset.mul_noncommProd_erase s hO f hcomm]
      simp only [Equiv.Perm.mul_apply, herase]
      exact (hchain O hO).1 x hxO
  -- 人手証明の最後の三段: 局所置換の合成、符号の有限積、軌道ごとの符号。
  calc
    finiteOrderedSign σ = finiteOrderedSign (s.noncommProd f hcomm) := by rw [hproduct]
    _ = ∏ O ∈ s, finiteOrderedSign (f O) := finiteOrderedSign_noncommProd s f hcomm
    _ = ∏ O ∈ s, (-1 : ℤ) ^ (O.card - 1) := by
      exact Finset.prod_congr rfl (fun O hO => (hchain O hO).2.2)

/-- 導出版: 同じ積表示を必要十分版から得たことの明示。 -/
theorem sign_movedEdgeOrbit_product_from_necSuf (σ : Equiv.Perm ι) :
    sign (fun x y : ι => x < y) σ =
      ∏ O ∈ movedEdgeOrbitSet σ, (-1 : ℤ) ^ (O.card - 1) :=
  sign_movedEdgeOrbit_product σ

end Ising2DLambda.KacWard
