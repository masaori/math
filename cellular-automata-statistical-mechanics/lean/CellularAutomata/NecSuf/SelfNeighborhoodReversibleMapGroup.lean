/-
章「自己近傍舞台の可逆大域写像群」の必要十分版。
具体版は CellularAutomata/SelfNeighborhoodReversibleMapGroup.lean。

具体版の証明が実際に使っている性質だけを残し、段の順序は具体版と同じにしてある。

  第一段（点ごとの表示と成分の単射性）
    自己近傍舞台の大域写像は成分ごとの写像の族が定める写像であり、その単射性と各成分の
    単射性の同値には添字型の等号判定だけが要る（NecSuf/LocalityRestrictsCycleType.lean の
    `productMap_injective_iff` をそのまま使う）。舞台の有限性も状態の二元性も要らない。

  第二段（単射な成分写像の二分類）
    具体版は状態集合が 2 元であることから「恒等写像か否定写像か」を出したが、実際に使うのは
    「各元 a について、a と異なる元がちょうど `neg a` である」という性質だけである。
    状態型の有限性も等号判定も要らない。`neg` の対合性と固定点のなさは、この性質から導ける。

  第三段（反転集合が定める写像とその合成）
    反転集合は `Finset` である必要がなく、決定可能な述語 `P : V → Prop` で足りる。
    対合性・単射性・合成が排他的論理和に一致することに要るのは `neg` の対合性だけであり、
    添字型・状態型の有限性も等号判定も要らない。

  第四段（反転述語による分類と単射性）
    可逆な大域写像が反転述語の写像に一致することには、第一段と第二段だけが要る。
    述語から写像への対応が単射であることには、`neg` に固定点がないことと状態型が空でないことが要る。

  第五段（固定点のない対合の巡回型）
    固定点のない対合の巡回型が 2 の並びであることに要るのは、台の有限性と等号判定だけである。
    台が配位型 A^V であること、元数が 2 の冪であることは要らない。

削れなかった仮定と、その必要な理由。

  * DecidableEq V（第一段・第四段）: 成分の単射性を出すときの証人配位の構成と、
    反転述語の相違から配位の相違を出す段で場合分けが要る。
  * `ne_iff_eq_neg`（第二段以降）: 単射な成分写像を恒等と `neg` の二つに絞る唯一の根拠。
    これを落とすと分類そのものが成り立たない（3 元以上の状態集合には反例がある）。
  * DecidablePred P（第三段以降）: 反転する成分かどうかで値を分ける定義に要る。
  * Nonempty A（第四段の単射性）: 述語の相違を配位の相違へ移すために配位が一つ必要である。
  * Fintype X, DecidableEq X（第五段）: 単射な自己写像を有限置換として読み、巡回型を
    有限多重集合として取るために要る。

有限集合・写像・自然数・有限多重集合だけで閉じ、R / C は現れない。
-/

import CellularAutomata.NecSuf.LocalityRestrictsCycleType

namespace CellularAutomata.NecSuf.SelfNeighborhoodReversibleMapGroup

open CellularAutomata.NecSuf.ReversibleGlobalMapCycleType
open CellularAutomata.NecSuf.LocalityRestrictsCycleType

variable {V A : Type}

/-! ### 第二段: 単射な成分写像の二分類 -/

/-- 具体版の `ne_iff_eq_nu` が担っていた性質。各元と異なる元が `neg` の値に一意に定まる。 -/
def IsOtherValue (neg : A → A) : Prop := ∀ a b : A, b ≠ a ↔ b = neg a

/-- 別値の一意性から `neg` に固定点がないことが従う。 -/
theorem neg_ne_self {neg : A → A} (h : IsOtherValue neg) (a : A) : neg a ≠ a :=
  (h a (neg a)).2 rfl

/-- 別値の一意性から `neg` の対合性が従う。 -/
theorem neg_neg {neg : A → A} (h : IsOtherValue neg) (a : A) : neg (neg a) = a :=
  ((h (neg a) a).1 (Ne.symm (neg_ne_self h a))).symm

/-- `claim_binary_bijection_is_identity_or_negation` の必要十分版。
    単射な自己写像は恒等写像か `neg` である。状態型の有限性も等号判定も使わない。 -/
