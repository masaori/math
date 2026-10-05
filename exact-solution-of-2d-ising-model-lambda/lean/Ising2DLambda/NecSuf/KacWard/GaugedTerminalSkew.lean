/-
対角相似による反対称化の必要十分版。具体版と同じ有限方向表と指数加法を使う。
係数は零付きモノイドと積に分配する負号だけを持ち、加法も体構造も要求しない。
指数写像の像の交換則は整数加法から導くので、係数全体の交換則は不要である。
φ(0)=1 は加法保存と φ(4)=-1 から導出し、最終定理の独立仮定には置かない。
成分の値域には演算と、結合・右単位・右零・差への左分配・積と負号・減法・和と負号の七法則を置く。
係数写像は零・積・負号だけを保存すればよい。値域に環構造は要求しない。
変数との交換は指数写像の像にだけ要求する。添字集合の有限性と格子構造は使わない。
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Ring.Basic
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

section Coefficient
variable {R : Type*} [MonoidWithZero R] [HasDistribNeg R]

def gaugePhase (φ : ℤ → R) (a b : ZMod 4) : R :=
  if b = a + 2 then φ 0 else if b = a + 3 then φ 1 else if b = a + 1 then φ (-1) else 0

def gaugeWeight (φ : ℤ → R) (a b : ZMod 4) (k l : ℤ) : R :=
  φ 2 * ((φ (2 * k) * φ (a.val : ℤ)) * (φ (-(b.val : ℤ)) * φ (-2 * l)))

def gaugeDirectionSign (a b : ZMod 4) : R :=
  if a.val < b.val then 1 else if b.val < a.val then -1 else 0

lemma gaugeDirectionSign_skew_necSuf (a b : ZMod 4) :
    gaugeDirectionSign (R := R) a b = -gaugeDirectionSign b a := by
  have hnegzero : -(0 : R) = 0 := by rw [← neg_one_mul, mul_zero]
  by_cases hab : a.val < b.val
  · simp [gaugeDirectionSign, hab, Nat.not_lt_of_ge (Nat.le_of_lt hab)]
  · by_cases hba : b.val < a.val
    · simp [gaugeDirectionSign, hab, hba]
    · simp [gaugeDirectionSign, hab, hba, hnegzero]

omit [HasDistribNeg R] in
lemma gaugePhase_table_necSuf (φ : ℤ → R) (a b : ZMod 4) :
    gaugePhase φ a b = if a = b then 0 else
      φ (if a.val < b.val then -2 - (a.val : ℤ) + b.val else 2 - (a.val : ℤ) + b.val) := by
  fin_cases a <;> fin_cases b <;> rfl

/-- 四の像と加法保存から零の像を導き、最終定理の独立仮定を減らす。 -/
lemma gaugeExponent_zero_necSuf (φ : ℤ → R)
    (hadd : ∀ a b, φ (a + b) = φ a * φ b) (hfour : φ 4 = -1) : φ 0 = 1 := by
  apply neg_injective
  calc
    -(φ 0) = φ 0 * (-1) := (mul_neg_one _).symm
    _ = φ 0 * φ 4 := by rw [hfour]
    _ = φ (0 + 4) := (hadd 0 4).symm
    _ = φ 4 := by rw [zero_add]
    _ = -1 := hfour

