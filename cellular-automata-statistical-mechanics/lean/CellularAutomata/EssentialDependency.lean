/-
章「本質的依存台」の具体版。
人手証明の正本は structured-latex/content/essential-dependency.ts。

人手証明のブロックとこのファイルの対応:

  状態集合 A = {0,1}（構造を入れない）        `State`（2 元の帰納型。演算・順序は与えない）
  局所真理値表 (S, f)                         `S` は `Fintype`・`DecidableEq` を持つ型、
                                              `f : (S → State) → State`
  2 元集合の入れ替え写像 ν（`def_negation_map`）  `nu`（値の場合分けで定義。1−x のような演算は使わない）
  A ∖ {a} = {ν(a)}                            `ne_iff_eq_nu`（a, b の 4 通りを定義に代入して確かめる）
  一点反転写像 φ_w（`def_flip_map`）           `flip`（u = w か否かの場合分け）
  本質的依存（`def_essential_dependency`）      `EssentialDep`（2 つの入力の存在文）
  本質的依存台 supp(f)（`def_essential_dependency_support`） `supp`（`Finset.filter`）
  claim_flip_test_equivalence                  `essentialDep_iff_flip`（証明の両方向を人手証明と同じ順で書く）
  claim_support_finite_decidability            `instance : Decidable (EssentialDep f w)`・`mem_supp_iff`
                                              （存在文が有限個の条件の論理和であること）と
                                              `card_scan_pairs`（走査する組 (w, x) の総数が |S|·2^{|S|}）

claim_support_finite_decidability について形式化した範囲:
  「w ∈ supp(f) が決定可能であること」（決定可能性インスタンスと `mem_supp_iff`）と、
  「走査する組 (w, x) の全体が |S|·2^{|S|} 個であること」（`card_scan_pairs`）。
  人手証明の「比較を高々 |S|·2^{|S|} 回行う」という回数の主張は、比較 1 回を組 (w, x)
  1 つに対応させた勘定であり、計算のコストモデル自体は形式化していない。

住処: 有限型・自然数のみ。ℝ / ℂ は現れない（人手証明と同じ）。

抽象度は人手証明に固定する。使う mathlib の補題は、人手証明が根拠に挙げる初等的事実
そのもの（有限集合上の存在文の決定可能性、有限型の個数の積・冪）に限る。
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Finset.Filter
import CellularAutomata.NecSuf.EssentialDependency

namespace CellularAutomata.EssentialDependency

/-- 状態集合 A = {0,1}（`def_state_set`）。加法・乗法・順序などの構造は入れない。 -/
inductive State : Type where
  | zero : State
  | one : State
deriving DecidableEq

/-- A の元は 0 と 1 の 2 つで尽きる（値の列挙。これが A の有限性である）。 -/
instance : Fintype State :=
  ⟨{State.zero, State.one}, fun a => by cases a <;> simp⟩

/-- A は 2 元集合である（`def_local_truth_table` が使う |A^S| = 2^{|S|} の底）。 -/
theorem card_state : Fintype.card State = 2 := rfl

/-
局所真理値表 (S, f)（`def_local_truth_table`）。
S は順序のない有限集合なので、番号付き `Fin n` ではなく「有限で、元の等号が判定できる型」
として仮定する。等号判定 `DecidableEq S` は、一点反転写像の場合分け（u = w か否か）が
人手証明でも各 u について確定していることの対応物である。
-/
variable {S : Type} [Fintype S] [DecidableEq S]

/-- 2 元集合の入れ替え写像 ν（`def_negation_map`）。値の場合分けで定義する。 -/
def nu : State → State
  | State.zero => State.one
  | State.one => State.zero

/-- A ∖ {a} = {ν(a)}（`def_negation_map` の後段）。a, b の 4 通りを定義に代入して確かめる。 -/
theorem ne_iff_eq_nu (a b : State) : b ≠ a ↔ b = nu a := by
  cases a <;> cases b <;> simp [nu]

/-- 一点反転写像 φ_w（`def_flip_map`）。u = w か否かの場合分けで定める。 -/
def flip (w : S) (x : S → State) : S → State :=
  fun u => if u = w then nu (x w) else x u

omit [Fintype S] in
/-- φ_w の上段: (φ_w x)(w) = ν(x(w))。 -/
theorem flip_at (w : S) (x : S → State) : flip w x w = nu (x w) := by
  simp [flip]

omit [Fintype S] in
/-- φ_w の下段: u ≠ w なら (φ_w x)(u) = x(u)。 -/
theorem flip_ne (w : S) (x : S → State) (u : S) (h : u ≠ w) : flip w x u = x u := by
  simp [flip, h]

/-- 本質的依存（`def_essential_dependency`）。w 以外のすべての元で一致する 2 つの入力で
    f の値が異なるものが存在すること。 -/