theorem eq_id_or_neg_of_injective {neg : A → A} (hother : IsOtherValue neg)
    {g : A → A} (hg : Function.Injective g) : g = id ∨ g = neg := by
  classical
  by_cases hfix : ∀ a : A, g a = a
  · exact Or.inl (funext fun a => hfix a)
  · right
    push Not at hfix
    obtain ⟨a, ha⟩ := hfix
    have hga : g a = neg a := (hother a (g a)).1 ha
    funext b
    by_cases hba : b = a
    · subst hba
      exact hga
    · have hbneg : b = neg a := (hother a b).1 hba
      have hne : g b ≠ g a := fun h => hba (hg h)
      have hne' : g b ≠ neg a := by rw [← hga]; exact hne
      have : g b = neg (neg a) := (hother (neg a) (g b)).1 hne'
      rw [this, hbneg]

/-! ### 第三段: 反転述語が定める写像とその合成 -/

/-- 反転述語 P が定める写像。反転集合が有限部分集合である必要はない。 -/
def flipMap (neg : A → A) (P : V → Prop) [DecidablePred P] : (V → A) → (V → A) :=
  fun x v => if P v then neg (x v) else x v

@[simp]
theorem flipMap_apply (neg : A → A) (P : V → Prop) [DecidablePred P] (x : V → A) (v : V) :
    flipMap neg P x v = if P v then neg (x v) else x v := rfl

/-- 反転述語の写像は成分ごとの写像の族が定める写像である（第一段へ接続する）。 -/
theorem flipMap_eq_productMap (neg : A → A) (P : V → Prop) [DecidablePred P] :
    flipMap neg P = productMap (fun v => if P v then neg else id) := by
  funext x v
  by_cases hv : P v <;> simp [flipMap, productMap, hv]

/-- `claim_self_neighborhood_flip_involution` の必要十分版。要るのは `neg` の対合性だけである。 -/
theorem flipMap_involution {neg : A → A} (hneg : ∀ a : A, neg (neg a) = a)
    (P : V → Prop) [DecidablePred P] (x : V → A) :
    flipMap neg P (flipMap neg P x) = x := by
  funext v
  by_cases hv : P v <;> simp [flipMap, hv, hneg]

theorem flipMap_injective {neg : A → A} (hneg : ∀ a : A, neg (neg a) = a)
    (P : V → Prop) [DecidablePred P] : Function.Injective (flipMap neg P) := by
  intro x y hxy
  rw [← flipMap_involution hneg P x, ← flipMap_involution hneg P y, hxy]

/-- `claim_self_neighborhood_flip_composition_symmetric_difference` の必要十分版。
    合成は述語の排他的論理和に一致する。対称差は `Finset` である必要がない。 -/
theorem flipMap_comp {neg : A → A} (hneg : ∀ a : A, neg (neg a) = a)
    (P Q : V → Prop) [DecidablePred P] [DecidablePred Q] :
    flipMap neg P ∘ flipMap neg Q = flipMap neg (fun v => ¬ (P v ↔ Q v)) := by
  classical
  funext x v
  by_cases hp : P v <;> by_cases hq : Q v <;>
    simp [Function.comp_apply, flipMap, hp, hq, hneg]

/-- 合成の可換性。排他的論理和が P と Q の交換で変わらないことから従う。 -/
theorem flipMap_comm {neg : A → A} (hneg : ∀ a : A, neg (neg a) = a)
    (P Q : V → Prop) [DecidablePred P] [DecidablePred Q] :
    flipMap neg P ∘ flipMap neg Q = flipMap neg Q ∘ flipMap neg P := by
  classical
  funext x v
  by_cases hp : P v <;> by_cases hq : Q v <;>
    simp [Function.comp_apply, flipMap, hp, hq, hneg]

/-! ### 第四段: 反転述語による分類と単射性 -/

/-- `claim_self_neighborhood_reversible_maps_classified_by_flip_sets` の全射性の必要十分版。
    単射な成分写像の族が定める写像は、ある反転述語の写像に一致する。
    要るのは添字型の等号判定と別値の一意性だけで、有限性は使わない。 -/