lemma gaugePhase_weighted_necSuf (φ : ℤ → R) (hzero : φ 0 = 1)
    (hadd : ∀ a b, φ (a + b) = φ a * φ b) (hfour : φ 4 = -1)
    (a b : ZMod 4) :
    φ (2 + (a.val : ℤ) - b.val) * gaugePhase φ a b = gaugeDirectionSign a b := by
  unfold gaugeDirectionSign
  by_cases heq : a = b
  · have hlt : ¬a.val < b.val := by rw [heq]; exact lt_irrefl _
    have hgt : ¬b.val < a.val := by rw [heq]; exact lt_irrefl _
    rw [if_neg hlt, if_neg hgt]
    calc
      φ (2 + (a.val : ℤ) - b.val) * gaugePhase φ a b =
          φ (2 + (a.val : ℤ) - b.val) * 0 := by rw [gaugePhase_table_necSuf, if_pos heq]
      _ = 0 := mul_zero _
  · by_cases hab : a.val < b.val
    · rw [if_pos hab]
      calc
        φ (2 + (a.val : ℤ) - b.val) * gaugePhase φ a b =
            φ (2 + (a.val : ℤ) - b.val) * φ (-2 - (a.val : ℤ) + b.val) := by
          rw [gaugePhase_table_necSuf, if_neg heq, if_pos hab]
        _ = φ ((2 + (a.val : ℤ) - b.val) + (-2 - (a.val : ℤ) + b.val)) := (hadd _ _).symm
        _ = φ 0 := by congr 1; ring
        _ = 1 := hzero
    · have hba : b.val < a.val := by
        have hne : a.val ≠ b.val := by
          intro h
          exact heq (ZMod.val_injective 4 h)
        omega
      rw [if_neg hab, if_pos hba]
      calc
        φ (2 + (a.val : ℤ) - b.val) * gaugePhase φ a b =
            φ (2 + (a.val : ℤ) - b.val) * φ (2 - (a.val : ℤ) + b.val) := by
          rw [gaugePhase_table_necSuf, if_neg heq, if_neg hab]
        _ = φ ((2 + (a.val : ℤ) - b.val) + (2 - (a.val : ℤ) + b.val)) := (hadd _ _).symm
        _ = φ 4 := by congr 1; ring
        _ = -1 := hfour

omit [HasDistribNeg R] in
lemma gaugeWeight_exponent_necSuf (φ : ℤ → R)
    (hadd : ∀ a b, φ (a + b) = φ a * φ b) (a b : ZMod 4) (k l : ℤ) :
    gaugeWeight φ a b k l = φ (2 + (a.val : ℤ) - b.val + 2 * k - 2 * l) := by
  calc
    gaugeWeight φ a b k l =
        φ 2 * ((φ (2 * k) * φ (a.val : ℤ)) * (φ (-(b.val : ℤ)) * φ (-2 * l))) := rfl
    _ = φ 2 * (φ (2 * k + a.val) * (φ (-(b.val : ℤ)) * φ (-2 * l))) := by rw [← hadd]
    _ = φ 2 * (φ (2 * k + a.val) * φ (-(b.val : ℤ) + -2 * l)) := by rw [← hadd]
    _ = φ 2 * φ ((2 * k + a.val) + (-(b.val : ℤ) + -2 * l)) := by rw [← hadd]
    _ = φ (2 + ((2 * k + a.val) + (-(b.val : ℤ) + -2 * l))) := by rw [← hadd]
    _ = φ (2 + (a.val : ℤ) - b.val + 2 * k - 2 * l) := by congr 1; ring

lemma gaugeWeight_reverse_necSuf (φ : ℤ → R) (hzero : φ 0 = 1)
    (hadd : ∀ a b, φ (a + b) = φ a * φ b) (hfour : φ 4 = -1)
    (a : ZMod 4) (k : ℤ) :
    gaugeWeight φ a (a + 2) k k = if a.val < 2 then 1 else -1 := by
  have hdir (d : ZMod 4) :
      (2 + (d.val : ℤ) - (d + 2).val) = if d.val < 2 then 0 else 4 := by
    fin_cases d <;> decide
  calc
    gaugeWeight φ a (a + 2) k k = φ (2 + (a.val : ℤ) - (a + 2).val + 2 * k - 2 * k) :=
      gaugeWeight_exponent_necSuf φ hadd a (a + 2) k k
    _ = φ (2 + (a.val : ℤ) - (a + 2).val) := by congr 1; ring
    _ = φ (if a.val < 2 then 0 else 4) := by rw [hdir]
    _ = if a.val < 2 then 1 else -1 := by split_ifs <;> assumption