def EssentialDep (f : (S → State) → State) (w : S) : Prop :=
  ∃ x x' : S → State, (∀ u : S, u ≠ w → x u = x' u) ∧ f x ≠ f x'

omit [Fintype S] in
/-- `claim_flip_test_equivalence` の具体版。本質的依存は一点反転の検査と同値である。 -/
theorem essentialDep_iff_flip (f : (S → State) → State) (w : S) :
    EssentialDep f w ↔ ∃ x : S → State, f x ≠ f (flip w x) := by
  constructor
  · -- (⇒) 存在文を満たす x, x' を取る。
    rintro ⟨x, x', agree, hne⟩
    -- まず x(w) ≠ x'(w) を示す。仮に等しいと、すべての u で x(u) = x'(u) となり
    -- 写像の外延性より x = x'、f(x) = f(x') となって矛盾する。
    have hw : x w ≠ x' w := by
      intro hEq
      apply hne
      have : x = x' := funext fun u => by
        by_cases hu : u = w
        · rw [hu]; exact hEq
        · exact agree u hu
      rw [this]
    -- x'(w) ∈ A ∖ {x(w)} なので ν より x'(w) = ν(x(w))。
    have hw' : x' w = nu (x w) := (ne_iff_eq_nu (x w) (x' w)).mp (Ne.symm hw)
    -- すべての u で x'(u) = (φ_w x)(u)。写像の外延性より x' = φ_w x。
    have : x' = flip w x := funext fun u => by
      by_cases hu : u = w
      · rw [hu, flip_at, hw']
      · rw [flip_ne w x u hu]; exact (agree u hu).symm
    exact ⟨x, by rw [← this]; exact hne⟩
  · -- (⇐) f(x) ≠ f(φ_w x) を満たす x を取り、x' := φ_w x と置く。
    rintro ⟨x, hne⟩
    refine ⟨x, flip w x, ?_, hne⟩
    -- φ_w の場合分けの下段より、u ≠ w で x(u) = (φ_w x)(u)。
    exact fun u hu => (flip_ne w x u hu).symm

/-
`claim_support_finite_decidability` の具体版・前半。
w ∈ supp(f) は、有限集合 A^S の元 x を走る有限個の条件 f(x) ≠ f(φ_w x) の論理和なので
決定できる。`Fintype.decidableExistsFintype` は「有限型上の存在文は有限個の論理和として
決定できる」という、人手証明がまさに根拠に挙げる初等的事実である。
-/
instance (f : (S → State) → State) (w : S) : Decidable (EssentialDep f w) :=
  CellularAutomata.NecSuf.EssentialDependency.essentialDepDecidable
    nu ne_iff_eq_nu f w

/-- 本質的依存台 supp(f)（`def_essential_dependency_support`）。S が有限なので有限集合である。 -/
def supp (f : (S → State) → State) : Finset S :=
  Finset.univ.filter (fun w => EssentialDep f w)

/-- supp(f) の所属は定義どおり本質的依存と一致する（filter の定義の確認）。 -/
theorem mem_supp_iff (f : (S → State) → State) (w : S) :
    w ∈ supp f ↔ EssentialDep f w := by
  simp [supp]

/-
`claim_support_finite_decidability` の具体版・後半。
走査する組 (w, x) ∈ S × A^S の総数は |S|·2^{|S|} である（各組が等号検査 1 回に対応する）。
有限型の個数の積と冪は、人手証明が根拠に挙げる「有限集合の間の写像の個数」そのものである。
-/
theorem card_scan_pairs :
    Fintype.card (S × (S → State)) = Fintype.card S * 2 ^ Fintype.card S := by
  rw [Fintype.card_prod, Fintype.card_fun, card_state]

omit [Fintype S] in
/-- 具体版の同値定理が、必要十分版を状態型 `State` と `nu` に特殊化して得られること。 -/
theorem essentialDep_iff_flip_from_necessary_sufficient
    (f : (S → State) → State) (w : S) :
    EssentialDep f w ↔ ∃ x : S → State, f x ≠ f (flip w x) := by
  have hflip : flip w = CellularAutomata.NecSuf.EssentialDependency.flip nu w := by
    funext x u
    simp [CellularAutomata.EssentialDependency.flip,
      CellularAutomata.NecSuf.EssentialDependency.flip]
  rw [hflip]
  exact CellularAutomata.NecSuf.EssentialDependency.essentialDep_iff_flip
    nu ne_iff_eq_nu f w

/-- 具体版の走査組数が、必要十分版の一般の状態型に対する個数式の特殊化で得られること。 -/
theorem card_scan_pairs_from_necessary_sufficient :
    Fintype.card (S × (S → State)) = Fintype.card S * 2 ^ Fintype.card S := by
  rw [CellularAutomata.NecSuf.EssentialDependency.card_scan_pairs, card_state]

end CellularAutomata.EssentialDependency