theorem exists_flipMap_of_injective [DecidableEq V] {neg : A → A} (hother : IsOtherValue neg)
    (g : V → A → A) (hg : Function.Injective (productMap g)) :
    ∃ (P : V → Prop) (_ : DecidablePred P), productMap g = flipMap neg P := by
  classical
  refine ⟨fun v => g v = neg, Classical.decPred _, ?_⟩
  funext x v
  have hgv : Function.Injective (g v) := (productMap_injective_iff g).1 hg v
  rcases eq_id_or_neg_of_injective hother hgv with hid | hnu
  · have hv : ¬ (g v = neg) := by
      intro heq
      have h1 : x v = neg (x v) := by
        simpa using congrFun (hid.symm.trans heq) (x v)
      exact neg_ne_self hother (x v) h1.symm
    simp only [productMap_apply, flipMap_apply]
    rw [if_neg hv, hid, id_eq]
  · simp [productMap, flipMap, hnu]

/-- 反転述語から写像への対応の単射性の必要十分版。
    `neg` に固定点がないことと、配位が一つ存在することだけを使う。 -/
theorem flipMap_family_injective [Nonempty A] {neg : A → A}
    (hneg : ∀ a : A, neg a ≠ a) (P Q : V → Prop) [DecidablePred P] [DecidablePred Q]
    (hPQ : flipMap neg P = flipMap neg Q) (v : V) : P v ↔ Q v := by
  classical
  obtain ⟨a⟩ := ‹Nonempty A›
  have hx := congrFun (congrFun hPQ (fun _ => a)) v
  simp only [flipMap] at hx
  by_cases hp : P v <;> by_cases hq : Q v <;> simp [hp, hq] at hx ⊢
  · exact absurd hx (hneg a)
  · exact absurd hx.symm (hneg a)

/-- 反転述語が真になる成分が一つでもあれば、その写像に固定点はない。 -/
theorem flipMap_fixedPointFree {neg : A → A} (hneg : ∀ a : A, neg a ≠ a)
    (P : V → Prop) [DecidablePred P] {v : V} (hv : P v) (x : V → A) :
    flipMap neg P x ≠ x := by
  intro h
  have hx := congrFun h v
  simp only [flipMap, if_pos hv] at hx
  exact hneg (x v) hx

/-! ### 第五段: 固定点のない対合の巡回型 -/

variable {X : Type} [Fintype X] [DecidableEq X]

/-- `claim_self_neighborhood_reversible_map_cycle_types_general` の必要十分版（固定点のない場合）。
    固定点のない対合の巡回型は 2 の並びであり、台の元数はその 2 倍である。
    台が配位型であることも、元数が 2 の冪であることも使わない。 -/
theorem cycleType_of_fixedPointFree_involution (F : InjSelfMap X)
    (hinv : ∀ x : X, F.1 (F.1 x) = x) (hfree : ∀ x : X, F.1 x ≠ x) :
    ∃ n : ℕ, Fintype.card X = 2 * n ∧ cycleType F = Multiset.replicate n 2 := by
  classical
  set σ := toPerm F with hσ
  have hpow : σ ^ 2 = 1 := by
    apply Equiv.ext
    intro x
    simpa [hσ, pow_two] using hinv x
  have hsupport : σ.support = Finset.univ := by
    ext x
    simp [Equiv.Perm.mem_support, hσ, hfree x]
  have htype := Equiv.Perm.cycleType_of_pow_prime_eq_one (p := 2) hpow
  have hsum : σ.cycleType.sum = Fintype.card X := by
    rw [σ.sum_cycleType, hsupport, Finset.card_univ]
  refine ⟨σ.cycleType.card, ?_, ?_⟩
  · have hcount : σ.cycleType.card * 2 = Fintype.card X := by
      rw [htype] at hsum
      simpa only [Multiset.sum_replicate, nsmul_eq_mul, Nat.cast_id] using hsum
    omega
  · have hzero : Fintype.card X - σ.cycleType.sum = 0 := by omega
    rw [cycleType, ← hσ, hzero, htype]
    simp

/-- 恒等写像の巡回型は台の元数だけの 1 からなる。 -/
theorem cycleType_of_id (F : InjSelfMap X) (hid : ∀ x : X, F.1 x = x) :
    cycleType F = Multiset.replicate (Fintype.card X) 1 := by
  classical
  have hp : toPerm F = 1 := by
    apply Equiv.ext
    intro x
    simpa using hid x
  rw [cycleType, hp]
  simp

end CellularAutomata.NecSuf.SelfNeighborhoodReversibleMapGroup