lemma gaugeWeight_phase_value_necSuf (φ : ℤ → R) (hzero : φ 0 = 1)
    (hadd : ∀ a b, φ (a + b) = φ a * φ b) (hfour : φ 4 = -1)
    (a b : ZMod 4) (k l : ℤ) :
    gaugeWeight φ a b k l * (φ (4 * l) * gaugePhase φ a b) =
      gaugeDirectionSign a b * φ (2 * (k + l)) := by
  have hcomm (m n : ℤ) : φ m * φ n = φ n * φ m := by
    calc
      φ m * φ n = φ (m + n) := (hadd _ _).symm
      _ = φ (n + m) := congrArg φ (add_comm _ _)
      _ = φ n * φ m := hadd _ _
  have hphaseComm : φ (2 * (k + l)) * gaugePhase φ a b =
      gaugePhase φ a b * φ (2 * (k + l)) := by
    unfold gaugePhase
    split_ifs <;> first | exact hcomm _ _ | simp
  calc
    gaugeWeight φ a b k l * (φ (4 * l) * gaugePhase φ a b) =
        φ (2 + (a.val : ℤ) - b.val + 2 * k - 2 * l) * (φ (4 * l) * gaugePhase φ a b) := by
      rw [gaugeWeight_exponent_necSuf φ hadd]
    _ = (φ (2 + (a.val : ℤ) - b.val + 2 * k - 2 * l) * φ (4 * l)) * gaugePhase φ a b :=
      (mul_assoc _ _ _).symm
    _ = φ ((2 + (a.val : ℤ) - b.val + 2 * k - 2 * l) + 4 * l) * gaugePhase φ a b := by rw [← hadd]
    _ = φ ((2 + (a.val : ℤ) - b.val) + 2 * (k + l)) * gaugePhase φ a b := by congr 2; ring
    _ = (φ (2 + (a.val : ℤ) - b.val) * φ (2 * (k + l))) * gaugePhase φ a b := by rw [hadd]
    _ = φ (2 + (a.val : ℤ) - b.val) * (φ (2 * (k + l)) * gaugePhase φ a b) := mul_assoc _ _ _
    _ = φ (2 + (a.val : ℤ) - b.val) * (gaugePhase φ a b * φ (2 * (k + l))) := by rw [hphaseComm]
    _ = (φ (2 + (a.val : ℤ) - b.val) * gaugePhase φ a b) * φ (2 * (k + l)) := (mul_assoc _ _ _).symm
    _ = gaugeDirectionSign a b * φ (2 * (k + l)) := by
      rw [gaugePhase_weighted_necSuf φ hzero hadd hfour]

lemma gaugeShortScalarCoefficient_skew_necSuf (φ : ℤ → R) (hzero : φ 0 = 1)
    (hadd : ∀ a b, φ (a + b) = φ a * φ b) (hfour : φ 4 = -1)
    (a b : ZMod 4) (k l : ℤ) :
    gaugeWeight φ a b k l * (φ (4 * l) * gaugePhase φ a b) =
      -(gaugeWeight φ b a l k * (φ (4 * k) * gaugePhase φ b a)) := by
  calc
    gaugeWeight φ a b k l * (φ (4 * l) * gaugePhase φ a b) =
        gaugeDirectionSign a b * φ (2 * (k + l)) :=
      gaugeWeight_phase_value_necSuf φ hzero hadd hfour a b k l
    _ = (-gaugeDirectionSign b a) * φ (2 * (k + l)) := by
      rw [gaugeDirectionSign_skew_necSuf a b]
    _ = -(gaugeDirectionSign b a * φ (2 * (k + l))) := neg_mul _ _
    _ = -(gaugeDirectionSign b a * φ (2 * (l + k))) := by rw [add_comm k l]
    _ = -(gaugeWeight φ b a l k * (φ (4 * k) * gaugePhase φ b a)) := by
      rw [gaugeWeight_phase_value_necSuf φ hzero hadd hfour b a l k]

