/-
章「共役類の集合と写像符号の像の全単射」の具体版。
人手証明の正本は
structured-latex/content/conjugacy-class-code-image-bijection.ts。

人手証明のブロックとこのファイルの対応:

  def_conjugacy_class_all_self_maps            `fullNeighborhood` / `fullRule` /
                                                 `globalMap_fullRule` / `card_allGlobalMaps`
  def_conjugacy_class_relation                   `Conj`
  claim_conjugacy_class_relation_is_equivalence  `conj_refl` / `conj_symm` / `conj_trans`
                                                 （まとめて `conjSetoid`）
  def_conjugacy_class_quotient                   `ConjClass`（`conjSetoid` による商）
  def_conjugacy_class_code_image                 `mapCodeOf` / `codeImage`
  claim_conjugacy_class_code_image_bijection     `quotientCode`（代表非依存）/
                                                 `quotientCode_injective` /
                                                 `codeSubtypeMap_surjective` /
                                                 `conjClassCodeEquiv`
  claim_conjugacy_class_count_finite_decidability `card_conjClass_eq_card_codeImage` /
                                                 `card_allGlobalMaps` /
                                                 `conjDecidable`

人手証明と同じく、舞台 V は一つに固定し、A^V 上の全ての自己写像を扱う。
各自己写像が近傍 N(v) = V の 2 値セルオートマトンの大域写像であることは、人手証明どおり
`claim_support_subset_implies_representable`（Lean では `supp_subset_implies_representable`）
を各セルへ適用して示す。共役の完全不変量である写像符号の性質は、既に形式化した
`mapCode_eq_iff_exists_conjugacy` を人手証明と同じ位置でだけ使う。

住処: 有限型・自然数・有限多重集合のみ。ℝ / ℂ は現れない（人手証明と同じ）。
-/
import CellularAutomata.RecursivePreimageTreeCode
import CellularAutomata.LocalRuleRepresentation
import CellularAutomata.NecSuf.ConjugacyClassCodeImageBijection

namespace CellularAutomata.ConjugacyClassCodeImageBijection

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.LocalRuleRepresentation
open CellularAutomata.RecursivePreimageTreeCode

variable {V : Type} [Fintype V] [DecidableEq V]

/-! ## 一つの有限舞台上の大域写像全体（`def_conjugacy_class_all_self_maps`） -/

/-- 全セルを近傍に取る近傍写像 N(v) = V。 -/
def fullNeighborhood (_v : V) : Finset V := Finset.univ

/-- 自己写像 F : A^V → A^V から作る、近傍 N(v) = V 上の局所真理値表の族。
    人手証明どおり基準値延長 ι^V_V を通して局所規則を作る
    （`claim_support_subset_implies_representable` の証明で使う写像そのもの）。 -/
def fullRule (F : (V → State) → V → State) :
    (v : V) → (↥(fullNeighborhood v) → State) → State :=
  fun v x => F (baseExtend (Finset.univ : Finset V) x) v

/-- `def_conjugacy_class_all_self_maps` の後段。A^V 上の任意の自己写像は、近傍 N(v) = V の
    2 値セルオートマトン (V, N, (f_v)) の大域写像である。人手証明どおり、各セル v について
    値写像 y ↦ F(y)(v) へ `claim_support_subset_implies_representable` を S = V で適用する。 -/
theorem globalMap_fullRule (F : (V → State) → V → State) :
    globalMap fullNeighborhood (fullRule F) = F := by
  funext y v
  exact (supp_subset_implies_representable (Finset.univ : Finset V) (fun y => F y v)
    (Finset.subset_univ _) y).symm

/-- `def_conjugacy_class_all_self_maps` の個数 |M(V)| = (2^{|V|})^{2^{|V|}}。 -/
theorem card_allGlobalMaps :
    Fintype.card ((V → State) → (V → State))
      = (2 ^ Fintype.card V) ^ (2 ^ Fintype.card V) := by
  rw [Fintype.card_fun, card_config]

/-! ## 同一舞台上の共役関係（`def_conjugacy_class_relation`） -/

/-- F から G への共役全単射の存在。`def_iterate_monoid_conjugacy_bijection` と同じ向き
    （h ∘ F = G ∘ h）で書く。 -/
def Conj (F G : (V → State) → V → State) : Prop :=
  ∃ h : (V → State) ≃ (V → State), ∀ y, h (F y) = G (h y)

omit [Fintype V] [DecidableEq V] in
/-- 反射律。人手証明どおり恒等写像 id を共役全単射に取る（id ∘ F = F = F ∘ id）。 -/
theorem conj_refl (F : (V → State) → V → State) : Conj F F :=
  ⟨Equiv.refl _, fun _ => rfl⟩

