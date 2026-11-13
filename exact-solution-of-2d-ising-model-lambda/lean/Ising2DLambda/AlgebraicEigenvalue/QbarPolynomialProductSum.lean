/-
「多項式の有限和の積の添字写像展開」の具体版。値は Polynomial Qbar、選択集合は全ての添字で
同じ有限型 B に固定する。本文の 𝔉(S)、W_S、ins、spl、spl∘ins と ins∘spl の往復、重みの分離、
部分集合の帰納法、全体集合への代入をこのファイルの中で定義し、本文と同じ順に示す。
必要十分版の定義・定理と、積和展開の既製定理は使わない。
住処は Qbar。実数・複素数を経由しない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {A B : Type*} [DecidableEq A]

/-- 本文の 𝔉(S) = {f | f : S → 𝓑}。S の元とその所属の証明を受け取って B の元を返す。 -/
def QbarFiniteMapsOn (B : Type*) (S : Finset A) : Type _ := ∀ i : A, i ∈ S → B

/-- 𝔉(S) と部分型からの写像の型の往復。引数の受け渡しを組み替えるだけである。 -/
def qbarFiniteMapsOnEquivSubtype (B : Type*) (S : Finset A) :
    QbarFiniteMapsOn B S ≃ ({i : A // i ∈ S} → B) where
  toFun f := fun i => f i.1 i.2
  invFun f := fun i hi => f ⟨i, hi⟩
  left_inv _ := rfl
  right_inv _ := rfl

/-- 本文「𝔉(S) は有限個の点への値の割当て全体なので有限である」。 -/
instance qbarFiniteMapsOnFintype [Fintype B] (S : Finset A) :
    Fintype (QbarFiniteMapsOn B S) :=
  Fintype.ofEquiv _ (qbarFiniteMapsOnEquivSubtype B S).symm

/-- 本文の W_S(f) := ∏_{i∈S} g(i, f(i))。所属の証明を取り出すため S.attach の上の積で書く。 -/
noncomputable def qbarProductSumWeight (g : A → B → Polynomial Qbar) (S : Finset A)
    (f : QbarFiniteMapsOn B S) : Polynomial Qbar :=
  ∏ i ∈ S.attach, g i.1 (f i.1 i.2)

/-- 本文の ins(b, f)。i = i₀ なら b、i ∈ S なら f(i)。 -/
def qbarInsertMap {S : Finset A} (i₀ : A) (b : B) (f : QbarFiniteMapsOn B S) :
    QbarFiniteMapsOn B (insert i₀ S) :=
  fun i hi => if h : i = i₀ then b else f i ((Finset.mem_insert.mp hi).resolve_left h)

/-- 本文の spl(h) := (h(i₀), h|_S)。 -/
def qbarSplitMap {S : Finset A} (i₀ : A) (h : QbarFiniteMapsOn B (insert i₀ S)) :
    B × QbarFiniteMapsOn B S :=
  (h i₀ (Finset.mem_insert_self i₀ S), fun i hi => h i (Finset.mem_insert_of_mem hi))

/-- ins の i₀ での値。 -/
theorem qbarInsertMap_apply_self {S : Finset A} (i₀ : A) (b : B) (f : QbarFiniteMapsOn B S)
    (hi : i₀ ∈ insert i₀ S) : qbarInsertMap i₀ b f i₀ hi = b := by
  simp [qbarInsertMap]

/-- ins の S 上の値。i ∈ S と i₀ ∉ S から i ≠ i₀ である。 -/
theorem qbarInsertMap_apply_of_mem {S : Finset A} {i₀ : A} (hi₀ : i₀ ∉ S) (b : B)
    (f : QbarFiniteMapsOn B S) {i : A} (hiS : i ∈ S) (hi : i ∈ insert i₀ S) :
    qbarInsertMap i₀ b f i hi = f i hiS := by
  have hne : i ≠ i₀ := fun h => hi₀ (h ▸ hiS)
  simp [qbarInsertMap, dif_neg hne]

/-- 本文の三等号 spl(ins(b,f)) = (ins(b,f)(i₀), ins(b,f)|_S) = (b, ins(b,f)|_S) = (b, f)。 -/
theorem qbarSplitMap_insertMap {S : Finset A} {i₀ : A} (hi₀ : i₀ ∉ S) (b : B)
    (f : QbarFiniteMapsOn B S) : qbarSplitMap i₀ (qbarInsertMap i₀ b f) = (b, f) := by
  refine Prod.ext ?_ ?_
  · calc
      (qbarSplitMap i₀ (qbarInsertMap i₀ b f)).1
          = qbarInsertMap i₀ b f i₀ (Finset.mem_insert_self i₀ S) := rfl
      _ = b := qbarInsertMap_apply_self _ _ _ _
  · funext i hi
    calc
      (qbarSplitMap i₀ (qbarInsertMap i₀ b f)).2 i hi
          = qbarInsertMap i₀ b f i (Finset.mem_insert_of_mem hi) := rfl
      _ = f i hi := qbarInsertMap_apply_of_mem hi₀ b f hi (Finset.mem_insert_of_mem hi)

/-- 本文の逆向き。i₀ での二等号と、i ∈ S での三等号を、点 i が i₀ かどうかで分けて辿る。 -/
theorem qbarInsertMap_splitMap {S : Finset A} {i₀ : A} (hi₀ : i₀ ∉ S)
    (h : QbarFiniteMapsOn B (insert i₀ S)) :
    qbarInsertMap i₀ (qbarSplitMap i₀ h).1 (qbarSplitMap i₀ h).2 = h := by
  funext i hi
  by_cases hii : i = i₀
  · subst hii
    calc
      qbarInsertMap i (qbarSplitMap i h).1 (qbarSplitMap i h).2 i hi
          = qbarInsertMap i (h i (Finset.mem_insert_self i S)) (qbarSplitMap i h).2 i hi := rfl
      _ = h i (Finset.mem_insert_self i S) := qbarInsertMap_apply_self _ _ _ hi
      _ = h i hi := rfl
  · have hiS : i ∈ S := (Finset.mem_insert.mp hi).resolve_left hii
    calc
      qbarInsertMap i₀ (qbarSplitMap i₀ h).1 (qbarSplitMap i₀ h).2 i hi
          = qbarInsertMap i₀ (h i₀ (Finset.mem_insert_self i₀ S))
              (fun j hj => h j (Finset.mem_insert_of_mem hj)) i hi := rfl
      _ = h i (Finset.mem_insert_of_mem hiS) := qbarInsertMap_apply_of_mem hi₀ _ _ hiS hi
      _ = h i hi := rfl

/-- 本文「ins は全単射である」。往復は上の二つの定理である。 -/
def qbarInsertMapEquiv {S : Finset A} {i₀ : A} (hi₀ : i₀ ∉ S) :
    B × QbarFiniteMapsOn B S ≃ QbarFiniteMapsOn B (insert i₀ S) where
  toFun p := qbarInsertMap i₀ p.1 p.2
  invFun h := qbarSplitMap i₀ h
  left_inv p := qbarSplitMap_insertMap hi₀ p.1 p.2
  right_inv h := qbarInsertMap_splitMap hi₀ h

/-- 本文の重みの四等号 W_{S⁺}(ins(b,f)) = g(i₀,b) W_S(f)。
二行目の一因子の分離は、S⁺.attach を i₀ と S.attach の像へ分けて行う。 -/
theorem qbarProductSumWeight_insertMap (g : A → B → Polynomial Qbar) {S : Finset A} {i₀ : A}
    (hi₀ : i₀ ∉ S) (b : B) (f : QbarFiniteMapsOn B S) :
    qbarProductSumWeight g (insert i₀ S) (qbarInsertMap i₀ b f) =
      g i₀ b * qbarProductSumWeight g S f := by
  classical
  have hsplit :
      (∏ i ∈ (insert i₀ S).attach, g i.1 (qbarInsertMap i₀ b f i.1 i.2)) =
        g i₀ (qbarInsertMap i₀ b f i₀ (Finset.mem_insert_self i₀ S)) *
          ∏ i ∈ S.attach, g i.1 (qbarInsertMap i₀ b f i.1 (Finset.mem_insert_of_mem i.2)) := by
    rw [Finset.attach_insert, Finset.prod_insert, Finset.prod_image]
    · rintro ⟨a, ha⟩ - ⟨c, hc⟩ - hac
      have hac' : a = c := congrArg Subtype.val hac
      exact Subtype.ext hac'
    · intro hmem
      rw [Finset.mem_image] at hmem
      obtain ⟨⟨a, ha⟩, -, hai⟩ := hmem
      have : a = i₀ := congrArg Subtype.val hai
      exact hi₀ (this ▸ ha)
  calc
    qbarProductSumWeight g (insert i₀ S) (qbarInsertMap i₀ b f)
        = ∏ i ∈ (insert i₀ S).attach, g i.1 (qbarInsertMap i₀ b f i.1 i.2) := rfl
    _ = g i₀ (qbarInsertMap i₀ b f i₀ (Finset.mem_insert_self i₀ S)) *
          ∏ i ∈ S.attach, g i.1 (qbarInsertMap i₀ b f i.1 (Finset.mem_insert_of_mem i.2)) :=
          hsplit
    _ = g i₀ b * ∏ i ∈ S.attach, g i.1 (f i.1 i.2) := by
          rw [qbarInsertMap_apply_self]
          congr 1
          refine Finset.prod_congr rfl ?_
          intro i _
          rw [qbarInsertMap_apply_of_mem hi₀ b f i.2]
    _ = g i₀ b * qbarProductSumWeight g S f := rfl

/-- 本文の部分集合上の主張。空集合の三等号と、一点追加の七等号をそのまま辿る。
空集合上の写像は、値域 B が空でもただ一つ存在する。 -/
theorem qbarPolynomial_prod_sum_eq_sum_prod_family [Fintype B]
    (g : A → B → Polynomial Qbar) (S : Finset A) :
    (∏ i ∈ S, ∑ b : B, g i b) =
      ∑ f : QbarFiniteMapsOn B S, qbarProductSumWeight g S f := by
  classical
  induction S using Finset.induction_on with
  | empty =>
      have hunique : ∀ f : QbarFiniteMapsOn B (∅ : Finset A),
          f = fun _ hi => absurd hi (Finset.notMem_empty _) :=
        fun f => funext fun _ => funext fun hi => absurd hi (Finset.notMem_empty _)
      have hcard : Fintype.card (QbarFiniteMapsOn B (∅ : Finset A)) = 1 :=
        Fintype.card_eq_one_iff.mpr ⟨fun _ hi => absurd hi (Finset.notMem_empty _), hunique⟩
      calc
        (∏ i ∈ (∅ : Finset A), ∑ b : B, g i b) = 1 := Finset.prod_empty
        _ = ∑ _f : QbarFiniteMapsOn B (∅ : Finset A), (1 : Polynomial Qbar) := by
          rw [Finset.sum_const, Finset.card_univ, hcard, one_smul]
        _ = ∑ f : QbarFiniteMapsOn B (∅ : Finset A),
            qbarProductSumWeight g (∅ : Finset A) f := by
          refine Finset.sum_congr rfl ?_
          intro f _
          simp [qbarProductSumWeight]
  | insert i₀ S hi₀ ih =>
      calc
        (∏ i ∈ insert i₀ S, ∑ b : B, g i b) =
            (∑ b : B, g i₀ b) * ∏ i ∈ S, ∑ b : B, g i b :=
          Finset.prod_insert hi₀
        _ = (∑ b : B, g i₀ b) * ∑ f : QbarFiniteMapsOn B S, qbarProductSumWeight g S f :=
          congrArg ((∑ b : B, g i₀ b) * ·) ih
        _ = ∑ b : B, g i₀ b * (∑ f : QbarFiniteMapsOn B S, qbarProductSumWeight g S f) :=
          Finset.sum_mul _ _ _
        _ = ∑ b : B, ∑ f : QbarFiniteMapsOn B S, g i₀ b * qbarProductSumWeight g S f := by
          refine Finset.sum_congr rfl ?_
          intro b _
          exact Finset.mul_sum _ _ _
        _ = ∑ p : B × QbarFiniteMapsOn B S, g i₀ p.1 * qbarProductSumWeight g S p.2 := by
          rw [Fintype.sum_prod_type]
        _ = ∑ p : B × QbarFiniteMapsOn B S,
            qbarProductSumWeight g (insert i₀ S) (qbarInsertMapEquiv hi₀ p) := by
          refine Finset.sum_congr rfl ?_
          intro p _
          exact (qbarProductSumWeight_insertMap g hi₀ p.1 p.2).symm
        _ = ∑ h : QbarFiniteMapsOn B (insert i₀ S), qbarProductSumWeight g (insert i₀ S) h :=
          Equiv.sum_comp (qbarInsertMapEquiv hi₀) (qbarProductSumWeight g (insert i₀ S))

/-- 本文 𝔉(𝓐) と写像 𝓐 → 𝓑 の全体の往復（所属の証明 i ∈ univ を受け取るかどうかだけが違う）。 -/
def qbarFiniteMapsOnUnivEquiv (B : Type*) [Fintype A] :
    QbarFiniteMapsOn B (univ : Finset A) ≃ (A → B) where
  toFun f := fun i => f i (Finset.mem_univ i)
  invFun f := fun i _ => f i
  left_inv _ := rfl
  right_inv _ := rfl

/-- 本文の最終段の三等号。部分集合を全体集合に取り、重みの定義を展開し、𝔉(𝓐) の定義で
写像の全体へ再添字付けする。A、B の空集合を除かない。 -/
theorem qbarPolynomial_prod_sum_eq_sum_prod_pi [Fintype A] [Fintype B]
    (g : A → B → Polynomial Qbar) :
    (∏ i : A, ∑ b : B, g i b) = ∑ f : A → B, ∏ i : A, g i (f i) := by
  classical
  calc
    (∏ i : A, ∑ b : B, g i b) =
        ∑ f : QbarFiniteMapsOn B (univ : Finset A), qbarProductSumWeight g univ f :=
      qbarPolynomial_prod_sum_eq_sum_prod_family g univ
    _ = ∑ f : QbarFiniteMapsOn B (univ : Finset A),
        ∏ i ∈ (univ : Finset A).attach, g i.1 (f i.1 i.2) := rfl
    _ = ∑ f : A → B, ∏ i : A, g i (f i) := by
      calc
        _ = ∑ f : A → B, ∏ i ∈ (univ : Finset A).attach, g i.1 (f i.1) :=
          Equiv.sum_comp (qbarFiniteMapsOnUnivEquiv B)
            (fun f => ∏ i ∈ (univ : Finset A).attach, g i.1 (f i.1))
        _ = ∑ f : A → B, ∏ i : A, g i (f i) := by
          refine Finset.sum_congr rfl ?_
          intro f _
          exact Finset.prod_attach (univ : Finset A) (fun i => g i (f i))

end Ising2DLambda.AlgebraicEigenvalue