lemma gaugeLongCoefficient_skew_necSuf {α : Type*} [DecidableEq α]
    (φ : ℤ → R) (hzero : φ 0 = 1) (hadd : ∀ a b, φ (a + b) = φ a * φ b)
    (hfour : φ 4 = -1) (rev : α → α) (hrev : Function.Involutive rev)
    (d : α → ZMod 4) (hd : ∀ e, d (rev e) = d e + 2)
    (k : α → ℤ) (hk : ∀ e, k (rev e) = k e) (e f : α) :
    (if f = rev e then gaugeWeight φ (d e) (d f) (k e) (k f) else 0) =
      -(if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0) := by
  have hnegzero : -(0 : R) = 0 := by rw [← neg_one_mul, mul_zero]
  have hcond : f = rev e ↔ e = rev f := by
    constructor
    · intro h
      rw [h, hrev e]
    · intro h
      rw [h, hrev f]
  by_cases hfe : f = rev e
  · subst f
    rw [if_pos rfl, if_pos (hrev e).symm]
    have hback : gaugeWeight φ (d (rev e)) (d e) (k (rev e)) (k e) =
        if (d (rev e)).val < 2 then 1 else -1 := by
      have heqD : d e = d (rev e) + 2 := by rw [← hd (rev e), hrev e]
      rw [heqD, ← hk e]
      exact gaugeWeight_reverse_necSuf φ hzero hadd hfour _ _
    have hfront : gaugeWeight φ (d e) (d (rev e)) (k e) (k (rev e)) =
        if (d e).val < 2 then 1 else -1 := by
      rw [hd e, hk e]
      exact gaugeWeight_reverse_necSuf φ hzero hadd hfour _ _
    rw [hfront, hback, hd e]
    generalize d e = a
    fin_cases a <;> first | exact (neg_neg (1 : R)).symm | rfl
  · rw [if_neg hfe, if_neg (fun h => hfe (hcond.mpr h)), hnegzero]

lemma gaugeShortCoefficient_skew_necSuf {α : Type*}
    (φ : ℤ → R) (hzero : φ 0 = 1) (hadd : ∀ a b, φ (a + b) = φ a * φ b)
    (hfour : φ 4 = -1) (d : α → ZMod 4) (k : α → ℤ)
    (P : α → α → Prop) [DecidableRel P] (hP : ∀ e f, P e f ↔ P f e) (e f : α) :
    (if P e f then gaugeWeight φ (d e) (d f) (k e) (k f) *
      (φ (4 * k f) * gaugePhase φ (d e) (d f)) else 0) =
      -(if P f e then gaugeWeight φ (d f) (d e) (k f) (k e) *
        (φ (4 * k e) * gaugePhase φ (d f) (d e)) else 0) := by
  have hnegzero : -(0 : R) = 0 := by rw [← neg_one_mul, mul_zero]
  by_cases h : P e f
  · rw [if_pos h, if_pos ((hP e f).mp h)]
    exact gaugeShortScalarCoefficient_skew_necSuf φ hzero hadd hfour (d e) (d f) (k e) (k f)
  · rw [if_neg h, if_neg (fun hh => h ((hP e f).mpr hh)), hnegzero]

end Coefficient

section Assembly
variable {R S : Type*} [MonoidWithZero R] [HasDistribNeg R]
  [Zero S] [One S] [Mul S] [Sub S]

def gaugedKernel {α : Type*} [DecidableEq α]
    (φ : ℤ → R) (C : R → S) (X : S) (rev : α → α)
    (d : α → ZMod 4) (k : α → ℤ) (P : α → α → Prop) [DecidableRel P] (e f : α) : S :=
  C (gaugeWeight φ (d e) (d f) (k e) (k f)) *
    ((if f = rev e then 1 else 0) - X *
      (if P e f then C (φ (4 * k f) * gaugePhase φ (d e) (d f)) else 0))