omit [Fintype V] [DecidableEq V] in
/-- 対称律。人手証明どおり h の逆写像 h⁻¹ を取り、F ∘ h⁻¹ = h⁻¹ ∘ G を示す。 -/
theorem conj_symm {F G : (V → State) → V → State} (hFG : Conj F G) : Conj G F := by
  obtain ⟨h, hcomm⟩ := hFG
  refine ⟨h.symm, ?_⟩
  intro y
  have hstep : h (F (h.symm y)) = G y := by
    rw [hcomm (h.symm y), h.apply_symm_apply]
  calc h.symm (G y)
      = h.symm (h (F (h.symm y))) := by rw [hstep]
    _ = F (h.symm y) := h.symm_apply_apply _

omit [Fintype V] [DecidableEq V] in
/-- 推移律。人手証明どおり合成 k ∘ h を共役全単射に取る。 -/
theorem conj_trans {F G H : (V → State) → V → State}
    (hFG : Conj F G) (hGH : Conj G H) : Conj F H := by
  obtain ⟨h, hcomm⟩ := hFG
  obtain ⟨k, kcomm⟩ := hGH
  refine ⟨h.trans k, ?_⟩
  intro y
  calc (h.trans k) (F y)
      = k (h (F y)) := rfl
    _ = k (G (h y)) := by rw [hcomm y]
    _ = H (k (h y)) := kcomm (h y)
    _ = H ((h.trans k) y) := rfl

/-- `claim_conjugacy_class_relation_is_equivalence`: 共役関係は M(V) 上の同値関係である。 -/
def conjSetoid : Setoid ((V → State) → V → State) where
  r := Conj
  iseqv := ⟨conj_refl, conj_symm, conj_trans⟩

/-! ## 共役類の集合（`def_conjugacy_class_quotient`） -/

/-- 共役類全体の集合 C(V)。 -/
def ConjClass (V : Type) [Fintype V] [DecidableEq V] : Type :=
  Quotient (conjSetoid (V := V))

/-! ## 写像符号の像（`def_conjugacy_class_code_image`） -/

/-- 自己写像 F の写像符号 K(F)。近傍 N(v) = V の局所真理値表を通して既出の `mapCode` を使う。 -/
noncomputable def mapCodeOf (F : (V → State) → V → State) : Multiset (Finset (List ℕ)) :=
  mapCode fullNeighborhood (fullRule F)

/-- 共役と写像符号の一致は同値である（既出の完全不変量 `mapCode_eq_iff_exists_conjugacy` を
    N(v) = V の局所真理値表へ適用し、大域写像を `globalMap_fullRule` で F・G へ戻す）。 -/
theorem conj_iff_mapCode_eq (F G : (V → State) → V → State) :
    Conj F G ↔ mapCodeOf G = mapCodeOf F := by
  have h := mapCode_eq_iff_exists_conjugacy (V := V) fullNeighborhood (fullRule F)
    (W := V) fullNeighborhood (fullRule G)
  rw [globalMap_fullRule F, globalMap_fullRule G] at h
  exact h.symm

/-- 写像符号の等号が決定可能なので、共役の成立も決定可能である
    （`claim_conjugacy_class_count_finite_decidability` の有限決定に使う）。 -/
noncomputable instance conjDecidable (F G : (V → State) → V → State) :
    Decidable (Conj F G) :=
  decidable_of_iff _ (conj_iff_mapCode_eq F G).symm

noncomputable instance : DecidableRel (conjSetoid (V := V)).r :=
  fun F G => conjDecidable F G

noncomputable instance : Fintype (ConjClass V) :=
  Quotient.fintype (conjSetoid (V := V))

/-- 写像符号の像 K(M(V))。M(V) が有限集合なので有限集合である。 -/
noncomputable def codeImage : Finset (Multiset (Finset (List ℕ))) :=
  letI : DecidableEq (Multiset (Finset (List ℕ))) :=
    CellularAutomata.NecSuf.RecursivePreimageTreeCode.mapCodeTypeDecidableEq
  (Finset.univ : Finset ((V → State) → (V → State))).image mapCodeOf

theorem mem_codeImage_iff (c : Multiset (Finset (List ℕ))) :
    c ∈ (codeImage (V := V)) ↔ ∃ F : (V → State) → V → State, mapCodeOf F = c := by
  letI : DecidableEq (Multiset (Finset (List ℕ))) :=
    CellularAutomata.NecSuf.RecursivePreimageTreeCode.mapCodeTypeDecidableEq
  simp [codeImage]

/-! ## 共役類の集合と写像符号の像の全単射
     （`claim_conjugacy_class_code_image_bijection`） -/

/-- 対応 K̄([F]_V) := K(F)。人手証明の「写像として定まること」（代表非依存性）は、
    共役から符号の一致を導く向きで与える。 -/
noncomputable def quotientCode : ConjClass V → Multiset (Finset (List ℕ)) :=
  Quotient.lift mapCodeOf (fun F G hFG => ((conj_iff_mapCode_eq F G).1 hFG).symm)

theorem quotientCode_mk (F : (V → State) → V → State) :
    quotientCode (Quotient.mk (conjSetoid (V := V)) F) = mapCodeOf F := rfl