omit [HasDistribNeg R] in
lemma gaugedKernel_entry_separated_necSuf {α : Type*} [DecidableEq α]
    (hmulassoc : ∀ a b c : S, (a * b) * c = a * (b * c))
    (hmulone : ∀ a : S, a * 1 = a) (hmulzero : ∀ a : S, a * 0 = 0)
    (hmulsub : ∀ a b c : S, a * (b - c) = a * b - a * c)
    (φ : ℤ → R) (hadd : ∀ a b, φ (a + b) = φ a * φ b)
    (C : R → S) (hCzero : C 0 = 0) (hCmul : ∀ a b, C (a * b) = C a * C b)
    (X : S) (hX : ∀ n, C (φ n) * X = X * C (φ n))
    (rev : α → α) (d : α → ZMod 4) (k : α → ℤ)
    (P : α → α → Prop) [DecidableRel P] (e f : α) :
    gaugedKernel φ C X rev d k P e f =
      C (if f = rev e then gaugeWeight φ (d e) (d f) (k e) (k f) else 0) - X *
        C (if P e f then gaugeWeight φ (d e) (d f) (k e) (k f) *
          (φ (4 * k f) * gaugePhase φ (d e) (d f)) else 0) := by
  let w := gaugeWeight φ (d e) (d f) (k e) (k f)
  let a := φ (4 * k f) * gaugePhase φ (d e) (d f)
  have hcomm : C w * X = X * C w := by
    dsimp [w]
    rw [gaugeWeight_exponent_necSuf φ hadd]
    exact hX _
  have hlong : C w * (if f = rev e then 1 else 0) = C (if f = rev e then w else 0) := by
    by_cases h : f = rev e
    · calc
        C w * (if f = rev e then 1 else 0) = C w * 1 := by rw [if_pos h]
        _ = C w := hmulone _
        _ = C (if f = rev e then w else 0) := by rw [if_pos h]
    · calc
        C w * (if f = rev e then 1 else 0) = C w * 0 := by rw [if_neg h]
        _ = 0 := hmulzero _
        _ = C 0 := hCzero.symm
        _ = C (if f = rev e then w else 0) := by rw [if_neg h]
  have hshort : C w * (if P e f then C a else 0) = C (if P e f then w * a else 0) := by
    by_cases h : P e f
    · calc
        C w * (if P e f then C a else 0) = C w * C a := by rw [if_pos h]
        _ = C (w * a) := (hCmul _ _).symm
        _ = C (if P e f then w * a else 0) := by rw [if_pos h]
    · calc
        C w * (if P e f then C a else 0) = C w * 0 := by rw [if_neg h]
        _ = 0 := hmulzero _
        _ = C 0 := hCzero.symm
        _ = C (if P e f then w * a else 0) := by rw [if_neg h]
  calc
    gaugedKernel φ C X rev d k P e f =
        C w * ((if f = rev e then 1 else 0) - X * (if P e f then C a else 0)) := rfl
    _ = C w * (if f = rev e then 1 else 0) - C w * (X * (if P e f then C a else 0)) := hmulsub _ _ _
    _ = C w * (if f = rev e then 1 else 0) - (C w * X) * (if P e f then C a else 0) := by rw [hmulassoc]
    _ = C w * (if f = rev e then 1 else 0) - (X * C w) * (if P e f then C a else 0) := by rw [hcomm]
    _ = C w * (if f = rev e then 1 else 0) - X * (C w * (if P e f then C a else 0)) := by rw [hmulassoc]
    _ = C (if f = rev e then w else 0) - X * (C w * (if P e f then C a else 0)) := by rw [hlong]
    _ = _ := by rw [hshort]

theorem gaugedKernel_skew_necSuf {α : Type*} [DecidableEq α] [Add S] [Neg S]
    (hmulassoc : ∀ a b c : S, (a * b) * c = a * (b * c))
    (hmulone : ∀ a : S, a * 1 = a) (hmulzero : ∀ a : S, a * 0 = 0)
    (hmulsub : ∀ a b c : S, a * (b - c) = a * b - a * c)
    (hmulneg : ∀ a b : S, a * (-b) = -(a * b))
    (hsubaddneg : ∀ a b : S, a - b = a + -b)
    (hnegadd : ∀ a b : S, -(a + b) = -a + -b)
    (φ : ℤ → R) (hadd : ∀ a b, φ (a + b) = φ a * φ b) (hfour : φ 4 = -1)
    (C : R → S) (hCzero : C 0 = 0) (hCmul : ∀ a b, C (a * b) = C a * C b)
    (hCneg : ∀ a, C (-a) = -C a) (X : S) (hX : ∀ n, C (φ n) * X = X * C (φ n))
    (rev : α → α) (hrev : Function.Involutive rev)
    (d : α → ZMod 4) (hd : ∀ e, d (rev e) = d e + 2)
    (k : α → ℤ) (hk : ∀ e, k (rev e) = k e)
    (P : α → α → Prop) [DecidableRel P] (hP : ∀ e f, P e f ↔ P f e) (e f : α) :
    gaugedKernel φ C X rev d k P e f = -gaugedKernel φ C X rev d k P f e := by
  have hzero := gaugeExponent_zero_necSuf φ hadd hfour
  calc
    gaugedKernel φ C X rev d k P e f =
        C (if f = rev e then gaugeWeight φ (d e) (d f) (k e) (k f) else 0) - X *
          C (if P e f then gaugeWeight φ (d e) (d f) (k e) (k f) *
            (φ (4 * k f) * gaugePhase φ (d e) (d f)) else 0) :=
      gaugedKernel_entry_separated_necSuf hmulassoc hmulone hmulzero hmulsub φ hadd C hCzero hCmul X hX rev d k P e f
    _ = C (-(if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0)) - X *
          C (if P e f then gaugeWeight φ (d e) (d f) (k e) (k f) *
            (φ (4 * k f) * gaugePhase φ (d e) (d f)) else 0) := by
      rw [gaugeLongCoefficient_skew_necSuf φ hzero hadd hfour rev hrev d hd k hk]
    _ = C (-(if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0)) - X *
          C (-(if P f e then gaugeWeight φ (d f) (d e) (k f) (k e) *
            (φ (4 * k e) * gaugePhase φ (d f) (d e)) else 0)) := by
      rw [gaugeShortCoefficient_skew_necSuf φ hzero hadd hfour d k P hP]
    _ = -(C (if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0)) - X * C (-(if P f e then gaugeWeight φ (d f) (d e) (k f) (k e) *
            (φ (4 * k e) * gaugePhase φ (d f) (d e)) else 0)) := by rw [hCneg]
    _ = -(C (if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0)) - X * -(C (if P f e then gaugeWeight φ (d f) (d e) (k f) (k e) *
            (φ (4 * k e) * gaugePhase φ (d f) (d e)) else 0)) := by rw [hCneg]
    _ = -(C (if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0)) - -(X * C (if P f e then gaugeWeight φ (d f) (d e) (k f) (k e) *
            (φ (4 * k e) * gaugePhase φ (d f) (d e)) else 0)) := by rw [hmulneg]
    _ = -(C (if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0)) + -(-(X * C (if P f e then gaugeWeight φ (d f) (d e) (k f) (k e) *
            (φ (4 * k e) * gaugePhase φ (d f) (d e)) else 0))) := hsubaddneg _ _
    _ = -(C (if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0) + -(X * C (if P f e then gaugeWeight φ (d f) (d e) (k f) (k e) *
            (φ (4 * k e) * gaugePhase φ (d f) (d e)) else 0))) := (hnegadd _ _).symm
    _ = -(C (if e = rev f then gaugeWeight φ (d f) (d e) (k f) (k e) else 0) - X * C (if P f e then gaugeWeight φ (d f) (d e) (k f) (k e) *
            (φ (4 * k e) * gaugePhase φ (d f) (d e)) else 0)) := by rw [hsubaddneg]
    _ = -gaugedKernel φ C X rev d k P f e := by
      rw [gaugedKernel_entry_separated_necSuf hmulassoc hmulone hmulzero hmulsub φ hadd C hCzero hCmul X hX]

end Assembly

/-- 零対角では任意の二成分写像を使い、右から零を掛ける法則と零の減法だけを要求する。 -/
theorem gaugedKernel_diagonal_zero_necSuf {α S : Type*} [DecidableEq α]
    [Zero S] [One S] [Mul S] [Sub S]
    (hmulzero : ∀ v : S, v * 0 = 0) (hsubzero : (0 : S) - 0 = 0)
    (w a : α → α → S) (X : S) (rev : α → α) (hrevne : ∀ e, rev e ≠ e)
    (P : α → α → Prop) [DecidableRel P] (hirrefl : ∀ e, ¬P e e) (e : α) :
    w e e * ((if e = rev e then 1 else 0) - X * (if P e e then a e e else 0)) = 0 := by
  calc
    w e e * ((if e = rev e then 1 else 0) - X * (if P e e then a e e else 0)) =
        w e e * (0 - X * (if P e e then a e e else 0)) := by rw [if_neg (Ne.symm (hrevne e))]
    _ = w e e * (0 - X * 0) := by rw [if_neg (hirrefl e)]
    _ = w e e * (0 - 0) := by rw [hmulzero]
    _ = w e e * 0 := by rw [hsubzero]
    _ = 0 := hmulzero _

end Ising2DLambda.NecSuf.KacWard