/-- 人手証明の単射性。符号が等しければ共役全単射が存在し、共役類が一致する。 -/
theorem quotientCode_injective : Function.Injective (quotientCode (V := V)) := by
  intro K L hKL
  induction K using Quotient.inductionOn with
  | h F =>
    induction L using Quotient.inductionOn with
    | h G =>
      rw [quotientCode_mk, quotientCode_mk] at hKL
      exact Quotient.sound ((conj_iff_mapCode_eq F G).2 hKL.symm)

theorem quotientCode_mem_codeImage (K : ConjClass V) :
    quotientCode K ∈ (codeImage (V := V)) := by
  induction K using Quotient.inductionOn with
  | h F => exact (mem_codeImage_iff _).2 ⟨F, rfl⟩

/-- 共役類の集合から写像符号の像への写像。 -/
noncomputable def codeSubtypeMap : ConjClass V → {c // c ∈ (codeImage (V := V))} :=
  fun K => ⟨quotientCode K, quotientCode_mem_codeImage K⟩

theorem codeSubtypeMap_injective : Function.Injective (codeSubtypeMap (V := V)) := by
  intro K L hKL
  exact quotientCode_injective (congrArg Subtype.val hKL)

/-- 人手証明の全射性。像の各元は、ある自己写像の符号として得られている。 -/
theorem codeSubtypeMap_surjective : Function.Surjective (codeSubtypeMap (V := V)) := by
  rintro ⟨c, hc⟩
  obtain ⟨F, hF⟩ := (mem_codeImage_iff c).1 hc
  refine ⟨Quotient.mk (conjSetoid (V := V)) F, Subtype.ext ?_⟩
  show quotientCode (Quotient.mk (conjSetoid (V := V)) F) = c
  rw [quotientCode_mk, hF]

theorem codeSubtypeMap_bijective : Function.Bijective (codeSubtypeMap (V := V)) :=
  ⟨codeSubtypeMap_injective, codeSubtypeMap_surjective⟩

/-- `claim_conjugacy_class_code_image_bijection`: C(V) と K(M(V)) の全単射。 -/
noncomputable def conjClassCodeEquiv : ConjClass V ≃ {c // c ∈ (codeImage (V := V))} :=
  Equiv.ofBijective _ codeSubtypeMap_bijective

/-! ## 共役類の個数（`claim_conjugacy_class_count_finite_decidability`） -/

/-- 共役類の個数は写像符号の像の元数に等しい。 -/
theorem card_conjClass_eq_card_codeImage :
    Fintype.card (ConjClass V) = (codeImage (V := V)).card := by
  rw [Fintype.card_congr (conjClassCodeEquiv (V := V)), Fintype.card_coe]

/-! ## 必要十分版からの導出 -/

/-- 具体版の共役類と写像符号の集合論的な像の全単射は、同値関係と符号等号の両方向だけを
    要求する必要十分版の特殊化である。有限性・等号判定はこの全単射には使わない。 -/
noncomputable def conjClassCodeRangeEquiv :
    ConjClass V ≃ Set.range (mapCodeOf (V := V)) :=
  CellularAutomata.NecSuf.ConjugacyClassCodeImageBijection.quotientEquivCodeRange
    (conjSetoid (V := V)) mapCodeOf
    (fun hFG => ((conj_iff_mapCode_eq _ _).1 hFG).symm)
    (fun hcode => (conj_iff_mapCode_eq _ _).2 hcode.symm)

/-- 必要十分版から得た全単射の値は、具体版の代表符号写像と一致する。 -/
theorem conjClassCodeRangeEquiv_apply (K : ConjClass V) :
    (conjClassCodeRangeEquiv (V := V) K : Multiset (Finset (List ℕ))) = quotientCode K :=
  rfl

/-- 集合論的な符号像を、具体版が有限走査で作る `Finset` の符号像へ読み替える全単射。 -/
noncomputable def codeRangeCodeImageEquiv :
    Set.range (mapCodeOf (V := V)) ≃ {c // c ∈ (codeImage (V := V))} :=
  Equiv.ofBijective
    (fun c => ⟨c.1, (mem_codeImage_iff c.1).2 c.2⟩)
    ⟨fun a b h => Subtype.ext (congrArg
      (fun z : {c // c ∈ (codeImage (V := V))} => z.1) h), fun c =>
      ⟨⟨c.1, (mem_codeImage_iff c.1).1 c.2⟩, rfl⟩⟩

/-- 具体版の全単射そのものを、必要十分版の全単射と有限符号像への読み替えの合成として得る。 -/
noncomputable def conjClassCodeEquiv_from_necSuf :
    ConjClass V ≃ {c // c ∈ (codeImage (V := V))} :=
  (conjClassCodeRangeEquiv (V := V)).trans (codeRangeCodeImageEquiv (V := V))

theorem conjClassCodeEquiv_from_necSuf_apply (K : ConjClass V) :
    conjClassCodeEquiv_from_necSuf (V := V) K = codeSubtypeMap K :=
  rfl

end CellularAutomata.ConjugacyClassCodeImageBijection
